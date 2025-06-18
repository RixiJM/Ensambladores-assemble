.8086
.model small
.stack 100h
.data
    titulo      db 'Dino', 0
    opciones    db 'Jugar', 0
                db 'Ver Creditos', 0
                db 'Salir', 0
    opcion_actual       db 0             ; 0=Jugar, 1=Ver Records, 2=Salir
    fila_titulo         db 5
    fila_inicio         db 10
    col_inicio          db 35
    normal_attr         db 07h            ; Gris sobre negro
    selec_attr          db 70h            ; Negro sobre gris

    col_gameOv          db 30
    col_msjGOv          db 10
    msg_game_over       db '*** GAME OVER ***', 0
    msg_game_over2      db '/|\ GAME OVER /|\', 0
    msg_ganaste         db '(^-^)Felicidades, ganaste!(^-^)', 0
    msg_ganaste2        db '(*-*)Felicidades, ganaste!(*-*)', 0
    msg_presiona_tecla  db 'Presiona cualquier tecla para volver al menu...', 0
    exit                db 'Gracias por jugar!',0Dh, 0Ah,'Dino robado, digo, basado en Dinosaurio de Chrome',0Dh, 0Ah,'Presiona W para saltar',0Dh, 0Ah,'Sistema de Procesamiento de Datos',0Dh, 0Ah,'1er Cuatri | 2025',0Dh, 0Ah,'Nicolas Marinkovic, Santiago Litvin, Matias Ortubia, Juan Martin Ricci Pierani', 0

.code
    EXTRN limpiar_pantalla:PROC ; -> LOGIC.ASM
    EXTRN delay_new:PROC        ; -> LOGIC.ASM
    EXTRN modo_texto:PROC       ; -> LOGIC.ASM
    ;EXTRN LEER_RECORDS:PROC     ; -> ARCHIVO.ASM
    EXTRN score:PROC            ; -> SCORE.ASM

    PUBLIC MENU
    PUBLIC dibujar_game_over
    PUBLIC dibujar_ganaste
    PUBLIC dibujar_creditos
    
;-------------------------------------------------------------------------------------------------
;Función menu 
;		Realiza: 		
;		Recibe: 		
;		Devuelve: 	
;-------------------------------------------------------------------------------------------------

menu proc
    push ax

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
        mov bl, opcion_actual
        cmp bl, 1
        jne  fin
        call dibujar_creditos
    fin:
        call limpiar_pantalla
    pop ax
    ret
menu endp

;-------------------------------------------------------------------------------------------------
;Función dibujar_menu 
;		Realiza: 		
;		Recibe: 		
;		Devuelve: 	
;-------------------------------------------------------------------------------------------------

dibujar_menu proc
        
        call limpiar_pantalla

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

;-------------------------------------------------------------------------------------------------
;Función imprimir_cadena 
;		Realiza: 		
;		Recibe: 		
;		Devuelve: 	
;-------------------------------------------------------------------------------------------------
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

; ;-------------------------------------------------------------------------------------------------
; ;Función dibujar_records 
; ;		Realiza: 		
; ;		Recibe: 		
; ;		Devuelve: 	
; ;-------------------------------------------------------------------------------------------------

; dibujar_records proc
;         CALL modo_texto
        
;         call limpiar_pantalla

;         ; AGREGAR MENU PARA RECORDS
;         call LEER_RECORDS
;         ; AGREGAR MENU PARA RECORDS

;         ; Esperar tecla
;         mov ah, 00h
;         int 16h
;         ret
; dibujar_records endp

;-------------------------------------------------------------------------------------------------
; Función dibujar_game_over
;       Realiza: Muestra un mensaje de "Game Over" y espera una tecla
;       Recibe: Nada
;       Devuelve: Nada
;-------------------------------------------------------------------------------------------------

dibujar_game_over proc
    PUSH BX
    PUSH DX
    PUSH SI
    
    ; mov fila_titulo, 120
    mov col_gameOv, 60
