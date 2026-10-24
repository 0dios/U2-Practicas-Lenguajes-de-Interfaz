;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 2 - CAPTURA Y DESPLEGADO DE MENSAJES
;   Descripcion : Se pide al usuario su nombre por consola, luego se imprime la cantidad
;                 de caracteres que escribio y se imprime el nombre ingresado por el usuario.

INCLUDE Irvine32.inc

.data
    mensaje BYTE "Escribe tu nombre: ", 0
    nombre BYTE 15 DUP(0) ;Se reserva el espacio para el nombre

.code
main proc
    
    mov edx, OFFSET mensaje
    call WriteString              ;Funcion de irvine para escribir el mensaje de texto

    mov edx, OFFSET nombre
    mov ecx, SIZEOF nombre        ;SIZEOF dice el tamanio maximo de bytes

    call ReadString ;Recibe EDX (Donde empezar a escribir)  y ECX (Cuantos Bytes puede escribir)
    call crlf

    ;codigo propio (cuantos caracteres escribio el usuario)
    ;WriteDec necesita el numero en eax para escribirlo
    call WriteDec
    call crlf

    mov edx, OFFSET nombre ;guarda la direccion de nombre en edx para que writestring pueda imprimirlo
    call WriteString
    call crlf

    exit
main endp
end main