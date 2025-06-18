.8086
.model small
.stack 100h
.data
    salto_activo db 0
    ticks_salto  db 0
    
    dino_color db 3fh       ;(ROJO)
    dino_x db 30
    dino_y db 120
    dino_y_salto db 100
    dino_y_ori   db 120

    pati_color   db 04H       ;(ROJO)
    pati_y_ori   db 18

    obstaculo_color db 02h  ;(VERDE)
    obstaculo_x db 255
    obstaculo_y db 120
    obstaculo_x_ori db 255
    obstaculo_fig db 0

    moneda_x db 255
    moneda_y db 100
    moneda_x_ori db 255

    score_actual     db 0
    scoreas          db '000',0dh,0ah
    moneda_colision  db 0

    senal_color db 85h  ;(VIOLETA)
    ship_color db 66h   ;(CELESTE)
    cactus_color db 02h ;(VERDE)
    moneda_color db 44h ;(AMARILLO)

.code
    EXTRN limpiar_pantalla:PROC ; -> LOGIC.ASM
    EXTRN modo_negro:PROC       ; -> LOGIC.ASM

    ;EXTRN ESPERA:PROC           ; -> ESPERA.ASM
    EXTRN delay_new:PROC        ; -> LOGIC.ASM

    EXTRN FONDOSP:PROC          ; -> SPRITE.ASM
    EXTRN DINOSP:PROC           ; -> SPRITE.ASM
    EXTRN OBSTACULOSP:PROC      ; -> SPRITE.ASM
    EXTRN PATINETASP:PROC       ; -> SPRITE.ASM
    EXTRN MONEDASP:PROC         ; -> SPRITE.ASM

    EXTRN score:PROC            ; -> SCORE.ASM

    EXTRN GAME_OVER:PROC        ; -> MAIN.ASM
    EXTRN GAME_WIN:PROC         ; -> MAIN.ASM

    EXTRN reg2ascii:PROC

    PUBLIC JUEGO

;-------------------------------------------------------------------------------------------------
;Función juego 
;		Realiza: 	UNIFICA TODA LA LOGICA DEL JUEGO
;		Recibe: 	NADA
;		Devuelve: 	NADA
;-------------------------------------------------------------------------------------------------
juego proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    CALL LIMPIAR_PANTALLA

    ;----------------
    ; MODO GRAFICO 256 COL
    mov ah, 00h
    mov al, 13h
    int 10h

inicio:
    call MODO_NEGRO ; ES COMO LIMPIAR PANTALLA PERO PARA EL MODO GRAFICO
    call FONDOSP    ; IMPRIMO EL BACKGROUND

    CALL resetMoneda
    mov bl, obstaculo_x_ori        ; SETEO EL OBSTACULO EN EL X ORIGINAL PARA CUANDO VUELVE DEL GAME OVER
    mov obstaculo_x, bl
    ;mov byte ptr score_actual, 0 ; SE RESETEA EL SCORE A 0 PARA CUANDO VUELVE DEL GAME OVER 

nuevo_obs:
    xor ax,ax
    INT 80h ; ← AL contiene un número entre 0 y 9
    mov si, ax
    cmp si, 9
    jne game_loop
    mov moneda_colision, 1
game_loop:
    mov al, score_actual
    cmp al, 250 ; SI LLEGAS A 250 GANAS!
    jae finJuego 
    cmp al, 230 ; SI ES 230 YA PUEDE ROMPER EL SCORE
    jbe monedaValida
    call resetMoneda
monedaValida:
    CALL SCORE           ; SE DIBUJA EL SCORE

    ; IMPRIMO SPRITES!
    cmp di, 0
    je mover_pat
    mov di, 0
    jmp imprime_pat
mover_pat:
    mov di, 1
imprime_pat:
    mov al, dino_color
    call dibujar_dino

    call obstaculo_color_leer
    call dibujar_obs
    
    cmp moneda_colision, 0
    je noImprimeMoneda
    mov al, moneda_color
    call dibujar_moneda
    ; IMPRIMO SPRITES!
noImprimeMoneda:
    call colision

    mov al, score_actual
    mov dl, al          ; AUMENTA LA VELOCIDAD EXPONENCIALMENTE
    mul dl
    call delay_new      ; USO LA FUNCION ESPERA PARA MANEJAR EL MOVIMIENTO

    mov ah, 01h         ; LEE LA PULSACION DE TECLA PERO SIN ESPERAR QUE SE PRESIONE ALGO!
    int 16h
    jz sin_tecla

    mov ah, 00h         ; OBTENGO EL ESTADO BUFFER DEL TECLADO A VER SI HAY UNA 'W'
    int 16h
    cmp al, 'w'
    je salto

