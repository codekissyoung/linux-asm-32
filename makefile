ALL = systemcall hexdump
all : $(ALL)

# systemcall
systemcall : systemcall.o
	ld systemcall.o -o systemcall
systemcall.o : systemcall.asm
	nasm -f elf64 -g -F dwarf systemcall.asm -l systemcall.lst

# hexdump
hexdump : hexdump.o
	ld hexdump.o -o hexdump
hexdump.o : hexdump.asm
	nasm -f elf64 -g -F dwarf hexdump.asm -l hexdump.lst

.PHONY=clean
clean:
	$(RM) $(ALL) *.o *.lst
