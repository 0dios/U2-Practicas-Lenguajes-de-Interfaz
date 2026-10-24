;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 13 - OBTENCION DE UNA CADENA HEXADECIMAL
;   Descripcion : En esta practica se convierte un numero hexadecimal de 32 bits 
;                 a una cadena de texto hexadecimal de forma manual para al final comparar
;                 el resultado que dio con WriteHex.



INCLUDE Irvine32.inc

.data
    numero DWORD 12AB34CDh
    bufferHex BYTE 9 DUP(0)
    msgValor BYTE "Valor numerico: ", 0
    msgCadena BYTE "Cadena hexadecimal: ", 0

.code
main PROC
    mov  eax, numero ; EAX = 12AB34CDh
    mov  esi, 7     ; ESI comienza en 7 Se pone asi para ir del menos significativo al mas significativo
    mov  ecx, 8  ; Contador del ciclo 32/4 = 8 digitos

SiguienteDigito:
    mov  dl, al         ; como son 8 bits, dos digitos en hexadecimal se encuentran aqui (CDh)
    and  dl, 00001111b       ; mascara nibble inferior 0000 1111 para ver que digito es el que esta en el nibble
    cmp  dl, 9          ; se compara con 9
    jbe  EsNumero   ; Si es menor a nueve es numero '0' a '9' = 30h a 39h y 'A' a 'F' = 41h a 46h

    sub  dl, 10     ; Se le resta 10 y dice que numero de letra es A=0, B=1, C=2, D=3
    add  dl, 'A'    ; Se le suma 'A'=41h y nos da la letra en codigo ASCII
    jmp  Guardar

EsNumero:
    add  dl, '0'    ; Si es un numero se le va a sumar el caracter '0' para obtener el numero en codigo ASCII


;Se guarda el codigo ascii en la posicion de esi que va de derecha a izquierda
Guardar:
    mov  bufferHex[esi], dl ; Se escribe desde el final
    shr  eax, 4     ; siguientes 4 bits (nibble) recorriendo hacia la derecha
    dec  esi                ;Se decrementa esi para que escriba ahora sobre el siguiente byte en el buffer
    loop SiguienteDigito    ;Va al siguiente digito

    ;Imprimir los valores
    mov  edx, OFFSET msgValor
    call WriteString
    mov  eax, numero
    call WriteHex
    call Crlf

    mov  edx, OFFSET msgCadena
    call WriteString
    mov  edx, OFFSET bufferHex
    call WriteString
    call Crlf

    exit
main ENDP
END main