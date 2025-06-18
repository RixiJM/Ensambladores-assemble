.8086
.model small
.stack 100h
.data
	JUG EQU 0210h ; JUG es la fila-columna de la posición superior izquierda del primer numero de score
	
	DISTCIFRAS EQU 07h
	DELAYBORRADO EQU 03h

	scorejugador db 00h ; SCOREJUGADOR es el valor de score que se quiere mostrar en pantalla
	
	cursor		  dw 00h, 00h ; CURSOR se utiliza para posicionar el cursor en la impresión del dígito del score
	punteronumero dw 00h, 00h ; PUNTERONUMERO es la variable cuyo valor es el offset del número a mostrar
	punterocursor	dw 00h, 00h ; PUNTEROCRURSOR el para posicionar cada línea de impresión del digito del score

	uno1 db 20h, 20h, 20h, 0DFh, 0DBh, '$' ; Composión del número 1, fila 1 en adelante
	uno2 db 20h, 20h, 20h, 20h, 0DBh, '$'
	uno3 db 20h, 20h, 20h, 20h, 0DBh, '$'
	uno4 db 20h, 20h, 20h, 20h, 0DBh, '$'
	uno5 db 20h, 20h, 20h, 20h, 0DBh, '$'

	dos1 db 0DFh, 0DFh, 0DFh, 0DFh, 0DBh, '$'
	dos2 db 20h, 20h, 20h, 20h, 0DBh, '$'
	dos3 db 0DBh, 0DFh, 0DFh, 0DFh, 0DFh, '$'
	dos4 db 0DBh,20h, 20h, 20h, 20h, '$'
	dos5 db 0DBh, 0DCh, 0DCh, 0DCh, 0DCh, '$'

	tres1 db 0DFh, 0DFh, 0DFh, 0DFh, 0DBh, '$'
	tres2 db 20h, 20h, 20h, 20h, 0DBh, '$'
	tres3 db 20h, 0DFh, 0DFh, 0DFh, 0DBh, '$'
	tres4 db 20h, 20h, 20h, 20h, 0DBh, '$'
	tres5 db 0DCh, 0DCh, 0DCh, 0DCh, 0DBh, '$'

	cuatro1 db 0DBh, 20h, 20h, 20h, 0DBh, '$'
	cuatro2 db 0DBh, 20h, 20h, 20h, 0DBh, '$'
	cuatro3 db 0DFh, 0DFh, 0DFh, 0DFh, 0DBh, '$'
	cuatro4 db 20h, 20h, 20h, 20h, 0DBh, '$'
	cuatro5 db 20h, 20h, 20h, 20h, 0DBh, '$'

	cinco1 db 0DBh, 0DFh, 0DFh, 0DFh, 0DFh, '$'
	cinco2 db 0DBh, 20h, 20h, 20h, 20h, '$'
	cinco3 db 0DFh, 0DFh, 0DFh, 0DFh, 0DBh, '$'
	cinco4 db 20h, 20h, 20h, 20h, 0DBh,'$'
	cinco5 db 0DCh, 0DCh, 0DCh, 0DCh, 0DBh, '$'

	seis1 db 0DBh, 0DFh, 0DFh, 0DFh, 0DFh, '$'
	seis2 db 0DBh, 20h, 20h, 20h, 20h, '$'
	seis3 db 0DBh, 0DFh, 0DFh, 0DFh, 0DBh, '$'
	seis4 db 0DBh, 20h, 20h, 20h, 0DBh,'$'
	seis5 db 0DBh, 0DCh, 0DCh, 0DCh, 0DBh, '$'

	siete1 db 0DFh, 0DFh, 0DFh, 0DFh, 0DBh, '$'
	siete2 db 20h, 20h, 20h, 20h, 0DBh, '$'
	siete3 db 20h, 20h, 20h, 20h, 0DBh, '$'
	siete4 db 20h, 20h, 20h, 20h, 0DBh, '$'
	siete5 db 20h, 20h, 20h, 20h, 0DBh, '$'

	ocho1 db 0DBh, 0DFh, 0DFh, 0DFh, 0DBh, '$'
	ocho2 db 0DBh, 20h, 20h, 20h, 0DBh, '$'
	ocho3 db 0DBh, 0DFh, 0DFh, 0DFh, 0DBh, '$'
	ocho4 db 0DBh, 20h, 20h, 20h, 0DBh,'$'
	ocho5 db 0DBh, 0DCh, 0DCh, 0DCh, 0DBh, '$'

	nueve1 db 0DBh, 0DFh, 0DFh, 0DFh, 0DBh, '$'
	nueve2 db 0DBh, 20h, 20h, 20h, 0DBh, '$'
	nueve3 db 0DFh, 0DFh, 0DFh, 0DFh, 0DBh, '$'
	nueve4 db 20h, 20h, 20h, 20h, 0DBh,'$'
	nueve5 db 20h, 20h, 20h, 20h, 0DBh, '$'

	cero1 db 0DBh, 0DFh, 0DFh, 0DFh, 0DBh, '$'
	cero2 db 0DBh, 20h, 20h, 20h, 0DBh, '$'
	cero3 db 0DBh, 20h, 20h, 20h, 0DBh, '$'
	cero4 db 0DBh, 20h, 20h, 20h, 0DBh,'$'
	cero5 db 0DBh, 0DCh, 0DCh, 0DCh, 0DBh, '$'
	
	borrarlineascore db 20h, 20h, 20h, 20h, 20h, '$'

 .code
 
 public SCORE
 extrn ESPERA:proc

