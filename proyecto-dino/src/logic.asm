.8086
.model small
.stack 100h
		
.code
    PUBLIC limpiar_pantalla
    PUBLIC delay
    PUBLIC delay_new
    PUBLIC modo_negro
    PUBLIC modo_texto

;-------------------------------------------------------------------------------------------------
;Función limpiar_pantalla 
;		Realiza: 		
;		Recibe: 		
;		Devuelve: 	
;-------------------------------------------------------------------------------------------------
limpiar_pantalla proc
    push ax
    push bx
    push cx
    push dx

    ; Limpiar pantalla
    mov ax, 0600h
    mov bh, 07h
    mov cx, 0000h
    mov dx, 184Fh
    int 10h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
limpiar_pantalla endp

;-------------------------------------------------------------------------------------------------
;Función modo_negro 
;		Realiza: 		
;		Recibe: 		
;		Devuelve: 	
;-------------------------------------------------------------------------------------------------
modo_negro proc
    push ax
    push bx

    ;SETEO FONDO EN NEGRO:
    MOV AH, 0BH
    MOV BH, 00H
    MOV BL, 00H
    INT 10H
    ;---------------

    pop bx
    pop ax
    ret
modo_negro endp

;-------------------------------------------------------------------------------------------------
;Función delay 
;		Realiza: 		
;		Recibe: 		
;		Devuelve: 	
;-------------------------------------------------------------------------------------------------
delay proc
    push ax
    push bx
    push cx
    push dx

    mov cx, 0
    ; Esperar en base a CX ticks (CX * ~55ms)
    ; CX debe contener la cantidad de ticks antes de llamar
    mov ah, 00h
    int 1Ah
    mov bx, dx
    add bx, cx

.loop_delay:
    mov ah, 00h
    int 1Ah
    cmp dx, bx
    jb .loop_delay

    pop dx
    pop cx
    pop bx
    pop ax
    ret
delay endp

delay_new proc
    push cx
    push ax

    mov cx, 0FFFFh ; me dejo de andar el de arriba :(
    sub cx, ax
delay_loop:
    nop
    loop delay_loop

    pop ax
    pop cx
    ret
delay_new endp


modo_texto proc
    push ax
    push cx

    ; Configurar modo video (80x25 texto) 16 COL
    mov ax, 0003h
    int 10h

    ; Ocultar cursor
    mov ah, 01h
    mov cx, 2607h
    int 10h

    pop cx
    pop ax
    ret
modo_texto endp

end
