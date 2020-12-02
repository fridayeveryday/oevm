%include "io.inc"

section .text
first   db "101", 0
second   db "011", 0
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    xor eax, eax
    xor ebx, ebx
    lea esi, [first]
    mov ecx, 3
       l1:
        mov bl, [esi]
        sub bl, 30h 
        add al, bl
        shl al, 1
        inc esi
        loop l1
   shr al,1
   lea esi, [second]
   mov ecx, 3
   xor ebx, ebx
   xor dx, dx
       l2:
        mov bl, [esi]
        sub bl, 30h 
        add dl, bl
        shl dl, 1
        inc esi
        loop l2
   shr dl,1
   add ax, dx
    
   PRINT_DEC 1, ax
   ret