;------------------------------------------------------------------------------------------------------------------------------------------------------------------
; Función SCORE - Muestra el score del jugador en pantalla
;		Recibe: 
; 	    AL = el score del jugador en hexa		
;							
;		Devuelve: 	Nada
;------------------------------------------------------------------------------------------------------------------------------------------------------------------
SCORE proc
	push ax
	push bx
	
	mov scorejugador, al
	
	mov ax, JUG ; Paso parámetro de posición del cartel de score del Jugador 1
	mov bl, scorejugador
	call mostrarscore
	
	pop bx
	pop ax
	ret
SCORE endp

;-------------------------------------------------------------------------------------------------------------------------------------------------
; Función MOSTRARSCORE - 	Muestra el score de un jugador. El marcador es de dos dígitos. Si el score a
;												mostrar es menor a 10 muestra un solo dígito de la forma X, no dos de la forma 0X
;		Recibe: AX = fila-columna superior izquierdo del marcador
; 	 			BL = el score del jugador en hexa
;		Devuelve: Nada
;-------------------------------------------------------------------------------------------------------------------------------------------------
mostrarscore proc
	push ax
	push bx
	push cx

	mov cursor, ax ; Guardo el parámetro del cursor
	
	; Se muestra el dígito más significativo del score
	cmp bl, 0Ah
	jb primer_digito ; El score es menor o igual a 9 es de un solo dígito. No muestro dos dígitos
	cmp bl, 64h
	jb segundo_digito ; Si es menor a 100 (y mayor a 9) dibuja la segunda cifra
tercer_digito:
	xor ax, ax 
	mov al, bl ; Muevo el score a al (con ah en 0) para poder dividir
	mov cl, 64h
	div cl     ; Divido por 100
	mov bl, al ; Paso la centena a bl 
	call muestrodigito 	; Llamo al mostrador de dígitos en pantalla teniendo en cuenta que el cursos está posicionado en el
									; borde superior izquierdo de su presentación
	
	mov bl, ah ; Muevo el resto a bl para continuar con la decena
	add cursor, DISTCIFRAS ; Muevo el cursor
segundo_digito:
	xor ax, ax   ; resetea ax
	mov al, bl   ; mueve el num a ax
	mov cl, 0Ah ; Como es mayor a nueve, lo divido por 10 y tomo el resto
	div cl
	mov bl, al ; El cociente lo paso como parámetro BL ya que es el dígito más significativo

	call muestrodigito 	; Llamo al mostrador de dígitos en pantalla teniendo en cuenta que el cursos está posicionado en el
									; borde superior izquierdo de su presentación
	
	mov bl, ah ; Paso ahora el resto al parámetro BL que es el dígito menos significativo
primer_digito:
	add cursor, DISTCIFRAS 	; Agrego 7 al cursor para que apunte al borde superior izquierdo del dígito menos significativo, 
								; o sea, lo corro 7 columnas a la derecha
	call muestrodigito ; se muestra el otro dígito
	
	pop cx
	pop bx
	pop ax
	ret
mostrarscore endp


