ALL = systemcall hexdump uselibc inputString mbr.o
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

# uselibc
uselibc : uselibc.o
	gcc -m32 uselibc.o -o uselibc
uselibc.o : uselibc.asm
	nasm -f elf32 -F dwarf uselibc.asm -l uselibc.lst

# inputString
inputString : inputString.o
	gcc -m32 inputString.o -o inputString
inputString.o : inputString.asm
	nasm -f elf32 -F dwarf inputString.asm -l inputString.lst

# mbr  -f bin 就是只生成与程序指令一样的机器码文件
mbr.o : mbr.asm
	nasm -f bin mbr.asm -o mbr.o

.PHONY=clean
clean:
	$(RM) $(ALL) *.o *.lst
