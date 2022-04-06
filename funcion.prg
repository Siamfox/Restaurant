***********************************************************************
*** FUNCIONES PREDEFINIDAS
***********************************************************************

*****************************************************************
FUNCTION CATALOGO()  &&  SELECCION DE CATALOGO DE INVENTARIO
*****************************************************************
**parameter xCATALOGO AS Character 

*!*	DO CASE
*!*		CASE xi13=1 && Premium
*!*			xCATALOGO='frmcat_Art1'
*!*		CASE xi13=2 && Clasico
*!*			xCATALOGO='frmcat_Art2'
*!*		CASE xi13=3 && Sencillo
*!*			xCATALOGO='frmcat_Art3'	&& Catalogo sin Busqueda Progresiva
*!*		CASE xi13=4 && Progresivo
*!*			xCATALOGO='frmcat_Art4'	&& Catalogo con Busqueda Progresiva
*!*		CASE xi13=5 && Filtrado
*!*				xCATALOGO='cat_platos' && Catalogo por Filtrado
*!*	*OTHERWISE
*!*	*		xCATALOGO='frmcat_Art'
*!*	ENDCASE

xCATALOGO='cat_platos' && Catalogo por Filtrado

RETURN xCATALOGO


*****************************************************************
FUNCTION SALIDA()  &&  PROGRAMA CERRAR Y LIBERAR FORMULARIOS
*****************************************************************
RELEASE ALL 	&& Liberar Variables y Matrices de Memoria
CLOSE TABLES all
RETURN

*!*	********************************************************************
*!*	FUNCTION SALIR()  &&  SALIR DEL MENU PRINCIPAL Y LIBERAR FORMULARIOS
*!*	********************************************************************
*!*	LOCAL mOpcSalirte as Integer 

*!*	mOpcSalirte=messagebox('<<< Salir del Sistema >>>',4+32+256,'Atencion')

*!*	IF mOpcSalirte=7 .OR. LASTKEY()=27

*!*	   RETURN TO MASTER

*!*	ELSE
*!*		**//Mejorar verificando si no hay procesos corriendo
*!*		**SALIDA()		&& CERRAR LAS TABLAS
*!*		RELEASE ALL 	&& Liberar Variables y Matrices de Memoria
*!*		CLOSE TABLES all
*!*		CLOSE DATABASES ALL
*!*		QUIT
*!*		
*!*	ENDIF

*!*	RETURN


*-------------------------------------------
*--- FIN PROGRAMA 
*-------------------------------------------
PROCEDURE SALIR()
	IF MESSAGEBOX("<<<<<< Salir del Sistema >>>>>>",4+32+256,"Atencion") = 6
		CLOSE TABLES all
		CLOSE DATABASES ALL
		QUIT
	ENDIF 
ENDPROC  


*****************************************************************
FUNCTION LOCK1()  &&  PROGRAMA PARA ABRIR ARCHIVOS EN REDES
*****************************************************************
PARAMETER cFILE,cUSO
RESULT=.F.
DO WHILE .T.
cFILEA=cFILE+'.dbf'
IF !FILE(cfilea)
   **NOPASA();NOPASA()
  	WAIT WINDOWS "Aperturando Tabla..." nowait
	mOpc=messagebox('Archivo '+cFILE+' No existe'+CHR(13)+;
					'1.-Debe crear el Archivo en el Menu de Utilidades'+CHR(13)+;
					'		 Opcion->Generar Tablas-> Nombre del Archivo Requerido'+CHR(13)+;
					'2.-Telefono de Atencion:+58(0412)0195056  +51 918347513 ',5+32,'Atencion')
	IF mOpc=2.OR. LASTKEY()=27
      RETURN .F.
	ELSE
      LOOP
   	ENDIF
ENDIF

DO CASE
   CASE cUSO='E'
        USE &cFILE EXCLUSIVE
        IF !ISFLOCKED() && !NETERR()
           RESULT=.T.
           **RETURN .T.
           EXIT
        ENDIF
   CASE cUSO='C'
        USE &cFILE SHARED 
        IF !ISFLOCKED()
           RESULT=.T.
           **RETURN .T.
           EXIT
        ENDIF
ENDCASE
IF !RESULT
   *NOPASA();NOPASA()
   mOpc=messagebox('Archivo >>> '+cFILE+' en Uso por Otro Terminal '+ID(),5+32,'Atencion')
   IF mOpc=2 .OR. LASTKEY()=27
      RETURN .F.
   ENDIF
ENDIF
ENDDO
RETURN

