section .bss
    buff resb 0x14 ; vai guardar 20 espaços na memória para armazenar o resultado da soma

section .data
    num1 dq 0x0A ; int num1 = 10
    num2 dq 0x0C ; int num2 = 12

    msg db "ola", 0x0A ; char[] msg = "oi\n"
    size_msg equ $ - msg ; int size_msg = msg.length

section .text
    global _start

_start:
    mov rax, [num1] ; move o valor de num1 para o registrador RAX
    add rax, [num2] ; adiciona o valor de num2 no valor presente em RAX
    ;push rax ; guarda o valor de RAX (resultado da soma) na stack

    lea rdi, [buff + 0x14] ; faz o RDI apontar para o fim do meu buff
   
    call number_to_str

    mov rcx, rbx
    call show_msg

    call exit


exit:
    mov rax, 0x3C
    xor rdi, rdi
    syscall


number_to_str:
    mov rcx, 0x00 ; inicializo meu contador
    .for:
        xor rdx, rdx ; zero o valor de RDX / faço ele ser igual a NULL
        mov rbx, 0x0A ; guardo o valor 10 no RBX que será usado como divisor
        div rbx ; faço RAX = RAX / RBX e RDX = RAX % RBX

        add rdx, '0' ; converto o valor de RDX para um caractere

        dec rdi ; decrementa uma posição no buffer armazenado em RDI
        mov [rdi], dl ; Adiciona o valor de DL (subregistrador de RDX) no endereço de memoria apontado por RDI, variavel buff

        inc rcx ; incremento no meu contador

        test rax, rax
        jnz .for

    mov rbx, rcx
    mov rax, rdi
    ret

show_msg:
    mov rcx, rbx    ; rcx = número de caracteres convertidos
    mov rax, rax    ; opcional, só para manter a lógica do show_msg
    
    mov rdi, 0x01 ; informo ao kernel que quero escrever no terminal
    mov rsi, rax ; faz o RSI apontar para o começo da minha string
    mov rax, 0x01 ; digo ao kernel que quero usar a syscall write
    mov rdx, rcx ; insiro no RDX o tamanho da minha string 

    syscall ; digo ao kernel que quero rodar a syscall que configurei anteriormente

    ret ; saio da função, igual ao return
