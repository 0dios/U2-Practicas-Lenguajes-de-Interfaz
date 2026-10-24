;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 5.1 - REPETIR HASTA QUE EL USUARIO INGRESE 0
;   Descripcion : En este codigo se aplica un programa que pide ingresar repetidamente numeros
;                 hasta que el usuario ingrese un 0, cuando se ingrese este el programa terminara



INCLUDE Irvine32.inc

.data
    numero BYTE "Escribe un numero: ", 0
    mensajeIntentar BYTE "Ingrese nuevamente un numero", 0
    mensajeCero BYTE "Programa terminado, se ingreso el 0", 0

.code
main PROC
ciclo:
    mov edx, OFFSET numero 
    call Crlf 
    call WriteString 
    call ReadInt ;Se lee el numero en consola
    cmp eax, 0 ;Se compara con 0
    je fin ;Si son iguales salta a fin

    mov edx, OFFSET mensajeIntentar 
    call Crlf 
    call WriteString 
    jmp ciclo ;Siguiente iteracion

fin:
    mov edx, OFFSET mensajeCero 
    call Crlf 
    call WriteString 

    exit 
main ENDP

END main