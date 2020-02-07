#!/bin/bash

if [ $1 ] 
then
	# Compat for WSL or other remote XWindow systems
	export DISPLAY=:0
fi

nasm -fbin boot_sector.asm -o beeOS.bin
qemu-system-x86_64 -drive format=raw,file=beeOS.bin

