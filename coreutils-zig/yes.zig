const std = @import("std");

pub fn main() !u8 {
    const buffer = "y\n" ** 8192;
    const out = std.io.getStdOut();
    var buf = std.io.bufferedWriter(out.writer());
    var writer = buf.writer();
    while (true) {
        _ = writer.write(buffer) catch {
            std.os.exit(1);
        };
    }
    return (0);
}
