section .text

extern puts
global main

main:
    nop
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    ;;;;;;;;;;;;;; 调用约定，保护现场

    push msg        ; 将 msg 地址压入栈，作为 puts 函数的入参
    call puts       ; 调用 glibc 中的 puts 函数
    add esp, 4      ; 清理栈，将 esp 调回 4 个字节

    ;;;;;;;;;;;;;; 调用约定，清理现场
    pop edi         ; 恢复保存的寄存器
    pop esi
    pop ebx
    mov esp, ebp    ; 返回之前销毁栈空间
    pop ebp
    ret             ; 将控制返回给 Linux

section .data
    msg: db "Hello world",0
section .bss