*****************************************************************
FUNCTION LOCK2()  &&  PROGRAMA PARA ABRIR ARCHIVOS EN REDES
*****************************************************************
PARAMETER cFILE,cUSO
RESULT=.F.
DO WHILE .T.
cFILEA=cFILE+'.dbf'
DO CASE
   CASE cUSO='E'
        USE &cFILE EXCLUSIVE
        IF !ISFLOCKED() && !NETERR()
           RESULT=.T.
           EXIT
        ENDIF
   CASE cUSO='C'
        USE &cFILE SHARED 
        IF !ISFLOCKED()
           RESULT=.T.
           EXIT
        ENDIF
ENDCASE
IF !RESULT
   *NOPASA();NOPASA()
   mOpc=messagebox('Archivo >>> '+cFILE+' en Uso por Otro Terminal '+ID(),5+32,'Atencion')
   IF mOpc=2 .OR. LASTKEY()=27
      RETURN .F.
   ENDIF
ENDIF
ENDDO
RETURN

*****************************************************
FUNCTION VISOR() && VISOR DE PRECIOS
*****************************************************
SELECT 2
IF !LOCK1('INVEN','C')
RETURN
ENDIF
SET INDEX TO INV_COD,INV_DES,INV_LIN,INV_BAR,INV_MAR,INV_REF
RETURN

*********************************************************
FUNCTION CREAR && CREAR TABLAS
*********************************************************
PARAMETERS ORIGEN,AUX

**CLOSE DATABASES all
OPEN DATABASE SIAMDB

CLEAR
DEFINE WINDOW wGrande ;
FROM 10, 15 TO 30, 90 ;
TITLE "Generador de Tablas..."         && Principal window
ACTIVATE WINDOW wGrande

@ 1,2 say '<<< Procesando, Por Favor espere... >>> '

**//VERIFICAR EXISTENCIA TABLA ORIGINAL
IF FILE('&ORIGEN'+'.dbf')
	
	**//Agregar Registros a la Tabla Auxiliar
	*messagebox('<<< Agregando registros al Auxiliar desde el Origen >>> ',0+64,'Atencion')
	@ 3,2 say '<<< Agregando registros al Auxiliar desde el Origen '+ORIGEN+' >>> '
	USE &AUX EXCLUSIVE
	FLOCK()
	APPEND FROM &ORIGEN
	UNLOCK
	USE 

	**//Remover Tabla Original o Renombrar a otra por Backup (Mejorar)
	CLOSE TABLES 
	REMOVE TABLE &origen DELETE
	
	**//Copiar Estructura Nueva a (Origen Nuevo)
	*messagebox('<<< Copiando Estructura Auxiliar al Nueva Tabla >>> ',0+64,'Atencion')
	@ 5,2 say '<<< Paso 1/2 -> Copiando Estructura Auxiliar a Nueva Tabla >>> '
	SET DATABASE TO siamdb
	USE &AUX EXCLUSIVE 
	FLOCK()
	COPY STRUCTURE TO &ORIGEN
	UNLOCK
	USE
	
	**//Agregar Registros desde Auxiliar a Tabla Origen Final
	*messagebox('<<< Agregando registros al Origen desde el Auxiliar >>> ',0+64,'Atencion')
	@ 7,2 say '<<< Paso 2/2 -> Agregando registros al Origen desde el Auxiliar  >>> '
	USE &ORIGEN EXCLUSIVE 
	FLOCK()
	APPEND FROM &AUX
	UNLOCK
	USE
	
	CLOSE TABLES 
	REMOVE TABLE &auX DELETE

	SET DATABASE TO siamdb
	ADD TABLE &ORIGEN 

		
ELSE

	@ 3,2 say '<<< Paso 1/2 -> Copiando Estructura para Tabla Nueva...'+ORIGEN+' >>> '
	USE &AUX EXCLUSIVE 
	FLOCK()
	COPY STRUCTURE TO &ORIGEN
	UNLOCK
	USE
			
	CLOSE tables 
	REMOVE TABLE &AUX DELETE
	SET DATABASE TO siamdb
	@ 5,2 say '<<< Paso 2/2 -> Agregando Tabla Nueva a Base de Datos Maestro... >>> '
	ADD TABLE &ORIGEN 
	
ENDIF
			
@ 9,2 say '<<< Finalizado Sub-Proceso... >>> '

RETURN



