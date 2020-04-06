section .text ; 程序段
global _start
_start:
	nop
Read:
    mov eax, 3              ; 指定 sys_read 系统调用
    mov ebx, 0              ; 文件描述符 0 
    mov ecx, Buff           ; 缓冲区地址为 Buff
    mov edx, BuffLen        ; 读取字符数 1 byte
    int 80H
    mov esi, eax            ; 复制系统调用返回值，保存在 esi 中
    cmp eax, 0              ; 如果 eax 为0， 说明到了 EOF
        je Exit

;   扫描缓冲区，改写小写字符为大写
    mov ebp, Buff           ; 基址
    mov ecx, esi            ; 保存读入的字节数到 ecx，即为偏移量
    dec ecx                 ; ebp + ecx 是越界地址，所以调整偏移量 ecx - 1
Scan:
    cmp byte [ebp + ecx], 'a'    ; 字符 < a ，直接输出 
        jb Next
    cmp byte [ebp + ecx], 'z'    ; 字符 > z，直接输出
        ja Next
    sub byte [ebp + ecx], 20H    ; a <= 字符 <= z，所以通过 - 20H 转换为大写字符，再输出
Next:
    dec ecx
    jnz Scan                     ; 如果还有字符，继续 Scan

Write:
    mov eax, 4                  ; sys_write
    mov ebx, 1                  ; 文件描述符
    mov ecx, Buff               ; 缓冲地址
    mov edx, esi                ; 写入字节
    int 80h
    jmp Read

Exit:
	mov eax, 1      ; exit 系统调用号
	mov ebx, 0      ; return 0
	int 80h         ; 发送中断，开始系统调用

section .data       ; 数据段
section .bss        ; 保存为被初始化的数据的 .bss 段
    BuffLen equ 1024
    Buff resb BuffLen