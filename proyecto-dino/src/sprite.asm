;TEMPLATE PARA ARMAR LIBRERIA DE FUNCIONES
.8086
.model small
.stack 100h

.data
        SPRITE_DINO     db 00h,3Eh,00h,7Fh,00h,6Fh,00h,7Fh,00h,78h,00h,7Eh,80h,70h,80h,0F0h,0C1h,0FCh,0E1h,0F4h,0FFh,0F0h,0FFh,0F0h,7Fh,0F0h,3Fh,0E0h,1Fh,0C0h,0Fh,80h,0Dh,80h,08h,80h,0Ch,0C0h
        SPRITE_SHIP     DB 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
        Piramide        db 18h, 24h, 42h, 81h, 0ffh ;Bitmap

        fondob          db 00h, 20h, 00h, 00h, 00h, 02h, 80h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 50h, 00h, 00h, 80h, 04h, 40h, 02h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 90h, 20h, 01h, 80h, 08h, 20h, 05h, 00h, 10h, 00h, 00h, 00h
                        db 00h, 88h, 50h, 02h, 80h, 12h, 10h, 04h, 80h, 28h, 00h, 00h, 00h
                        db 01h, 28h, 48h, 02h, 40h, 21h, 08h, 08h, 80h, 48h, 00h, 00h, 00h
                        db 02h, 24h, 88h, 04h, 40h, 20h, 88h, 10h, 40h, 64h, 00h, 02h, 00h
                        db 02h, 65h, 04h, 09h, 20h, 40h, 04h, 21h, 40h, 94h, 00h, 05h, 00h
                        db 04h, 42h, 24h, 10h, 11h, 86h, 02h, 41h, 21h, 02h, 02h, 08h, 80h
                        db 08h, 04h, 42h, 10h, 0Ah, 01h, 82h, 82h, 12h, 02h, 05h, 08h, 80h
                        db 08h, 05h, 81h, 20h, 04h, 40h, 41h, 10h, 14h, 01h, 04h, 90h, 40h
                        db 10h, 8Ah, 01h, 41h, 02h, 40h, 00h, 90h, 88h, 41h, 08h, 0A0h, 40h
                        db 23h, 14h, 00h, 82h, 02h, 22h, 00h, 88h, 88h, 40h, 9Ch, 40h, 20h
                        db 24h, 20h, 31h, 04h, 21h, 02h, 0Ch, 40h, 04h, 20h, 0A0h, 88h, 20h
                        db 48h, 20h, 0C2h, 00h, 41h, 01h, 30h, 20h, 02h, 0Eh, 4Ch, 84h, 10h
                        db 80h, 40h, 02h, 00h, 00h, 80h, 00h, 11h, 0C2h, 00h, 41h, 00h, 90h

        fondom          db 00h, 20h, 00h, 00h, 00h, 03h, 80h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 60h, 00h, 00h, 00h, 07h, 0C0h, 02h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 70h, 20h, 01h, 00h, 0Dh, 0E0h, 03h, 00h, 10h, 00h, 00h, 00h
                        db 00h, 0F0h, 30h, 01h, 80h, 1Eh, 0F0h, 07h, 00h, 30h, 00h, 00h, 00h
                        db 01h, 0F8h, 70h, 03h, 80h, 1Fh, 70h, 0Fh, 80h, 18h, 00h, 00h, 00h
                        db 01h, 0F8h, 0F8h, 06h, 0C0h, 3Fh, 0F8h, 1Eh, 80h, 68h, 00h, 02h, 00h
                        db 03h, 0FDh, 0D8h, 0Fh, 0E0h, 79h, 0FCh, 3Eh, 0C0h, 0FCh, 00h, 07h, 00h
                        db 03h, 0FDh, 0D8h, 0Fh, 0E0h, 79h, 0FCh, 3Eh, 0C0h, 0FCh, 00h, 07h, 00h
                        db 07h, 0FBh, 0BCh, 0Fh, 0F1h, 0FEh, 7Ch, 7Dh, 0E1h, 0FCh, 02h, 07h, 00h
                        db 07h, 0FAh, 7Eh, 1Fh, 0FBh, 0BFh, 0BEh, 0EFh, 0E3h, 0FEh, 03h, 0Fh, 80h
                        db 0Fh, 0F5h, 0FEh, 3Eh, 0FDh, 0BFh, 0FFh, 6Fh, 77h, 0BEh, 07h, 1Fh, 80h
                        db 1Fh, 0EBh, 0FFh, 7Dh, 0FDh, 0DDh, 0FFh, 77h, 77h, 0BFh, 03h, 0BFh, 0C0h
                        db 1Fh, 0DFh, 0CEh, 0FBh, 0DEh, 0FDh, 0F3h, 0BFh, 0FBh, 0DFh, 1Fh, 77h, 0C0h
                        db 3Fh, 0DFh, 3Dh, 0FFh, 0BEh, 0FEh, 0CFh, 0DFh, 0FDh, 0F1h, 0B3h, 7Bh, 0E0h
                        db 7Fh, 0BFh, 0FDh, 0FFh, 0FFh, 7Fh, 0FFh, 0EEh, 3Dh, 0FFh, 0BEh, 0FFh, 60h

        fondon          db 80h, 00h, 00h, 00h, 07h, 00h, 03h, 80h, 00h, 00h, 00h, 00h, 00h
                        db 80h, 00h, 00h, 00h, 07h, 80h, 07h, 0C0h, 00h, 00h, 00h, 00h, 00h
                        db 0C0h, 00h, 00h, 40h, 0Fh, 80h, 07h, 0E0h, 04h, 00h, 00h, 20h, 10h
                        db 0E0h, 00h, 00h, 0E0h, 1Fh, 0C0h, 07h, 0E0h, 0Eh, 00h, 00h, 70h, 30h
                        db 0E0h, 00h, 00h, 0E0h, 1Fh, 0C0h, 07h, 0E0h, 0Eh, 00h, 00h, 70h, 30h
                        db 0E0h, 00h, 00h, 0F0h, 1Fh, 80h, 03h, 0C0h, 1Fh, 00h, 00h, 0F8h, 70h
                        db 0F0h, 00h, 01h, 0E0h, 0Eh, 00h, 01h, 80h, 1Eh, 00h, 00h, 0F0h, 70h
                        db 0F0h, 00h, 01h, 0E0h, 04h, 00h, 01h, 00h, 0Ch, 00h, 40h, 0F0h, 70h
                        db 0F0h, 00h, 00h, 0C0h, 00h, 00h, 00h, 00h, 08h, 00h, 0E0h, 60h, 30h
                        db 0E0h, 00h, 00h, 80h, 00h, 00h, 00h, 00h, 00h, 00h, 0F0h, 40h, 30h
                        db 0C0h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 60h, 00h, 10h
                        db 0C0h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 60h, 00h, 10h
                        db 0C0h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 40h, 00h, 10h
                        db 80h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
        
        BITMAP_MASK	DB	10000000b
                        DB	01000000b
                        DB	00100000b
                        DB	00010000b
                        DB	00001000b
                        DB	00000100b
                        DB	00000010b
                        DB	00000001b

	COLOR_REGISTER	DB	0FH
	TEMP_COLOR	DB	0
	TEMP_DRAWRECTANGLE_X	DW	0
	TEMP_DRAWRECTANGLE_Y	DW	0
		
