;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : Contador de Bytes (NO SOLICITADA)
;   Descripcion : Se pide al usuario su nombre, este se muestra en pantalla y
;                 decir cuantos caracteres ha escrito.


INCLUDE Irvine32.inc

.data
    mensajeEntrada BYTE "Escribe tu nombre: ", 0
    mensajeLongitud BYTE "Caracteres capturados: ", 0
    nombre BYTE 30 DUP(0)
    longitud DWORD ?

.code
main proc
    ; IMPRIMIR MENSAJE DE ESCRIBE TU NOMBRE
    mov edx, OFFSET mensajeEntrada
    call WriteString
    call crlf

    ; LEER NOMBRE ESCRITO
    mov edx, OFFSET nombre
    mov ecx, SIZEOF nombre
    call ReadString
    call crlf

    ; SE COPIA LA LONGITUD EN LA VARIABLE LONGITUD
    mov longitud, eax
    

    ; SE IMPRIME EL NOMBRE ESCRITO POR EL USUARIO
    mov edx, OFFSET nombre
    call WriteString
    call crlf

    ; IMPRIMIR MENASJE DE CARACTERES CAPTURADOS
    mov edx, OFFSET mensajeLongitud
    call WriteString

    ; IMPRIMIR LOS CARACTERES ESCRITOS
    mov eax, longitud
    call WriteDec
    call crlf


    exit
main endp
end main