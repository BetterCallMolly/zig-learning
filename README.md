# Learning Zig

I'm currently learning [Zig](https://ziglang.org/), and this repository is where I'll be keeping my notes and code.

# Infos

I'm happy to receive any feedback, so feel free to open an issue for any suggestions / tips / corrections !

# Content

- [coreutils-zig](./coreutils-zig) : Implementation of some `coreutils` in Zig (wip / not faithful to real coreutils)
    - [x] [false](./coreutils-zig/false.zig) / [true](./coreutils-zig/true.zig) (ok it's not really impressive)
    - [x] [sleep](./coreutils-zig/sleep.zig), without suffix support (`s`, `m`, `h`, `d`)
        - [std::process::args](https://ziglang.org/documentation/master/std/#A;std:process.args)
        - [std::ArrayList](https://ziglang.org/documentation/master/std/#A;std:ArrayList)
        - [std::fmt::parseUnsigned](https://ziglang.org/documentation/master/std/#A;std:fmt.parseUnsigned)
        - [std::time::sleep](https://ziglang.org/documentation/master/std/#A;std:time.sleep)
        - [std::heap::page_allocator](https://ziglang.org/documentation/master/std/#A;std:heap.page_allocator)
        - [defer](https://ziglang.org/documentation/master/#defer)
    - [x] [yes](./coreutils-zig/yes.zig) (no arguments, can output 10.4 GB/s on my machine, probably bottlenecked by `pv`)
        - [std::io::writer](https://ziglang.org/documentation/master/std/#A;std:io.Writer)
        - [std::io::BufferedWriter](https://ziglang.org/documentation/master/std/#A;std:io.BufferedWriter)
    - [x] [wc](./coreutils-zig/wc.zig) (count bytes/lines/words for all passed files / stdin if no file were provided)
        - [std::process:args](https://ziglang.org/documentation/master/std/#A;std:process.args)
        - [std.fs.File](https://ziglang.org/documentation/master/std/#A;std:fs.File)
        - [std.fs.openFileAbsolute](https://ziglang.org/documentation/master/std/#A;std:fs.openFileAbsolute)
        - [std.fs.cwd](https://ziglang.org/documentation/master/std/#A;std:fs.cwd)
        - [std.io.getStdOut](https://ziglang.org/documentation/master/std/#A;std:io.getStdOut)
        - [std.io.getStdErr](https://ziglang.org/documentation/master/std/#A;std:io.getStdErr)
        - [std.io.getStdIn](https://ziglang.org/documentation/master/std/#A;std:io.getStdIn)
        - [std.fmt.format](https://ziglang.org/documentation/master/std/#A;std:fmt.format)
        - [std.meta.Tuple](https://ziglang.org/documentation/master/std/#A;std:meta.Tuple)
        - [switch](https://ziglang.org/documentation/master/#switch)
        - [catch](https://ziglang.org/documentation/master/#catch)