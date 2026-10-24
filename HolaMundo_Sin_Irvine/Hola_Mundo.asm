;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : Hola Mundo sin Irvine32 (NO SOLICITADA)
;   Descripcion : Hacer un hola mundo sin el uso de Irvine32.

.386
.model flat, stdcall
.stack 4096

INCLUDELIB kernel32.lib

GetStdHandle  PROTO, nStdHandle:DWORD
WriteConsoleA PROTO, hConsoleOutput:DWORD, lpBuffer:PTR BYTE,
                     nNumberOfCharsToWrite:DWORD,
                     lpNumberOfCharsWritten:PTR DWORD, lpReserved:DWORD
ExitProcess   PROTO, dwExitCode:DWORD

.data
mensaje  BYTE "Hola, mundo", 13, 10 
largo    EQU $ - mensaje            
escritos DWORD ?                    

.code
main PROC
    INVOKE GetStdHandle, -11                                 
    INVOKE WriteConsoleA, eax, OFFSET mensaje, largo, OFFSET escritos, 0
    INVOKE ExitProcess, 0
main ENDP
END main