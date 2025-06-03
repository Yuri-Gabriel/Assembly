section .bs
    buff resb 0x20 ; vai guardar 20 espaços na memória para armazenar o resultado da soma

section .data
    num1 dw 0x10 ; num1 = 10
    num2 dw 0x03 ; num2 = 3

section .text
    global _start

_start:
    mov rax, [num1] ; move o valor de num1 para o registrador RAX
    add rax, [num2] ; adiciona o valor de num2 no valor presente em RAX
    mov rbx, rax ; guarda o valor de RAX em RBX

    lea rax, buff ; armazena o endereço de buff em RAX
    add rax, 0x13 ; adiciona 19 ao valor do endereço armazenado em RAX
    mov rdi, rax


    mov rax, 60
    xor rdi, rdi
    syscall
