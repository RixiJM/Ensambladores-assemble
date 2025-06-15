.8086
.model small
.stack 100h
.data
    titulo1 db '   DINO   $'
    titulo2 db 'Esquiva los obstaculos$'
    menu1   db 'Jugar$'
    menu2   db 'Records$'
    menu3   db 'Opciones$'
    menu4   db 'Salir$'
    resalta db '> ', '$'
    espacio db '  ', '$'
.code
public dibujar_menu

;-------------------------------------------------
; Procedimiento: dibujar_menu
; Entrada: AL = índice de opción seleccionada (0-3)
;-------------------------------------------------
dibujar_menu proc
    push ax
    push bx
    push dx

    ; Limpiar pantalla
    mov ah, 06h
    mov al, 0
    mov bh, 07h
    mov cx, 0
    mov dx, 184Fh
    int 10h

    ; Mostrar "DINO"
    mov ah, 02h
    mov bh, 0
    mov dh, 3
    mov dl, 35
    int 10h
    mov ah, 09h
    lea dx, titulo1
    int 21h

    ; Mostrar "Esquiva los obstaculos"
    mov ah, 02h
    mov dh, 5
    mov dl, 28
    int 10h
    mov ah, 09h
    lea dx, titulo2
    int 21h

    ; Mostrar opciones con resaltado
    mov bl, al ; Guardar seleccionada en BL

    ; Jugar
    mov ah, 02h
    mov dh, 8
    mov dl, 35
    int 10h
    mov al, bl
    cmp al, 0
    jne no_jugar
    mov ah, 09h
    lea dx, resalta
    int 21h
    mov ah, 09h
    lea dx, menu1
    int 21h
    jmp sig1
no_jugar:
    mov ah, 09h
    lea dx, espacio
    int 21h
    mov ah, 09h
    lea dx, menu1
    int 21h
sig1:

    ; Records
    mov ah, 02h
    mov dh, 10
    mov dl, 35
    int 10h
    mov al, bl
    cmp al, 1
    jne no_records
    mov ah, 09h
    lea dx, resalta
    int 21h
    mov ah, 09h
    lea dx, menu2
    int 21h
    jmp sig2
no_records:
    mov ah, 09h
    lea dx, espacio
    int 21h
    mov ah, 09h
    lea dx, menu2
    int 21h
sig2:

    ; Opciones
    mov ah, 02h
    mov dh, 12
    mov dl, 35
    int 10h
    mov al, bl
    cmp al, 2
    jne no_opciones
    mov ah, 09h
    lea dx, resalta
    int 21h
    mov ah, 09h
    lea dx, menu3
    int 21h
    jmp sig3
no_opciones:
    mov ah, 09h
    lea dx, espacio
    int 21h
    mov ah, 09h
    lea dx, menu3
    int 21h
sig3:

    ; Salir
    mov ah, 02h
    mov dh, 14
    mov dl, 35
    int 10h
    mov al, bl
    cmp al, 3
    jne no_salir
    mov ah, 09h
    lea dx, resalta
    int 21h
    mov ah, 09h
    lea dx, menu4
    int 21h
    jmp fin_menu
no_salir:
    mov ah, 09h
    lea dx, espacio
    int 21h
    mov ah, 09h
    lea dx, menu4
    int 21h
fin_menu:

    pop dx
    pop bx
    pop ax
    ret
dibujar_menu endp

end