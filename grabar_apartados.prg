*********************************************************************
*FUNCTION GRABAR_APARTADOS() && Remplazar existencias hacia Apartados
*********************************************************************
**//PARAMETROS
**//CANT_ANT 	&& Cantidad Anterior
**//VALOR 		&& 1-Sumar 2-Restar

PARAMETERS CANT_ANT,VALOR

**//Calculo Formula
**  nva_cant - cant_ant = res1
**  remplazar apartados con  (apart + res1)
**  remplazar deposito  con  (dep   - res1)

**//Intercambiar el signo en la formula
IF VALOR=1 	&&Sumar
	RES1=WCANTIDAD-CANT_ANT
ELSE		&&Restar
	RES1=CANT_ANT-WCANTIDAD
ENDIF

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
		CASE WDEPOSITO='01'

			IF XI01=.T. && Ctrol Existencias en Negativo (.T. No permitir .F. Permitir)

				IF RES1>B->Dep_01
					messagebox('Cantidad Mayor a Existencia Almacen <01>',0+64,'Atencion')
					WRETURN=.f.
					RETURN 
				ENDIF

			ENDIF			
			
			**//Grabar 	
			RLOCK()
			REPLACE DEP_01 	WITH DEP_01-RES1
			REPLACE APAR_01	WITH APAR_01+RES1
			UNLOCK


		CASE WDEPOSITO='02'

			IF XI01=.T. && Ctrol Existencias en Negativo (.T. No permitir .F. Permitir)

				IF RES1>B->Dep_02
					messagebox('Cantidad Mayor a Existencia Almacen <02>',0+64,'Atencion')
					WRETURN=.f.
					RETURN 
				ENDIF

			ENDIF
			
			**//Grabar
			RLOCK()
			REPLACE DEP_02 	WITH DEP_02-RES1
			REPLACE APAR_02	WITH APAR_02+RES1
			UNLOCK

	
		CASE WDEPOSITO='03'

			IF XI01=.T. && Ctrol Existencias en Negativo (.T. No permitir .F. Permitir)

				IF RES1>B->Dep_03
					messagebox('Cantidad Mayor a Existencia Almacen <03>',0+64,'Atencion')
					WRETURN=.f.
					RETURN 
				ENDIF

			ENDIF
			
			**//Grabar
			RLOCK()
			REPLACE DEP_03  WITH DEP_03-RES1
			REPLACE APAR_03	WITH APAR_03+RES1
			UNLOCK

		CASE WDEPOSITO='04'

			IF XI01=.T. && Ctrol Existencias en Negativo (.T. No permitir .F. Permitir)

				IF RES1>B->Dep_04
					messagebox('Cantidad Mayor a Existencia Almacen <04>',0+64,'Atencion')
					WRETURN=.f.
					RETURN 
				ENDIF

			ENDIF
			
			**//Grabar
			RLOCK()
			REPLACE DEP_04  WITH DEP_04-RES1
			REPLACE APAR_04	WITH APAR_04+RES1
			UNLOCK

		OTHERWISE
			messagebox('No se pudo Validar Nro.Almacen <  >',0+64,'Atencion')
			WRETURN=.f.
			RETURN 
	ENDCASE 

WRETURN=.T.
RETURN

