; 程序段
section .text
global _start
_start:
	nop

    mov ebx, Snippet
    mov eax, 13

DoMore:
    add byte [ebx], 32  ; 通过 + 32 将大写字母 修改为 小写
    inc ebx             ; ebx 地址 ++
    dec eax             ; eax 归零后，ZF = 0，jnz 判断为 false，不再跳转到 DoMore
    jnz DoMore

    call printHelloWorld
    call exit

printHelloWorld:
    ; 保护现场
    push rax        
    push rbx
    push rcx
    push rdx

	mov eax, 4      ; sys_write 系统调用
	mov ebx, 1      ; 输出到 文件描述符 1
	mov ecx, msg    ; 起时位置
	mov edx, len    ; 长度
	int 80h         ; 发送中断，开始系统调用

    ; 恢复现场
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

exit:
	mov eax, 1      ; exit 系统调用号
	mov ebx, 0      ; return 0
	int 80h         ; 发送中断，开始系统调用

; 数据段
section .data

    Snippet db "CODEKISSYOUNG"    
    
    
    msg:
        db "Hello world", 10 , "nice to meet you !", 10 ; 10 是换行符 \n 的 assic 码
    len equ $ - msg ; nasm编译时，计算 msg: 到本行的字节长度, 赋值给 len

; 保存为被初始化的数据的 .bss 段
section .bss
