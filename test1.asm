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
 