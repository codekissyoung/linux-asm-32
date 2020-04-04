BIN=systemcall

$(BIN) : systemcall.o
	ld systemcall.o -o $(BIN)

systemcall.o : systemcall.asm
	nasm -f elf64 -g -F dwarf systemcall.asm

.PHONY=clean
clean:
	$(RM) $(BIN) *.o

