%include "libs.asm"

section .data
  msg db "oi mundo", 0x0A
  msg_len equ $ - msg

section .text
  global _start

_start:
  mov rsi, msg
  mov rdx, msg_len
  call print

  mov rax, 0x3C
  xor rdi, rdi
  syscall
