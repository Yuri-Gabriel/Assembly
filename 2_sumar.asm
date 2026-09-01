%include "libs.asm"

section .bss
  buff resb 0x0B

section .data
  msg db "Digite um numero: ", 0x0A
  msg_len equ $ - msg

  msg_final db "A soma é igual a: ", 0x0A
  msg_final_len equ $ - msg_final

section .text
  global _start

_start:
  mov rsi, msg
  mov rdx, msg_len
  call print

  mov rsi, buff
  mov rdx, 0x0A
  call input

  mov rsi, buff
  mov rdx, 0x0A
  dec rax
  mov rcx, rax
  call str_to_int

  mov rdi, rax
  push rdi

  mov rsi, msg
  mov rdx, msg_len
  call print

  mov rsi, buff
  mov rdx, 0x0A
  call input

  mov rsi, buff
  mov rdx, 0x0A
  dec rax
  mov rcx, rax
  call str_to_int

  pop rdi

  add rax, rdi

  push rax

  mov rsi, msg_final
  mov rdx, msg_final_len
  call input

  pop rax

  call int_to_str

  mov rdx, buff
  add rdx, 0x0B
  sub rdx, rsi
  call input

  call end_line

  call exit
