; programm - eqation solver: (2c + d – 52) / (a/4 + 1)

format PE console

; tell programm where is entery point
entry Start

include 'C:\fasmw17327\INCLUDE\win32a.inc'


; section for initialising variables
section '.data' data readable writable

	; strings to invite user to input
	strA db 'Enter A: ', 0
	strB db 'Enter B: ', 0
	strC db 'Enter C: ', 0
	strD db 'Enter D: ', 0

	; string to output result
	resStr db 'Result: %d', 0

	; string with space
	spaceStr db ' %d', 0
	
	; input numbers
	a dd ?
	b dd ? 
	c dd ?
	d dd ?

	; variable to store if a is odd or not: if = 1 then odd if = 0 then notOdd
	odd dd ?

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

		; invite to enter B
        push strB
        call [printf]

        ; read input to B
        push b
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
        mov [odd], edx


	; SOLVE EQUATION

        ; (2c – d/3) / (b – a/4).

		; (b – a/4)

			; (a/4)
			mov eax, [a]
			cdq
			mov ecx, 4
			idiv ecx

			; MOD OR DIV
			cmp [odd], 0
			jne isOdd
				mov eax, edx
			isOdd:
			mov ebx, eax

			; (b - a/4)
			mov eax, [b]
			sub eax, ebx
			mov esi, eax
			; (result is now in ESI )

		; (2c – d/3)

			; (2*c)
			mov eax, [c]
     		mov ebx, 2
       		imul ebx
			mov edi, eax 
			; (result is now in EDI)

			; (d/3)
			mov eax, [d]
			cdq
			mov ecx, 3
			idiv ecx

			; MOD OR DIV
			cmp [odd], 0
			jne isOdd1
				mov eax, edx
			isOdd1:
			mov ebx, eax
			; (is now in EBX)

			; (2c - d/3)
			mov eax, edi		; move 2*c to eax
			sub eax, ebx
			; (result is now in EAX )

		; (2c – d/3) / (b – a/4)
			cdq
			mov ecx, esi		; move (b – a/4) to ecx
			idiv ecx

			; MOD OR DIV
			cmp [odd], 0
			jne isOdd2
				mov eax, edx
			isOdd2:
			mov ebx, eax
			; (is now in EBX)

	; OUTPUT RESULT
        push ebx
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