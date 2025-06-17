.8086
.MODEL SMALL
.STACK 100h
.DATA
    nombreArchivo DB "records.txt", 00H
    puntajesArc   DB "JP | PUN", 0dh, 0ah
    ;mensaje       DB "XXX 000", 0dh, 0ah ,24h
    handle        DW ?
    filehandler db 00h,00h
    readchar db 20h
    filerror db "Archivo no existe o error de apertura", 0dh, 0ah, '$'
    charactererror db "Error de lectura de caracter", 0dh, 0ah, '$'
    nextpage db "Presione <Enter> para seguir, otra tecla para salir...", "$"
    currentline db 01h
    divisores db 100,10,1
    EXTRN scoreas
.CODE
EXTRN limpiar_pantalla:PROC ; -> LOGIC.ASM

PUBLIC CREA_RECORDS
PUBLIC ESCRIBIR_RECORDS
PUBLIC LEER_RECORDS
PUBLIC reg2ascii
CREA_RECORDS PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH DI
    ; --------------------------------------
    ; Crear archivo (modo escritura)
    ; --------------------------------------
    MOV AH, 3Ch            ; Función DOS: Crear archivo
    MOV CX, 0              ; Atributos del archivo (normal)
    LEA DX, nombreArchivo  ; Nombre del archivo
    INT 21h
    JC ERROR               ; Si falla, ir a ERROR
    MOV handle, AX         ; Guardar handle del archivo

    ; --------------------------------------
    ; Escribir en el archivo
    ; --------------------------------------
    mov di, 5
loop_escritura:
    cmp di, 0
    je fin_escritura
    LEA DX, scoreas        ; Dirección del mensaje
    PUSH DX
    CALL ESCRIBIR_RECORDS
    JC ERROR
    dec di
jmp loop_escritura

fin_escritura:
    ; --------------------------------------
    ; Cerrar archivo
    ; --------------------------------------
    MOV AH, 3Eh
    MOV BX, handle
    INT 21h

    JMP FIN
ERROR:
    ; Manejo de error simple: terminar
    MOV AX, 4C01h
    INT 21h
FIN:
    POP DI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
CREA_RECORDS ENDP

; RECIBE POR STACK [BP+4] EL OFFSET DE LA VARIABLE A ESCRIBIR EN EL ARCHIVO
ESCRIBIR_RECORDS PROC 
    PUSH BP
    MOV BP, SP
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV AH, 40h            ; Función DOS: Escribir archivo
    MOV BX, handle         ; Handle del archivo
    MOV DX, SS:[BP+4]      ; Dirección del mensaje
    MOV CX, 5             ; Cantidad de bytes a escribir (ajustar según el mensaje real)
    INT 21h

    POP DX
    POP CX
    POP BX
    POP AX
    POP BP
    RET 2
ESCRIBIR_RECORDS ENDP

LEER_RECORDS PROC
    PUSH DX
    LEA DX, nombreArchivo
    call leeTxt
    POP DX
    RET
LEER_RECORDS ENDP
 
leeTXT proc 
  push ax
  push bx
  push cx
  push dx
  push si
  push di
  pushf
  xor ax, ax
  xor bx, bx
  xor cx, cx
  xor si, si
  xor di, di

  mov ah,3dH
  mov al,0
  int 21H
  jc openerr
  mov word ptr[filehandler], ax

char:
  mov ah,3FH
  mov bx, word ptr [filehandler]
  mov cx,1
  lea dx,readchar
  int 21H
  jc charerr
  
  cmp ax,0
  je final
  
  mov dl,readchar
  mov ah,02H
  int 21H
  
  cmp dl,0ah
  jne char
  cmp currentline,18h
  je endofpage
  inc currentline
  jmp char
  
endofpage:
  lea dx, nextpage
  mov ah,9
  int 21h
  
  mov ah,1
  int 21h
  cmp al,0dh
  jne final
  mov currentline,01h
  call limpiar_pantalla
  jmp char
 
 openerr:
  lea dx, filerror
  mov ah,9
  int 21h
  jmp final
  
 charerr:
  lea dx, charactererror
  mov ah,9
  int 21h
  jmp final
 
final:

Mov  bx, word ptr [filehandler] ;CIERRA ARCHIVO
  mov ah, 3eh
  int 21h

  popf
  pop di
  pop si
  pop dx
  pop cx
  pop bx
  pop ax
ret

leeTXT endp

reg2ascii proc
    push bp
    mov bp, sp
    push bx
    push cx
    push si
    push ax

    xor ax, ax
    mov al, [bp + 6] 
    mov si, [bp + 4] 
    mov bx, offset divisores 
    mov cx, 3 ; cx = 3  
convertir:
    mov dl,[bx]
    div dl 
    add al,30h
    mov [si], al  
    inc bx 
    inc si 
    mov al,ah
    xor ah,ah 
loop convertir

    pop ax
    pop si
    pop cx
    pop bx
    pop bp
    ret 4 
reg2ascii endp


END