.code
        EXTRN delay:PROC            ; -> LOGIC.ASM
        PUBLIC SPRITE 

SPRITE proc

;;; MONTAÑAS
      PUSH 07H                  ;(Marron)
      PUSH OFFSET fondob        ;(OFFSET DEL SPRITE)
      PUSH 0                  ;COORDENADA X
      PUSH 80                   ;COORDENADA Y

      PUSH 13               ;BASE EN BYTES, LA NAVE SON 2 BYTES DE LARGO.
      PUSH 30                 ;ALTURA EN PIXELES, (12 DE ALTO).
      CALL DRAW_SPRITE

      PUSH 07H                  ;(Marron)
      PUSH OFFSET fondob        ;(OFFSET DEL SPRITE)
      PUSH 100                  ;COORDENADA X
      PUSH 80                   ;COORDENADA Y

      PUSH 13               ;BASE EN BYTES, LA NAVE SON 2 BYTES DE LARGO.
      PUSH 30                 ;ALTURA EN PIXELES, (12 DE ALTO).
      CALL DRAW_SPRITE

      PUSH 07H                  ;(Marron)
      PUSH OFFSET fondob        ;(OFFSET DEL SPRITE)
      PUSH 200                  ;COORDENADA X
      PUSH 80                   ;COORDENADA Y

      PUSH 13               ;BASE EN BYTES, LA NAVE SON 2 BYTES DE LARGO.
      PUSH 30                 ;ALTURA EN PIXELES, (12 DE ALTO).
      CALL DRAW_SPRITE
