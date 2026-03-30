global _start

section .data
    usage_msg db "Usage: ./crc <filename>", 0x0A
    usage_len equ $ - usage_msg

    err_open_msg db "Error: Cannot open file", 0x0A
    err_open_len equ $ - err_open_msg 

section .bss 
    fd resq 1
    buffer resb 4096

section .text
_start:
    pop rdi 
    cmp rdi, 2
    jl .show_usage 
    
    pop rsi 
    pop rdi 


    mov rax, 2
    mov rsi, 0
    mov rdx, 0
    syscall 

    cmp rax, 0
    jl .show_open_error

    mov [fd], rax


.read_loop:
    mov rax, 0
    mov rdi, [fd]
    mov rsi, buffer 
    mov rdx, 4096 
    syscall 

    cmp rax, 0
    je .close_file 
    jl .show_open_error

    jmp .read_loop 


.close_file:
    jmp.exit_ok

    
.exit_ok:
    mov rax, 60
    xor rdi, rdi 
    syscall 

.show_usage:
    mov rax, 1
    mov rdi, 1
    mov rsi, usage_msg 
    mov rdx, usage_len 
    syscall 

    mov rax, 60 
    mov rdi, 1
    syscall 

.show_open_error:
    mov rax, 1
    mov rdi, 1
    mov rsi, err_open_msg 
    mov rdx, err_open_len 
    syscall 

    mov rax, 60
    mov rdi, 1
    syscall