;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 3 - COMPARACION Y PRUEBA
;   Descripcion : En esta practica se puede observar el como CMP, ADD y TEST encienden
;                 diferentes banderas al momento de ejecutarse y ver las funciones de cada uno
;                 al final de cada operacion se pone dumpRegs que sirve para mostrar los registros y las banderas.


INCLUDE Irvine32.inc

.code
main proc
    
    ; CONDICION 1 Zero Flag
    mov ebx, 1
    cmp ebx, 1 ;Hace una resta de los valores para compararlos, por eso se activa la zero flag (1-1=0)
    call dumpRegs

    mov eax, 01h
    cmp eax, ebx
    call dumpRegs

    mov cl, 11111111b
    cmp cl, cl
    call dumpRegs

    ; CONDICION 2 Sign Flag
    mov eax, 0
    mov ebx, 0 ;Limpiar los registros

    mov al, -5
    mov bl, 1
    cmp al, bl ; El resultado de la comparacion da un numero negativo (-6) ya que cmp hace una resta
    call dumpRegs

    ; CONDICION 3 Carry Flag (Desbordamiento de numeros sin signo)
    mov eax, 0
    mov ebx, 0

    mov al, 255
    add al, 1 ; al sumar 1 a al da 256, lo que ya no cabe en 8 bits asi que se activa CF porque hubo un acarreo fuera del bit 7
    call dumpRegs

    ; CONDICION 4 Overflow Flag (Desbordamiento de numeros con signo)
    mov eax, 0
    mov ebx, 0
    mov al, -128
    mov bl, 1
    cmp al, bl ;Le resta 1 a -128 lo que hace que se desborde pero con signo
    call dumpRegs

    ; CONDICION 5 Test
    mov eax, 0
    mov eax, 5 ; 5 en binario = 00000101b
    test eax, 1; 00000101b and 00000001b = 00000001b (Muy utilizado para saber si un numero es par o impar)
    call dumpRegs


    ; Por que al comparar el bit mas significativo da SF???
    mov eax, 0
    mov al, 10000000b
    test al, al
    call dumpRegs

    ; El SF se activa porque el bit mas a la izquierda del resultado es 1.
    ; Se activa porque el bit de hasta la izquierda se usar para representar valores con signo negativo representa -128 y a la vez tambien representa 128
    ; Todo depende de la interpretacion que se le de despues

    exit
main endp
end main