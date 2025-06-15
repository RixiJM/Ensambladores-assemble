.8086
.model small
.stack 100h
.data
    titulo      db 'Dino', 0
    opciones    db 'Jugar', 0
                db 'Ver Records', 0
                db 'Salir', 0
    opcion_actual db 0             ; 0=Jugar, 1=Ver Records, 2=Salir
    fila_titulo  equ 5
    fila_inicio  equ 10
    col_inicio   equ 35
    normal_attr  db 07h            ; Gris sobre negro
    selec_attr   db 70h            ; Negro sobre gris

.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax

    ; Configurar modo video (80x25 texto)
    mov ax, 0003h
    int 10h

    ; Ocultar cursor
    mov ah, 01h
    mov cx, 2607h
    int 10h

menu_principal:
    call dibujar_menu

leer_tecla:
    mov ah, 00h
    int 16h

    cmp ah, 50h            ; Flecha abajo
    je flecha_abajo
    cmp ah, 48h            ; Flecha arriba
    je flecha_arriba
    cmp al, 0Dh            ; Enter
    je procesar_enter
    jmp leer_tecla

flecha_abajo:
    inc opcion_actual
    cmp opcion_actual, 3
    jb  actualizar_menu
    mov opcion_actual, 0
    jmp actualizar_menu

flecha_arriba:
    dec opcion_actual
    cmp opcion_actual, 0
    jge actualizar_menu
    mov opcion_actual, 2

actualizar_menu:
    call dibujar_menu
    jmp leer_tecla

procesar_enter:
    cmp opcion_actual, 2
    je  salir_programa
    ; Aquí puedes añadir lógica para "Jugar" y "Ver Records"
    jmp menu_principal

salir_programa:
    mov ax, 4C00h
    int 21h
main endp

dibujar_menu proc
    ; Limpiar pantalla
    mov ax, 0600h
    mov bh, 07h
    mov cx, 0000h
    mov dx, 184Fh
    int 10h

    ; Dibujar título
    mov dh, fila_titulo
    mov dl, col_inicio
    mov si, offset titulo
    mov bl, [normal_attr]
    call imprimir_cadena

    ; Dibujar opciones
    mov si, offset opciones
    mov cx, 0                ; Contador de opciones

dibujar_opcion:
    mov dh, fila_inicio
    add dh, cl
    add dh, cl               ; dh = fila_inicio + opcion*2
    mov dl, col_inicio

    ; Seleccionar atributo
    cmp cl, [opcion_actual]
    je  usar_seleccionado
    mov bl, [normal_attr]
    jmp imprimir_opcion
usar_seleccionado:
    mov bl, [selec_attr]

imprimir_opcion:
    call imprimir_cadena

    ; Avanzar al siguiente item
    inc cx
avanzar_siguiente:
    mov al, [si]
    inc si
    test al, al
    jnz avanzar_siguiente

    cmp cx, 3
    jb  dibujar_opcion
    ret
dibujar_menu endp

imprimir_cadena proc

    push ax
    push bx
    push cx
    push dx
    push si
    push bp
    push di
    
    mov di, si              ; DI para contar longitud
    mov bp, si              ; BP = offset cadena (ES:BP para int 10h)
    mov ax, ds
    mov es, ax              ; ES = segmento de datos
    
    ; Contar longitud de cadena
    xor cx, cx              ; CX = contador de longitud
contar:
    mov al, [di]
    inc di
    cmp al, 0
    je  imprimir
    inc cx
    jmp contar

imprimir:
    jcxz salir              ; Si cadena vacía, saltar
    mov bh, 0               ; Página 0
    mov ax, 1301h           ; AH=13h (escribir cadena), AL=01h (modo atributo)
    int 10h

salir:

    pop di
    pop bp
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
imprimir_cadena endp

end main