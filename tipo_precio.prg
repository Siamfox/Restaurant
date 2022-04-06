**************************************************************************
FUNCTION TIPO_PRECIO() && TIPO PRECIO ESCOGIDO POR EL USUARIO
**************************************************************************
PARAMETERS TPRECIO

SELECT 2 &&INVENTARIO
DO CASE
CASE TPRECIO='01'
	STORE PRE1 		TO WPRECIO
	STORE DSCTO1	TO WDSCTO
CASE TPRECIO='02'
	STORE PRE2 		TO WPRECIO
	STORE DSCTO2	TO WDSCTO
CASE TPRECIO='03'
	STORE PRE3	 	TO WPRECIO
	STORE DSCTO3	TO WDSCTO
ENDCASE			
IF WPRECIO<=0
	*WAIT WINDOWS "Error Articulo sin Precio ..." TIMEOUT 1
	*messagebox('Error en Precio',0+64,'Atencion')	
	*STORE ""			TO thisform.cCodigo.Value 
	*STORE SPACE(45) 	TO thisform.cDescrip.Value 
	WRETURN=.F.
ELSE
	WRETURN=.T.
ENDIF
RETURN

