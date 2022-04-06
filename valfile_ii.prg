******************************************************************************
*PROCEDURE VALFILE_ii  && VALIDAR EXISTENCIA DE UNA TABLA 
******************************************************************************
PARAMETER ARCHI
IF !FILE('ARCHI'+'.dbf')
	RETURN=.F.
ENDIF
RETURN=.T.