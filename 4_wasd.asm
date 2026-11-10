%include "libs.asm"

section .data
  msg_digit db "Aperte uma tecla: (q para encerrar)"
  msg_digit_size equ $ - msg_digit

  msg db "Tecla digitada: "
  msg_size equ $ - msg

section .bss
  digit    resb 0x2

section .text
  global _start

_start:
  _while:
    xor rax, rax
    
    mov rsi, msg_digit
    mov rdx, msg_digit_size
    call println

    mov rsi, digit
    mov rdx, 0x2
    call input

    xor rax, rax
    mov rax, 

    mov rsi, digit
    mov rdx, 0x2
    call println

    cmp byte [rel digit], 'q'
    jne _while

  call exit
