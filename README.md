# CRC-32 Calculator in x86-64 Assembly

A standalone CRC-32 checksum calculator written in pure x86-64 assembly (NASM) for Linux. This program interacts directly with the Linux kernel via system calls.

## What is CRC?
Cyclic Redundancy Check (CRC) is an error-detecting code commonly used in digital networks and storage devices to detect accidental changes to raw data. It acts as a digital fingerprint for files. Changing even a single bit in a file will result in a completely different CRC checksum. 

For more mathematical background, visit [Wikipedia](https://en.wikipedia.org/wiki/Cyclic_redundancy_check).

## How the Program Works
The tool accepts a file path as a command-line argument and performs the following operations:
1. Safely opens the file in read-only mode.
2. Reads data in 4 KB chunks into a memory buffer, ensuring efficient handling of files of any size without exhausting system memory.
3. Processes the data byte by byte and bit by bit, performing logical operations (XOR, bitwise shifts) against the standard CRC-32 polynomial (`0xEDB88320`).
4. Converts the final 32-bit binary result into an 8-character hexadecimal ASCII string.
5. Closes the file and prints the formatted result to standard output (`stdout`).


Building this project provided a deep dive into computer architecture and low-level programming. Key concepts mastered include:
* **Linux System Calls:** Direct communication with the kernel using software interrupts (`syscall`). Manually handled `sys_open`, `sys_read`, `sys_write`, `sys_close`, and `sys_exit`.
* **Memory Management:** Reserving uninitialized memory space in the `.bss` section for file chunk buffers and text formatting.
* **Stack Operations:** Understanding how the operating system passes command-line arguments (`argc` and `argv`) to the process stack upon execution.
* **Bitwise Operations:** Practical application of hardware-level instructions like `shr` (Shift Right), `rol` (Rotate Left), `xor`, `and`, and `not` for bit manipulation and masking.
* **Binary to ASCII Conversion:** Implementing a custom loop to translate raw binary values into human-readable hexadecimal characters that can be displayed by the terminal.

## Compilation and Usage

**Requirements:** Linux x86-64 system, `nasm` assembler, and `ld` linker.

### Compilation
To compile the assembly source code into an executable binary:
```bash
nasm -f elf64 crc.asm -o crc.o
ld crc.o -o crc