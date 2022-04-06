*---------------------------------------------------
*--- Enrutar Almacenamiento y Programas 
*---------------------------------------------------
SET DEFAULT TO 'C:\SIAMFOX\DATA\'

*!*	SELECT 2
*!*	IF !LOCK1('INVEN','C')
*!*		RETURN
*!*	ENDIF

CLOSE ALL 
SELECT 2
USE cliente SHARED 
INDEX on rif TO irif

SELECT 1
USE scli SHARED  
GO top

DO WHILE !EOF()
	RLOCK()
	
	SELECT 2
	SEEK a->RIF
	IF EOF()
		APPEND BLANK 
		REPLACE rif 		with	a->RIF
		replace nombre 		WITH 	a->nombre
		replace dir1	 	WITH 	a->dir
		replace dir2		with	a->direc2
		replace telefonos	WITH 	a->tel1
		replace vendedor	WITH 	a->vendedor
		*replace contribuye	WITH 	a->contri
		replace ciudad		WITH 	a->ciu_cli
		replace estado		WITH 	a->edo_cli
		replace activo		WITH 	.t.
		replace contribuye	WITH	.t.	

	*!*		REPLACE costo2		WITH Costo/(1+12*.01)
	*!*		REPLACE costo_pro2	WITH Costo_pro/(1+12*.01)
	*!*		REPLACE costo_ant2	WITH Costo_ant/(1+12*.01)
	*!*		REPLACE costo_emp2	WITH Costo_emp/(1+12*.01)
	
	ENDIF
	
	SELECT 1
	SKIP 1
ENDDO
UNLOCK
WAIT windows ('Remplazo completo..')
*salida() 
RETURN