******************************************************************************
FUNCTION VERIFICAR()  &&  PROGRAMA PARA VERIFICAR TABLA ACTIVA O NO ACTIVA
******************************************************************************
PARAMETER cFILE
RESULT=.F.
DO WHILE .T.
cFILEA=cFILE+'.dbf'
IF !FILE(cfilea)
  	WAIT WINDOWS "Aperturando Tabla..." nowait
	mOpc=messagebox('Archivo '+cFILE+' No existe'+CHR(13)+;
					'1.-Debe crear el Archivo en el Menu de Utilidades'+CHR(13)+;
					'		 Opcion->Generar Tablas-> Nombre del Archivo Requerido'+CHR(13)+;
					'2.-Telefono de Atencion:(0416)712.55.82',5+32,'Atencion')
	IF mOpc=2.OR. LASTKEY()=27
      RETURN .F.
	ELSE
      LOOP
   	ENDIF
ENDIF

IF USED('&cFile')
    RESULT=.T.
    EXIT
ENDIF

IF !RESULT
   mOpc=messagebox('Archivo >>> '+cFILE+' en Uso por Otro Terminal '+ID(),5+32,'Atencion')
   IF mOpc=2 .OR. LASTKEY()=27
      RETURN .F.
   ENDIF
ENDIF
ENDDO
RETURN


****************************************************************
FUNCTION SETEO && CONFIGURACION INICIAL DE TABLAS  Y SISTEMA
****************************************************************
SET HELP off
SET ECHO OFF
SET TALK OFF
SET SAFETY OFF 
SET COLOR TO
SET CLOCK STATUS
SET CENTURY ON
SET DATE TO DMY
SET EXCLUSIVE OFF 
SET DELETED ON 
SET EXACT ON
SET COMPATIBLE OFF
**SET MULTILOCKS ON
**SET DECIMALS TO 2
RETURN



**************************************************************************
FUNCTION TIPO_PRECIO() && TIPO PRECIO Y DEPOSITO ESCOGIDO POR EL USUARIO
**************************************************************************
PARAMETERS TPRECIO

IF EMPTY(TPRECIO)
	WAIT WINDOWS "Error en Tipo de Precio Seleccionado ..." TIMEOUT 2
	WRETURN=.F.
	RETURN
ENDIF

SELECT 2 &&INVENTARIO
DO CASE
CASE TPRECIO='01'
	STORE PRE1 		TO WPRECIO
	STORE DSCTO1	TO WDSCTO
CASE TPRECIO='02'
	STORE PRE2 		TO WPRECIO
	STORE DSCTO2	TO WDSCTO
CASE TPRECIO='03'
	STORE PRE3	 	TO WPRECIO
	STORE DSCTO3	TO WDSCTO
CASE TPRECIO='04'
	STORE PVPBUL 	TO WPRECIO
	STORE DSCTOBUL	TO WDSCTO
ENDCASE			
IF WPRECIO<=0
	*WAIT WINDOWS "Error Articulo sin Precio ..." TIMEOUT 1
	*messagebox('Error en Precio',0+64,'Atencion')	
	*STORE ""			TO thisform.cCodigo.Value 
	*STORE SPACE(45) 	TO thisform.cDescrip.Value 
	WRETURN=.F.
ELSE
	WRETURN=.T.
ENDIF
RETURN


************************************************************
**//Calcular Totales Segun Caso con Impuesto o sin Impuesto
************************************************************
FUNCTION TOTALES() &&Calcular Totales en Pedidos y Facturas
************************************************************
nImpuesto=0
nTotal=0
SELECT 10
GO top
DO WHILE !EOF()
	store	CANTIDAD	to WCANTIDAD 
	store	PRECIO		to WPRECIO   
	store	DSCTO		to WDSCTO    
	store	ALICUOTA	to WALICUOTA
	
	**//Caso Con Precio_con_Impuesto
	IF xv01=.T. 
	
			nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
			nsub_impuesto=nsub_total-nsub_total/(1+WALICUOTA*.01)

			nImpuesto=nImpuesto+nsub_impuesto
			ntotal=ntotal+nsub_total

	ELSE && Caso Precio_+_Impuesto
	
			nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
			nsub_impuesto=nsub_total*walicuota/100

			nImpuesto=nImpuesto+nsub_impuesto
			ntotal=ntotal+nsub_total+nsub_total*walicuota/100
			
	ENDIF

	SKIP 1

ENDDO

RETURN

***************************************************************
**//Recalcular Totales Segun Caso con Impuesto o sin Impuesto
***************************************************************
FUNCTION TOTALES2() &&Modificar pedidos en Caja
***************************************************************
nImpuesto=0
nTotal=0

SELECT 9 && Registros Pedidos
IF !LOCK1('PEDREG','C')
	RETURN
ENDIF
SET INDEX TO PED_REG	

