section .data
    tit      db  10, '-----------------',10, '| Calculadora |',10 ,0
    ltit     equ $ - tit
    obVal1   db  10,'Valor 1:',0
    lobVal1  equ $ - obVal1
    obVal2   db  10,'Valor 2:',0
    lobVal2  equ $ - obVal2
    opc1     db  10,'1. Adicionar',0
    lopc1    equ $- opc1
    opc2     db  10,'2. Subtrair',0
    lopc2    equ $- opc2
    opc3     db  10,'3. Multiplicar',0
    lopc3    equ $- opc3
    opc4     db  10,'4. Dividir',0
    lopc4    equ $- opc4
    msgOpc   db  10,'Deseja Realizar?',0
    lmsgOpc  equ $- msgOpc
    msgErro  db  10,'Valor da opção invalida!!',0
    lmsgErro equ $- msgErro
    msgDivZero db 10,'Erro: Divisão por zero!',0
    lmsgDivZero equ $- msgDivZero
    msgSubNeg  db  10,'Erro: Subtração resulta em valor negativo!',0
    lmsgSubNeg equ $- msgSubNeg
    nLinha   db 10,0
    lLinha   equ $ - nLinha
    result_msg db 10, 'Resultado: ', 0
    lresult_msg equ $ - result_msg

section .bss
    opc      resb 2
    num1     resb 10
    num2     resb 10
    result   resb 10

section .text
    global _start
    extern string_to_int
    extern int_to_string

_start:
    ; Exibir o título
    mov rax, 1          ; sys_write
    mov rdi, 1          ; file descriptor (stdout)
    mov rsi, tit        ; mensagem
    mov rdx, ltit       ; tamanho da mensagem
    syscall

    ; Solicitar Valor 1
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, obVal1     ; mensagem
    mov rdx, lobVal1    ; tamanho da mensagem
    syscall

    ; Ler Valor 1
    mov rax, 0          ; sys_read
    mov rdi, 0          ; file descriptor (stdin)
    mov rsi, num1       ; buffer para armazenar a entrada
    mov rdx, 10         ; tamanho do buffer
    syscall

    ; Solicitar Valor 2
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, obVal2     ; mensagem
    mov rdx, lobVal2    ; tamanho da mensagem
    syscall

    ; Ler Valor 2
    mov rax, 0          ; sys_read
    mov rdi, 0          ; stdin
    mov rsi, num2       ; buffer para armazenar a entrada
    mov rdx, 10         ; tamanho do buffer
    syscall

    ; Exibir opções
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, opc1       ; mensagem
    mov rdx, lopc1      ; tamanho da mensagem
    syscall

    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, opc2       ; mensagem
    mov rdx, lopc2      ; tamanho da mensagem
    syscall

    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, opc3       ; mensagem
    mov rdx, lopc3      ; tamanho da mensagem
    syscall

    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, opc4       ; mensagem
    mov rdx, lopc4      ; tamanho da mensagem
    syscall

    ; Solicitar a operação
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, msgOpc     ; mensagem
    mov rdx, lmsgOpc    ; tamanho da mensagem
    syscall

    ; Ler a operação
    mov rax, 0          ; sys_read
    mov rdi, 0          ; stdin
    mov rsi, opc        ; buffer para armazenar a entrada
    mov rdx, 2          ; tamanho do buffer
    syscall

    ; Converter a operação para número
    movzx rax, byte [opc]
    sub rax, '0'

    ; Verificar a operação escolhida
    cmp rax, 1
    je adicionar
    cmp rax, 2
    je subtrair
    cmp rax, 3
    je multiplicar
    cmp rax, 4
    je dividir

    ; Se a operação for inválida, exibir mensagem de erro
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, msgErro    ; mensagem de erro
    mov rdx, lmsgErro   ; tamanho da mensagem
    syscall
    jmp saida

