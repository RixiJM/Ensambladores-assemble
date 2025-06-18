;TEMPLATE PARA ARMAR LIBRERIA DE FUNCIONES
.8086
.model small
.stack 100h

.data
      SPRITE_DINO       db 00h,3Eh,00h,7Fh,00h,6Fh,00h,7Fh,00h,78h,00h,7Eh,80h,70h,80h,0F0h,0C1h,0FCh,0E1h,0F4h,0FFh,0F0h,0FFh,0F0h,7Fh,0F0h,3Fh,0E0h,1Fh,0C0h,0Fh,80h,0Dh,80h,08h,80h,0Ch,0C0h
      SPRITE_LINEA      DB 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh

      SPRITE_SHIP       DB 02H,00H,07H,00H,05H,00H,05H,00H,15H,40H,97H,48H,9FH
                        DB 0C8H,0BFH,0E8H,0FFH,0F8H,0EFH,0B8H,0CFH,98H,82H,08H
      
      SPRITE_PATINETA db 0C0h, 03h, 3Fh, 0FCh, 10h, 08h, 28h, 14h, 10h, 08h ;base 2 bytes, Altura 5 pix, color 04h (rojo)

      SPRITE_PAT_MOV db  0C0h, 03h, 3Fh, 0FCh, 28h, 14h, 00h, 00h, 28h, 14h ;base 2 bytes, Altura 5 pix, color 04h (rojo)
      
      SPRITE_MONEDA db   01h,0C0h,03h,0E0h,07h,70h,06h,30h,07h,70h,03h,0E0h,01h,0C0h ; base 2 bytes, altura 7 pix, color 44h (amarillo)


      SPRITE_SENAL db  07h, 0E0h, 0Fh, 0F0h, 1Fh, 0F8h, 3Fh, 0FCh, 3Fh, 0FCh, 3Fh, 0FCh, 3Fh, 0FCh, 3Fh, 0FCh, 1Fh, 0F8h, 0Fh, 0F0h, 07h, 0E0h, 01h, 80h, 01h, 80h, 01h, 80h, 01h, 80h, 01h, 80h, 01h, 80h
      
      SPRITE_CACTUS db 01h,80h,03h,0C0h,03h,0C0h,03h,0C6h,03h,0CFh,43h,0CFh,0E3h,0CFh,0E3h,0CFh,0E3h,0CFh,0FFh,0CFh,7Fh,0CFh,03h,0FFh,03h,0FEh,03h,0FEh,03h,0F8h,03h,0C0h,03h,0C0h,03h,0C0h

      fondob            db 00h, 20h, 00h, 00h, 00h, 02h, 80h, 00h, 00h, 00h, 00h, 00h, 00h
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

      fondom            db 00h, 20h, 00h, 00h, 00h, 03h, 80h, 00h, 00h, 00h, 00h, 00h, 00h
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

      fondon            db 80h, 00h, 00h, 00h, 07h, 00h, 03h, 80h, 00h, 00h, 00h, 00h, 00h
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
		
.code
        EXTRN DRAW_RECTANGLE:PROC   ; -> LIBSP.ASM
        EXTRN DRAW_SPRITE:PROC      ; -> LIBSP.ASM
        
        PUBLIC FONDOSP 
        PUBLIC DINOSP
        PUBLIC OBSTACULOSP
        PUBLIC PATINETASP
        PUBLIC MONEDASP 

;-------------------------------------------------------------------------------------------------
;Función FONDOSP 
;		Realiza: DIBUJA SPRITE FONDO / BACKGROUND
;		Recibe: 	NADA, TODO HARDCODEADO
;		Devuelve: 	   NADA
;-------------------------------------------------------------------------------------------------
FONDOSP proc
;;; MONTAÑAS
      PUSH DI

      MOV DI, 0
dibujar_montanas:
      PUSH 07H                  ;(Marron)
      PUSH OFFSET fondob        ;(OFFSET DEL SPRITE)
      PUSH DI                   ;COORDENADA X
      PUSH 70                   ;COORDENADA Y

      PUSH 13               ;BASE EN BYTES, LA NAVE SON 2 BYTES DE LARGO.
      PUSH 30                 ;ALTURA EN PIXELES, (12 DE ALTO).
      CALL DRAW_SPRITE

      ADD DI, 100
      CMP DI, 200
      JA continua_fondo
jmp dibujar_montanas
;;; MONTAÑAS
continua_fondo:
;;; LINEA DE ABAJO
      PUSH 0fH                ;(BLANCO)
      PUSH OFFSET SPRITE_LINEA ;(OFFSET DEL SPRITE)
      PUSH 0                 ;COORDENADA X
      PUSH 143               ;COORDENADA Y

      PUSH 40                  ;BASE EN BYTES, LA NAVE SON 2 BYTES DE LARGO.
      PUSH 1                 ;ALTURA EN PIXELES, (12 DE ALTO).
      CALL DRAW_SPRITE
      
      POP DI
      RET
