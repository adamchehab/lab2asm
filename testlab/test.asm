format PE console

entry Start

include 'C:\fasmw17327\INCLUDE\win32a.inc'

section '.data' data readable writable
    strA db 'Enter A: ', 0
    strC db 'Enter C: ', 0
    strD db 'Enter D: ', 0

    resStr db 'Result: %d', 0

    spaceStr db ' %d', 0

    A dd ?
    C dd ?
    D dd ?


section '.code' code readable executable

    Start:
        ; invite to enter A
        push strA
        call [printf]

        ; read input to A
        push A
        push spaceStr
        call [scanf]

        ; invite to enter C
        push strC
        call [printf]

        ; read input to C
        push C
        push spaceStr
        call [scanf]

        ; invite to enter D
        push strD
        call [printf]

        ; read input to D
        push D
        push spaceStr
        call [scanf]

        ;y=(2*c-d+23)/(a/4-1)

        ;ebx=(2*c-d+23)
        mov eax,[e]
        mov ebx, 2
        imul ebx
        sub eax, [d]
        add eax, 23
        mov ebx, eax

        ;ecx=(a/4-1)
        mov eax,[a]
        cdq
        mov ecx, 4
        idiv ecx
        sub eax, 1
        mov ecx, eax

        ;eax=(2*c-d+23)/(a/4-1)
        mov eax, ebx
        idiv ecx
        
        ;y=(2*c-d+23)/(a/4-1)
        mov [y], eax


        jmp finish

    finish:

        call [getch]                    ; чтобы окно не закрылось

        push 0
        call [ExitProcess]

section '.idata' import data readable
    library kernel, 'kernel32.dll',\
            msvcrt, 'msvcrt.dll'
        
    import  kernel,\
            ExitProcess, 'ExitProcess'

    import  msvcrt,\
            printf, 'printf',\
            scanf, 'scanf',\
            getch, '_getch'