;-------------------------------------------------------------------------------------------------------------------------------------------------
; Función MUESTRODIGITO - Muestra un dígito del score en pantalla en función de la variable cursor
;		Recibe: AX = fila-columna superior izquierdo del digito del marcador
; 				BL = el dígito a dibujar
;		Devuelve: Nada
;-------------------------------------------------------------------------------------------------------------------------------------------------
muestrodigito proc
	push ax
	push bx
	push cx
	push dx 

	mov ax, cursor
	mov punterocursor, ax ; Guardo el parámetro del cursor
	
	mov cx, 2607h
	mov ah, 01h
	int 10h ; cursor invisible

	cmp bl, 00h
	je es_cero
	cmp bl, 01h
	je es_uno
	cmp bl, 02h
	je es_dos
	cmp bl, 03h
	je es_tres
	cmp bl, 04h
	je es_cuatro
	cmp bl, 05h
	je es_cinco
	cmp bl, 06h
	je es_seis
	cmp bl, 07h
	je es_siete
	cmp bl, 08h
	je es_ocho
	cmp bl, 09h
	je es_nueve

	; Se carga la variable punteronumero con el offset de los ASCIIs del numero
es_cero:
	mov punteronumero, offset cero1
	jmp seguir
es_uno:
	mov punteronumero, offset uno1
	jmp seguir
es_dos:
	mov punteronumero, offset dos1
	jmp seguir
es_tres:
	mov punteronumero, offset tres1
	jmp seguir
es_cuatro:
	mov punteronumero, offset cuatro1
	jmp seguir
es_cinco:
	mov punteronumero, offset cinco1
	jmp seguir
es_seis:
	mov punteronumero, offset seis1
	jmp seguir
es_siete:
	mov punteronumero, offset siete1
	jmp seguir
es_ocho:
	mov punteronumero, offset ocho1
	jmp seguir
es_nueve:
	mov punteronumero, offset nueve1
seguir:
	mov cx, 05h ; variable del LOOP para las 5 líneas de caracteres por número
	xor bx, bx

imprimolineanumero:
	mov dx, punterocursor ; traigo a DX el lugar del cursor
	mov ah, 02h
	int 10h ; posiciono el cursor

	add dx, 100h ; Al sumas 100h estoy cambiando de fila, una más abajo
	mov punterocursor, dx ; actualizo cursor para la próxima línea
	mov dx, punteronumero ; traigo a DX el puntero del núemero a imprimir
	mov ah, 09H
	int 21H	

	add dx, 06h ; al agregar 6 salto a la segunda línea de caracteres del número. Cada número tiene 5 caracteres ascii más es pesos son 6
	mov punteronumero, dx
	loop imprimolineanumero ; loopeo hasta imprimir las cinco líneas de cada número

	pop dx
	pop cx
	pop bx
	pop ax

	ret
muestrodigito endp

;------------------------------------------------------------------------------------------------------------------------------------------------------------------
; Función BORRARSCORE - Borra las zonas donde se imprimen los scores
;		Recibe: 		Parametros de contadores de score a través de variables JUG1 y JUG2
;		Devuelve: 	Nada
;------------------------------------------------------------------------------------------------------------------------------------------------------------------
BORRARSCORE proc
	mov punterocursor, JUG ; Guardo el parámetro del cursor
	call borrardigito
	mov punterocursor, JUG + DISTCIFRAS ; Guardo el parámetro del cursor
	call borrardigito
	ret
BORRARSCORE endp

;------------------------------------------------------------------------------------------------------------------------------------------------------------------
; Función BORRARDIGITO - Borra un dígito del score
;		Recibe: 		Parametros de contadores de score a través de variable punterocursor
;		Devuelve: 	Nada
;------------------------------------------------------------------------------------------------------------------------------------------------------------------BORRARDIGITO proc
BORRARDIGITO proc
	push ax
	push bx
	push cx
	push dx

	mov cx, 05h ; variable del LOOP para las 5 líneas de caracteres por número
	xor bx, bx
borrolineanumero:
	mov dx, punterocursor ; traigo a DX el lugar del cursor
	mov ah, 02h
	int 10h ; posiciono el cursor

	add dx, 100h ; Al sumas 100h estoy cambiando de fila, una más abajo
	mov punterocursor, dx ; actualizo cursor para la próxima línea
	lea dx, borrarlineascore ; traigo a DX el puntero del núemero a imprimir
	mov ah, 09H
	int 21H	

	loop borrolineanumero ; loopeo hasta imprimir las cinco líneas de cada número

	pop dx
	pop cx
	pop bx
	pop ax

	ret
BORRARDIGITO endp
;------------------------------------------------------------------------------------------------------------------------------------------------------------------
end