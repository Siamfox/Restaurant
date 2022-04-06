**************************************************************************
*FUNCTION GRABAR_TRANFERENCIAS) && Remplazar existencias por tranferencias
**************************************************************************
*PARAMETERS VALOR && 1-Sumar 2-Restar

**//Validar Codigo  en Maestro de Inventario
SELECT 2 && INVENTARIO	
SET INDEX TO INV_COD
SEEK WCODIGO
IF EOF()
	messagebox('Articulo no se encontro en Maestro de Inventario'+CHR(13)+'Codigo Articulo -> '+WCODIGO,0+64,'Error')
	WRETURN=.F.
	RETURN
ENDIF


*IF XI01=.T. && Ctrol Existencias

	DO CASE
		CASE WDEPOSITO='01'
			IF WCantidad>B->Dep_01
				messagebox('Cantidad Mayor a Existencia Almacen <01>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ELSE
				RLOCK()
				REPLACE DEP_01 	WITH DEP_01-WCantidad
				DO CASE 
					CASE WDEPOSITO2='02'
						REPLACE DEP_02	WITH DEP_02+WCantidad
					CASE WDEPOSITO2='03'
						REPLACE DEP_03	WITH DEP_03+WCantidad
					CASE WDEPOSITO2='04'
						REPLACE DEP_04	WITH DEP_04+WCantidad
					CASE WDEPOSITO2='05'
						REPLACE DEP_05	WITH DEP_05+WCantidad
						
				ENDCASE
				unlock
			ENDIF

		CASE WDEPOSITO='02'
			IF WCantidad>B->Dep_02
				messagebox('Cantidad Mayor a Existencia Almacen <02>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ELSE
				RLOCK()
				REPLACE DEP_02 	WITH DEP_02-WCantidad
				DO CASE 
					CASE WDEPOSITO2='01'
						REPLACE DEP_01	WITH DEP_01+WCantidad
					CASE WDEPOSITO2='03'
						REPLACE DEP_03	WITH DEP_03+WCantidad
					CASE WDEPOSITO2='04'
						REPLACE DEP_04	WITH DEP_04+WCantidad
					CASE WDEPOSITO2='05'
						REPLACE DEP_05	WITH DEP_05+WCantidad
						
				ENDCASE
				unlock
			ENDIF

		CASE WDEPOSITO='03'
			IF WCantidad>B->Dep_03
				messagebox('Cantidad Mayor a Existencia Almacen <03>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ELSE
				RLOCK()
				REPLACE DEP_03  WITH DEP_03-WCantidad
				DO CASE 
					CASE WDEPOSITO2='01'
						REPLACE DEP_01	WITH DEP_01+WCantidad
					CASE WDEPOSITO2='02'
						REPLACE DEP_02	WITH DEP_02+WCantidad
					CASE WDEPOSITO2='04'
						REPLACE DEP_04	WITH DEP_04+WCantidad
					CASE WDEPOSITO2='05'
						REPLACE DEP_05	WITH DEP_05+WCantidad
						
				ENDCASE
				unlock
			ENDIF

		CASE WDEPOSITO='04'
			IF WCantidad>B->Dep_04
				messagebox('Cantidad Mayor a Existencia Almacen <04>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ELSE
				RLOCK()
				REPLACE DEP_04  WITH DEP_04-WCantidad
				DO CASE 
					CASE WDEPOSITO2='01'
						REPLACE DEP_01	WITH DEP_01+WCantidad
					CASE WDEPOSITO2='02'
						REPLACE DEP_02	WITH DEP_02+WCantidad
					CASE WDEPOSITO2='03'
						REPLACE DEP_03	WITH DEP_03+WCantidad
					CASE WDEPOSITO2='05'
						REPLACE DEP_05	WITH DEP_05+WCantidad
				ENDCASE
				unlock
			ENDIF
			
		CASE WDEPOSITO='05'
			IF WCantidad>B->Dep_05
				messagebox('Cantidad Mayor a Existencia Almacen <05>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ELSE
				RLOCK()
				REPLACE DEP_05  WITH DEP_05-WCantidad
				DO CASE 
					CASE WDEPOSITO2='01'
						REPLACE DEP_01	WITH DEP_01+WCantidad
					CASE WDEPOSITO2='02'
						REPLACE DEP_02	WITH DEP_02+WCantidad
					CASE WDEPOSITO2='03'
						REPLACE DEP_03	WITH DEP_03+WCantidad
					CASE WDEPOSITO2='04'
						REPLACE DEP_04	WITH DEP_04+WCantidad
				ENDCASE
				unlock
			ENDIF

			
			
			
	OTHERWISE
		messagebox('No se pudo Validar Nro.Almacen <  >',0+64,'Atencion')
		WRETURN=.f.
		RETURN 
	ENDCASE 

*ENDIF		