SEEK WPEDIDO
IF !EOF()
	DO WHILE WPEDIDO=NRO 
		store	CANTIDAD	to WCANTIDAD 
		store	PRECIO		to WPRECIO   
		store	DSCTO		to WDSCTO    
		store	ALICUOTA	to WALICUOTA
		
		**//Caso Con Precio_con_Impuesto
		IF xv01=.T. 
		
				nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
				nsub_impuesto=nsub_total-nsub_total/(1+WALICUOTA*.01)

				nImpuesto=nImpuesto+nsub_impuesto
				ntotal=ntotal+nsub_total

		ELSE && Caso Precio_+_Impuesto
		
				nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
				nsub_impuesto=nsub_total*walicuota/100

				nImpuesto=nImpuesto+nsub_impuesto
				ntotal=ntotal+nsub_total+nsub_total*walicuota/100
				
		ENDIF

		SKIP 1

	ENDDO
ENDIF	
RETURN


******************************************************************
**//Calcular Totales Segun Caso con Impuesto o sin Impuesto
******************************************************************
FUNCTION TOTALES3() &&Calcular Totales en Modificacion Documentos
******************************************************************
nImpuesto=0
nTotal=0
SELECT 9
SET ORDER TO 1
SEEK nNro
IF !EOF()
DO WHILE NRO=nNRO
	store	CANTIDAD	to WCANTIDAD 
	store	PRECIO		to WPRECIO   
	store	DSCTO		to WDSCTO    
	store	ALICUOTA	to WALICUOTA
	
	**//Caso Con Precio_con_Impuesto
	IF xv01=.T. 
	
			nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
			nsub_impuesto=nsub_total-nsub_total/(1+WALICUOTA*.01)

			nImpuesto=nImpuesto+nsub_impuesto
			ntotal=ntotal+nsub_total

	ELSE && Caso Precio_+_Impuesto
	
			
			nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
			nsub_impuesto=nsub_total*walicuota/100

			nImpuesto=nImpuesto+nsub_impuesto
			*ntotal=ntotal+nsub_total+nsub_total*walicuota/100
			ntotal=ntotal+nsub_total	&&+nsub_Impuesto

			
	ENDIF

	SKIP 1

ENDDO

ENDIF
RETURN 

**--anterior
*!*	nImpuesto=0
*!*	nTotal=0
*!*	SELECT 9
*!*	SET ORDER TO 1
*!*	SEEK nNro
*!*	IF !EOF()
*!*	DO WHILE NRO=nNRO
*!*		store	CANTIDAD	to WCANTIDAD 
*!*		store	PRECIO		to WPRECIO   
*!*		store	DSCTO		to WDSCTO    
*!*		store	ALICUOTA	to WALICUOTA
*!*		
*!*		**//Caso Con Precio_con_Impuesto
*!*		IF xv01=.T. 
*!*		
*!*				nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
*!*				nsub_impuesto=nsub_total-nsub_total/(1+WALICUOTA*.01)

*!*				nImpuesto=nImpuesto+nsub_impuesto
*!*				ntotal=ntotal+nsub_total

*!*		ELSE && Caso Precio_+_Impuesto
*!*		
*!*				
*!*				nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
*!*				nsub_impuesto=nsub_total*walicuota/100

*!*				nImpuesto=nImpuesto+nsub_impuesto
*!*				*ntotal=ntotal+nsub_total+nsub_total*walicuota/100
*!*				ntotal=ntotal+nsub_total+nsub_Impuesto

*!*				
*!*		ENDIF

*!*		SKIP 1

*!*	ENDDO
*!*	ENDIF
*!*	RETURN

*************************************************************************
**//Calcular Totales Segun Caso con Impuesto o sin Impuesto para Compras
************************************************************************
FUNCTION TOTALES4() &&Calcular Totales en Compras
************************************************************
nImpuesto=0
nTotal=0
SELECT 10
GO top
DO WHILE !EOF()
	store	CANTIDAD	to WCANTIDAD 
	store	PRECIO		to WPRECIO   
	store	DSCTO		to WDSCTO    
	store	ALICUOTA	to WALICUOTA
	
	**//Caso Con Precio_con_Impuesto
	*IF xv01=.T. 
	*
	*		nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
	*		nsub_impuesto=nsub_total-nsub_total/(1+WALICUOTA*.01)
	*
	*		nImpuesto=nImpuesto+nsub_impuesto
	*		ntotal=ntotal+nsub_total
	*
	*ELSE && Caso Precio_+_Impuesto
	
			nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
			nsub_impuesto=nsub_total*walicuota/100

			nImpuesto=nImpuesto+nsub_impuesto
			*ntotal=ntotal+nsub_total+nsub_total*walicuota/100
			ntotal=ntotal+nsub_total+nsub_Impuesto
			
	*ENDIF

	SKIP 1

