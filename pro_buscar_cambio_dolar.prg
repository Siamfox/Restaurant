**--Buscar el valor dolar segun fecha como parametro
PARAMETERS  xfecha

xcambio=0

**--Validar fecha de parametro
*MESSAGEBOX(xfecha)

IF EMPTY(xfecha) 
	xfecha=DATE()
ENDIF 


SET OPTIMIZE ON 
SELECT fecha,cambio FROM monedaINICIAL WHERE DTOS(fecha)=DTOS(xfecha) ORDER BY FECHA DESC INTO CURSOR temp_monedaini
SET OPTIMIZE OFF


IF !EOF() .or. RECCOUNT()>0
	STORE cambio TO xcambio 
ENDIF 

RETURN xcambio