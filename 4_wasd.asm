%include "libs.asm"

section .text
  global _start

_start:
  
  sub rsp, 0x0F

  mov word [rsp], 0x0A45

  mov rsi, rsp
  mov rdx, 0x04
  call print

  call exit