ENDDO

RETURN

************************************************************************
**//Calcular Totales Segun Caso con Impuesto o sin Impuesto para Compras
*************************************************************************
FUNCTION TOTALES5() &&Calcular Totales en Modificacion Documentos
******************************************************************
nImpuesto=0
nTotal=0
SELECT 9
SET ORDER TO 1
SEEK nNro
IF !EOF()
DO WHILE NRO=nNRO
	store	CANTIDAD	to WCANTIDAD 
	store	PRECIO		to WPRECIO   
	store	DSCTO		to WDSCTO    
	store	ALICUOTA	to WALICUOTA
	
	**//Caso Con Precio_con_Impuesto
*!*		IF xv01=.T. 
*!*		
*!*				nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
*!*				nsub_impuesto=nsub_total-nsub_total/(1+WALICUOTA*.01)

*!*				nImpuesto=nImpuesto+nsub_impuesto
*!*				ntotal=ntotal+nsub_total

*!*		ELSE && Caso Precio_+_Impuesto
	
			
			nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
			nsub_impuesto=nsub_total*walicuota/100

			nImpuesto=nImpuesto+nsub_impuesto
			ntotal=ntotal+nsub_total+nsub_Impuesto

			
*!*		ENDIF

	SKIP 1

ENDDO
ENDIF
RETURN

************************************************************************
function Analisa_iRetorno() && RETORNOS IMPRESORAS FISCALES BEMATECH
************************************************************************
parameters iRetorno

DECLARE INTEGER   Bematech_FI_RetornoImpresora IN "BemaFi32.dll";
        INTEGER   @ACK,;
        INTEGER   @ST1,;
        INTEGER   @ST2
        
if iRetorno <> 1
	do case
        case iRetorno = 0
             MessageBox( "Error de Comunicación !", "Error" )
        case iRetorno = -2
             MessageBox( "Parámetro Inválido !", "Error" )     
        case iRetorno = -3
             MessageBox( "Alicuota no programada !", "Atención" )     
        case iRetorno = -18
             MessageBox( "No fue posible abrir el archivo INTPOS.001 !" )     
        case iRetorno = -19
             MessageBox( "Parámetro diferentes !", "Atención" )     
        case iRetorno = -20
             MessageBox( "Transación cancelada por el Operador !", "Atención" )     
        case iRetorno = -21
             MessageBox( "La transación no fue aprobada !", "Atención" )     
        case iRetorno = -22
             MessageBox( "No fue posible finalizar la impresión !", "Atención" )     
        case iRetorno = -23
             MessageBox( "No fue posible finalizar la operación !", "Atención" )              
    endcase
else
    iACK = 0
  	iST1 = 0
  	iST2 = 0
  	cMSJError = ""
  	iRetorno = Bematech_FI_RetornoImpresora( @iACK, @iST1, @iST2 )   
    if iACK = 21 
    	= MessageBox("La impresora ha retornado NAK !", 16+0+0, [Atención] )
    else
		if ( iST1 <> 0 ) .OR. ( iST2 <> 0 )
       		&& Analisa ST1

            if ( iST1 >= 128 ) 
                iST1 = iST1 - 128
                cMSJError = cMSJError + "Fin de Papel" + chr(13)
            endif    
            if ( iST1 >= 64 )
               	iST1 = iST1 - 64
               	cMSJError = cMSJError + "Poco Papel" + chr(13)
            endif
            if ( iST1 >= 32 ) 
               	iST1 = iST1 - 32
               	cMSJError = cMSJError + "Error en el Reloj" + chr(13)
            endif
 		    if ( iST1 >= 16 ) 
				iST1 = iST1 - 16
				cMSJError = cMSJError + 'Impresora con error' + chr(13)
			endif
			if ( iST1 >= 8 ) 
				iST1 =  iST1 - 8 
				cMSJError =  cMSJError + "Primer dato del comando no fue ESC" + chr(13) 
			endif
		    if iST1 >= 4 
				iST1 =  iST1 - 4 
				cMSJError =  cMSJError + "Comando inexistente" + chr(13) 
			endif
 		    if iST1 >= 2  
                iST1 =  iST1 - 2 
                cMSJError =  cMSJError + "Cupón fiscal abierto" + chr(13) 
            endif    
            if iST1 >= 1  
                iST1 =  iST1 - 1 
                cMSJError =  cMSJError + "Número de parámetros inválidos" + chr(13) 
            endif

            && Analisa ST2

            if iST2 >= 128  
                iST2 =  iST2 - 128 
                cMSJError =  cMSJError + "Tipo de parámetro de comando inválido" + chr(13) 
            endif    
            if iST2 >= 64  
                iST2 =  iST2 - 64 
                cMSJError =  cMSJError + "Memória fiscal llena" + chr(13) 
            endif    
            if iST2 >= 32  
                iST2 =  iST2 - 32 
                cMSJError =  cMSJError + "Error en la CMOS" + chr(13) 
            endif 
            if iST2 >= 16  
                iST2 =  iST2 - 16 
                cMSJError =  cMSJError + "Alicuota no programada" + chr(13) 
            endif
            if iST2 >= 8  
                iST2 =  iST2 - 8 
                cMSJError =  cMSJError + "Capacidad de Alicuota Programables llena" + chr(13) 
            endif
            if iST2 >= 4  
                iST2 =  iST2 - 4 
                cMSJError =  cMSJError + "Cancelamiento no permitido" + chr(13) 
            endif
            if iST2 >= 2  
                iST2 =  iST2 - 2 
                cMSJError =  cMSJError + "RIF del propietario no Programados" + chr(13) 
            endif
            if iST2 >= 1  
                iST2 =  iST2 - 1 
                cMSJError =  cMSJError + "Comando no ejecutado" + chr(13) 
            endif
           && Exhibe mensaje de error  
            MessageBox (cMSJError, "Atención" )
   
       endif     
   
   return (STR (iRetorno) )
   endif
