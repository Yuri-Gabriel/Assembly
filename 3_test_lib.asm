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

<<<<<<< HEAD
  mov rax, 0x3C
  xor rdi, rdi
  syscall
=======
  mov rsi, 0x03
  call sleep

  mov rsi, msg
  mov rdx, msg_len
  call print

  call exit
>>>>>>> 8e78484b1cb33b63109b89a773949fcc6fb83e95
