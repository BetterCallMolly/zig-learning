const std = @import("std");

fn parse_arg(arg: []const u8) u64 {
    return std.fmt.parseUnsigned(u64, arg, 10) catch {
        std.debug.print("Failed to parse argument: {s}\n", .{arg});
        std.os.exit(1);
    };
}

pub fn main() u8 {
    var args_iterator = std.process.args();
    defer args_iterator.deinit();
    _ = args_iterator.next();
    var times = std.ArrayList(u64).init(std.heap.page_allocator);
    defer times.deinit();
    while (args_iterator.next()) |arg| {
        times.append(parse_arg(arg)) catch {
            std.debug.print("buy more ram XD\n", .{});
            return (1);
        };
    }
    for (times.items) |time| {
        std.time.sleep(time * @as(u64, 1e9));
    }
    return (0);
}
