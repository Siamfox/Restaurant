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
	replace dep_01 WITH 10
	replace dep_02 WITH 10
	replace dep_03 WITH 10
	replace dep_04 WITH 10

	replace apar_01 WITH 0
	replace apar_02 WITH 0
	replace apar_03 WITH 0
	replace apar_04 WITH 0
	SKIP 1
ENDDO
UNLOCK
WAIT windows ('Remplazo completo..')
*salida() 
RETURN
