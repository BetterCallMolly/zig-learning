const std = @import("std");

var total_lines: u64 = 0;
var total_words: u64 = 0;
var total_chars: u64 = 0;
var files_read: u16 = 0;

const BUFFER_SIZE: usize = 4096;

fn get_file_stats(file: std.fs.File) !std.meta.Tuple(&.{ u64, u64, u64 }) {
    var buffer: [BUFFER_SIZE]u8 = undefined;
    var lines: u64 = 0;
    var words: u64 = 0;
    var chars: u64 = 0;
    while (true) { // read until EOF / Error
        const read_bytes = file.readAll(&buffer) catch |err| {
            return err;
        };
        if (read_bytes == 0) {
            break;
        }
        for (buffer[0..read_bytes]) |byte| {
            chars += 1;
            switch (byte) {
                '\t', ' ' => {
                    words += 1;
                },
                '\n' => {
                    lines += 1;
                },
                else => {},
            }
        }
    }
    total_lines += lines;
    total_words += words;
    total_chars += chars;
    files_read += 1;
    return .{ lines, words, chars };
}

fn open_file(path: []const u8) !std.fs.File {
    if (path[0] == '/') { // absolute path
        return try std.fs.openFileAbsolute(path, .{ .mode = .read_only });
    } else { // relative path (should work for all cases?)
        return try std.fs.cwd().openFile(path, .{ .mode = .read_only });
    }
}

pub fn main() u8 {
    const stdout = std.io.getStdOut();
    const stderr = std.io.getStdErr();
    var args_iterator = std.process.args();
    defer args_iterator.deinit();
    _ = args_iterator.next();
    var parsed_args: u16 = 0;
    var errors: u16 = 0;
    while (args_iterator.next()) |arg| {
        parsed_args += 1;
        const file = open_file(arg) catch |err| {
            std.fmt.format(stderr.writer(), "wc: {s}: {any}\n", .{ arg, err }) catch {};
            errors += 1;
            continue;
        };
        const stats = get_file_stats(file) catch |err| {
            std.fmt.format(stderr.writer(), "wc: {s}: {any}\n", .{ arg, err }) catch {};
            errors += 1;
            continue;
        };
        std.fmt.format(stdout.writer(), "{any} {any} {any} {s}\n", .{ stats[0], stats[1], stats[2], arg }) catch {};
    }
    if (parsed_args == 0) { // no files were specified, we read from stdin
        const reader = std.io.getStdIn();
        const stats = get_file_stats(reader) catch |err| {
            std.fmt.format(stderr.writer(), "wc: stdin: {any}\n", .{err}) catch {};
            return (1);
        };
        std.fmt.format(stdout.writer(), "{any} {any} {any}\n", .{ stats[0], stats[1], stats[2] }) catch {};
    } else if (parsed_args > 1 and errors < parsed_args - 1) { // only display total if at least one file was read successfully
        std.fmt.format(stdout.writer(), "{any} {any} {any} total\n", .{ total_lines, total_words, total_chars }) catch {};
    }
    return (0);
}
