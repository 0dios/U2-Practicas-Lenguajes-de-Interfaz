;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 1 - CICLOS NUMERICOS
;   Descripcion : Se usa la instruccion LOOP para hacer que en
;                 un ciclo se imprima la cuenta regresiva del 5 a 1
;                 usando el registro ECX.

INCLUDE Irvine32.inc
.code
main proc
    mov ecx, 5         ;numero de ciclos que hara el programa
    jecxz finciclo     ;brincar si ecx es cero y no entra al ciclo

    ciclo:
        mov eax, ecx   ;Se copia el numero de ciclo en eax
        call WriteDec  ;Se imprime el numero del ciclo 
        call crlf
        loop ciclo     ;se decrementa ecx 

    finciclo:
        exit

main endp
end main