;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 9 - PUSH Y POP
;   Descripcion : Se practica con el funcionamiento de la pila para diferentes escenarios como:
;				  el orden LIFO, volver a restaurar registros para poder operar con ellos y ver como
;				  funciona CALL y RET para llamar procedimientos


INCLUDE Irvine32.inc

.data

.code
main PROC
	;1 - PUSH Y POP
	mov eax, 500
	push eax ;Se ingresa 500 a la pila
	nop 
	mov ebx, 0
	pop ebx ;Se saca el valor de 500 en el registro ebx
	nop

	;2 - ORDEN LIFO
	mov eax, 10
	push eax        ;Se ingresa 10, PILA=10
	mov eax, 20
	push eax		;Se ingresa 20, PILA=10,20
	mov eax, 30
	push eax		;Se ingresa 30, PILA=10,20,30
	nop
	pop eax			;Se saca el valor 30 a eax
	pop ebx			;Se saca el valor 20 a ebx
	pop ecx			;Se saca el valor 10 a ecx
	nop

	;3 - CONSERVAR REGISTROS
	mov eax, 100
	mov ebx, 200
	push eax		;Se guarda 100 de eax en la pila
	push ebx		;Se guarda 200 de ebx en la pila 

	;SE TRABAJAN CON LOS REGISTROS
	mov eax, 999	
	mov ebx, 888

	;Se sacan los valores de la pila a ebx y eax para que queden como su valor original
	pop ebx
	pop eax
	nop

	;4 - CALL Y RET
	mov eax, 50
	mov ebx, 666
	call aumentarDiez ; se llama al procedimiento aumentarDiez
	exit

main ENDP

aumentarDiez PROC
	push ebx		;se guarda 666 en la pila
	mov ebx, 10		;se copia 10 en ebx
	add eax, ebx	;se le suma 10(ebx) a eax(50)
	pop ebx			;se restaura 666 en ebx
	ret
aumentarDiez ENDP

END main