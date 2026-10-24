;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 10 - OBTENCION DE UNA CADENA DECIMAL
;   Descripcion : En este codigo se simula el avance de una descarga donde
;                 se tiene que calcular cuantos bytes se descargaron, cuantos bytes faltan, el 
;                 porcentaje que llevan de avance y cuantos grupos de 1024 bytes se pueden hacer.
;                 Tambien se hace una conversion de un numero a una cadena de forma manual para usar WriteString y no WriteDec




INCLUDE Irvine32.inc

.data
    archivo DWORD 100000
    bloques DWORD 125
    tamano_bloque DWORD 512

    descargados DWORD ?
    pendientes DWORD ?
    porcentaje_avance DWORD ?
    grupos_completos DWORD ?
    residuo_agrupamiento DWORD ?

    ; El buuffer para la cadena decimal que son hasta 10 digitos mas el terminador nulo
    bufferDec BYTE 11 DUP(0)

    ; Mensajes
    msgDescargados BYTE "Bytes descargados :", 0
    msgPendientes BYTE "Bytes pendientes: ", 0
    msgPorcentaje BYTE "Porcentaje de avance: ", 0
    msgSimboloPorc BYTE "%", 0
    msgGrupos BYTE "Grupos de 1024 bytes: ", 0
    msgResiduo BYTE "Residuo agrupamiento: ", 0

.code
main proc

    ;BYTES DESCARGADOS
    mov eax, bloques ;Se copie 125 a eax
    mov edx, tamano_bloque ;se copia 512 a edx
    mul edx ; 125*512
    mov descargados, eax ;El valor se guarda en descargados

    ;BYTES PENDIENTES
    mov eax, archivo   ;se copia 100000 a eax
    mov ebx, descargados    ;se copia la cantidad de archivos descargados a ebx
    sub eax, ebx            ;se restan las cantidades (100000-(125*512))
    mov pendientes, eax     ;El restante son los pendientes

    ;PORCENTAJE AVANCE
    mov eax, descargados ;La cantidad de descargados (64000)
    mov edx, 100 
    mul edx ;Se multiplica por 100 el resultado (6400000) (Se guarda en eax)
    mov edx, 0 ;(se limpia edx)
    mov ebx, archivo ;(100000 en ebx)
    div ebx ;6400000/100000 = 64
    mov porcentaje_avance, eax ;Se guarda el porcentaje de avance

    ;GRUPOS COMPLETOS Y RESIDUO DEL AGRUPAMIENTO
    mov eax, descargados    ;Cantidad de descargados en eax
    mov edx, 0
    mov ebx, 1024  ;bloque de 1024
    div ebx       ;Cuandos bloques de 1024 hay
    mov grupos_completos, eax ;Se guarda la cantidad de bloques
    mov residuo_agrupamiento, edx ;Se guarda el residuo de la division

    ;MOSTRAR BYTES DESCARGADOS
    mov edx, OFFSET msgDescargados
    call WriteString
    mov eax, descargados
    mov esi, OFFSET bufferDec   ;Se copia el inicio de bufferDec a esi
    call convertirDecimal  ;se llava a la fucion para poder convertir el decimal a string e imprimirlo
    mov edx, OFFSET bufferDec
    call WriteString
    call Crlf

    ;MOSTRAR BYTES PENDIENTES
    mov edx, OFFSET msgPendientes
    call WriteString
    mov eax, pendientes
    mov esi, OFFSET bufferDec    ;Se copia el inicio de bufferDec a esi
    call convertirDecimal   ;se llava a la fucion para poder convertir el decimal a string e imprimirlo
    mov edx, OFFSET bufferDec
    call WriteString
    call Crlf

    ;MOSTRAR PORCENTAJE DE AVANCE
    mov edx, OFFSET msgPorcentaje
    call WriteString
    mov eax, porcentaje_avance
    mov esi, OFFSET bufferDec   ;Se copia el inicio de bufferDec a esi
    call convertirDecimal   ;se llava a la fucion para poder convertir el decimal a string e imprimirlo
    mov edx, OFFSET bufferDec
    call WriteString
    mov edx, OFFSET msgSimboloPorc
    call WriteString
    call Crlf

    ;MOSTRAR GRUPOS COMPLETOS DE 1024 BYTES
    mov edx, OFFSET msgGrupos
    call WriteString
    mov eax, grupos_completos   
    mov esi, OFFSET bufferDec  ;Se copia el inicio de bufferDec a esi
    call convertirDecimal       ;se llava a la fucion para poder convertir el decimal a string e imprimirlo
    mov edx, OFFSET bufferDec
    call WriteString
    call Crlf

    ;MOSTRAR RESIDUO DEL AGRUPAMIENTO
    mov edx, OFFSET msgResiduo
    call WriteString
    mov eax, residuo_agrupamiento
    mov esi, OFFSET bufferDec       ;Se copia el inicio de bufferDec a esi
    call convertirDecimal     ;se llava a la fucion para poder convertir el decimal a string e imprimirlo
    mov edx, OFFSET bufferDec
    call WriteString
    call Crlf

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