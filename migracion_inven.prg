*---------------------------------------------------
*--- Enrutar Almacenamiento y Programas 
*---------------------------------------------------
SET DEFAULT TO 'C:\zanzibar\DATA\'

*!*	SELECT 2
*!*	IF !LOCK1('INVEN','C')
*!*		RETURN
*!*	ENDIF

CLOSE ALL 
SELECT 2
USE inven SHARED 
INDEX on codigo TO icodigo

SELECT 1
USE inven_a SHARED  
GO top

DO WHILE !EOF()
	RLOCK()
	
	SELECT 2
	SEEK a->codigo
	IF EOF()
		APPEND BLANK 
		REPLACE codigo 		with	a->codigo
		replace descrip	 	WITH 	a->descrip
		replace descrip2 	WITH 	a->descrip2
		*replace costo_us 	WITH 	a->costo_us
		*replace ubica		WITH	a->ubica
		*replace referencia	with	a->referencia
		*replace marca		with	a->marca
		*replace modelo		with	a->modelo
		*replace talla		with	a->talla
		*replace color		with	a->color
		
		REPLACE pre1		WITH 	a->pre1
		REPLACE pre2		WITH 	a->pre2
		REPLACE pre3		WITH 	a->pre3
		*REPLACE pvpbul		WITH 	a->pvpbul
				
		*REPLACE pre1_us		WITH 	a->pre1_us
		*REPLACE pre2_us		WITH 	a->pre2_us
		*REPLACE pre3_us		WITH 	a->pre3_us
		*REPLACE pre4_us		WITH 	a->pre4_us	
		
		replace porpre3		WITH 	a->porpre3
		
		*replace cambio_us	WITH 	a->cambio_us
		*replace inv_ven		with	a->inven_ven
		replace unidad		with	a->unidad
		replace tipo		with	a->tipo
		replace alicuota	with	a->alicuota
		replace linea		with	a->linea
		

		replace costo		with a->costo
		*replace costo_pro	with a->costo_pro
		*replace costo_ant	with a->costo_ant
		*replace costo_emp	with a->costo_emp
	
		*replace alterno		WITH a->alterno
		*REPLACE ubica 		WITH a->ubica
		replace compuesto	WITH a->compuesto
		*replace inven_ven	WITH a->inven_ven
		replace fch_actua	WITH a->fch_actua
		replace foto		WITH a->foto
		
		replace dep_01		WITH a->dep_01
		replace pre22		WITH a->pre22
		replace pre32		WITH a->pre32
		*replace pvpbul2		WITH a->pvpbul2	
		replace costo2		WITH a->costo2
		*replace costo_emp2	WITH a->costo_emp2
		*replace tipomoneda	WITH a->tipomoneda
		replace habilitado	WITH a->habilitado
		
		
			
		
	ENDIF
	
	SELECT 1
	SKIP 1
ENDDO
UNLOCK
WAIT windows ('Remplazo completo..')
*salida() 
RETURN
