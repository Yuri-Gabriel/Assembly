%include "libs.asm"

section .data
  msg_input_meses db "Digite a quantidade de meses: "
  msg_input_meses_size equ $ - msg_input_meses

  msg_input_qtd_mes db "Digite a quantidade de produto do "
  msg_input_qtd_mes_size equ $ - msg_input_qtd_mes

  msg_input_qtd_mes_final db "º mes: "
  msg_input_qtd_mes_final_size equ $ - msg_input_qtd_mes_final

  msg_input_tmp_etq db "Digite o tempo de reposição: "
  msg_input_tmp_etq_size equ $ - msg_input_tmp_etq

  msg_input_lote_rep db "Digite o lote de reposição: "
  msg_input_lote_rep_size equ $ - msg_input_lote_rep

  msg_input_etq_atual db "Digite a quantidade atual do produto: "
  msg_input_etq_atual_size equ $ - msg_input_etq_atual

  msg_compra db "Compra!"
  msg_compra_size equ $ - msg_compra

  msg_nao_compra db "Não compra!"
  msg_nao_compra_size equ $ - msg_nao_compra

  lbl_num_meses db "Numero de meses: "
  lbl_num_meses_size equ $ - lbl_num_meses

  lbl_vmd db "VMD: "
  lbl_vmd_size equ $ - lbl_vmd

  lbl_emin db "EMIN: "
  lbl_emin_size equ $ - lbl_emin

  lbl_emax db "EMAX: "
  lbl_emax_size equ $ - lbl_emax

  lbl_etq_atual db "Estoque atual: "
  lbl_etq_atual_size equ $ - lbl_etq_atual

  lbl_tempo_rep db "Tempo de reposição: "
  lbl_tempo_rep_size equ $ - lbl_tempo_rep

  buffer_size equ 0x10

section .bss
  buffer        resb 0x10
  num_meses     resq 0x05
  soma_produtos resq 0x05
  vmd           resq 0x05
  emin          resq 0x05
  emax          resq 0x05
  etq_atual     resq 0x05
  tempo_rep     resq 0x05

section .text
  global _start

_reset_buffer:
  xor rax, rax
  mov qword [buffer], rax
  mov qword [buffer + 0x08], rax
  ret

_print_nao_compra:
  call end_line
  
  mov rsi, msg_nao_compra
  mov rdx, msg_nao_compra_size
  call print

  call end_line

  call exit

_start:
  mov rsi, msg_input_meses
  mov rdx, msg_input_meses_size
  call print

  mov rsi, buffer
  mov rdx, buffer_size
  call input

  mov rsi, buffer
  mov rdx, buffer_size
  mov rcx, rax
  call str_to_int

  mov [num_meses], al

  sub rsp, [num_meses]

  call end_line

  mov r12, 0x01
  mov byte [soma_produtos], 0x00
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
    mov rdx, buffer_size
    call input

    mov rsi, buffer
    mov rdx, buffer_size
    mov rcx, rax
    call str_to_int

    add [soma_produtos], eax

    call end_line

    inc r12
    movzx rcx, byte [num_meses]
    cmp r12, rcx
    jle .for

  ; start getVMD
  mov eax, [soma_produtos]
  xor rdx, rdx
  movzx rbx, byte [num_meses]
  div rbx

  xor rdx, rdx
  mov rbx, 25
  div rbx

  mov [vmd], al
  ; end getVMD

  ; start getEMIN
  mov rsi, msg_input_tmp_etq
  mov rdx, msg_input_tmp_etq_size
  call print

  call _reset_buffer

  mov rsi, buffer
  mov rdx, buffer_size
  call input

  mov rsi, buffer
  mov rdx, buffer_size
  mov rcx, rax
  call str_to_int

  mov [tempo_rep], al

  mov rbx, [vmd]
  mul rbx

  mov [emin], al
  ; end getEMIN

  ; start getEMAX
  mov rsi, msg_input_lote_rep 
  mov rdx, msg_input_lote_rep_size
  call print

  call _reset_buffer

  mov rsi, buffer
  mov rdx, buffer_size
  call input

  mov rsi, buffer
  mov rdx, buffer_size
  mov rcx, rax
  call str_to_int

  mov rbx, [emin]
  add rax, rbx

  mov [emax], al
  ; end getEMAX

  mov rsi, msg_input_etq_atual 
  mov rdx, msg_input_etq_atual_size
  call print

  call _reset_buffer

  mov rsi, buffer
  mov rdx, buffer_size
  call input

  mov rsi, buffer
  mov rdx, buffer_size
  mov rcx, rax
  call str_to_int

  mov [etq_atual], al

  ; Exibição final dos dados
  call end_line

  mov rsi, lbl_vmd
  mov rdx, lbl_vmd_size
  call print

  call _reset_buffer

  mov rax, [vmd]
  mov rdx, buffer
  call int_to_str

  mov rsi, rax
  mov rdx, 0x05
  call print

  ; -----------------------
  call end_line

  mov rsi, lbl_emin
  mov rdx, lbl_emin_size
  call print

  call _reset_buffer

  mov rax, [emin]
  mov rdx, buffer
  call int_to_str

  mov rsi, rax
  mov rdx, 0x05
  call print

  ; -----------------------
  call end_line

  mov rsi, lbl_emax
  mov rdx, lbl_emax_size
  call print

  call _reset_buffer

  mov rax, [emax]
  mov rdx, buffer
  call int_to_str

  mov rsi, rax
  mov rdx, 0x05
  call print

  ; -----------------------
  call end_line

  mov rsi, lbl_tempo_rep
  mov rdx, lbl_tempo_rep_size
  call print

  call _reset_buffer

  mov rax, [tempo_rep]
  mov rdx, buffer
  call int_to_str

  mov rsi, rax
  mov rdx, 0x05
  call print

  ; -----------------------
  call end_line

  mov rsi, lbl_etq_atual
  mov rdx, lbl_etq_atual_size
  call print

  call _reset_buffer

  mov rax, [etq_atual]
  mov rdx, buffer
  call int_to_str

  mov rsi, rax
  mov rdx, 0x05
  call print

  call end_line

  mov rax, [etq_atual]
  mov rbx, [emin]
  mov rcx, [emax]

  cmp rax, rbx
  jle _print_nao_compra

  cmp rax, rcx
  jge _print_nao_compra

  call end_line
  
  mov rsi, msg_compra
  mov rdx, msg_compra_size
  call print

  call end_line

  call exit
