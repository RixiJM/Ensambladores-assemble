.8086
.model small
.stack 100h
.data

.code
    EXTRN menu:PROC             ; -> MENU.ASM
    EXTRN dibujar_dino:PROC     ; -> DRAW.ASM
    EXTRN limpiar_pantalla:PROC ; -> LOGIC.ASM
    EXTRN delay:PROC            ; -> LOGIC.ASM
    EXTRN modo_negro:PROC       ; -> LOGIC.ASM
    EXTRN sprite:PROC           ; -> SPRITE.ASM

main proc
    mov ax, @data
    mov ds, ax
    mov es, ax

    ; Configurar modo video (80x25 texto) 16 COL
    mov ax, 0003h
    int 10h

    ; Ocultar cursor
    mov ah, 01h
    mov cx, 2607h
    int 10h
menu_principal:
    call menu

    cmp bl, 2
    je  salir_programa
    cmp bl, 0
    je  dino

    jmp menu_principal
dino:
    call juego
    ;jmp menu_principal

salir_programa:
    mov ax, 4C00h
    int 21h
main endp

juego proc
    push ax
    push bx
    push cx
    push dx
    push si
    push bp
    push di

    call limpiar_pantalla
    ;----------------
    ; MODO GRAFICO 256 COL
    mov ah, 00h
    mov al, 13h
    int 10h

    call modo_negro
    call delay
    call SPRITE
    jmp finJuego

    game_loop:
    ;call dibujar_dino
    ;call dibujar_obstaculo

    mov ah, 01h
    int 16h
    jz sin_tecla

    mov ah, 00h
    int 16h
    cmp al, 'w'
    je salto

    sin_tecla:
        ;call manejar_salto
        ;call mover_obstaculo
        call delay

        jmp game_loop

    salto:
        ;mov salto_activo, 1
        ;mov dino_y, dino_y_salto
        ;jmp sin_tecla

    finJuego:

    pop di
    pop bp
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
juego endp

end