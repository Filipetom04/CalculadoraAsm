section .text
    global adicionar
    global subtrair
    global multiplicar
    global dividir

; Função para adicionar dois números
; Entrada: rdi = num1, rsi = num2
; Saída: rax = resultado
adicionar:
    mov rax, rdi        ; rax = num1
    add rax, rsi        ; rax = num1 + num2
    ret

; Função para subtrair dois números
; Entrada: rdi = num1, rsi = num2
; Saída: rax = resultado
subtrair:
    mov rax, rdi        ; rax = num1
    sub rax, rsi        ; rax = num1 - num2
    ret

; Função para multiplicar dois números
; Entrada: rdi = num1, rsi = num2
; Saída: rax = resultado
multiplicar:
    mov rax, rdi        ; rax = num1
    imul rax, rsi       ; rax = num1 * num2
    ret

; Função para dividir dois números
; Entrada: rdi = num1, rsi = num2
; Saída: rax = resultado (quociente)
dividir:
    mov rax, rdi        ; rax = num1
    xor rdx, rdx        ; Limpar rdx para a divisão
    idiv rsi            ; rax = rax / rsi (quociente em rax, resto em rdx)
    ret