adicionar:
    ; Converter num1 para inteiro
    mov rsi, num1
    call string_to_int
    mov rbx, rax        ; rbx = num1

    ; Converter num2 para inteiro
    mov rsi, num2
    call string_to_int
    add rbx, rax        ; rbx = num1 + num2

    ; Exibir o resultado
    mov rdi, result       ;endereço do buffer resultado
    mov rax, rbx
    call int_to_string
    call mostrar_valor
    jmp saida

subtrair:
    ; Converter num1 para inteiro
    mov rsi, num1
    call string_to_int
    mov rbx, rax        ; rbx = num1

    ; Converter num2 para inteiro
    mov rsi, num2
    call string_to_int

    cmp rbx, rax          ; Comparar num1 com num2 (rbx - rax)
    jl subtracao_negativa  ; Se num1 < num2, pular para subtracao_negativa

    sub rbx, rax        ; rbx = num1 - num2

    ; Exibir o resultado
    mov rdi, result      ;endereço do buffer resultado
    mov rax, rbx
    call int_to_string
    call mostrar_valor
    jmp saida

subtracao_negativa:
    ; Exibir mensagem de erro de subtração negativa
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, msgSubNeg ; mensagem de erro
    mov rdx, lmsgSubNeg ; tamanho da mensagem
    syscall
    jmp saida

multiplicar:
    ; Converter num1 para inteiro
    mov rsi, num1
    call string_to_int
    mov rbx, rax        ; rbx = num1

    ; Converter num2 para inteiro
    mov rsi, num2
    call string_to_int
    imul rbx, rax       ; rbx = num1 * num2

    ; Exibir o resultado
    mov rdi, result      ;endereço do buffer resultado
    mov rax, rbx
    call int_to_string
    call mostrar_valor
    jmp saida

dividir:
    ; Converter num1 para inteiro
    mov rsi, num1
    call string_to_int
    mov rbx, rax        ; rbx = num1

    ; Converter num2 para inteiro
    mov rsi, num2
    call string_to_int
    cmp rax, 0          ; Verificar se o divisor é zero
    je divisao_por_zero ; Se for zero, exibir erro

    ; Realizar a divisão
    mov rcx, rax        ; Movendo o divisor para rcx
    mov rax, rbx        ; Movendo o dividendo para rax
    xor rdx, rdx        ; Limpar rdx para a divisão
    idiv rcx           ; rax = rax / rcx (quociente em rax, resto em rdx)

    mov rbx, rax        ; rbx = resultado da divisão

    ; Exibir o resultado
    mov rdi, result      ;endereço do buffer resultado
    mov rax, rbx
    call int_to_string
    call mostrar_valor
    jmp saida

divisao_por_zero:
    ; Exibir mensagem de erro de divisão por zero
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, msgDivZero ; mensagem de erro
    mov rdx, lmsgDivZero ; tamanho da mensagem
    syscall
    jmp saida

saida:
    ; Nova linha
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, nLinha     ; mensagem
    mov rdx, lLinha     ; tamanho da mensagem
    syscall

    ; Sair do programa
    mov rax, 60         ; sys_exit
    xor rdi, rdi        ; código de saída 0
    syscall

; Função para exibir o valor
mostrar_valor:
    ; Exibir mensagem "Resultado:"
    mov rax, 1
    mov rdi, 1
    mov rsi, result_msg
    mov rdx, lresult_msg
    syscall

    ; Exibir o valor convertido
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, result     ; endereço da string do resultado
    mov rdx, 10         ; tamanho máximo do buffer de resultado
    mov rcx, result     ; ponteiro inicial da string do resultado
.contar_caracteres:
    cmp byte [rcx], 0 ; compara o byte apontado por rcx com 0
    je .fim_contagem    ; se for 0, vai para o fim_contagem
    inc rcx             ; incrementa o ponteiro rcx
    inc rdx             ; incrementa o tamanho do buffer
    jmp .contar_caracteres
.fim_contagem:
    sub rdx,1          ;retira 1 do tamanho do buffer para eliminar o caractere nulo
    syscall
    ret
