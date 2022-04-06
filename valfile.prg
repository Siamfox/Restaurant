******************************************************************************
*PROCEDURE VALFILE  && VALIDAR EXISTENCIA DE UNA TABLA 
******************************************************************************
PARAMETER ARCHI
IF FILE('&ARCHI'+'.dbf')
	CLOSE TABLES
	REMOVE TABLE AUXILIAR DELETE
	DELETE FILE AUXILIAR.DBF
	OPEN DATABASE SIAMDB
	*messagebox('<<< LA ENCONTRE Y BORRE >>> ',0+64,'Atencion')
ELSE
	*messagebox('<<< nO CONSEGUI NADA PA LANTE >>> ',0+64,'Atencion')
	
ENDIF
RETURN