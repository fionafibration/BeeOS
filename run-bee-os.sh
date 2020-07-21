#!/bin/bash

nasm -fbin boot_sector.asm -o beeOS.bin
qemu-system-x86_64 -drive format=raw,file=beeOS.bin

