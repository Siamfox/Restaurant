**//Buscar Valor del Iva segun articulo seleccionado
SELECT 20 && Monedas
SET ORDER TO MON_COD
SEEK wmoneda_ex
IF EOF()
	*WAIT WINDOWS "Articulo No Tiene Asignado Valor del Iva ..." TIMEOUT 1
	*messagebox('Articulo No Tiene Asignado Valor del Iva',0+64,'Atencion...')
	WRETURN=.F.
	RETURN
ELSE
	WMONEDA_EX=VALOR
	WRETURN=.T.
ENDIF
RETURN