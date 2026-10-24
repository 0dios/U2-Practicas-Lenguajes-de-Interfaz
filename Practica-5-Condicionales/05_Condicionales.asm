;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 5 - CONDICIONALES
;   Descripcion : Codigo que hace la logica de los dos ciclos principales
;                 While: Revisa la condicion antes de ejecutar las instrucciones, por lo que puede que no se ejecute nunca.
;                 Do-While: Ejecuta las instrucciones al menos una vez y despues revisa si la condicion cumple.

INCLUDE Irvine32.inc

.code
main PROC
    mov ebx, 1 ;EBX inicia en 1

;Puede que no se ejecute si la condicion al inicio da mayor
cicloWhile:
    cmp ebx, 100 
    jg fin ;Hasta que ebx sea mayor que 100 se va a fin
    mov eax, ebx    ;Se copia el valor a eax
    call WriteDec ;Escribe el numero en eax
    call Crlf 
    inc ebx     ;se incrementa ebx
    jmp cicloWhile ;siguiente iteracion

fin:
    call Crlf 
    mov ebx, 1


;Se ejecuta al menos una vez porque la condicion esta hasta el final, despues de las instrucciones
cicloDoWhile:
    mov eax, ebx 
    call WriteDec 
    call Crlf 
    inc ebx 
    cmp ebx, 100 
    jle cicloDoWhile 

    exit 
main ENDP

END main