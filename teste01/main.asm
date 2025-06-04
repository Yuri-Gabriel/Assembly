section .bss
    buff resb 0x14 ; vai guardar 20 espaços na memória para armazenar o resultado da soma

section .data
    num1 dw 0x10 ; int num1 = 10
    num2 dw 0x03 ; int num2 = 3
    msg db "ola", 0x0A ; char[] msg = "oi\n"
    size_msg equ $ - msg ; int size_msg = msg.length

section .text
    global _start

exit:
    mov rax, 0x3C
    xor rdi, rdi
    syscall

number_to_str:
    ret

show_msg:
    mov rax, 0x01 ; digo ao kernel que quero usar a syscall write
    mov rdi, 0x01 ; informo ao kernel que quero escrever no terminal
    mov rsi, msg ; faz o RSI apontar para o começo da minha variáel msg
    mov rdx, size_msg ; insiro no RDX o tamanho da minha string msg

    syscall ; digo ao kernel que quero rodar a syscall que configurei anteriormente

    ret ; saio da função, igual ao return

_start:
    mov rax, [num1] ; move o valor de num1 para o registrador RAX
    add rax, [num2] ; adiciona o valor de num2 no valor presente em RAX
    mov rbx, rax ; guarda o valor de RAX em RBX

    lea rdi, [buff] ; armazena o endereço de buff em RAX

    call show_msg

    call exit
