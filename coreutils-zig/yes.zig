const MAX_BUFFER_SIZE: usize = 16384;

const std = @import("std");

pub fn main() !u8 {
    var buffer: [MAX_BUFFER_SIZE]u8 = undefined;
    // const out = std.io.getStdOut();
    // var buf = std.io.bufferedWriter(out.writer());
    // var writer = buf.writer();
    var writer = std.io.getStdOut().writer();
    var offset: u32 = 0;
    while (offset < MAX_BUFFER_SIZE) : (offset += 1) {
        buffer[offset] = switch (offset % 2) {
            0 => @as(u8, 'y'),
            1 => @as(u8, '\n'),
            else => @as(u8, 'y'),
        };
    }
    while (true) {
        _ = writer.write(buffer[0..]) catch {};
    }
    return (0);
}
