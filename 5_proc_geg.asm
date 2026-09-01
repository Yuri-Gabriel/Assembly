%include "libs.asm"

section .data
  msg_input_meses db "Digite a quantidade de meses: "
  msg_input_meses_size equ $ - msg_input_meses

  msg_input_qtd_mes db "Digite a quantidade de produto do "
  msg_input_qtd_mes_size equ $ - msg_input_qtd_mes

  msg_input_qtd_mes_final db "º mes: "
  msg_input_qtd_mes_final_size equ $ - msg_input_qtd_mes_final

section .bss
  buffer        resb 0x10
  num_meses     resb 0x01
  vmd           resb 0x01
  emin          resb 0x01
  emax          resb 0x01
  etq_atual     resb 0x01

section .text
  global _start

_reset_buffer:
  xor rax, rax
  mov qword [buffer], rax
  mov qword [buffer + 0x08], rax
  ret

_start:
  mov rsi, msg_input_meses
  mov rdx, msg_input_meses_size
  call print

  mov rsi, buffer
  mov rdx, 0x10
  call input

  mov rsi, buffer
  mov rdx, 0x10
  mov rcx, rax
  call str_to_int

  mov [num_meses], al

  sub rsp, [num_meses]

  call end_line

  mov r12, 0x01
  .for:
    mov rsi, msg_input_qtd_mes
    mov rdx, msg_input_qtd_mes_size
    call print

    call _reset_buffer

    mov rax, r12
    mov rdx, buffer
    call int_to_str

    mov rsi, rax
    mov rdx, 0x0A
    call print

    mov rsi, msg_input_qtd_mes_final
    mov rdx, msg_input_qtd_mes_final_size
    call print

    mov rsi, buffer
    mov rdx, 0x10
    call input

    mov rsi, buffer
    mov rdx, 0x10
    mov rcx, rax
    call str_to_int

    mov dword [rsp + r12], eax

    call end_line

    inc r12
    movzx rcx, byte [num_meses]
    cmp r12, rcx
    jle .for

  call end_line

  call exit
