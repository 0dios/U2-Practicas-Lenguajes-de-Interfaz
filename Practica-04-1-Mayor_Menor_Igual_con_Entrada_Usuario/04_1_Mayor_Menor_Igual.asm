;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 4.1 - MAYOR, MENOR O IGUAL CON ENTRADA DEL USUARIO
;   Descripcion : En este programa se leen dos numeros enteros, cuando estos se comparan se
;                 muestra si son iguales o cual es mayor y cual es menor.



INCLUDE Irvine32.inc

.data
    n1 BYTE "Escribe el primer numero a comparar: ", 0
    n2 BYTE "Escribe el segundo numero a comparar: ", 0
    msgIguales BYTE "Los numeros son iguales", 0
    msgMayor BYTE "El primer numero es mayor que el segundo numero", 0
    msgMenor BYTE "El primer numero es menor que el segundo numero", 0

    ;Variables para guardar los numeros
    num1 DWORD ?
    num2 DWORD ?

.code
main PROC

    mov edx, OFFSET n1 
    call WriteString 
    call ReadInt ;Se lee el primer numero
    mov num1, eax 

    mov edx, OFFSET n2 
    call WriteString 
    call ReadInt ;Se lee el segundo numero
    mov num2, eax 

    ;Se copian los numeros a los registros eax, ebx
    mov eax, num1 
    mov ebx, num2 

    ;Se comparan los numeros
    cmp eax, ebx 
    je iguales  ;JE = la resta dio 0 entonces son iguales
    jg mayor   ;JG = Mayor con signo, se revisan las banderas ZF=0 y SF=OF
    jl menor  ;JL = menor con signo, Se revisa que SF /= OF


;Impresion de mensajes dependiendo del caso dado
iguales:
    mov edx, OFFSET msgIguales 
    call WriteString 
    jmp fin 
mayor:
    mov edx, OFFSET msgMayor  
    call WriteString 
    jmp fin 
menor:
    mov edx, OFFSET msgMenor 
    call WriteString 
    jmp fin
fin:
    call Crlf 
    exit 

main ENDP

END main