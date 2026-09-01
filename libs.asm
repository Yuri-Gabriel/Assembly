%include "syscall.asm"

section .data
  endline db 0x0A

section .text

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
    ret

; void end_line()
end_line:
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
    mov rax, SYS_INPUT               ; sys_read
    mov rdi, SYS_INPUT               ; stdin
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
    mov rax, SYS_PRINT               ; sys_write
    mov rdi, SYS_PRINT               ; stdout
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
    mov rax, SYS_EXIT               ; sys_exit
    xor rdi, rdi
    syscall
