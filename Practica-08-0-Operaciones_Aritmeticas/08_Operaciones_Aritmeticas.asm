;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 8 - OPERACIONES ARITMETICAS
;   Descripcion : Este codigo implementa las operaciones aritmeticas add, sub, mul, imul, div, idiv
;                 y en cada una se ve como se van afectando los registros y las banderas.




INCLUDE Irvine32.inc

.code
main proc
    ;OPERACIONES ADD Y SUB
    mov eax, 50
    mov ebx, 20
    add eax, ebx ;Se suma 50+20=70
    sub eax, 15  ;Se le resta 15 = 55decimal o 37h
    nop

    ; CF Acarreo en un asuma sin signo
    mov eax, 0
    mov al, 255
    add al, 1  ;Se pasa de un byte y como es sin signo hay acarreo
    nop

    ; OF Condicion de desbordamiento
    mov eax, 0
    mov al, 127
    add al, 1         ;128 no cabe con signo
    nop

    ; MUL Multiplicacion de valores en 32 bits
    mov eax, 25
    mov edx, 3
    mul edx ;Multiplica 25*3 EDX:EAX = 75
    nop

    ; MUL Producto que necesita mas de 32 bits
    mov eax, 65537
    mov ebx, 65537
    mul ebx  ;Si cf y of = 1 es que hay algo en edx tambien   
    nop 

    ; IMUL Multiplicacion con signo
    mov eax, -5  ;En hx -5 = FFFFFFFB y -15 = FFFFFFF1 (Va como alreves)
    imul eax, eax, 3
    nop

    ; DIV Dividiendo sin signo
    mov eax, 125
    mov edx, 0 ; Se limpia para la parte alta y guarda el residuo
    mov ebx, 12
    div ebx ; edx:eax / ebx
    nop

    ; IDIV Dividiendo con signo
    mov eax, -125
    cdq    ; EDX = 0xFFFFFFFF
    mov ebx, 12
    idiv ebx ; EDX:EAX / EBX (con signo)
    ;El resultado de la division es -10 y el residuo -5
    nop

    exit
main endp
end main