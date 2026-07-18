%include "syscall.asm"

section .data
  endline db 0x0A

section .text

; void sleep(rdi)
;
;   @param {rdi} tempo que o programa esperará em segundos
sleep:
  mov rax, SYS_SLEEP
  syscall
  ret

; rax str_to_int(rsi, rdx, rcx)
;
;   @param {rsi} ponteiro para o inicio da string buffer (char*)
;   @param {rdx} ultimo indice do array buffer[] definido em .bss (buffer.length - 1)
;   @param {rcx} numero de espaços alocados que estão de fato sendo usados no buffer 
;
;   @return {rax} numero convertido
str_to_int:
  xor rbx, rbx
  .run:
    movzx rax, byte[rsi]
    inc rsi
    sub al, 0x30
    imul rbx, 0x0A
    add rbx, rax
    loop .run
    mov rax, rbx
  ret

; rax int_to_str(rax)
;   @param {rax} numero a ser convertido
;   @param {rdx} ponteiro para o inicio do buffer onde será armazenado o numero convertido
;
;   @return {rax} ponteiro para inicio da string gerada
int_to_str:
    lea rsi, [rdx + 0x0A]
    mov byte[rsi], 0x0A
    mov rbx, 0x0A
    .run:
        xor rdx, rdx
        div rbx
        add dl, 0x30
        dec rsi
        mov byte[rsi], dl
        test rax, rax
        jnz .run
    ret

; void end_line()
end_line:
  mov rsi, endline
  mov rdx, 0x01
  call print
  ret

; rax input(rsi, rdx)
;
;   @param {rsi} ponteiro para o inicio do buffer que armazenará o texto lido no terminal
;   @parma {rdx} tamanho do buffer
;
;   @return {rax} numero de caracteres lidos no terminal
input:
  mov rax, SYS_INPUT
  mov rdi, SYS_INPUT
  syscall
  ret

; void print(rsi, rdx)
;
;   @param {rsi} ponteiro para o inicio da string a ser exibida
;   @parma {rdx} tamanho da string
print:
  mov rax, SYS_PRINT
  mov rdi, SYS_PRINT
  syscall
  ret

; void println(rsi, rdx)
;
;   @param {rsi} ponteiro para o inicio da string a ser exibida
;   @parma {rdx} tamanho da string
println:
  call print
  call end_line
  ret

; void exit()
exit:
  mov rax, SYS_EXIT
  xor rdi, rdi
  syscall
