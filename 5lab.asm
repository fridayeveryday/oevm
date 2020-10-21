%include "io.inc"

section .data
    msg db 'Hello, world!', 0
    mult dd 1, 2, 4, 8
    i dd 0
    n1 dd 0
    n2 dd 0

section .text
    global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    GET_DEC 4, eax
    cmp eax, 2
    je binary
    
    GET_DEC 4, eax
    GET_DEC 4, ebx
    add eax, ebx
    PRINT_DEC 4, eax
    ret
    
    
    
    binary:
        call conv2Dec
        mov [n1], esi
        ;PRINT_DEC 4, [n1]
      
        call conv2Dec
        mov [n2], esi
        ;PRINT_DEC 4, [n2]
    
        mov eax, [n1]
        mov ebx, [n2]
        add eax, ebx
        call toBin
        xor eax, eax
        ret
             
        
        conv2Dec:
            mov ebp, esp
            GET_DEC 4, eax
            mov ecx, 4 ; размер 
            mov ebx, 10 ; делитель
            l1:
                xor edx,edx
                div ebx            
                push edx
                loop l1 
            mov eax, 3  
            mov [i], eax
            xor esi, esi
            toDec:
                pop eax
                mov ecx, [i]
                mov ebx, [mult+ecx*4]
                mul ebx
                add esi, eax
                dec ecx
                mov [i], ecx
                cmp ecx, 0
                jge toDec
            ret
         
         
         toBin:
            mov ebp, esp
            mov ecx, 4 ; размер 
            mov ebx, 2 ; делитель
            l2:
                xor edx,edx
                div ebx            
                push edx
                loop l2
            mov ecx, 4 ; размер 
            l3:
                pop eax
                PRINT_DEC 4, eax
                loop l3
            ret
    
    
