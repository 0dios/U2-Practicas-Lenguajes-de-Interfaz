;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 14 - CAPTURA Y ALMACENAMIENTO
;   Descripcion : En este codigo se va a simular la entrada de una mercancia a un inventario.
;                 Se debe de escribir la cantidad que se va a ingresar como cadena, se validara si el numero en cadena esta
;                 entre 1 y 99, se convertira el texto a un numero de forma manual y al resultado se le sumara 25 existencias.
;                 Al final se mostrara el resultado.


INCLUDE Irvine32.inc

.data
    mensaje BYTE "Ingrese la cantidad: ", 0
    mensajeFuera BYTE "Caracter invalido o esta fuera de rango", 0
    mensajeExistencia BYTE "Existencia actual: ", 0
    mensajeUnidades BYTE " unidades", 0
    cantidadDigitosPermitidos = 2
    buffer BYTE 11 DUP(0) ;Espacio para diez caracteres
    bufferDec BYTE 11 DUP(0) ;Cadena decimal del resultado

    existenciaInicial DWORD 25
    cantidadRecibida DWORD 0
    existenciaActual DWORD 0

.code
main proc
pedirCantidad:
    mov edx, OFFSET mensaje
    call WriteString
    mov edx, OFFSET buffer
    mov ecx, 10
    call ReadString ; Se lee la cantidad en buffer
    call crlf

    cmp eax, 0
    je fueraRango ; Si es 0 esta fuera del rango
    cmp eax, cantidadDigitosPermitidos
    ja fueraRango ; si es mayor que cantidadDigitosPermitidos =2 esta fuera del rango

    mov ecx, eax ;ECX guardara cuantas vueltas dar la ciclo
    mov esi, OFFSET buffer ;ESI apuntara al primer caracter
    mov ebx, 0 ;EBX guardara el acumulado

ciclo:
    mov eax, 0
    mov al, [esi]
    cmp al, '0'
    jb fueraRango ; Se mira si el caracter es abajo de 0
    cmp al, '9'
    ja fueraRango ;Se mira si el caracter esta arriba de 9

    sub al, '0'  ;Se le resta el caracter 0
    imul ebx, ebx, 10 ; Se multiplica por 10
    add ebx, eax ; Se le suma el digto
    inc esi ;Siguiente caracter
    loop ciclo ;Interacion

    ;VALIDAR RANGO 1 A 99
    cmp ebx, 1
    jb fueraRango
    cmp ebx, 99
    ja fueraRango

    mov cantidadRecibida, ebx ;se guarda la cantidad recibida

    ;EXISTENCIA ACTUAL
    mov eax, existenciaInicial
    add eax, cantidadRecibida ; Se le suma la existencia inicial a cantidad recibida para sacar la existencia actual
    mov existenciaActual, eax

    ;MOSTRAR EXISTENCIA ACTUAL
    mov edx, OFFSET mensajeExistencia
    call WriteString
    mov eax, existenciaActual
    mov esi, OFFSET bufferDec
    call convertirDecimal ;Se convierte decimal a cadena para imprimirlo
    mov edx, OFFSET bufferDec
    call WriteString
    mov edx, OFFSET mensajeUnidades
    call WriteString
    call crlf
    jmp salir

fueraRango:
    mov edx, OFFSET mensajeFuera
    call WriteString
    call crlf
    jmp pedirCantidad ;Solicitar nuevamente la cantidad porque no esta en el rango

salir:
    exit

main endp

convertirDecimal proc
    mov ebx, 10        ; 10 sera el divisor
    mov ecx, 0        ; contador de digitos

    ;EXTRAER DÍGITOS
ExtraerDigitos:
    mov edx, 0  ; se limpia edx para guardar el residuo de la division
    div ebx     ; se divide el digito de eax y el residuo se queda en edx
    push edx    ; se guarda el residuo en la pila
    inc ecx     ; incremento de ecx para ir al siguiente digito
    cmp eax, 0      ; comparar si el cociente es diferente de cero
    jne ExtraerDigitos

    ;CONSTRUIR CADENA
ConstruirCadena:
    pop edx     ; se saca el digito
    add dl, '0'     ; se le suma el caracter '0'
    mov [esi], dl   ; se guarda el caracter 
    inc esi     ; siguiente posicion del buffer para el siguiente caracter
    loop ConstruirCadena    ; loop hasta que no queden digitos

    mov dl, 0   ; terminador nulo
    mov [esi], dl   ; se le agrega el terminador nulo al final de la cadena
    ret
convertirDecimal endp

end main