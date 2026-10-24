;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 12 - DESPLAZAMIENTO Y ROTACION
;   Descripcion : En este codigo se practica el uso de las instrucciones de desplazamiento y rotacion:
;                 SHL, SHR, SAR, ROL, ROR, RCL, RCR. 
;                 Y se va viendo como cada una mueven los bits de acuerdo a la instruccion y como se van modificando
;                 las banderas dependiendo de esta. Tambien se utiliza WriteBin que permite ver el resultado en binario




INCLUDE Irvine32.inc

.code
main proc
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0 ;Se limpian los registros

    ; 1-SHL Desplazar una posicion a la izquierda
    mov al, 00001100b   ;00001100b = 12dec
    shl al, 1       ;00011000b = 24dec, CF = 0 Al desplazar a la izquierda aumenta el numero al doble
    call dumpRegs
    call WriteBin ;muestra EAX en binario
    call Crlf

    ; CF recibe el ultimo bit que sale
    mov al, 10000000b
    shl al, 1       ;00000000b CF = 1 ZF = 1 Si se sale del byte se utiliza CF como 9no bit
    call DumpRegs
    call WriteBin
    call Crlf

    ; 2-SHR Desplazar una posicion a la derecha
    mov al, 00001101b   ;13
    shr al, 1           ;00000110b = 6 y CF = 1 Si se mueve a la derecha se divide a la mitad, pero como es impar quedo en 6 y el bit restante se guarda en CF
    call dumpRegs
    call WriteBin
    call Crlf

    ; 3-SAR Conservar el signo
    mov al, -8 ;11111000b el bit mas significativo significa -128 y sigue -128+64+32+16+8 = -8
    sar al, 1   ;11111100b = -4, CF = 0 se desplaza a la derecha y almacena un 0 en CF
    call dumpRegs
    call WriteBin
    call Crlf

    ; 4-SAR Con operaciones no exactas
    mov al, -9  ;11110111b -128+64+32+16+0+4+2+1=-9
    sar al, 1  ;11111011b = -5 redondea hacia menos infinito, CF = 1
    call dumpRegs
    call WriteBin
    call Crlf

    ; 5-Conteo: Desplazar 2 bits hacia la izquierda con constante
    mov al, 00001111b
    shl al, 2   ;00111100b = 60, CF = 0 Al moverlo 2 posiciones primero se multiplica x2 y luego x2
    call dumpRegs
    call WriteBin
    call Crlf

    ; 6-Desplazar 2 bits hacia la derecha utilizando cl
    mov al, 00001111b ;15
    mov cl, 2
    shr al, cl  ;00000011b = 3, CF = 1
    call DumpRegs
    call WriteBin
    call Crlf

    ; 7- ROR, ROL, RCL, RCR

    ;ROL Rotar hacia la izquierda el bit 7 pasa al bit 0 y se copia en CF
    mov al, 10001100b ;140
    rol al, 1           ;00011001b, CF = 1.   25
    call dumpRegs
    call WriteBin
    call Crlf

    ;RCL Rota a la izquierda pasando por CF el bit 7 va a CF y CF entra al bit 0
    mov al, 10001100b
    clc     ;CF = 0
    rcl al, 1       ;00011000b, CF = 1
    call dumpRegs
    call WriteBin
    call Crlf

    ;ROR Rotar hacia la derecha: el bit 0 pasa al bit 7 y se copia en CF
    mov al, 00001101b
    ror al, 1           ;10000110b, CF = 1
    call dumpRegs
    call WriteBin
    call Crlf

    ;RCR Rota a la derecha pasando por CF el bit 0 va a CF y CF entra al bit 7
    mov al, 00001101b
    clc       ;CF = 0
    rcr al, 1       ;00000110b, CF = 1
    call dumpRegs
    call WriteBin
    call Crlf

    exit
main endp
end main