ENDIF



*!*	*!*	******************************************************************************
*!*	***PROCEDURE errores &&Manejo de Errores
*!*	*!*	******************************************************************************
*!*	PARAMETER merror, mess, mess1, mprog, mlineno
*!*	**//Por Pantalla Errores Severos
*!*	CLEAR
*!*	_Screen. BackColor = RGB(255,255,255)
*!*	=messagebox("Ocurrió un error " + "en Programa " + mprog + chr(13)+;
*!*	CHR(13)+" Por favor, consulte a su programador",0+64,"¡ATENCIÓN!") 

*!*	**//Grabar Error en Archivo Plano ERRORES.LOG
*!*	*SET PRINTER off
*!*	SET printer TO errores.txt additive
*!*	??? 'Fecha y Hora             : ' + DTOC(DATE())+' - '+ time()+CHR(13)+CHR(10)
*!*	??? 'Error número             : ' + LTRIM(STR(merror))+CHR(13)+CHR(10)
*!*	??? 'Mensaje de error         : ' + mess+CHR(13)+CHR(10)
*!*	??? 'Línea de código con error: ' + mess1+CHR(13)+CHR(10)
*!*	??? 'Número de línea del error: ' + LTRIM(STR(mlineno))+CHR(13)+CHR(10)
*!*	??? 'Programa con error       : ' + mprog +CHR(13)+CHR(10)
*!*	??? REPLICATE('-',120)+CHR(13)+CHR(10)

*!*	close database
*!*	quit
*!*	return


*!*	******************************************************************************
*!*	PROCEDURE VALFILE  && VALIDAR EXISTENCIA DE UNA TABLA 
*!*	******************************************************************************
*!*	PARAMETER ARCHI
*!*	IF FILE('&ARCHI'+'.dbf')
*!*		CLOSE TABLES
*!*		REMOVE TABLE AUXILIAR DELETE
*!*		DELETE FILE AUXILIAR.DBF
*!*		OPEN DATABASE SIAMDB
*!*		messagebox('<<< LA ENCONTRE Y BORRE >>> ',0+64,'Atencion')
*!*	ELSE
*!*		messagebox('<<< nO CONSEGUI NADA PA LANTE >>> ',0+64,'Atencion')
*!*		
*!*	ENDIF
*!*	RETURN


