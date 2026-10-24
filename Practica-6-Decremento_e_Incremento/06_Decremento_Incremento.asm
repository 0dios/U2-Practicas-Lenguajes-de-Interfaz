;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 6 - DECREMENTO E INCREMENTO
;   Descripcion : En este codigo se hace un sistema de ingreso de PIN con 3 intentos
;				  Si el usuario acierta se muestra el mensaje de acceso, pero si este falla 3
;				  veces se bloquea y se acaba el programa


INCLUDE Irvine32.inc

.data
	msgPIN BYTE "Ingrese el PIN: ", 0
	msgIntentos BYTE "Intentos restantes: ", 0
	msgError BYTE "PIN incorrecto.", 0
	msgAcceso BYTE "Acceso permitido.", 0
	msgBloqueado BYTE "Autodestruccion comenzada...", 0

	pinCorrecto = 1234

.code
main PROC
	mov ebx, 3 ; numero de intentos para ingresar

intentar: 
	mov edx, OFFSET msgPIN 
	call WriteString
	call ReadInt ; permite guardar el numero escrito en consola en eax

	cmp eax, pinCorrecto ; se compara con el pin correcto
	je acceso ; si el pin es correcto, se va a la etiqueta de acceso

	mov edx, OFFSET msgError ; si es incorrecto, muestra el mensaje de error
	call WriteString
	call crlf

	dec ebx ; decrementa los intentos

	jz bloqueado ; si ebx = 0, se va a la etiqueta bloqueado

	mov edx, OFFSET msgIntentos ; muestra el mensaje de intentos restantes
	call WriteString
	
	mov eax, ebx ; muestra el numero de intentos restantes
	call WriteDec
	call crlf

	jmp intentar ; si no se fue a ninguna de las etiquetas anteriores, vuelve a la de intentar

acceso:
	mov edx, OFFSET msgAcceso
	call WriteString
	call crlf

	jmp fin

bloqueado:
	mov edx, OFFSET msgBloqueado
	call WriteString
	call crlf

	jmp fin

fin:
	exit ; se termina el programa

main ENDP

END main