;;; LINEA DE ABAJO
FONDOSP ENDP

;-------------------------------------------------------------------------------------------------
;Función DINOSP 
;		Realiza: DIBUJA SPRITE DINO	
;		Recibe: 		AL -> COLOR, BL -> COORDENADA X, CL -> COORDENADA Y
;		Devuelve: 	   NADA
;-------------------------------------------------------------------------------------------------
DINOSP PROC
;;; DINO
      PUSH AX                 ;COLOR
      PUSH OFFSET SPRITE_DINO ;(OFFSET DEL SPRITE)
      PUSH BX                 ;COORDENADA X (30)
      PUSH CX                 ;COORDENADA Y (120)

      PUSH 2                  ;BASE EN BYTES, LA NAVE SON 2 BYTES DE LARGO.
      PUSH 19                 ;ALTURA EN PIXELES, (12 DE ALTO).
      CALL DRAW_SPRITE
      RET
;;; DINO
DINOSP ENDP

;-------------------------------------------------------------------------------------------------
;Función OBSTACULOSP 
;		Realiza: DIBUJA SPRITE OBSTACULO	
;		Recibe: 		AL -> COLOR, BL -> COORDENADA X, CL -> COORDENADA Y, SI -> OBSTACULO A IMPRIMIR
;		Devuelve: 	   NADA
;-------------------------------------------------------------------------------------------------
OBSTACULOSP PROC
;;; OBSTACULO
      push ax
      PUSH BX
      PUSH DX
      push di
      
      CMP SI, 2
      JBE CACTUS
      CMP SI, 4
      JBE SENAL
      CMP SI, 6
      JBE CACTUS
      CMP SI, 8
      JBE SENAL
      LEA DX, SPRITE_SHIP
      mov di, 12
      JMP IMPRIME
CACTUS:
      LEA DX, SPRITE_CACTUS
      mov di, 17
      JMP IMPRIME
SENAL:
      LEA DX, SPRITE_SENAL
      mov di, 17
IMPRIME:
      xor ah,ah
      PUSH AX                 ;COLOR
      PUSH DX                 ;(OFFSET DEL SPRITE)
      PUSH BX                 ;COORDENADA X (160)
      PUSH CX                 ;COORDENADA Y (120)

      PUSH 2                  ;BASE EN BYTES, LA NAVE SON 2 BYTES DE LARGO.
      PUSH DI                 ;ALTURA EN PIXELES, (12 DE ALTO).
      CALL DRAW_SPRITE
FIN:
      POP DI
      POP DX
      POP BX
      POP AX
      RET
;;; OBSTACULO
OBSTACULOSP ENDP

;-------------------------------------------------------------------------------------------------
;Función PATINETASP 
;		Realiza: DIBUJA SPRITE PATINETA	
;		Recibe: 		BL -> COORDENADA X, CL -> COORDENADA Y
;		Devuelve: 	   NADA
;-------------------------------------------------------------------------------------------------
PATINETASP PROC
;;; PATINETA
      PUSH DX
      PUSH Di
      
      cmp di, 1
      je movimiento_pat
      lea dx, SPRITE_PATINETA
      jmp imprime_patineta
movimiento_pat:
      lea dx, SPRITE_PAT_MOV
imprime_patineta:
      PUSH AX                 ;COLOR
      PUSH DX                 ;(OFFSET DEL SPRITE)
      PUSH BX                 ;COORDENADA X (30)
      PUSH CX                 ;COORDENADA Y (120)

      PUSH 2                  ;BASE EN BYTES, LA NAVE SON 2 BYTES DE LARGO.
      PUSH 5                  ;ALTURA EN PIXELES, (12 DE ALTO).
      CALL DRAW_SPRITE

      POP DI
      POP DX
      RET
;;; PATINETA
PATINETASP ENDP

;-------------------------------------------------------------------------------------------------
;Función MONEDASP 
;		Realiza: DIBUJA SPRITE MONEDA	
;		Recibe: 		BL -> COORDENADA X, CL -> COORDENADA Y
;		Devuelve: 	   NADA
;-------------------------------------------------------------------------------------------------
MONEDASP PROC
;;; MONEDA
      PUSH AX                  ;COLOR
      PUSH OFFSET SPRITE_MONEDA ;(OFFSET DEL SPRITE)
      PUSH BX                   ;COORDENADA X (30)
      PUSH CX                   ;COORDENADA Y (120)

      PUSH 2                  ;BASE EN BYTES, LA NAVE SON 2 BYTES DE LARGO.
      PUSH 7                  ;ALTURA EN PIXELES, (12 DE ALTO).
      CALL DRAW_SPRITE
      RET
;;; MONEDA
MONEDASP ENDP

end
