const std = @import("std");

fn part_one() !void {
    var file = try std.fs.cwd().openFile("./input.txt", .{});
    defer file.close();
    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();
    var buf: [1024]u8 = undefined;
    var n: u64 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var digits: [2]u8 = undefined;
        for (0..line.len) |i| {
            switch (line[i]) {
                '0'...'9' => {
                    digits[0] = line[i] - '0';
                    break;
                },
                else => {}
            }
        }
        var c = line.len - 1;
        while (c >= 0) {
            switch (line[c]) {
                '0'...'9' => {
                    digits[1] = line[c] - '0';
                    break;
                },
                else => {}
            }
            c -= 1;
        }
        n += digits[0] * 10 + digits[1];
    }
    try std.fmt.format(std.io.getStdOut().writer(),"{d}\n", .{n});
}

fn strnstr(buf: []const u8, offset: usize, needle: []const u8) bool {
    var i: usize = 0;
    if (offset + needle.len > buf.len) {
        return false;
    }
    while (i < needle.len) {
        if (buf[offset + i] != needle[i]) {
            return false;
        }
        i += 1;
    }
    return true;
}

fn number_matches(buf: []const u8, offset: usize) u8 {
    if (strnstr(buf, offset, "zero")) return 0;
    if (strnstr(buf, offset, "one")) return 1;
    if (strnstr(buf, offset, "two")) return 2;
    if (strnstr(buf, offset, "three")) return 3;
    if (strnstr(buf, offset, "four")) return 4;
    if (strnstr(buf, offset, "five")) return 5;
    if (strnstr(buf, offset, "six")) return 6;
    if (strnstr(buf, offset, "seven")) return 7;
    if (strnstr(buf, offset, "eight")) return 8;
    if (strnstr(buf, offset, "nine")) return 9;
    return 0;
}

fn part_two() !void {
    var file = try std.fs.cwd().openFile("./debug.txt", .{});
    defer file.close();
    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();
    var buf: [1024]u8 = undefined;
    var n: u64 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        std.debug.print("{s}\n", .{line});
        var digits: [2]u8 = undefined;
        for (0..line.len) |i| {
            switch (line[i]) {
                '0'...'9' => {
                    digits[0] = line[i] - '0';
                    break;
                },
                else => {
                    // check if a litteral number matches
                }
            }
        }
        var c = line.len - 1;
        while (c >= 0) {
            switch (line[c]) {
                '0'...'9' => {
                    digits[1] = line[c] - '0';
                    break;
                },
                else => {
                    // check if a litteral number matches
                    std.debug.print("checking {d} - {s}\n", .{c, line[c..line.len]});
                    const digit = number_matches(line, c);
                    if (digit == 0) {
                        continue;
                    }
                    digits[1] = digit;
                    break;
                }
            }
            c -= 1;
        }
        n += digits[0] * 10 + digits[1];
    }
    try std.fmt.format(std.io.getStdOut().writer(),"{d}\n", .{n});
}

pub fn main() !void {
    // try part_one();
    try part_two();
}
