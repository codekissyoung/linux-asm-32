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

    mov ebp, eax            ; 保存下系统调用返回值
    cmp eax, 0              ; 如果 eax 为0， 说明到了 EOF
        je Exit

    mov esi, Buff           ; esi 缓冲地址
    mov edi, HexStr         ; 字符串地址
    xor ecx, ecx            ; ecx 清零

Scan:
    xor eax, eax            ; eax 清零

    mov edx, ecx
    shl edx, 1
    add edx, ecx

    mov al, byte [esi + ecx]
    mov ebx, eax

    ; 低字节插入字符串
    and al, 0Fh                     ; 通过 and 00001111 取低字节
    mov al, byte [Digits + eax]
    mov byte [HexStr + edx + 1], al

    ; 高字节插入字符串
    shr bl, 4                       ; bl >> 4
    mov bl, byte [Digits + ebx]
    mov byte [HexStr + edx + 0], bl

    inc ecx
    cmp ecx, ebp
        jna Scan                    ; ecx <= ebp

; 将 HexStr 写入标准输出
Write:
    mov eax, 4
    mov ebx, 1
    mov ecx, HexStr
    mov edx, HexLen
    int 80h
    jmp Read

Exit:
	mov eax, 1      ; exit 系统调用号
	mov ebx, 0      ; return 0
	int 80h         ; 发送中断，开始系统调用

section .data       ; 数据段
    Digits: db "0123456789ABCDEF"
    HexStr: db "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00", 10
    HexLen equ $ - HexStr

section .bss        ; 保存为被初始化的数据的 .bss 段
    BuffLen equ 16
    Buff resb BuffLen