*---------------------------------------------------
*--- Enrutar Almacenamiento y Programas 
*---------------------------------------------------
SET DEFAULT TO 'C:\SIAMFOX\DATA\'

CLOSE ALL 
SELECT 2
USE inven SHARED 
INDEX on codigo TO icodigo
GO top

DO WHILE !EOF()
	RLOCK()

		
	replace cambio_us	WITH 	.f.
	replace inv_ven		with	.t.
	replace alicuota	with	1
	replace tipomoneda	WITH	1
		

	REPLACE costo2		WITH ROUND(Costo/(1+12*.01),2)
	REPLACE costo_pro2	WITH ROUND(Costo_pro/(1+12*.01),2)
	REPLACE costo_ant2	WITH ROUND(Costo_ant/(1+12*.01),2)
	REPLACE costo_emp2	WITH ROUND(Costo_emp/(1+12*.01),2)

	REPLACE pre12		WITH ROUND(pre1/(1+12*.01),2)
	REPLACE pre22		WITH ROUND(pre2/(1+12*.01),2)
	REPLACE pre32		WITH ROUND(pre3/(1+12*.01),2)
	REPLACE pvpbul2		WITH ROUND(pvpbul/(1+12*.01),2)
	
	unlock
	
	SKIP 1
ENDDO
UNLOCK
WAIT windows ('Remplazo completo..')
*salida() 
RETURN
