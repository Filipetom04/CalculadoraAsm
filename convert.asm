
section .text
    global string_to_int
    global int_to_string

string_to_int:
    push rbp        ; Salvar o valor de rbp na pilha
    mov rbp, rsp    ; Configurar um novo frame na pilha
    xor rax, rax    ; Limpa rax
    xor rcx, rcx    ; Limpa rcx
.prox_digito:
    movzx rdx, byte [rsi + rcx] ; Carrega o próximo dígito
    cmp rdx, 0          ; Verifica se é o final da string
    je .fim
    cmp rdx, 10         ; Verifica se é uma nova linha
    je .fim
    sub rdx, '0'        ; Converte char para int
    imul rax, 10        ; Multiplica o resultado atual por 10
    add rax, rdx        ; Adiciona o dígito ao resultado
    inc rcx             ; Avança para o próximo caractere
    jmp .prox_digito
.fim:
    mov rsp, rbp        ; Restaurar o valor de rsp
    pop rbp        ; Restaurar o valor de rbp
    ret

int_to_string:
    push rbp        ; Salvar o valor de rbp na pilha
    mov rbp, rsp    ; Configurar um novo frame na pilha
    lea rsi, [rdi + 9] ; Aponta para o final do buffer
    mov byte [rsi], 0     ; Adiciona o terminador nulo
    mov rbx, 10           ; Base 10
.prox_digito:
    dec rsi               ; Move para a próxima posição no buffer
    xor rdx, rdx          ; Limpa rdx para a divisão
    mov rcx, rbx          ; Move o divisor para rcx
    div rcx               ; Divide rax por 10
    add dl, '0'           ; Converte o resto para char
    mov [rsi], dl         ; Armazena o caractere
    test rax, rax         ; Verifica se rax == 0
    jnz .prox_digito      ; Se não, continua
    mov rsp, rbp        ; Restaurar o valor de rsp
    pop rbp        ; Restaurar o valor de rbp
    ret
