;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 6.1 - CONTROL DE OCUPACION DE UN ESTACIONAMIENTO
;   Descripcion : En este codigo se controla la ocupacion de un estacionamiento que tiene el
;                 limite de 10 lugares, cuando se elige la opcion de que entre un carro se
;                 incrementa el numero de ocupacion usando INC, de igual manera si se elige sacar un carro
;                 se decrementa usando DEC. Si el estacionamiento esta lleno solo se permite sacar un carro o terminar
;                 el programa.


INCLUDE Irvine32.inc

.data
    msgCarros BYTE "Entrada o salida de carro (Ingrese 1 para entrar o 2 para salir): ", 0
    msgSacarCarroOTerminarPrograma BYTE "Salida de carro 1 o Terminar programa 2: ", 0
    msgLleno BYTE "Estacionamiento lleno. ", 0
    msgOcupados BYTE "Espacios ocupados: ", 0
    
    ingresoCarros=1  ;opciones de teclado
    salidaCarros=2

    cantidadCarros DWORD 0 ; cantidad de carros al inicio
    limiteCarros DWORD 10   ;Limite de carros del estacionamiento

.code
main proc

    principal:
        mov eax, limiteCarros
        cmp cantidadCarros, eax ;Compara la cantidad de carros con el limite de carros
        je lleno                 ;Salta si el estacionamiento esta lleno

        mov edx, OFFSET msgCarros
        call WriteString
        call crlf
        call ReadInt

        cmp eax, ingresoCarros  ;Compara si la opcion elegida es de ingreso
        je ingreso
    
        cmp eax, salidaCarros   ;Compara si la opcion elegida es de salida
        je salida

        jmp principal


    ;Si se ingresa un carro
    ;Se incrementa la cantidad de carros
    ;Se muestra la cantidad de carros que hay en el estacionamiento
    ;Se regresa a principal
    ingreso:
        inc cantidadCarros
        mov edx, OFFSET msgOcupados
        call WriteString
        mov eax, cantidadCarros
        call WriteDec
        call crlf
        jmp principal

    ;Si se saca un carro
    ;Se verifica si hay carros en el estacionamiento
    ;Si hay carros, se decrementa la cantidad de carros
    ;Se imprimie la cantidad de carros
    ;Se regresa a principal
    salida:
        mov eax, cantidadCarros
        cmp eax, 0
        je principal

        dec cantidadCarros
        mov edx, OFFSET msgOcupados
        call WriteString
        mov eax, cantidadCarros
        call WriteDec
        call crlf
        jmp principal
        


    ;Si el estacionamiento esta lleno muestra mensaje y se va a sacarOterminar
    lleno:
        mov edx, OFFSET msgLleno
        call WriteString
        call Crlf
        jmp sacarOterminar
    

    ;Solo da las opciones de sacar un carro ya que esta lleno
    ;O terminar el programa
    sacarOterminar:
        mov edx, OFFSET msgSacarCarroOTerminarPrograma
        call WriteString
        call crlf
        call ReadInt
        cmp eax, 1
        je salida
        cmp eax, 2
        je fin
        jmp sacarOterminar

    fin:
        exit

main endp
end main