sin_tecla:
    call manejar_salto
    call mover_obstaculo
    cmp moneda_colision, 0
    je noMuevoMoneda
    call mover_moneda
noMuevoMoneda:
    cmp si, 10
    je nuevo_obs
    jmp game_loop ; TERMINA CON EL 'GAME OVER'

salto:
    mov salto_activo, 1 ; CUANDO SE PRESIONE LA 'W' LO MARCO PARA QUE SALTE
    jmp sin_tecla

finJuego:
    CALL LIMPIAR_PANTALLA
    CALL GAME_WIN

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
juego endp

;-------------------------------------------------------------------------------------------------
;Función manejar_salto 
;		Realiza: 	TIENE LA LOGICA DEL SALTO DEL DINO	
;		Recibe: 	NADA
;		Devuelve: 	NADA
;-------------------------------------------------------------------------------------------------
manejar_salto proc
    PUSH AX
    PUSH BX
    PUSH CX

    mov ah, 0
    call borro_sprite       ; BORRO EL SPRITE ANTERIOR PARA IMPRIMIR UNO NUEVO

    cmp salto_activo, 0     ; CHEQUEO EL FLAG DE SALTO, ESTE SE ACTIVA SI PRESIONO LA 'W'
    je sin_salto

    MOV bl, dino_y_salto
    MOV dino_y, bl

    mov al, ticks_salto     ; MANTENGO AL DINO ARRIBA POR X TICKS DE ESPERA
    cmp al, 10              ; SETEO 10 TICKS PARA MANTENERLO ARRIBA
    je fin_salto
    inc al
    mov ticks_salto, al
    jmp fin
fin_salto:
    call FONDOSP            ; VUELVO A IMPRIMIR EL FONDO PORQUE EL DINO LO PISA
    mov ticks_salto, 0      ; RESETEO TICKS
    mov salto_activo, 0     ; RESETEO SALTO PARA ESPERAR LA 'W'
sin_salto:
    MOV bl, dino_y_ori      ; PONGO AL DINO EN SU POSICION Y ORIGINAL
    MOV dino_y, bl
fin:
    POP CX
    POP BX
    POP AX
    ret
manejar_salto endp

;-------------------------------------------------------------------------------------------------
;Función mover_obstaculo 
;		Realiza: 	MUEVE UN OBSTACULO X PIXELES HARDCODEADOS, MANEJA LA VELOCIDAD
;		Recibe: 		NADA
;		Devuelve: 	    NADA
;-------------------------------------------------------------------------------------------------
mover_obstaculo proc
    PUSH AX
    PUSH BX
    PUSH CX

    mov ah, 1
    call borro_sprite
    
    mov al, dino_x
    sub al, 20          ; SI SE PASO POR 20 PIXELES VUELVE AL PRINCIPIO
    cmp obstaculo_x, al
    jb resetObs

    mov bl, obstaculo_x
    sub bl, 5           ; VELOCIDAD DE MOVIMIENTO DEL OBSTACULO
    mov obstaculo_x, bl
    jmp finObs
resetObs:
    mov bl, obstaculo_x_ori     ; SI SE PASO DEL X DEL DINO LO RESETEO
    mov obstaculo_x, bl
    mov si, 10
finObs:
    POP CX
    POP BX
    POP AX
    ret
mover_obstaculo endp

mover_moneda proc
    PUSH AX
    PUSH BX
    PUSH CX

    mov ah, 2
    call borro_sprite

    mov al, dino_x
    sub al, 20          ; SI SE PASO POR 20 PIXELES VUELVE AL PRINCIPIO
    cmp moneda_x, al
    jbe resetMon

    mov bl, moneda_x
    sub bl, 1           ; VELOCIDAD DE MOVIMIENTO DEL OBSTACULO
    mov moneda_x, bl
    jmp finMovMoneda
resetMon:
    CALL resetMoneda
finMovMoneda:
    POP CX
    POP BX
    POP AX
    ret
mover_moneda endp

;-------------------------------------------------------------------------------------------------
;Función COLISION 
;		Realiza: VERIFICA LA COLISION DE EL OBSTACULO Y EL DINO USANDO EL XY DE LOS MISMOS
;		Recibe: 	NADA	
;		Devuelve: 	NADA
;-------------------------------------------------------------------------------------------------
colision proc
    PUSH AX
    PUSH BX
    PUSH CX

    mov al, dino_x
    sub al, 5           ; VALIDO RANGO DE 5 PIXELES A VER SI COLISIONO
    cmp al, obstaculo_x
    jbe comparaX
    jmp no_colisiona

