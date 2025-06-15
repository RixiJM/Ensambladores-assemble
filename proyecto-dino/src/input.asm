;TEMPLATE PARA ARMAR LIBRERIA DE FUNCIONES
.8086
.model small
.stack 100h

.data
		
.code

public input ;LAS FUNCIONES PUBLICAS (SE VAN A USAR EN EL OTRO PROCESO DEBEN TENER UNA LINEA AQUI)
;public otra
;public etc
;etc

input proc
        ;SE GUARDA EL ENTORNO (PUSH)

        ;LO QUE SEA QUE HAGA LA FUNCION
 
        ;SE DEVUELVE EL ENTORNO (POP)
        ret

input endp

;SE PUEDEN AGREGAR CUANTOS PROCESOS SE QUIERAN

end ;asi terminamos la libreria
