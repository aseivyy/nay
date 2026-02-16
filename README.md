# nay
Hi,
This is my bootable thingy, named "nay bi", where "bi" stands for "bootable interface" so people won't tell me this don't fit all of those os requirements, so here it is. 

For now it does kind of nothing except being able to show a "light"coded text (? i don't know how to name it, there is a driver but only for vga but not user input from actually human running it), but I guess you have to do foundation first before going further. And it isn't going to be soon, for now I plan it when doing userspace things.

This is the new version, existing as an efi app, so it could boot in the future on real device

## Anyways, guide to how to build
1. Run "make" in root directory

Done, output in image.img

## How to run
1. sh qemu.sh

## What do you need
Anything supporting following packages [command] in general:
- make [make]
- nasm [nasm]
- sh (not a package but should pint to your shell thing (default on linux and maybe macos)) [sh]
- coreutils [a lot, with this one the package should have the same name on everything]
- clang [clang]
- lld [ld.lld]
- vim [xxd]

For emulating with build-in qemu.sh:
- qemu-full [qemu-system-x86_64]

---

The package names was checked on arch linux, so I added the comamnd names too so if it changes you can adjust easly. Or just run the makefile and look for "command not found" errors and install whatever it wants

If you are reading this have a good day <3
