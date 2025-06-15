.8086
.MODEL SMALL
.STACK 100H

.DATA
	BITMAP_MASK				DB	10000000b
							DB	01000000b
							DB	00100000b
							DB	00010000b
							DB	00001000b
							DB	00000100b
							DB	00000010b
							DB	00000001b

	COLOR_REGISTER			DB	0FH
	TEMP_COLOR				DB	0
	TEMP_DRAWRECTANGLE_X	DW	0
	TEMP_DRAWRECTANGLE_Y	DW	0

.CODE

	

	

	PUBLIC DRAW_RECTANGLE

	;Push color.
	;Push offset del sprite.
	;Push coordenada x
	;Push coordenada y
	;Push base (en bytes)
	;Push altura (en pixeles)

	PUBLIC DRAW_SPRITE

	
	DRAW_RECTANGLE PROC
		; EN STACK:
		;EN CX, COORDENADA (X)
		;EN DX, COORDENADA (Y)
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
END