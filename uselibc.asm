[SECTION .text]

extern puts
global main

main:
    nop
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    push msg
    call puts

    add esp, 8
    pop edi
    pop esi
    pop ebx
    mov esp, ebp
    pop ebp
    ret

[section .data]
    msg: db "Hello world",0
[section .bss]
