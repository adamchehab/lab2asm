format PE console

entry Start

include 'C:\fasmw17327\INCLUDE\win32a.inc'

section '.data' data readable writable
    strA db 'Enter A: ', 0
    strC db 'Enter C: ', 0
    strD db 'Enter D: ', 0

    resStr db 'Result: %d', 0

    a dd 1
    c dd 2
    d dd 3
    res dd ?


section '.code' code readable executable

    Start:
        ; (2c + d – 52) / (a/4 + 1)

        ; (2c + d – 52)
        mov eax, [c]
        mov ebx, 2
        imul ebx
        add eax, [d]
        sub eax, 52

        ; move eax to ebx
        mov ebx, eax

        ; move ebx to res
        mov [res], ebx

        ; output result
        push [res]
        push resStr
        call [printf]


        ; prevent window from closing
        call [getch]                

        ; leave programm
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