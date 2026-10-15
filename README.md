### CRC-32 calculator in x86-64 assembly

## description

A CRC-32 checksum calculator written in pure x86-64 assembly (NASM) for Linux. This program interacts directly with the Linux kernel via system calls.

Cyclic Redundancy Check (CRC) is an error-detecting code commonly used in digital networks and storage devices to detect accidental changes to raw data. It acts as a digital fingerprint for files. Changing even a single bit in a file will result in a completely different CRC checksum. 


## compilation and usage

Requirements: Linux x86-64 system, `nasm` assembler, and `ld` linker.

## compilation
To compile the assembly source code into an executable binary:
```bash
nasm -f elf64 crc.asm -o crc.o
```
```bash
ld crc.o -o crc
```
