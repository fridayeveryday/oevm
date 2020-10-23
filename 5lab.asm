%include "io.inc"

section .data
    mult dd 1, 2, 4, 8
    i dd 0
    n1 dd 0
    n2 dd 0

section .text
    global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    GET_DEC 4, eax ;считывается первое число,
    cmp eax, 2     ; если оно равно 2 то осуществляется 
    je binary      ; прыжок для работы с бинарным представлением
    jne decimal    ; иначе (для 10-чных чисел) происходит простое сложение
    decimal:
        GET_DEC 4, eax 
        GET_DEC 4, ebx
        add eax, ebx
        PRINT_DEC 4, eax ; вывод результата сложения в 10 представлении
        ret
    
    
    
    binary:
        call conv2Dec ; прыжок к метке для перевода 2 числа в 10
        mov [n1], esi ; поместить полученное 10-чное число в переменную n1
      
        call conv2Dec ; аналогично как и выше только для второго числа
        mov [n2], esi
    
        mov eax, [n1] ; перемещение в регистры чисел
        mov ebx, [n2]
        add eax, ebx ; их сложение
        call toBin ; прыжок к метке для перевода числа из 10-чного представления в 2-чное
        xor eax, eax
        ret
             
        
        conv2Dec:
            mov ebp, esp
            GET_DEC 4, eax
            mov ecx, 4 ; размер 
            mov ebx, 10 ; делитель
            l1:              ; деление в цикле и занесение остатка edx в стек
                xor edx,edx
                div ebx            
                push edx
                loop l1 
            ; по итогу в стеке бинарное представление числа по элементам
            mov eax, 3  ; инициализация индекса для прохождения по массиву степеней 2 mult
            mov [i], eax
            xor esi, esi
            toDec: ; перевод числа из 2-чного в 10-чное в цикле
                pop eax
                mov ecx, [i]
                mov ebx, [mult+ecx*4] ; берется степень 2ки
                mul ebx
                add esi, eax ; сложение полученнного результата
                dec ecx ; декремент
                mov [i], ecx
                cmp ecx, 0 ; условие выхода из цикла
                jge toDec
            ret
         
         
         toBin:
            mov ebp, esp
            mov ecx, 4 ; размер числа
            mov ebx, 2 ; делитель
            l2:
                xor edx,edx
                div ebx              ; деление числа на 2
                push edx                ; занесение результата в стек
                loop l2
            mov ecx, 4 ; размер 
            l3: ;вывод полученного числа из стека
                pop eax 
                PRINT_DEC 4, eax
                loop l3
            ret
