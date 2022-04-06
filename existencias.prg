**//Control de Existencias
PARAMETERS VALOR
*****************************************************
**//1-Sumar 2-Restar
*****************************************************

DO CASE 
**********************************************
CASE valor=1 && Sumar Apartados
**********************************************
**//Validar Existencia Segun Deposito
**********************************************
**//Deposito debe ser '01' por defecto
WDEPOSITO=PADL(alltrim(STR(xv10,2,0)), 2, '0')
IF XI01=.T. && Ctrol Existencia en Negativo
	
	DO CASE
		CASE WDEPOSITO='01'
			IF WCantidad>B->Dep_01
				messagebox('Cantidad Mayor a Existencia Almacen <01>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ENDIF

		CASE WDEPOSITO='02'
			IF WCantidad>B->Dep_02
				messagebox('Cantidad Mayor a Existencia Almacen <02>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ENDIF

		CASE WDEPOSITO='03'
			IF WCantidad>B->Dep_03
				messagebox('Cantidad Mayor a Existencia Almacen <03>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ENDIF

		CASE WDEPOSITO='04'
			IF WCantidad>B->Dep_04
				messagebox('Cantidad Mayor a Existencia Almacen <04>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ENDIF
		ENDCASE 

ENDIF

**************************************
**//Validar Precio
**************************************
**//Tipo de Precio por defecto '03'
wtprecio=PADL(alltrim(STR(xv09,2,0)),2,'0') 
IF WPRECIO=0
	messagebox('Error en Precio',0+64,'Atencion')	
	STORE ""			TO thisform.cCodigo.Value 
	*STORE SPACE(45) 	TO thisform.cDescrip.Value 
	WRETURN=.f.
	RETURN
ENDIF

*!*	**************************************************
*!*	**//Buscar Valor del Iva del Articulo Seleccionado
*!*	**************************************************
*!*	SELECT 1 && Impuestos
*!*	SET ORDER TO IMP_COD
*!*	SEEK walicuota
*!*	IF EOF()
*!*		messagebox('Articulo No Tiene Valor del Impuesto',0+64,'Atencion...')
*!*		WRETURN=.f.
*!*		RETURN
*!*	ELSE
*!*		WALICUOTA=a->alicuota
*!*	ENDIF

******************************************
**//Remplazar existencias en Apartados
******************************************
IF XI01=.T. && Ctrol Existencia en Negativo
	SELECT 2
	***SEEK alltrim(WRETORNO)
	RLOCK()
	DO CASE
		CASE WDEPOSITO='01' 
			REPLACE DEP_01 WITH DEP_01-WCantidad
		CASE WDEPOSITO='02'
			REPLACE DEP_02 WITH DEP_02-WCantidad
		CASE WDEPOSITO='03' 
			REPLACE DEP_03 WITH DEP_03-WCantidad
		CASE WDEPOSITO='04' 
			REPLACE DEP_04 WITH DEP_04-WCantidad
	ENDCASE
			REPLACE CANT_APAR	WITH CANT_APAR+WCantidad
	UNLOCK
ENDIF		

**********************************************
CASE valor=2 && Restar Existencias Apartados
**********************************************
**//Validar Existencia Apartada Segun Deposito
**********************************************
**//Deposito debe ser '01' por defecto
WDEPOSITO=PADL(alltrim(STR(xv10,2,0)), 2, '0')
IF XI01=.T. && Ctrol Existencia en Negativo
	
	DO CASE
		CASE WDEPOSITO='01'
			IF WCantidad>B->CANT_APAR
				messagebox('Cantidad Mayor a Existencia Apartada Almacen <01>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ENDIF

		CASE WDEPOSITO='02'
			IF WCantidad>B->CANT_APAR
				messagebox('Cantidad Mayor a Existencia Apartada Almacen <02>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ENDIF

		CASE WDEPOSITO='03'
			IF WCantidad>B->CANT_APAR
				messagebox('Cantidad Mayor a Existencia Apartada Almacen  <03>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ENDIF

		CASE WDEPOSITO='04'
			IF WCantidad>B->CANT_APAR
				messagebox('Cantidad Mayor a Existencia Apartada Almacen  <04>',0+64,'Atencion')
				WRETURN=.f.
				RETURN 
			ENDIF
		ENDCASE 

ENDIF

******************************************
**//Remplazar existencias hacia Apartados
******************************************
IF XI01=.T. && Ctrol Existencia en Negativo
	SELECT 2
	***SEEK alltrim(WRETORNO)
	RLOCK()
	DO CASE
		CASE WDEPOSITO='01' 
			REPLACE DEP_01 WITH DEP_01+WCantidad
		CASE WDEPOSITO='02'
			REPLACE DEP_02 WITH DEP_02+WCantidad
		CASE WDEPOSITO='03' 
			REPLACE DEP_03 WITH DEP_03+WCantidad
		CASE WDEPOSITO='04' 
			REPLACE DEP_04 WITH DEP_04+WCantidad
	ENDCASE
			REPLACE CANT_APAR	WITH CANT_APAR-WCantidad
	UNLOCK

ENDIF
ENDCASE

WRETURN=.T.			

RETURN
