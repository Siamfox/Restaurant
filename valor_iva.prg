**//Buscar Valor del Iva segun articulo seleccionado
SELECT 1 && Impuestos
SET ORDER TO IMP_COD
SEEK walicuota
IF EOF()
	*WAIT WINDOWS "Articulo No Tiene Asignado Valor del Iva ..." TIMEOUT 1
	*messagebox('Articulo No Tiene Asignado Valor del Iva',0+64,'Atencion...')
	WRETURN=.F.
	RETURN
ELSE
	WALICUOTA=a->alicuota
	WRETURN=.T.
ENDIF
RETURN