*------------------------------------------------------
* FUNCTION _StrTo128B(tcString) * CODIGO 128B
*------------------------------------------------------
* Convierte un string para ser impreso con
* fuente True Type "PF Barcode 128"
* Caracteres numéricos y alfabeticos (mayúsculas y minúsculas)
* Si un caracter es no válido lo remplaza por espacio
* USO: _StrTo128B('Codigo 128 B')
* RETORNA: Caracter
*------------------------------------------------------
FUNCTION _StrTo128B(tcString)
  LOCAL lcStart, lcStop, lcRet, lcCheck, ;
    lnLong, lnI, lnCheckSum, lnAsc
  lcStart = CHR(104 + 32)
  lcStop = CHR(106 + 32)
  lnCheckSum = ASC(lcStart) - 32
  lcRet = tcString
  lnLong = LEN(lcRet)
  FOR lnI = 1 TO lnLong
    lnAsc = ASC(SUBS(lcRet,lnI,1)) - 32
    IF NOT BETWEEN(lnAsc,0,99)
      lcRet = STUFF(lcRet,lnI,1,CHR(32))
      lnAsc = ASC(SUBS(lcRet,lnI,1)) - 32
    ENDIF
    lnCheckSum = lnCheckSum + (lnAsc * lnI)
  ENDFOR
  lcCheck = CHR(MOD(lnCheckSum,103) + 32)
  lcRet = lcStart + lcRet + lcCheck + lcStop
  *--- Esto es para cambiar los espacios y caracteres invalidos
  lcRet = STRTRAN(lcRet,CHR(32),CHR(232))
  lcRet = STRTRAN(lcRet,CHR(127),CHR(192))
  lcRet = STRTRAN(lcRet,CHR(128),CHR(193))
  RETURN lcRet
ENDFUNC


******************************************************************
**//Calcular Totales Segun Caso con Impuesto o sin Impuesto
******************************************************************
FUNCTION TOTALcomanda() &&Calcular Totales en Comandas
******************************************************************
nImpuesto=0
nTotal=0
SELECT 10
GO top
*SET ORDER TO 1
DO WHILE !EOF()
	store	CANTIDAD	to WCANTIDAD 
	store	PRECIO		to WPRECIO   
	store	DSCTO		to WDSCTO    
	store	ALICUOTA	to WALICUOTA
	
	**//Caso Con Precio_con_Impuesto
	IF xv01=.T. 
	
			nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
			nsub_impuesto=nsub_total-nsub_total/(1+WALICUOTA*.01)

			nImpuesto=nImpuesto+nsub_impuesto
			ntotal=ntotal+nsub_total

	ELSE && Caso Precio_+_Impuesto
	
			*MESSAGEBOX('voy por aca')
			
			nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
			*nsub_impuesto=nsub_total*walicuota/100

			**nImpuesto=nImpuesto+nsub_impuesto
			*ntotal=ntotal+nsub_total+nsub_total*walicuota/100
			ntotal=ntotal+nsub_total	&&+nsub_Impuesto

			
	ENDIF

	SKIP 1

ENDDO
RETURN nTotal

ENDFUNC



******************************************************************
**//Calcular Totales Segun Caso con Impuesto o sin Impuesto
******************************************************************
FUNCTION TOTALpedido() &&Calcular Totales en Comandas
******************************************************************
nImpuesto=0
nTotal=0
SELECT 9
SET ORDER TO 1
SEEK nNro
IF !EOF()

DO WHILE NRO=nNRO
	store	CANTIDAD	to WCANTIDAD 
	store	PRECIO		to WPRECIO   
	store	DSCTO		to WDSCTO    
	store	ALICUOTA	to WALICUOTA
	
	**//Caso Con Precio_con_Impuesto
	IF xv01=.T. 
	
			nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
			nsub_impuesto=nsub_total-nsub_total/(1+WALICUOTA*.01)

			nImpuesto=nImpuesto+nsub_impuesto
			ntotal=ntotal+nsub_total

	ELSE && Caso Precio_+_Impuesto
	
			
			nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
			**nsub_impuesto=nsub_total*walicuota/100

			**nImpuesto=nImpuesto+nsub_impuesto
			*ntotal=ntotal+nsub_total+nsub_total*walicuota/100
			ntotal=ntotal+nsub_total	&&+nsub_Impuesto

			
	ENDIF

	SKIP 1

ENDDO
ENDIF

ENDFUNC

**--------------------------------------------------------------
**--Fecha juliana
**--------------------------------------------------------------
FUNCTION cFecha(tdFecha)
  LOCAL aDias(7), aMeses(12)
  aDias[1]="Domingo "
  aDias[2]="Lunes "
  aDias[3]="Martes "
  aDias[4]="Miércoles "
  aDias[5]="Jueves "
  aDias[6]="Viernes "
  aDias[7]="Sábado "
  aMeses[1]="Enero"
  aMeses[2]="Febrero"
  aMeses[3]="Marzo"
  aMeses[4]="Abril"
  aMeses[5]="Mayo"
  aMeses[6]="Junio"
  aMeses[7]="Julio"
  aMeses[8]="Agosto"
  aMeses[9]="Septiembre"
  aMeses[10]="Octubre"
  aMeses[11]="Noviembre"
  aMeses[12]="Diciembre"
  RETURN aDias(DOW(tdFecha,1)) + ;
  	TRANSFORM(DAY(tdFecha),"@L 99") + ;
  	" de " + aMeses(MONTH(tdFecha)) + ;
  	" de " + TRANSFORM(YEAR(tdFecha),"@L 9999")
