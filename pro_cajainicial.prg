**--Proceso Caja Inicial Cajero

**--Validar si esta en cierre el ultimo registro del usuario-cajero
SET OPTIMIZE ON 

SELECT fecha,hora,cierre,fecha2,hora2,cajero FROM CAJAINICIAL ;
WHERE cajero=ALLTRIM(xu003) .and. cierre=.f. ORDER BY FECHA DESC INTO CURSOR temp_cajaini

SET OPTIMIZE OFF

*browse

*MESSAGEBOX(xs99)

WRETURN=.F.

IF  cierre=.t. .or. EOF()
		
	IF fecha<>DATE()
	
		**--Inicial nueva Caja 
			KLAVE=DTOS(DATE())+ALLTRIM(xu003)
			*MESSAGEBOX(klave)
			LOCATE FOR DTOS(FECHA)+ALLTRIM(CAJERO)=KLAVE

			IF EOF()
				DO FORM frmCaja_inicial
				IF !WRETURN
					WRETURN=.f.
					RETURN
				ELSE 
					**---Retorno Positivo
					WRETURN=.t.
					**--Fecha de Operacion de Caja
					STORE fecha	TO xs99
					RETURN
				ENDIF 

			ELSE 
			
				IF cierre=.f.

					MESSAGEBOX('Cajero con cierre de caja pendiente a la fecha, validar fecha de Operaciones',0+16,'Aviso')
					WRETURN=.f.
					RETURN
				
				ELSE 

					MESSAGEBOX('Cajero con cierre de caja a la fecha, validar fecha de Operaciones ',0+16,'Aviso')
					WRETURN=.f.
					RETURN
			
				ENDIF 
			
			ENDIF 
		
		
	ELSE 
			
		MESSAGEBOX('Cajero con cierre de caja anteriormente...',0+16,'Aviso')
		
	
	ENDIF 
		
ELSE

	**---Retorno Positivo
	WRETURN=.t.

	**--Fecha de Operacion de Caja
	STORE fecha	TO xs99

	*MESSAGEBOX('Caja abierta...')
	*MESSAGEBOX(xs99)
	
	WAIT windows 'Caja Abierta...' TIMEOUT 0.2 

ENDIF 	

RETURN





*!*		*MESSAGEBOX('Usuario, con Cierre de Caja a la fecha ...',0+64,'Atencion...')
*!*		*WRETURN=.f.
*!*		*RETURN	






