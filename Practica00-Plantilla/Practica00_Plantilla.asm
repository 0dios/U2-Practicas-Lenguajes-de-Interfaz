INCLUDE Irvine32.inc

.data
mensaje BYTE "Practica 00 lista", 0

.code
main proc
    mov edx, OFFSET mensaje
    call WriteString
    call Crlf
    exit
main endp
end main