ENDFUNC 



*-----------------------------------------------------------
* IS_RUN(Nombre_proceso)
* Devuelve verdadero si el proceso se esta ejecutando
*-----------------------------------------------------------
FUNCTION IS_RUN(tcprograma) 
	#DEFINE PROCESS_QUERY_INFORMATION  1024
	#DEFINE PROCESS_VM_READ_SEC 16 
	#DEFINE DWORD 4 

	*-------------------------------------------------- 
	* Declaración de Funciones API 
	*-------------------------------------------------- 
	DECLARE INTEGER GetLastError IN kernel32 
	DECLARE INTEGER CloseHandle IN kernel32 INTEGER Handle 
	DECLARE INTEGER OpenProcess IN kernel32 INTEGER dwDesiredAccessas, INTEGER bInheritHandle,INTEGER dwProcId 
	DECLARE INTEGER EnumProcesses IN psapi STRING @ lpidProcess, INTEGER cb,INTEGER @ cbNeeded 
	DECLARE INTEGER GetModuleBaseName IN psapi INTEGER hProcess, INTEGER hModule,STRING @ lpBaseName, INTEGER nSize 
	DECLARE INTEGER EnumProcessModules IN psapi INTEGER hProcess, STRING @ lphModule,INTEGER cb, INTEGER @ cbNeeded 

	LOCAL lcProcBuf, lnBufSize, lnProcessBufRet, lnProcNo, lnProcId, hProcess, lcModBuf, lnModBufRet, lcBasename, lcst, lcpbase 

	tcprograma = UPPER(tcprograma) 
	IF EMPTY(JUSTEXT(tcprograma)) 
		tcprograma = tcprograma + ".EXE" 
	ENDIF 

	lnBufSize = 4096 
	lcProcBuf = Repli(Chr(0), lnBufSize) 
	lnProcessBufRet = 0 

	IF EnumProcesses (@lcProcBuf, lnBufSize, @lnProcessBufRet) = 0 
		RETURN .F.
	ENDIF 

	lcst = "" 
	lnVeces = 0
	FOR lnProcNo=1 TO lnProcessBufRet/DWORD 
		lnProcId = buf2dword(SUBSTR(lcProcBuf, (lnProcNo-1)*DWORD+1, DWORD)) 
		hProcess = OpenProcess (PROCESS_QUERY_INFORMATION + PROCESS_VM_READ_SEC, 0, lnProcId)

		IF hProcess > 0 
			lnBufSize = 4096 
			lcModBuf = Repli(Chr(0), lnBufSize) 
			lnModBufRet = 0 

			IF EnumProcessModules(hProcess,@lcModBuf,lnBufSize,@lnModBufRet) > 0 
				hModule = buf2dword(SUBSTR(lcModBuf,1, DWORD)) 
				lcBasename = SPACE(250) 
				lnBufSize = GetModuleBaseName (hProcess, hModule, @lcBasename, Len(lcBasename)) 
				lcBasename = UPPER(Left (lcBasename, lnBufSize)) 
				
				IF lcBasename = tcprograma
					lnVeces = lnVeces + 1
				ENDIF 
			ENDIF 
			=CloseHandle(hProcess) 
		ENDIF 
	ENDFOR 

	RETURN (lnVeces <= 1)
ENDFUNC 



**--Acticar o Desactivar ventana activa
*-----------------------------
FUNCTION F_ActivaWin(cCaption)
*-----------------------------
LOCAL nHWD
DECLARE INTEGER FindWindow IN WIN32API ;
STRING cNULL, ;
STRING cWinName

DECLARE SetForegroundWindow IN WIN32API ;
INTEGER nHandle

DECLARE SetActiveWindow IN WIN32API ;
INTEGER nHandle

DECLARE ShowWindow IN WIN32API ;
INTEGER nHandle, ;
INTEGER nState

nHWD = FindWindow(0, cCaption)
IF nHWD > 0
	* VENTANA YA ACTIVA
	* LA "LLAMAMOS":
	ShowWindow(nHWD,9)

	* LA PONEMOS ENCIMA
	SetForegroundWindow(nHWD)

	* LA ACTIVAMOS
	SetActiveWindow(nHWD)
	RETURN .T.
ELSE
	* VENTANA NO ACTIVA
	RETURN .F.
ENDIF
