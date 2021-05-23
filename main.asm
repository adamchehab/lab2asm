; programm - eqation solver: (2c + d – 52) / (a/4 + 1)

format PE console

; tell programm where is entery point
entry Start

include 'C:\fasmw17327\INCLUDE\win32a.inc'


; section for initialising variables
section '.data' data readable writable

	; strings to invite user to input
	strA db 'Enter A: ', 0
	strC db 'Enter C: ', 0
	strD db 'Enter D: ', 0

	; string to output result
	resStr db 'Result: %d', 0

	; string with space
	spaceStr db ' %d', 0
	
	; input numbers
	a dd ?
	c dd ?
	d dd ?

	; variable to store if a is odd or not: if = 1 then odd if = 0 then notOdd
	b dd ? 


; section for code
section '.code' code readable executable

    Start:

	; INPUT SECTION
        
        ; invite to enter A
        push strA
        call [printf]

        ; read input to A
        push a
        push spaceStr
        call [scanf]

        ; invite to enter C
        push strC
        call [printf]

        ; read input to C
        push c
        push spaceStr
        call [scanf]

        ; invite to enter D
        push strD
        call [printf]

        ; read input to D
        push d
        push spaceStr
        call [scanf]

	; CHECK IF A IS ODD

        mov eax, [a]
        cdq
        mov ecx, 2
        idiv ecx
        mov [b], edx


	; SOLVE EQUATION

        ; (2c + d – 52) / (a/4 + 1)

        ; (2c + d – 52)
        mov eax, [c]
        mov ebx, 2
        imul ebx
        add eax, [d]
        sub eax, 52
        mov ebx, eax
        ; (result is in EBX)

        ;ecx=(a/4-1)
        mov eax, [a]
        cdq
        mov ecx, 4
        idiv ecx

        ; MOD OR DIV - we enter this code if a is not odd
        cmp [b], 0
        jne isOdd
        	mov eax, edx
		
        isOdd:
        add eax, 1
        mov ecx, eax
        ; (result is in ECX)

        ;eax=(2*c-d+23)/(a/4-1)
        mov eax, ebx
        cdq
        idiv ecx

        ; MOD OR DIV - we enter this code if a is not odd
        cmp [b], 0
        jne isOdd1
        	mov eax, edx
		
        isOdd1:
        ; (result is in EAX)

	; OUTPUT RESULT
        push eax
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