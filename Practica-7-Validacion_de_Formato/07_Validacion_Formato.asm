;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 7 - VALIDACION DE FORMATO
;   Descripcion : Se valida que el usuario ingrese una cadena que cumpla con el formato de
;				  3 letras en mayuscula, un guion y 3 digitos
;				  Cuando el formato no sea valido se vuelve a pedir

INCLUDE Irvine32.inc

.data
	mensaje BYTE "Ingrese una cadena: ", 0
	msgInvalido BYTE "El formato es invalido.", 0
	msgCorrecto BYTE "Formato valido: ", 0
	codigo BYTE 9 DUP(0) ;Se pone mas de 8 bytes para saber si el usuario ingresa una cadena mas larga

.code
main PROC
inicio:
	mov esi, 0
	mov edx, OFFSET mensaje
	call WriteString			;Se escribe el mensaje para ingreso del codigo
	mov edx, OFFSET codigo
	mov ecx, SIZEOF codigo
	call ReadString			;Se lee el codigo
	cmp eax, 7
	je tresLetras ;Si la longitud de la entrada es 7 se comprueba que los tres primeros caracteres sean letras mayusculas
	jmp invalido

tresLetras:
	mov al, codigo[esi] ;Se copia el caracter en esi del codigo
	cmp al, 'A'
	jb invalido ;Si es menor a 'A'(41h) es invalido
	cmp al, 'Z'
	ja invalido ; Si es mayor a 'Z' es invalido
	cmp esi, 2 
	je separador ;Si esi=2 ya tiene que saltar para ver la posicion del separador
	inc esi
	jmp tresLetras

separador:
	inc esi
	mov al, codigo[esi]
	cmp al, '-'
	je tresNumeros ;Si esta el separador en la posicion se salta a ver que los siguientes caracteres sean numeros
	jmp invalido

tresNumeros:
	inc esi
	mov al, codigo[esi]
	cmp al, '0'
	jb invalido	;Si el caracter es menor a '0' es invalido
	cmp al, '9' ;Si el caracter es mayor a '9' es invalido
	ja invalido
	cmp esi, 6
	je correcto ;Cuando esi=6 significa que ya se recorrio toda la cadena y el formato es valido
	jmp tresNumeros



; IMPRESION DE SI EL FORMATO ES VALIDO O INVALIDO

invalido:
	mov edx, OFFSET msgInvalido
	call WriteString
	call crlf
	jmp inicio

correcto:
	mov edx, OFFSET msgCorrecto
	call WriteString
	mov edx, OFFSET codigo
	call WriteString
	call crlf
	jmp fin

fin:
	exit

main ENDP
END main