;;; MONTAÑAS

;;; LINEA DE ABAJO
      PUSH 04H                ;(ROJO)
      PUSH OFFSET SPRITE_SHIP ;(OFFSET DEL SPRITE)
      PUSH 0                 ;COORDENADA X
      PUSH 150               ;COORDENADA Y

      PUSH 40                  ;BASE EN BYTES, LA NAVE SON 2 BYTES DE LARGO.
      PUSH 1                 ;ALTURA EN PIXELES, (12 DE ALTO).
      CALL DRAW_SPRITE
;;; LINEA DE ABAJO

;;; DINO
      PUSH 3fH                ;(ROJO)
      PUSH OFFSET SPRITE_DINO ;(OFFSET DEL SPRITE)
      PUSH 30                 ;COORDENADA X
      PUSH 120                ;COORDENADA Y

      PUSH 2                  ;BASE EN BYTES, LA NAVE SON 2 BYTES DE LARGO.
      PUSH 19                 ;ALTURA EN PIXELES, (12 DE ALTO).
      CALL DRAW_SPRITE
;;; DINO
        xor bx ,bx
        ;;; RECTANGULO
loopRectangulo:
      ;EN CX, COORDENADA X.
      ;EN DX, COORDENADA Y.
      ;EN AL, COLOR.
      ;PUSH BASE EN PIXELES.
      ;PUSH ALTURA EN PIXELES.
       
      MOV CX, 160  ;COORDENADA X
      sub cx,bx
      MOV DX, 130  ;COORDENADA Y
      MOV AL, 02H ;COLOR EN AL.
      PUSH 25     ;BASE.
      PUSH 10     ;ALTURA.
      CALL DRAW_RECTANGLE
      call delay
      cmp bx, 100
      je fin
      add bx, 10
jmp loopRectangulo
;;; RECTANGULO
fin:
      ret

SPRITE endp

DRAW_SPRITE PROC
        PUSH BP
        MOV BP, SP
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH DI

        ;En variable db COLOR_REGISTER Color a dibujar.
        ;[BP+4] 	Altura en pixeles.
        ;[BP+6] 	Base en bytes.
        ;[BP+8] 	(Y)
        ;[BP+10] 	(X)
        ;[BP+12] 	OFFSET del bitmap.
        ;[BP+14]    COLOR.


        XOR BX,BX ;Contadores BL base, BH altura.
        MOV AX, [BP+14]
        MOV COLOR_REGISTER, AL
        XOR AX,AX
        MOV DI, [BP+12]
        MOV DX, [BP+8]
        MOV BL, 00H
        MOV CX, [BP+10]
        JMP CONTINUE_ROW

        NEXT_ROW:
        ADD DI, 01H
        MOV BL, 00H
        MOV CX, [BP+10]
        CONTINUE_ROW:
        MOV AL, byte ptr [DI]
        PUSH AX
        CALL PRINT_APPLY_MASK

        INC BL
        CMP BL, [BP+6]
        JGE PREPARE_NEXTROW
        ADD DI, 01H

        add CX, 8
        JMP CONTINUE_ROW
        PREPARE_NEXTROW:
        INC AH
        CMP AH, [BP+4]
        JGE END_DRAWING_SPRITE
        INC DX
        JMP NEXT_ROW
        END_DRAWING_SPRITE:

        POP DI
        POP DX
        POP CX
        POP BX
        POP AX
        POP BP
        RET 12
