<<<<<<< HEAD
=======
%include "syscall.asm"

>>>>>>> 8e78484b1cb33b63109b89a773949fcc6fb83e95
section .data
  endline db 0x0A

section .text

<<<<<<< HEAD
; rax str_to_int(rsi, rcx)
;   @param {rsi} ponteiro para o inicio da string no buffer (char*)
;   @param {rcx} quantidade de bytes lidos / a converter
;   @return {rax} numero inteiro convertido
str_to_int:
    push rbx
    push rcx
    push rsi

    xor rbx, rbx                ; Acumulador zerado

    test rcx, rcx
    jz .done

    .run:
        movzx rax, byte [rsi]
        cmp al, 0x0A                ; Se for '\n', encerra a conversão
        je .done
        cmp al, '0'
        jb .done                    ; Se for menor que '0', encerra
        cmp al, '9'
        ja .done                    ; Se for maior que '9', encerra

        sub al, '0'
        imul rbx, rbx, 10
        add rbx, rax
        inc rsi
        loop .run

.done:
    mov rax, rbx                ; Devolve o resultado numérico em RAX
    pop rsi
    pop rcx
    pop rbx
    ret

; rax int_to_str(rax, rdx)
;   @param {rax} numero a ser convertido
;   @param {rdx} ponteiro para o inicio do buffer onde sera armazenado
;   @return {rax} ponteiro para o inicio exato da string gerada dentro do buffer
int_to_str:
    push rbx
    push rcx
    push rdx

    mov rbx, 10
    lea rsi, [rdx + 15]         ; Aponta para o fim de um buffer de 16 bytes
    mov byte [rsi], 0x00        ; Finalizador nulo

    .run:
        xor rdx, rdx
        div rbx                     ; Divide RAX por 10 (Resto fica em RDX)
        add dl, '0'                 ; Converte o resto para caractere ASCII
        dec rsi
        mov byte [rsi], dl
        test rax, rax
        jnz .run

    mov rax, rsi                ; Retorna em RAX o ponteiro de onde a string começou
    pop rdx
    pop rcx
    pop rbx
=======
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
>>>>>>> 8e78484b1cb33b63109b89a773949fcc6fb83e95
    ret

; void end_line()
end_line:
<<<<<<< HEAD
    push rsi
    push rdx
    mov rsi, endline
    mov rdx, 0x01
    call print
    pop rdx
    pop rsi
    ret

; rax input(rsi, rdx)
;   @param {rsi} ponteiro para o buffer de entrada
;   @param {rdx} tamanho do buffer
;   @return {rax} numero de caracteres lidos no terminal
input:
    push rcx
    push r11
    mov rax, 0x00               ; sys_read
    mov rdi, 0x00               ; stdin
    syscall
    pop r11
    pop rcx
    ret

; void print(rsi, rdx)
;   @param {rsi} ponteiro para a string a ser exibida
;   @param {rdx} tamanho da string
print:
    push rcx                    ; Preserva RCX (sobrescrito pela instrução syscall)
    push r11                    ; Preserva R11 (sobrescrito pela instrução syscall)
    mov rax, 0x01               ; sys_write
    mov rdi, 0x01               ; stdout
    syscall
    pop r11
    pop rcx
    ret

; void println(rsi, rdx)
println:
    call print
    call end_line
    ret

; void exit()
exit:
    mov rax, 0x3c               ; sys_exit
    xor rdi, rdi
    syscall
=======
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
>>>>>>> 8e78484b1cb33b63109b89a773949fcc6fb83e95
