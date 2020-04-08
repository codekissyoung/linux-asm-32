ALL = systemcall hexdump uselibc inputString mbr
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

# uselibc 32 位
uselibc : uselibc.o
	gcc -m32 uselibc.o -o uselibc
uselibc.o : uselibc.asm
	nasm -f elf32 -F dwarf uselibc.asm -l uselibc.lst

# inputString 32 位
inputString : inputString.o
	gcc -m32 inputString.o -o inputString
inputString.o : inputString.asm
	nasm -f elf32 -F dwarf inputString.asm -l inputString.lst

# mbr 32 位
# mbr : mbr.o
# 	ld mbr.o -o mbr.iso
mbr : mbr.asm
	nasm -f obj mbr.asm -o mbr -l mbr.lst

.PHONY=clean
clean:
	$(RM) $(ALL) *.o *.lst