muevo_go:
    cmp col_gameOv, 29
    je pres_tecla

    call limpiar_pantalla
    ; Mostrar "Game Over"
    mov dh, fila_titulo     ; Fila
    add dh, 5
    mov dl, col_gameOv      ; Columna centrada aproximadamente
    mov si, offset msg_game_over
    mov bl, 06h   ; Atributo resaltado
    call imprimir_cadena
    dec col_gameOv
    call delay_new
    call delay_new
jmp muevo_go2

muevo_go2:
    cmp col_gameOv, 29
    je pres_tecla

    call limpiar_pantalla
    ; Mostrar "Game Over"
    mov dh, fila_titulo     ; Fila
    add dh, 5
    mov dl, col_gameOv      ; Columna centrada aproximadamente
    mov si, offset msg_game_over2
    mov bl, 06h   ; Atributo resaltado
    call imprimir_cadena
    dec col_gameOv
    call delay_new
    call delay_new
jmp muevo_go

pres_tecla:
    ; Mostrar instrucción para volver
    mov dh, fila_inicio
    add dh, 5
    mov dl, col_msjGOv
    mov si, offset msg_presiona_tecla
    mov bl, [normal_attr]
    call imprimir_cadena

    ; Esperar tecla
    mov ah, 00h
    int 16h

    POP SI
    POP DX
    POP BX
    ret
dibujar_game_over endp

dibujar_ganaste proc

    PUSH BX
    PUSH DX
    PUSH SI
    
    ; mov fila_titulo, 120
    mov col_gameOv, 60
muevo_win:
    cmp col_gameOv, 29
    je pres_tecla

    call limpiar_pantalla
    ; Mostrar "Game Over"
    mov dh, fila_titulo     ; Fila
    add dh, 5
    mov dl, col_gameOv      ; Columna centrada aproximadamente
    mov si, offset msg_ganaste
    mov bl, 06h   ; Atributo resaltado
    call imprimir_cadena
    dec col_gameOv
    call delay_new
    call delay_new
    call delay_new
    call delay_new
    call delay_new
    call delay_new
jmp muevo_win2

muevo_win2:
    cmp col_gameOv, 29
    je pres_tecla_w

    call limpiar_pantalla
    ; Mostrar "Felicitaciones, ganaste!"
    mov dh, fila_titulo     ; Fila
    add dh, 5
    mov dl, col_gameOv      ; Columna centrada aproximadamente
    mov si, offset msg_ganaste2
    mov bl, 06h   ; Atributo resaltado
    call imprimir_cadena
    dec col_gameOv
    call delay_new
    call delay_new
    call delay_new
    call delay_new
    call delay_new
    call delay_new
jmp muevo_win

pres_tecla_w:
    ; Mostrar instrucción para volver
    mov dh, fila_inicio
    add dh, 5
    mov dl, col_msjGOv
    mov si, offset msg_presiona_tecla
    mov bl, [normal_attr]
    call imprimir_cadena

    ; Esperar tecla
    mov ah, 00h
    int 16h

    POP SI
    POP DX
    POP BX
    ret

dibujar_ganaste endp

dibujar_creditos proc

    PUSH BX
    PUSH DX
    PUSH SI
    
    mov fila_titulo, 30
    ;mov col_gameOv, 60
muevo_creditos:
    cmp fila_titulo, 1
    je pres_tecla_c

    call limpiar_pantalla
    ; Mostrar "Game Over"
    mov dh, fila_titulo     ; Fila
    add dh, 5
    mov dl, col_gameOv      ; Columna centrada aproximadamente
    mov si, offset exit
    mov bl, 02h   ; Atributo resaltado
    call imprimir_cadena
    dec fila_titulo
    call delay_new
    call delay_new
    call delay_new
    call delay_new
    call delay_new
    call delay_new
jmp muevo_creditos

pres_tecla_c:
    ; Mostrar instrucción para volver
    mov dh, fila_inicio
    add dh, 5
    mov dl, col_msjGOv
    mov si, offset msg_presiona_tecla
    mov bl, [normal_attr]
    call imprimir_cadena

    ; Esperar tecla
    mov ah, 00h
    int 16h

    POP SI
    POP DX
    POP BX
    ret

dibujar_creditos endp

end