DRAW_SPRITE ENDP

PRINT_APPLY_MASK PROC
    PUSH BP
    MOV BP, SP

    PUSH AX
    PUSH CX
    PUSH DX
    PUSH BX

    LEA BX, BITMAP_MASK
    XOR AX, AX
    MOV AL, [BP+4]
    BITPRINT:
    ;bit 7
    AND AL, [BX+0]
    CALL PIXEL_PRINT_TEST
    INC CX	;bit 6
    MOV AL, [BP+4]
    AND AL, [BX+1]
    CALL PIXEL_PRINT_TEST
    INC CX	;bit 5
    MOV AL, [BP+4]
    AND AL, [BX+2]
    CALL PIXEL_PRINT_TEST
    INC CX	;bit 4
    MOV AL, [BP+4]
    AND AL, [BX+3]
    CALL PIXEL_PRINT_TEST
    INC CX	;bit 3
    MOV AL, [BP+4]
    AND AL, [BX+4]
    CALL PIXEL_PRINT_TEST
    INC CX	;bit 2
    MOV AL, [BP+4]
    AND AL, [BX+5]
    CALL PIXEL_PRINT_TEST
    INC CX	;bit 1
    MOV AL, [BP+4]
    AND AL, [BX+6]
    CALL PIXEL_PRINT_TEST
    INC CX	;bit 0
    MOV AL, [BP+4]
    AND AL, [BX+7]
    CALL PIXEL_PRINT_TEST

    POP BX
    POP DX
    POP CX
    POP AX

    POP BP
    RET 2
PRINT_APPLY_MASK ENDP

PIXEL_PRINT_TEST PROC
    PUSH AX
    PUSH BX

    CMP AL, 00H
    JNE PRINT_THIS_PIXEL
    ;Sino imprimo en negro.
    MOV AL, 00H
    JMP RETURN_FROM_PIXEL_PRINT
    PRINT_THIS_PIXEL:
    MOV AL, COLOR_REGISTER
    RETURN_FROM_PIXEL_PRINT:
    MOV AH, 0CH ;Escribir pixel grafico..
    MOV BH, 00H ;Pagina.
    INT 10H

    POP BX
    POP AX
    RET
PIXEL_PRINT_TEST ENDP

DRAW_RECTANGLE PROC
        ; EN STACK:
        ; EN CX, COORDENADA (X)
        ; EN DX, COORDENADA (Y)
        ; En AL el color (00H A 0FH).
        ; 1 PUSH BASE    	[BP+6].
        ; 2 PUSH ALTURA		[BP+4].

        PUSH BP
        MOV BP, SP
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX

        MOV TEMP_COLOR, AL
        MOV TEMP_DRAWRECTANGLE_X, CX
        MOV TEMP_DRAWRECTANGLE_Y, DX

        DRAW_RECTANGLE_LOOP:
        MOV AH, 0CH ;servicio 0ch.
        MOV AL, TEMP_COLOR
        MOV BH, 00H
        INT 10H							;Escribe un pixel.

        INC CX							;Incrementa la coordenada.
        MOV AX, CX
        SUB AX, TEMP_DRAWRECTANGLE_X 	;Se resta la coordenada (X).
        CMP AX, [BP+6]	 				;La diferencia tiene que ser mayor que su base.
        JL DRAW_RECTANGLE_LOOP
        MOV CX, TEMP_DRAWRECTANGLE_X	;Se reinicia la coordenada (X).
        INC DX							;Se incrementa la coordenada (Y).				
        MOV AX, DX
        SUB AX, TEMP_DRAWRECTANGLE_Y		
        CMP AX, [BP+4] 					;La diferencia tiene que ser mayor que la altura.
        JL DRAW_RECTANGLE_LOOP

        POP DX
        POP CX
        POP BX
        POP AX
        POP BP
        RET 4
DRAW_RECTANGLE ENDP

end