comparaX:
    add al, 10          ; VALIDO RANGO DE 5 PIXELES A VER SI COLISIONO
    cmp al, obstaculo_x
    jbe continua

comparaY:
    mov al, dino_y
    cmp al, obstaculo_y
    jne suma_punto
    
    CALL delay_new
    CALL delay_new
    CALL LIMPIAR_PANTALLA 
    CALL GAME_OVER    ; Si XY son iguales para ambos SPRITES PIERDE!
no_colisiona:
    cmp salto_activo, 0
    je suma_punto
    jmp continua

suma_punto:
    inc score_actual ; SUPERA EL OBSTACULO, SUMA 1 PUNTO

continua:                   ; LOGICA COLISION MONEDA
    mov al, moneda_x
    cmp al, dino_x
    jne finColision
    mov al, moneda_y
    cmp al, dino_y
    jne finColision
    mov cx, 15    ; CUANTOS PUNTOS DA AGARRAR LA MONEDA
choqueMoneda:
    inc score_actual
loop choqueMoneda
    mov ah, 2               ; BORRO MONEDA
    call borro_sprite
    CALL resetMoneda        ; RESETEO MONEDA
                            ; FIN LOGICA COLISION MONEDA
finColision:
    POP CX
    POP BX
    POP AX
    RET
colision endp

;-------------------------------------------------------------------------------------------------
;Función borro_sprite 
;		Realiza: 	PRINTEA EN NEGRO EL SPRITE VIEJO PARA IMPRIMIR EL NUEVO
;		Recibe: 	EN AH 1 PARA OBSTACULO, 0 PARA DINO	
;		Devuelve: 	NADA
;-------------------------------------------------------------------------------------------------
borro_sprite PROC
    ; PRINTEO EL SPRITE EN NEGRO PARA 'BORRARLO'
    PUSH AX
    PUSH BX
    PUSH CX

    mov al, 00H             ;(NEGRO)
    cmp ah, 1               ; SI VIENE 1 EN AH BORRO EL OBSTACULO, SI VIENE 0 EL DINO
    je obs
    cmp ah, 2               ; SI VIENE 1 EN AH BORRO EL OBSTACULO, SI VIENE 0 EL DINO
    je mon
    call dibujar_dino       ; DIBUJO EL DINO PERO EN NEGRO (LO BORRO)
    jmp finSp
obs:
    call dibujar_obs        ; DIBUJO EL OBS PERO EN NEGRO (LO BORRO)
    jmp finSp
mon:
    call dibujar_moneda     ; DIBUJO EL MONEDA PERO EN NEGRO (LO BORRO)
finSp:
    POP CX
    POP BX
    POP AX
    ret
borro_sprite endp

Score_Ascii proc

mov al,score_actual
push ax
mov dx, offset scoreas
push dx
call reg2ascii

Score_ascii endp


;-------------------------------------------------------------------------------------------------
;Función dibujar 
;		Realiza: 	DIBUJAR LAS FIGURAS
;		Recibe: 	AL -> COLOR, BL -> POS X, CL -> POS Y
;		Devuelve: 	NADA
;-------------------------------------------------------------------------------------------------

dibujar_dino proc
    mov bl, dino_x
    mov cl, dino_y
    call DINOSP

    cmp al, 00H
    je negroPat
    mov al, pati_color
negroPat:
    mov bl, dino_x
    mov cl, dino_y
    add cl, pati_y_ori
    call PATINETASP
    ret
dibujar_dino endp

dibujar_obs proc
    mov bl, obstaculo_x
    mov cl, obstaculo_y
    call OBSTACULOSP
    ret
dibujar_obs endp

dibujar_moneda proc
    mov bl, moneda_x
    mov cl, moneda_y
    call MONEDASP
    ret
dibujar_moneda endp

obstaculo_color_leer proc
    CMP SI, 2
    JBE esCactus
    CMP SI, 4
    JBE esSenal
    CMP SI, 6
    JBE esCactus
    CMP SI, 8
    JBE esSenal
    mov al, ship_color
    JMP finLecturaColorObstaculo
esCactus:
    mov al, cactus_color
    JMP finLecturaColorObstaculo
esSenal:
    mov al, senal_color
finLecturaColorObstaculo:
    ret
obstaculo_color_leer endp

resetMoneda proc
    PUSH BX
    mov bl, moneda_x_ori        ; SETEO LA MONEDA EN EL X ORIGINAL PARA CUANDO VUELVE DEL GAME OVER
    mov moneda_x, bl
    mov moneda_colision, 0
    POP BX
    RET
resetMoneda endp
end