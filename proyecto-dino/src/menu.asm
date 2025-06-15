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
    PUBLIC MENU

    EXTRN limpiar_pantalla:PROC ; -> LOGIC.ASM
    EXTRN delay:PROC            ; -> LOGIC.ASM
    EXTRN imprimir_cadena:PROC  ; -> DRAW.ASM
    
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
        call dibujar_records

    fin:
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
;Función dibujar_records 
;		Realiza: 		
;		Recibe: 		
;		Devuelve: 	
;-------------------------------------------------------------------------------------------------

dibujar_records proc
        
        call limpiar_pantalla

        ; AGREGAR MENU PARA RECORDS
        call menu
        ; AGREGAR MENU PARA RECORDS
        ret
dibujar_records endp

end