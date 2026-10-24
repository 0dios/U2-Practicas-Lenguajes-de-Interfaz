;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : Hola Mundo con Irvine32 (NO SOLICITADA)
;   Descripcion : Programa basico para imprimir hola mundo en consola
;                 usando Irvine32.

INCLUDE Irvine32.inc

.data
mensaje BYTE "Hola Mundo! Con Irvine32", 0

.code
main proc
    mov edx, OFFSET mensaje
    call WriteString
    call Crlf
    exit
main endp
end main