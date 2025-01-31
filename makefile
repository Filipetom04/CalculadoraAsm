# Variáveis
ASM = nasm
ASMFLAGS = -f elf64
LD = ld
LDFLAGS =
TARGET = main
OBJ = main.o

# Regras

# Regra principal
all: $(TARGET)

# Regra para gerar o executável
$(TARGET): $(OBJ)
	$(LD) $(LDFLAGS) $(OBJ) -o $(TARGET)

# Regra para gerar o objeto
$(OBJ): main.asm
	$(ASM) $(ASMFLAGS) main.asm -o $(OBJ)

# Regra para limpar arquivos temporários
clean:
	rm -f $(OBJ) $(TARGET)
