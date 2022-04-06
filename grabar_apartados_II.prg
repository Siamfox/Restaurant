*********************************************************************
*FUNCTION GRABAR_APARTADOS() && Remplazar existencias hacia Apartados
*********************************************************************
PARAMETERS VALOR && 1-Sumar 2-Restar

**//Validar Codigo  en Maestro de Inventario
SELECT 2 && INVENTARIO	
SET INDEX TO INV_COD
SEEK WCODIGO
IF EOF()
	messagebox('Articulo no se encontro en Maestro de Inventario'+CHR(13)+'Codigo Articulo -> '+WCODIGO,0+64,'Error')
	WRETURN=.F.
	RETURN
ENDIF

DO CASE 

CASE valor=1 && Sumar los Apartados y Restar las Existencias

IF XI01=.T. && Ctrol Existencias

	DO CASE
		CASE WDEPOSITO='01'
			IF WCantidad>B->Dep_01
				messagebox('Cantidad Mayor a Existencia Almacen <01>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ELSE
				RLOCK()
				REPLACE DEP_01 	WITH DEP_01-WCantidad
				REPLACE APAR_01	WITH APAR_01+WCantidad
				UNLOCK
			ENDIF

		CASE WDEPOSITO='02'
			IF WCantidad>B->Dep_02
				messagebox('Cantidad Mayor a Existencia Almacen <02>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ELSE
				RLOCK()
				REPLACE DEP_02 	WITH DEP_02-WCantidad
				REPLACE APAR_02	WITH APAR_02+WCantidad
				UNLOCK
			ENDIF

		CASE WDEPOSITO='03'
			IF WCantidad>B->Dep_03
				messagebox('Cantidad Mayor a Existencia Almacen <03>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ELSE
				RLOCK()
				REPLACE DEP_03  WITH DEP_03-WCantidad
				REPLACE APAR_03	WITH APAR_03+WCantidad
				UNLOCK
			ENDIF

		CASE WDEPOSITO='04'
			IF WCantidad>B->Dep_04
				messagebox('Cantidad Mayor a Existencia Almacen <04>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ELSE
				RLOCK()
				REPLACE DEP_04  WITH DEP_04-WCantidad
				REPLACE APAR_04	WITH APAR_04+WCantidad
				UNLOCK
			ENDIF
	OTHERWISE
		messagebox('No se pudo Validar Nro.Almacen <  >',0+64,'Atencion')
		WRETURN=.f.
		RETURN 
	ENDCASE 

ENDIF		

CASE valor=2 && Restar los Apartados y Sumar las Existencias

IF XI01=.T. && Ctrol Existencias
	
	DO CASE
		CASE WDEPOSITO='01'
			IF WCantidad>B->APAR_01
				messagebox('Cantidad Mayor a Existencia Apartada Almacen <01>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ELSE
				RLOCK()
				REPLACE DEP_01 		WITH DEP_01+WCantidad
				REPLACE APAR_01		WITH APAR_01-WCantidad
				UNLOCK
			ENDIF

		CASE WDEPOSITO='02'
			IF WCantidad>B->APAR_02
				messagebox('Cantidad Mayor a Existencia Apartada Almacen <02>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ELSE
				RLOCK()
				REPLACE DEP_02 		WITH DEP_02+WCantidad
				REPLACE APAR_02		WITH APAR_02-WCantidad
				UNLOCK
			ENDIF

		CASE WDEPOSITO='03'
			IF WCantidad>B->APAR_03
				messagebox('Cantidad Mayor a Existencia Apartada Almacen  <03>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ELSE
				RLOCK()
				REPLACE DEP_03 		WITH DEP_03+WCantidad
				REPLACE APAR_03		WITH APAR_03-WCantidad
				UNLOCK
			ENDIF

		CASE WDEPOSITO='04'
			IF WCantidad>B->APAR_04
				messagebox('Cantidad Mayor a Existencia Apartada Almacen  <04>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ELSE
				RLOCK()
				REPLACE DEP_04 		WITH DEP_04+WCantidad
				REPLACE APAR_04		WITH APAR_04-WCantidad
				UNLOCK
			ENDIF
	OTHERWISE
		messagebox('No se pudo Validar Nro.Almacen <  >',0+64,'Atencion')
		WRETURN=.f.
		RETURN 
	ENDCASE 
ENDIF

ENDCASE
WRETURN=.T.
RETURN

