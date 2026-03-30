global _start

section .data
    usage_msg db "Usage: ./crc <filename>", 0x0A
    usage_len equ $ - usage_msg

    err_open_msg db "Error: Cannot open file", 0x0A
    err_open_len equ $ - err_open_msg 

section .bss 
    fd resq 1
    buffer resb 4096
    hex_buf resb 9

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

    mov r9d, 0xFFFFFFFF
    mov r10d, 0xEDB88320

.read_loop:
    mov rax, 0
    mov rdi, [fd]
    mov rsi, buffer 
    mov rdx, 4096 
    syscall 

    cmp rax, 0
    je .close_file 
    jl .show_open_error

    mov rbx, 0

.process_buffer:
    cmp rbx, rax
    je .read_loop

    movzx r8, byte [buffer+rbx]

    xor r9d, r8d        

    mov rcx, 8        

.bit_loop:
    shr r9d, 1          
    jnc .skip_xor       
    
    xor r9d, r10d       

.skip_xor:
    dec rcx            
    jnz .bit_loop

    inc rbx
    jmp .process_buffer


.close_file:
    not r9d

    mov rax, 3
    mov rdi, [fd]
    syscall

    mov rcx, 8
    mov rbx, hex_buf

.hex_loop:
    rol r9d, 4
    mov r11d, r9d
    and r11d, 0x0F

    cmp r11b, 9
    jle .is_digit

    add r11b, 87
    jmp .save_char

.is_digit:
    add r11b, 48

.save_char:
    mov [rbx], r11b
    inc rbx
    dec rcx
    jnz .hex_loop

    mov byte [rbx], 10

    mov rax, 1
    mov rdi, 1
    mov rsi, hex_buf
    mov rdx, 9
    syscall

    jmp .exit_ok

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