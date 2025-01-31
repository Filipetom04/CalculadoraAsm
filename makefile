# Variáveis
ASM = nasm
ASMFLAGS = -f elf64
LD = ld
LDFLAGS =
TARGET = main
OBJ = main.o
LIB = convert.o

# Regras

# Regra principal
all: $(TARGET)

# Regra para gerar o executável
$(TARGET): $(OBJ) $(LIB)
	$(LD) $(LDFLAGS) $(OBJ) $(LIB) -o $(TARGET)
	chmod +x $(TARGET)

# Regra para gerar o objeto principal
$(OBJ): main.asm
	$(ASM) $(ASMFLAGS) main.asm -o $(OBJ)

# Regra para gerar o objeto da biblioteca
$(LIB): main.asm
	$(ASM) $(ASMFLAGS) convert.asm -o $(LIB)

# Regra para limpar arquivos temporários
clean:
	rm -f $(OBJ) $(TARGET) $(LIB)
