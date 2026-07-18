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

  mov rsi, 0x03
  call sleep

  mov rsi, msg
  mov rdx, msg_len
  call print

  call exit
