# CRC-32 calculator in x86-64 assembly

A CRC-32 checksum calculator written in pure x86-64 assembly (NASM) for Linux. This program interacts directly with the Linux kernel via system calls.

## what is CRC?
Cyclic Redundancy Check (CRC) is an error-detecting code commonly used in digital networks and storage devices to detect accidental changes to raw data. It acts as a digital fingerprint for files. Changing even a single bit in a file will result in a completely different CRC checksum. 

For more mathematical background, visit [Wikipedia](https://en.wikipedia.org/wiki/Cyclic_redundancy_check)

## how the program works
The tool accepts a file path as a command-line argument and performs the following operations:
1. Safely opens the file in read-only mode.
2. Reads data in 4 KB chunks into a memory buffer, ensuring efficient handling of files of any size without exhausting system memory.
3. Processes the data byte by byte and bit by bit, performing logical operations (XOR, bitwise shifts) against the standard CRC-32 polynomial (`0xEDB88320`).
4. Converts the final 32-bit binary result into an 8-character hexadecimal ASCII string.
5. Closes the file and prints the formatted result to standard output (`stdout`).

## compilation and usage

Requirements: Linux x86-64 system, `nasm` assembler, and `ld` linker.

## compilation
To compile the assembly source code into an executable binary:
```bash
nasm -f elf64 crc.asm -o crc.o
ld crc.o -o crc
