section .data
    tit      db  10, '-----------------', 10, '| Calculadora |', 10 ,0
    ltit     equ $ - tit
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

section .bss
    opc      resb 2

section .text
    global exibir_menu
    global obter_opcao

; Função para exibir o menu
exibir_menu:
    ; Exibir o título
    mov rax, 1          ; sys_write
    mov rdi, 1          ; file descriptor (stdout)
    mov rsi, tit        ; mensagem
    mov rdx, ltit       ; tamanho da mensagem
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

    ret

; Função para obter a opção do usuário
; Saída: rax = opção (1, 2, 3, 4)
obter_opcao:
    ; Ler a operação
    mov rax, 0          ; sys_read
    mov rdi, 0          ; stdin
    mov rsi, opc        ; buffer para armazenar a entrada
    mov rdx, 2          ; tamanho do buffer
    syscall

    ; Converter a operação para número
    movzx rax, byte [opc]
    sub rax, '0'

    ret
