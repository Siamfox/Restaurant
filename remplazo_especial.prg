*---------------------------------------------------
*--- Enrutar Almacenamiento y Programas 
*---------------------------------------------------
SET DEFAULT TO 'C:\SIAMFOX\DATA\'

*!*	SELECT 2
*!*	IF !LOCK1('INVEN','C')
*!*		RETURN
*!*	ENDIF

CLOSE ALL 

USE inven SHARED  

DO WHILE !EOF()
	RLOCK()

	REPLACE pre12		WITH Pre1/(1+12*.01)
	REPLACE pre22		WITH Pre2/(1+12*.01)
	REPLACE pre32		WITH Pre3/(1+12*.01)
	REPLACE pvpbul2		WITH Pvpbul/(1+12*.01)

	REPLACE costo2		WITH Costo/(1+12*.01)
	REPLACE costo_pro2	WITH Costo_pro/(1+12*.01)
	REPLACE costo_ant2	WITH Costo_ant/(1+12*.01)
	REPLACE costo_emp2	WITH Costo_emp/(1+12*.01)

	SKIP 1
ENDDO
UNLOCK
WAIT windows ('Remplazo completo..')
*salida() 
RETURN
