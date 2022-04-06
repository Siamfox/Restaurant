**--Proceso Moneda Inicial 

**--Validar si esta en cierre el ultimo registro del usuario
SET OPTIMIZE ON 

SELECT fecha,hora,cierre,fecha2,hora2,cajero,cambio FROM monedaINICIAL ;
WHERE DTOS(fecha)=DTOS(DATE()) .and. cierre=.f. ORDER BY FECHA DESC INTO CURSOR temp_monedaini

SET OPTIMIZE OFF


WRETURN=.F.


IF  cierre=.t. .or. EOF()
	
	
	IF fecha<>xs99		&&DATE()
	
		**--Inicial nueva Caja 
			KLAVE=DTOS(DATE())  &&+ALLTRIM(xu003)

			*SEEK (KLAVE)

			*MESSAGEBOX(klave)
		
			LOCATE FOR DTOS(FECHA)=KLAVE

			*+ALLTRIM(CAJERO)

			IF EOF()
	
				DO FORM frmmoneda_inicial
			
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

					MESSAGEBOX('Cajero con cierre pendiente a la fecha, validar fecha de Operaciones',0+16,'Aviso')
					WRETURN=.f.
					RETURN
				
				ELSE 

					MESSAGEBOX('Cajero con cierre a la fecha, validar fecha de Operaciones ',0+16,'Aviso')
					WRETURN=.f.
					RETURN
			
				ENDIF 
			
			ENDIF 
		
		
		ELSE 
			
				MESSAGEBOX('Cajero con cierre anteriormente...',0+16,'Aviso')
		
	
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






