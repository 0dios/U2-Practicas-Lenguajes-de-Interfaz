;   Materia : Lenguajes de Interfaz
;   Alumno : Ulises Papachoris Camacho
;   Horario : 8:00-9:00 AM
;   Docente : Dr. José Luis Medina Jiménez
;   Practica : 15 - MANIPULACION DE ARCHIVOS
;   Descripcion : En este codigo se crea un archivo de texto Inventario.txt, se escribira en el el texto de 125
;                 para despues cerrar el archivo.
;                 Todo esto usando las funciones de CreateOutputFile, WriteToFile y CloseFile



INCLUDE Irvine32.inc

.data

    nombreArchivo BYTE "Inventario.txt", 0   ;Nombre del archivo con el que se va a guardar
    texto BYTE "125", 0          ;El texto que se va a guardar
    archivoHandle DWORD ?    ;Manejar o almacenar el valor del identificador (Saber el archivo exacto con el que estamos trabajando)

    mensajeExito BYTE "Archivo guardado", 0 ;Mensaje de que se ha guardado correctamente
    mensajeError BYTE "No se guardo correctamente", 0 ;Mensaje de error de guardado

.code
main proc
    
    ;1.- CREAR EL ARCHIVO
    mov edx, OFFSET nombreArchivo   ;Ve a la primera posicion de nombreArchivo
    call CreateOutputFile           ;funcion de irvine que crea el archivo
    
    
    cmp eax, INVALID_HANDLE_VALUE   ;Verifica si es un valor invalido que en este caso representa un error
    je error


    mov archivoHandle, eax


    ;2.-ESCRIBIR EL TEXTO ("125")
    mov eax, archivoHandle          ;Recuperar el id del archivo para saber en que archivo se va a escribir el texto
    mov edx, OFFSET texto
    mov ecx, SIZEOF texto - 1       ;La cantidad de datos sobre los que se quiere escribir
    call WriteToFile

    jc errorEscritura               ;Jump Carry (En la carry se ve si hubo un error de escritura)

    cmp eax, SIZEOF texto - 1       ; Para ver si no se escribio el archivo
    jne errorEscritura  


    ;3.-CERRAR ARCHIVO TXT
    mov eax, archivoHandle          ;Se copia el identificador
    call CloseFile                  ;Cerrar el archivo
    
    ;SI no se cerro correctamente el archivo (SI = 0 hay error, Diferente de cero esta correcto)
    test eax, eax
    jz error                        ;Salto si hay zero flag

    mov edx, OFFSET mensajeExito
    call WriteString
    jmp fin

errorEscritura:
    mov eax, archivoHandle
    call CloseFile               ;Cerrar el archivo si no se pudo escribir
    
error:
    mov edx, OFFSET mensajeError
    call WriteString             ; Escribir el mensaje de error
fin:
    exit                         ;salir

main endp
end main