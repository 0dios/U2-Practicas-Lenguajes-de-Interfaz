;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 11 - OPERACIONES LOGICAS
;   Descripcion : En este codigo se utiliza un byte como unos interruptores, donde cada bit representa un estado de
;                 la computadora. Se usan las diferentes operaciones logicas como AND, OR, XOR, NOT y TEST para ir
;                 modificando o consultando el estado de los interruptores, y, se va observando los resultados con dumpRegs 



INCLUDE Irvine32.inc

;OPERACIONES LOGICAS
; Practicar como cambia el estado de los bits con las diferentes operaciones logicas
; Practicar conversiones a hexadecimal
.code
main proc
    ; 0 - Encendido
    ; 1 - Alarma
    ; 2 - Conectado
    ; Estado inicial 00000101b

    ; ===1-AND Extraer el estado de encendido===
    mov eax, 0
    mov ebx, 0
    mov al, 00000101b   ;estado inicial
    mov bl, al          ;para copiar el estado de al a bl
    and bl, 00000001b   ;se compara con la mascara (ebx es el que cambia el estado)
    call dumpRegs

    ; ===2-OR Encender alarma
    mov al, 00000101b
    or al, 00000010b  ;Eciende el 2do bit con un or para prender la alarma
    call dumpRegs

    ; ===3-XOR Desconectar y conectar computador
    mov al, 00000101b
    xor al, 00000100b  ;Desconecta la computadora ya que invierte los bits
    call dumpRegs
    xor al, 00000100b   ;Vuelve a concetar la computadora prendiendo el 3er bit
    call dumpRegs

    ; ===4-NOT Devolver estados
    mov al, 00000101b
    not al ;11111010b
    call dumpRegs

    ; ===5-TEST Evaluar alarma y realizar salto
    mov al, 00000101b
    test al, 00000010b ;Da ZF ya que no coincide el and en la mascara
    jz sinAlarma

    mov al, 11111111b ;Si la alarma esta encendida
    jmp finAlarma

sinAlarma:
    mov al, 00000000b ;si se tomo el camino de la alarma apagada

finAlarma:
    call dumpRegs ;Se verifica en los registros que camino se ha tomado

    exit
main endp
end main