# BeeOS

The Bee Movie operating system. In my opiniong way better than CentOS or RHEL. 

The original code was made by [CommandBlockGuy](https://github.com/commandblockguy) 
in the SciCraft Discord, I expanded it to delay character for readability and use the VGA color palette

### Dependencies

`qemu-system-x86_64` and `nasm`.

I just ran `sudo apt install qemu qemu-system-x86_64 nasm`.

### Usage

Run the `run-bee-os.sh` script. If you are using WSL or a remote X server, stick an argument and it will default to `DISPLAY=:0`.

