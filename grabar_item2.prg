*************************************************
*FUNCTION GRABAR_ITEM() && GRABAR ITEM COMBOS
*************************************************
*************************
**//GRABAR ITEM AL COMBO
*************************
SELECT 10 &&TEMPORAL REGISTROS 
SET ORDER TO 1 
FLOCK()
APPEND BLANK 
**//GRID1 /REGISTROS
	REPLACE CBO_ID		WITH WCBO_ID
	REPLACE CODIGO		WITH WCODIGO
	REPLACE DESCRIP		WITH WDESCRIP
	REPLACE DESCRIP2	WITH WDESCRIP2
	REPLACE REFERENCIA	WITH WREFERENCIA
	REPLACE MARCA		WITH WMARCA
	REPLACE CANTIDAD	WITH WCANTIDAD 
	REPLACE PRECIO		WITH WPRECIO   
	REPLACE DSCTO		WITH WDSCTO    
	REPLACE UNIDAD		WITH WUNIDAD   
	REPLACE GARANTIA	WITH UPPER(WGARANTIA)
	REPLACE ALICUOTA	WITH WALICUOTA
	REPLACE COSTO		WITH WCOSTO
	REPLACE COSTO_PRO	WITH WCOSTO_PRO
	REPLACE DEPOSITO	WITH WDEPOSITO
	REPLACE TPRECIO		WITH WTPRECIO
	*REPLACE SERIAL		WITH UPPER(THISFORM.cSeriales.Value)
		
UNLOCK

RETURN

