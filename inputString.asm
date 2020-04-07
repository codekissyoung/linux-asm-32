section .text

extern stdin
extern fgets
extern printf
extern scanf

global main
main:
    push ebp
    mov  ebp, esp
    push ebx
    push esi
    push edi
    ;;;;;;;;;; 以上是 C 程序约定，保存现场

    push Sprompt
    call printf
    add  esp, 4         ; printf("Enter string data, followed by Enter : ");

    push dword [stdin]
    push 72
    push intString
    call fgets
    add  esp, 12        ; fgets( intString, 72, stdin );
    
    push intString
    push Sshow
    call printf
    add  esp, 8         ; printf( "The string you entered was : %s ", intString )

    push Iprompt
    call printf
    add  esp, 4         ; printf( "Enter an int value, followed by Enter : ")

    push intVal
    push Iformat
    call scanf
    add esp, 8          ; scanf( "%d", intVal )

    push dword [intVal]
    push Ishow
    call printf
    add esp, 8          ; printf("The int value you entered was : %5d", intVal)

    ;;;;;;;;;; 以下是 C 程序约定，恢复现场
    pop edi
    pop esi
    pop ebx
    mov esp, ebp
    pop ebp
    ret

section .data

Sprompt db 'Enter string data, followed by Enter : ', 0
Iprompt db 'Enter an int value, followed by Enter : ', 0
Iformat db "%d", 0
Sshow db "The string you entered was : %s ", 10, 0
Ishow db 'The int value you entered was : %5d', 10, 0 

section .bss
intVal resd 1           ; double word
intString resb 128      ; 128 byte