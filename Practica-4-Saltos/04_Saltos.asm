;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 4 - SALTOS
;   Descripcion : En esta practica se puede ver el como funciona jmp, que sirve como un salto
;				  incondicional.

INCLUDE Irvine32.inc

.code
main PROC
	mov eax, 5
	jmp continuar ;Salta antes de poner el valor de 10
	mov eax, 10 ; No se ejecuta

	continuar: 
	call dumpRegs ;Se ve que eax no se actualizo a 10
	exit 
main ENDP

END main