# Variáveis
ASM = nasm
ASMFLAGS = -f elf64
LD = ld
LDFLAGS =
TARGET = main
OBJ = main.o
LIBS = convert.o calcular.o menu.o

# Regras

# Regra principal
all: $(TARGET)

# Regra para gerar o executável
$(TARGET): $(OBJ) $(LIBS)
	@echo "Linkando objetos..."
	$(LD) $(LDFLAGS) $(OBJ) $(LIBS) -o $(TARGET)
	chmod +x $(TARGET)
	@echo "Executável gerado: $(TARGET)"

# Regra para gerar o objeto principal
$(OBJ): main.asm
	@echo "Compilando main.asm..."
	$(ASM) $(ASMFLAGS) main.asm -o $(OBJ)

# Regra para gerar o objeto da biblioteca convert
convert.o: convert.asm
	@echo "Compilando convert.asm..."
	$(ASM) $(ASMFLAGS) convert.asm -o convert.o

# Regra para gerar o objeto da biblioteca calcular
calcular.o: calcular.asm
	@echo "Compilando calcular.asm..."
	$(ASM) $(ASMFLAGS) calcular.asm -o calcular.o

# Regra para gerar o objeto da biblioteca menu
menu.o: menu.asm
	@echo "Compilando menu.asm..."
	$(ASM) $(ASMFLAGS) menu.asm -o menu.o

# Regra para executar o programa
run: $(TARGET)
	@echo "Executando $(TARGET)..."
	./$(TARGET)

# Regra para limpar arquivos temporários
clean:
	@echo "Limpando arquivos temporários..."
	rm -f $(OBJ) $(TARGET) $(LIBS) *.lst *.map

# Regra para compilar com símbolos de depuração
debug: ASMFLAGS += -g
debug: all
