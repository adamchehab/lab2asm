format PE console

entry Start

include 'C:\fasmw17327\INCLUDE\win32a.inc'

section '.data' data readable writable
        resStr db 'Result: %d', 0
        
        a dd -10
        b dd 3


section '.code' code readable executable

    Start:
        mov eax, [a]
        mov ecx, 2
        cdq
        idiv ecx
        mov [b], edx

        push edx
        push resStr
        call [printf]

        ; LEAVE PROGRAMM

        ; prevent console from closing
        call [getch]                

        ; leave programm
        push 0
        call [ExitProcess]


; section for libraries
section '.idata' import data readable
        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'
        
        import  kernel,\
                ExitProcess, 'ExitProcess'

        import  msvcrt,\
                printf, 'printf',\
                scanf, 'scanf',\
                getch, '_getch'