*************************************************************************************************
**--FUNCTION ACLAS1_NC &&  IMPRIME NOTAS DE CREDITO FISCAL DETAL/MAYOR 
*************************************************************************************************
PUBLIC lStatus, lError


**------------------------------------
**//Funciones del Cupon Fiscal   
**------------------------------------
DECLARE INTEGER  OpenFpctrl      IN TFHKAIF.DLL  String lpPortName
DECLARE INTEGER  CloseFpctrl     IN TFHKAIF.DLL  
DECLARE INTEGER  CheckFprinter   IN TFHKAIF.DLL  
DECLARE INTEGER  ReadFpStatus    IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError
DECLARE INTEGER  SendCmd         IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @cmd
DECLARE INTEGER  SendNCmd        IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @bufferCmd
DECLARE INTEGER  SendFileCmd     IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @fileCmd
DECLARE INTEGER  UploadReportCmd IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @cmd,string @fileCmd
DECLARE INTEGER  UploadStatusCmd IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @cmd,string @fileCmd


**------------------------------------
**// DECLARACION VARIABLES 
**------------------------------------
STORE 0  TO WTOT, WSTOT, WIVA, L,WDTO,NPAGO
STORE 0  TO PPRECIO,CCANTIDAD,CALICUOTA,CCANT_DEC
STORE 0  TO CCANTIDAD,CCANT_PZA
STORE 0  TO nDIAS
STORE 0  TO nDto
STORE 0	 TO wTotal

STORE '' TO CDIR,CDIR1,CDIR2,CRIF,CNIT,CNOMBRE
STORE '' TO CCODIGO,CDESCRIP
STORE '' TO CUNIFRA,CDESCUENTO,CUNIDAD,CSERIAL
STORE '' TO CCIUDAD,CESTADO,CTELEFONOS
STORE '' TO CDES_ITE,CDES_GEN
STORE '' TO RUTA,RUTAI,RUTAF,letras
STORE '' TO CPAGO,CCPAGO,CCPAGO1,CCPAGO2,CCPAGO3
STORE '' TO CVPAGO1,CVPAGO2,CVPAGO3
STORE '' TO CNCHEQUE,CNTARJETA,CBANCO
STORE '' TO	cVEND
STORE '' TO cORDEN
STORE '' TO texto
STORE '' TO cSerialfis
STORE DATE()	TO dFecha


**-------------------------------------------------------
**--Buscar Valor del Dolar del dia
**-------------------------------------------------------
xcambio=0
pro_buscar_cambio_dolar(DATE())
IF xcambio<=0
	messagebox('Error'+CHR(13)+'Error en Monto de Conversion Monetaria ...',0+64,'Atencion...')
	return
ENDIF 




*!*	**
*!*	**-- Creacion del Temporal
*!*	temp_fis='tmp_fis'+alltrim(xu003)+alltrim(xsta)
*!*	temp_caj='tmp_caj'+alltrim(xu003)+alltrim(xsta)

*!*	**-----------------------------------------------
*!*	**//Apertura de Tablas necesarias segun estacion
*!*	**-----------------------------------------------

*!*	SET OPTIMIZE ON

*!*		DO CASE 

*!*		CASE MAYDET=.F. 	&& Detal

*!*			SELECT x.nro, x.dto, x.vend, x.dias, x.orden, x.cliente, x.juridico, x.nit, x.serie, x.serialfis, x.via, x.pago,;
*!*				   y.codigo, y.descrip, y.cantidad, y.precio, y.dscto, y.alicuota, talicuota, y.serial ;
*!*			where  x.nro=y.nro .and. WNRO=x.nro ;
*!*			FROM force det x, detreg y 	INTO TABLE &temp_fis  
*!*			
*!*			browse 
*!*			
*!*			
*!*			**-- VERIFICAR REGISTROS DE FACTURAS
*!*			IF RECCOUNT()<=0
*!*				WAIT WINDOW 'Error Nro. Factura sin Registros... '+STR(wNro) 
*!*				RETURN
*!*			ENDIF
*!*				
*!*				
*!*			USE 
*!*			


*!*		CASE MAYDET=.T.		&& Mayor

*!*			SELECT x.nro, x.dto, x.vend, x.dias, x.orden, x.cliente, x.juridico, x.nit, x.serie, x.serialfis, x.via, x.pago,;
*!*				   y.codigo, y.descrip, y.cantidad, y.precio, y.dscto, y.alicuota,talicuota, y.serial ;
*!*			where  x.nro=y.nro .and. WNRO=x.nro ;
*!*			FROM force fac x, facreg y  INTO table &temp_fis  

*!*			BROWSE
*!*					
*!*			**-- VERIFICAR REGISTROS DE FACTURAS
*!*			IF RECCOUNT()<=0
*!*				WAIT WINDOW 'Error Nro. Factura sin Registros... '+STR(wNro) 
*!*				RETURN
*!*			ENDIF

*!*			use	
*!*					
*!*		ENDCASE

*!*	SET OPTIMIZE OFF 

*!*	return

**-------------------------------------------------------
**// Creacion del Temporal
**TEMP2='TCAJ'+SUBSTR(ALLTRIM(ID()),1, (AT('#',ID())-2) )
TEMP2='TFIS80'
**-------------------------------------------------------

temp_caj='tmp_caj'+alltrim(xu003)+alltrim(xsta)

IF LEN(temp2)>12 
	messagebox('Nombre-Estacion, demasiado largo...'+CHR(13)+'Debe Cambiar o participar al Administrador de la Red',0+64,'Atencion...')
	RETURN
ENDIF

**//Nro Factura a Imprimir
WNRO=WFACTURA

**// GENERAR TEMPORAL
TEMFISCO()

SELECT 20
USE &TEMP2 &&SHARED

**-----------------------------------------------------------------
**// INICIO DEL PROCESO (VERIFICACION DATOS FACTURAS Y REGISTROS)
**// VERIFICAR FACTURA Y DATOS DEL ENCABEZADO
**-----------------------------------------------------------------

**-----------------------------------------------
**//Apertura de Tablas necesarias segun estacion
**-----------------------------------------------
DO CASE 

CASE MAYDET=.F. 	&& Detal
	maestro='DET'
	registros='DETREG'
	IND_I='DET_NRO'
	IND_II='DETREG_NRO'
		

CASE MAYDET=.T.		&& Mayor
	maestro='FAC'
	registros='FACREG'
	IND_I='FAC_NRO'
	IND_II='FACREG_NRO'

ENDCASE


SELECT 8 && FACTURAS MAESTRO
USE &MAESTRO SHARED 
SET INDEX TO &IND_I

SELECT 9 &&REGISTROS FACTURAS
USE &REGISTROS SHARED 
SET INDEX TO &IND_II

**--------------------------------------
**// VERIFICAR MAESTRO DE FACTURA 
**--------------------------------------
SELECT 8
SEEK WNRO
IF EOF()
   	WAIT WINDOWS "!!! ERROR !!! MAESTRO FACTURA->FACTURA LISTAR INCORRECTA '+STR(WNRO))..." nowait
   RETURN
ENDIF


**--------------------------------------
**// VERIFICAR REGISTROS DE FACTURAS
**--------------------------------------
SELECT 9 &&REGISTROS FACTURAS
SEEK WNRO
IF EOF()
   WAIT WINDOWS'ннн ERROR !!!(REGISTROS)-> FACTURA A LISTAR INCORRECTA...' nowait
   RETURN
ENDIF
  
**----------------------------------------------------------------------------
**// INICIAR PROCESO REPORTE FISCAL(ENCABEZADO,REGISTROS,ARCHIVO PLANO FISCAL)
**----------------------------------------------------------------------------
DAT_CLI()      && DATOS DEL CLIENTE
DETA_FAC()     && DETALLE DE LA FACTURA
PRO_FIS()      && PROCESO FISCAL

RETURN

**------------------------------------
FUNCTION DAT_CLI  && ENCABEZADO  *
**--BUSACAR MAESTRO
**--PASE DATOS A VARIABLES DE TRABAJO
**------------------------------------
SELECT 8 && MAESTRO FACTURAS
SET ORDER TO 1

SEEK WNRO

IF EOF()

	WAIT WINDOWS 'ннн ERROR !!! Nro. FACTURA NO EXISTE... ' &&nowait
    RETURN

ELSE

	STORE WNRO		TO WNRO_FAC 		&&NRO FACTURA
	STORE CLIENTE	TO cCliente			&&RIF CLIENTE
	STORE DTO		TO nDTO				&&DESCUENTO GENERAL GLOBAL
	STORE VEND		TO cVend			&&VENDEDOR
	STORE DIAS		TO nDias			&&DIAS
	STORE ORDEN		TO cORDEN			&&NRO.ORDEN	
	STORE fecha		TO dFecha			&&Fecha Factura
	STORE serialfis	TO cSerialfis	 	&& Nro serial Impresora FIscal

ENDIF

**--Validar Codigo Serial Printer Fiscal
IF EMPTY(cSerialfis)	 	&& Nro serial Impresora FIscal
	MESSAGEBOX('ннн ERROR !!! Nro. Serial Printer Fiscal, esta vacio... ',0+16,'Error')
    RETURN
ENDIF 

**-------------------------------------------------------
**--Proceso de Validar los Campos Obligatorios
**-------------------------------------------------------
**// NOMBRE CLIENTE
SELECT 3  && CLIENTES
USE CLIENTE SHARED 
SET INDEX TO CLI_RIF

SEEK UPPER(ALLTRIM(cCLIENTE))
	
IF !EOF()
	cRIF=ALLTRIM(JURIDICO)+UPPER(ALLTRIM(cCLIENTE))	
	cNOMBRE=ALLTRIM(NOMBRE)  &&40
ELSE
	WAIT WINDOWS 'ннн ERROR !!! CLIENTE SIN REGISTRO FISCAL(RIF) o SIN RAZON SOCIAL(NOMBRE)' &&nowait
    RETURN
ENDIF
              
**// DIRECCION, CIUDAD, ESTADO Y TELEFONO
IF DIR1<>SPACE(40)  &&MAXIMO 133
	cDIR1=ALLTRIM(DIR1)
    cDIR2=ALLTRIM(DIR2)
    cCIUDAD=ALLTRIM(CIUDAD)
    cESTADO=ALLTRIM(ESTADO)
    cTELEFONOS=ALLTRIM(TELEFONOS)
ELSE
    WAIT WINDOWS 'ннн ERROR !!! CLIENTE SIN DIRECCION FISCAL (DIRECCION) ' &&nowait
    RETURN
ENDIF

**--Pase de Variables 
STORE cVEND			TO WNRO_VEN
STORE cNOMBRE		TO WNOM_CLI
STORE cDIR1			TO WDIR_CLI1
STORE cDIR2			TO WDIR_CLI2
STORE cCIUDAD		TO WCIU_CLI
STORE cESTADO		TO WEST_CLI
STORE cRIF			TO WRIF_CLI
STORE cTELEFONOS	TO WTEL_CLI
STORE nDIAS			TO WPLA_FAC
STORE cORDEN		TO WORD_COM
STORE nPAGO			TO WCON_CRD		
STORE nDTO			TO WDTO

RETURN

**---------------------------------------------------------------
FUNCTION DETA_FAC     && IMPRESION DETALLADA DE ITEM  
**---------------------------------------------------------------
DO WHILE .T.
   STORE '' TO CDES_ITE,CDES_GEN,CSERIAL

   SELECT 9 && **// (REGISTRO FACTURAS)
	**// CAPTURA DE DATOS REGISTRO PARA DATOS VARIABLES FISCALES

	**// CODIGO
	   CCODIGO=SUBSTR(ALLTRIM(CODIGO),1,4) &&13

	**// DESCRIPCION
		IF xi15=.t.  && Control Manejo de Cantidad de Piezas
		   CDESCRIP=ALLTRIM(STR(CANT_PZA))+'Pz'+' '+SUBSTR(ALLTRIM(DESCRIP),1,38)
		ELSE
		   CDESCRIP=SUBSTR(ALLTRIM(DESCRIP),1,38)
		ENDIF
		
	**// ALICUOTA 
	   calicuota=alicuota
	   IF ALICUOTA=0 && PRODUCTOS EXENTOS
	      CDESCRIP=CDESCRIP
	   ENDIF

	**--Tipo_ALICUOTA  
		**cTipoAlicuota=talicuota	

	**// CANTIDAD Y UNIDAD DE VENTA FRACIONADA O ENTERA (DECIMALES PARA LA CANTIDAD)
	   *VALOR=CANTIDAD
	   ccantidad=cantidad

	**// PRECIO (NOTA SE PASA EL PRECIO Y EL PRINTER CALCULA EL IMPUESTO)
	   IF xV01=.T. && PRECIO CON IMPUESTO INCLUIDO

	      **PPRECIO=PRECIO/(1+ALICUOTA*.01)
	      PPRECIO=PRECIO*XCAMBIO/(1+ALICUOTA*.01)
	      

	      **// DESCUENTO POR ITEM
	         CDES_ITE=PRECIO*CANTIDAD*DSCTO*.01
	         CDES_GEN=(PRECIO-CDES_ITE)*CANTIDAD*WDTO*.01
	         CDESCUENTO=ALLTRIM(STR(CDES_ITE+CDES_GEN))

	   ELSE           // PRECIO MAS IMPUESTO

	      PPRECIO=PRECIO

	      **// DESCUENTO POR ITEM
	         CDES_ITE=PRECIO*CANTIDAD*DSCTO*.01
	         CDES_GEN=(PRECIO-CDES_ITE)*CANTIDAD*WDTO*.01
	         CDESCUENTO=ALLTRIM(STR(CDES_ITE+CDES_GEN,6,2))

	   ENDIF


	   DET_FISCO()  && CREAR DETALLE FISCAL

       SELECT 9 && REGISTROS FACTURAS
	   SKIP

	   IF WNRO<>NRO .OR. EOF()
	      RETURN
	   ENDIF EOF

ENDDO
RETURN


**---------------------------------------------------------------
FUNCTION TEMFISCO  && CREAR TEMPORAL IMPRESION FISCAL
**---------------------------------------------------------------
WAIT WINDOWS "Creando Temporales..." nowait

IF FILE('&temp2'+'.dbf')
	DELETE FILE &temp2
ENDIF


**---------------------------------------------------------------
**// CREACION ESTRUCTURA NUEVA CON LOS DATOS FISCALES
**---------------------------------------------------------------
CREATE TABLE &temp2 ;
	(FCODIGO    C(4,0),;   && CAMPO  1 CODIGO ART.
   	 FDESCRIP   C(13,0),;  && CAMPO  2 DESCRIPCION ART.
 	 FALICUOTA  N(5,2),;   && CAMPO  3 ALICUOTA ART.
 	 FTALICUOTA	N(1),;	   && TIPO ALICUOTA (TASA)
	 FUNIFRA    C(1,0),;   && CAMPO  4 TIPO CANTIDAD (I)ENTERO (F)RACCION
	 FCANTIDAD  N(14,3),;   && CAMPO  5 CANTIDAD ART(S)
	 FCANT_DEC  C(1,0),;   && CAMPO  6 CANTIDAD DECIMALES PRECIO UNITARIO ART
	 FPRECIO	N(14,2),;  && CAMPO  7 PRECIO VALOR UNITARIO
	 FTIPO_DES  C(1,0),;   && CAMPO  8 TIPO DESCUENTO VALOR O PORCENTAJE
	 FDESCUENTO C(8,0),;   && CAMPO  9 VALOR DEL DESCUENTO
	 FUNIDAD    C(2,0),;   && CAMPO 10 UNIDAD DE MEDIDA ART.
	 FSERIAL    C(40,0))   && CAMPO 11 SERIAL ART.
	 	 
	 CLOSE DATABASES all
	 WAIT WINDOWS "Temporal Finalizado..." nowait
	
RETURN

**---------------------------------------------------------------
FUNCTION DET_FISCO && CREAR DETALLE DEL REPORTE FISCAL
**---------------------------------------------------------------
SET DECIMALS TO 3

SELECT 20
FLOCK()
APPEND BLANK

REPLACE FCODIGO    WITH  CCODIGO    && CAMPO  1 CODIGO ART.
REPLACE FDESCRIP   WITH  CDESCRIP   && CAMPO  2 DESCRIPCION ART.
REPLACE FALICUOTA  WITH  CALICUOTA  && CAMPO  3 ALICUOTA ART.
**REPLACE FTALICUOTA WITH  CTipoALICUOTA && TIPO ALICUOTA (TASA)
*REPLACE FUNIFRA   WITH  CUNIFRA    && CAMPO  4 T/CANTIDAD (I)ENTERO (F)RACCION
REPLACE FCANTIDAD  WITH  CCANTIDAD  && CAMPO  5 CANTIDAD ART(S)
*REPLACE FCANT_DEC WITH  CCANT_DEC  && CAMPO  6 CANTIDAD DECIMALES PRECIO UNITARIO ART
REPLACE FPRECIO    WITH  PPRECIO    && CAMPO  7 PRECIO VALOR UNITARIO
*REPLACE FTIPO_DES WITH  '$'        && CAMPO  8 TIPO DESCUENTO ($)VALOR O (%)PORCENTAJE
REPLACE FDESCUENTO WITH  CDESCUENTO && CAMPO  9 VALOR DEL DESCUENTO
*REPLACE FUNIDAD   WITH  CUNIDAD    && CAMPO 10 UNIDAD DE MEDIDA
*REPLACE FSERIAL   WITH  CSERIAL    && CAMPO 11 SERIAL DEL ARTICULO

UNLOCK
RETURN

**---------------------------------------------------------------
FUNCTION PRO_FIS    && PROCESO IMPRESION FISCAL HACIA AL MONITOR
**---------------------------------------------------------------
**--Pase de Variables 
STORE wnro			TO wnro_fac
STORE cVEND			TO WNRO_VEN
STORE cNOMBRE		TO WNOM_CLI
STORE cDIR1			TO WDIR_CLI1
STORE cDIR2			TO WDIR_CLI2
STORE cCIUDAD		TO WCIU_CLI
STORE cESTADO		TO WEST_CLI
STORE cRIF			TO WRIF_CLI
STORE cTELEFONOS	TO WTEL_CLI
STORE nDIAS			TO WPLA_FAC
STORE cORDEN		TO WORD_COM
STORE nPAGO			TO WCON_CRD		
STORE nDTO			TO WDTO

*------------------------------------------------
**//Directorio almacen archivos Planos
*------------------------------------------------
IF DIRECTORY('c:\nc_fis')=.f.
   MKDIR c:\nc_fis
ENDIF

wnro_arch=0
FOR wnro_arch=0 TO 10000
    wnro=ALLTRIM(TRANSFORM(wnro_arch,'999999'))
    warchivo='c:\nc_fis\input'+wnro+'.dat'
    IF FILE(warchivo)=.f.
       gntestfile=Fcreate(warchivo) 
       EXIT  
    ENDIF
ENDFOR 
*------------------------------------------------


*------------------------------------------------
**//Detalle Impresion Fiscal
*------------------------------------------------
SELECT 20 &&  det_temp
GO top

**BROWSE

*!*	word_com=word_com
*!*	wpla_fac=wpla_fac
l=0

**--Encabezado
**--Rif. Cliente
texto=texto+'i'+'R*'+ALLTRIM(WRIF_CLI)+Chr(13)+ Chr(10)        

**--Nombre Cliente 
texto=texto+'i'+'S*'+SUBSTR(wNOM_CLI,1,40)+ Chr(13) + Chr(10)

**--Referencia Nro Factura
fac_f=TRANSFORM(wnro_fac,'99999999999')
le=LEN(ALLTRIM(fac_f))
fac_f=SUBSTR('00000000000',1,11-le)+ALLTRIM(fac_f)
texto=texto+'i'+'F*'+ALLTRIM(STR(wnro_fac))+Chr(13) + Chr(10)

**--Fecha Factura Relacionada
texto=texto+'i'+'D*'+DTOC(dfecha)+Chr(13) + Chr(10)

**--Serial Impresora
texto=texto+'i'+'I*'+ALLTRIM(cserialfis)+Chr(13) + Chr(10)

**--Informacion Adicional Cliente (Direccion, Telefonos, nro.transa del siamfox)

**--Direccion Linea1
texto=texto+'i'+'01'+SUBSTR(wDIR_CLI1,1,40)+ Chr(13) + Chr(10) 
texto=texto+'i'+'02'+SUBSTR(wDIR_CLI2,1,40)+ Chr(13) + Chr(10) 

**--Ciudad y Estado Cliente
*texto=texto+'i'+'03'+ALLTRIM(wciu_cli)+ Chr(13) + Chr(10) 
*texto=texto+'i'+'04'+ALLTRIM(west_cli)+ Chr(13) + Chr(10) 

**--Telefono Cliente
texto=texto+'i'+'03'+'Telf.: '+ ALLTRIM(wTEL_CLI)+ Chr(13) + Chr(10)

**--Vendedor o Cajero
texto=texto+'i'+'04'+'Caj/Vend: '+ALLTRIM(wNRO_VEN)+Chr(13) + Chr(10)


**--Anterior 14-02-2017
*!*	*!*	**--Nombre Cliente 
*!*	*!*	l=l+1
*!*	*!*	wl='0'+ALLTRIM(TRANSFORM(l,'99'))   
*!*	*!*	IF !EMPTY(wNOM_CLI)
*!*	*!*	    texto=texto+'i'+wl+'Nombre: '+SUBSTR(wNOM_CLI,1,24)+ Chr(13) + Chr(10)
*!*	*!*	ENDIF      

*!*	*!*	**--Rif. Cliente
*!*	*!*	l=l+1
*!*	*!*	wl='0'+ALLTRIM(TRANSFORM(l,'99'))   
*!*	*!*	IF !EMPTY(WRIF_CLI) 
*!*	*!*	    texto=texto+'i'+wl+'Rif/CI:'+ALLTRIM(WRIF_CLI)+Chr(13)+ Chr(10)        
*!*	*!*	ENDIF 

*!*	*!*	**--Direccion 

*!*	*!*	**--Direccion Linea1
*!*	*!*	IF !EMPTY(wDIR_CLI1)   
*!*	*!*	   l=l+1
*!*	*!*	   IF LEN(ALLTRIM(STR(l)))=1
*!*	*!*	       wl='0'+ALLTRIM(TRANSFORM(l,'99'))
*!*	*!*	   ELSE
*!*	*!*	       wl=TRANSFORM(l,'99')   
*!*	*!*	   ENDIF 
*!*	*!*	   texto=texto+'i'+wl+SUBSTR(wDIR_CLI1,1,32)+ Chr(13) + Chr(10) 
*!*	*!*	ENDIF

*!*	*!*	**--Direccion Linea2
*!*	*!*	IF !EMPTY(wDIR_CLI2)
*!*	*!*	   l=l+1
*!*	*!*	   IF LEN(ALLTRIM(STR(l)))=1
*!*	*!*	       wl='0'+ALLTRIM(TRANSFORM(l,'99'))
*!*	*!*	   ELSE
*!*	*!*	      wl=TRANSFORM(l,'99')   
*!*	*!*	   ENDIF   
*!*	*!*	   texto=texto+'i'+wl+SUBSTR(wDIR_CLI2,1,32)+ Chr(13)+ Chr(10) 
*!*	*!*	ENDIF 

*!*	*!*	*!*	**--Ciudad y Estado Cliente
*!*	*!*	*!*	IF !EMPTY(wciu_CLI) OR !EMPTY(west_CLI)
*!*	*!*	*!*		l=l+1
*!*	*!*	*!*	    IF LEN(ALLTRIM(STR(l)))=1
*!*	*!*	*!*	       wl='0'+ALLTRIM(TRANSFORM(l,'99'))
*!*	*!*	*!*	    ELSE
*!*	*!*	*!*	       wl=TRANSFORM(l,'99')   
*!*	*!*	*!*	    ENDIF  
*!*	*!*	*!*	    tex1=ALLTRIM(wciu_cli)+ space(3)+ALLTRIM(west_cli)
*!*	*!*	*!*	    texto=texto+'i'+wl+SUBSTR(tex1,1,32) + Chr(13)+ Chr(10) 
*!*	*!*	*!*	ENDIF   

*!*	*!*	*!*	**--Telefono Cliente
*!*	*!*	*!*	l=l+1
*!*	*!*	*!*	wl='0'+ALLTRIM(TRANSFORM(l,'99'))   
*!*	*!*	*!*	IF !EMPTY(wTEL_CLI)
*!*	*!*	*!*		texto=texto+'i'+wl+'Telf.: '+ ALLTRIM(wTEL_CLI)+ Chr(13) + Chr(10)
*!*	*!*	*!*	ENDIF

*!*	*!*	**--Referencia Nro Factura
*!*	*!*	l=l+1
*!*	*!*	wl='0'+ALLTRIM(TRANSFORM(l,'99'))
*!*	*!*	texto=texto+'i'+wl+'Nro. Factura Dev.: '+ALLTRIM(STR(wnro_fac))+Chr(13) + Chr(10)

*!*	*!*	**--Vendedor o Cajero
*!*	*!*	l=l+1
*!*	*!*	wl='0'+ALLTRIM(TRANSFORM(l,'99'))
*!*	*!*	texto=texto+'i'+wl+'Caj/Vend: '+ALLTRIM(wNRO_VEN)+Chr(13) + Chr(10)

*!*	*!*	**--Fecha/Hora NotadeCredito
*!*	*!*	l=l+1
*!*	*!*	wl='0'+ALLTRIM(TRANSFORM(l,'99'))
*!*	*!*	fecha=DTOC(DATE())
*!*	*!*	hora =ALLTRIM(TIME())
*!*	*!*	texto=texto+'i'+wl+'Fecha: '+fecha+' - Hora: '+hora+Chr(13) + Chr(10)

*!*	*!*	  
*--------temino encabezado---


**BROWSE

	  
*--------Impresion Registros
SCAN
  
**//Pase de Variables
	STORE FPRECIO			TO PVP_PRO
	STORE FCANTIDAD			TO CAN_PRO
	STORE FALICUOTA			TO POR_IMP
	STORE ALLTRIM(FDESCRIP)	TO DES_PRO
	STORE ALLTRIM(FCODIGO)	TO NRO_PRO
	
	**--parche 30-12-2020
	**STORE FTALICUOTA		TO TIPO_IMP
	STORE 1 TO tipo_imp

	
	*MESSAGEBOX(pvp_pro)
	
	**--Precio		  

	pvp1=TRANSFORM(PVP_PRO,'99999999999999.99')
	pvp2=SUBSTR(pvp1,1,14)+SUBSTR(pvp1,16,2)
	pvp_f=Padl(alltr(pvp2), 16,'0')

**--anterior
*!*		pvp1=TRANSFORM(PVP_PRO,'99999999.99')
*!*		pvp2=SUBSTR(pvp1,1,8)+SUBSTR(pvp1,10,2)
*!*		pvp_f=Padl(alltr(pvp2), 10,'0')


	*MESSAGEBOX(pvp_f) 
		       
	**--Cantidad
	can=TRANSFORM(can_PRO,'99999999999999.999')
	can=SUBSTR(can,1,14)+SUBSTR(can,16,3)
	can_f=Padl(alltr(can), 17,'0')
	
	
	
**--anterior	
*!*		can1=TRANSFORM(can_PRO,'99999.999')
*!*		can2=SUBSTR(can1,1,5)+SUBSTR(can1,7,3)
*!*		can_f=Padl(alltr(can2), 8,'0')
*!*	    

	
	**---------------------------------------------------------------
	**----Impuesto('0' Exento /'1' Imp_1 / '2' Imp_2 / '3' Imp_3)
	**---------------------------------------------------------------
	
 	DO CASE
 	    
	    CASE tipo_imp=1 	&& Tasa Imp 1

	        texto=texto+'d1'+pvp_f+can_f+' '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10)

 	    CASE  tipo_imp=2 .or. por_imp=0 .or. EMPTY(tipo_imp)	&& Tasa 2 Exento 

	     	texto=texto+'d0'+pvp_f+can_f+' '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10) 
		
 	    CASE tipo_imp=3  &&CASE por_imp=22	&& Tasa3  Imp 3
 	    
	     	texto=texto+'d3'+pvp_f+can_f+' '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10) 

	 	CASE tipo_imp=4 	&& Tasa Imp4 (IVA DEL 10%) 

	        texto=texto+'d2'+pvp_f+can_f+' '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10)
   	  
    ENDCASE
 
	
	**--Sumatoria del Documento Fiscal
	wtotal=wtotal+can_pro*pvp_pro*(1+por_imp*.01)
     

ENDSCAN

**--Notas  
*texto=texto+'P'+'H'+'91'+'TELEFONOS:'+Chr(13) + Chr(10)
*texto=texto+'P'+'H'+'92'+'0212-993.43.20'+Chr(13) + Chr(10)
*texto=texto+'P'+'H'+'93'+''+Chr(13) + Chr(10)
*texto=texto+'P'+'H'+'94'+''+Chr(13) + Chr(10)


**---------------------------------------------------------------
**--Cierre Devolucion y Medio de Pagos
**--Medio de Pago 00-16 Pago y Monto de Pago (12 digitos 10+2)
**---------------------------------------------------------------
**wdto=ALLTRIM(STR(wdto,5,2))

**--Buscar forma de Pagos

**--Solo un Medio de Pago (OK)
*!*	tot=TRANSFORM(wtotal,'9999999999.99')
*!*	tot=SUBSTR(tot,1,10)+SUBSTR(tot,12,2)
*!*	le=LEN(ALLTRIM(tot))
*!*	tot_f=SUBSTR('000000000000',1,12-le)+ALLTRIM(tot)
*!*	texto=texto+'f01'+tot_f+Chr(13) + Chr(10)


**--Con Medio de Pago
*wtotal=PADL(ALLTRIM(STR(wtotal,10,2)),12,'0')
*texto=texto+'f01'+wtotal+Chr(13) + Chr(10)

***MESSAGEBOX(tot_f)
**--forma de pago nuevo 04/08/2016

*!*	DO CASE 
*!*		
*!*		CASE  con_crd=1  && Contado


SELECT nro,tpago,monto,banco,detalle,serie;
FROM FORCE cajapagos ;
WHERE wNro_fac=Nro;
INTO CURSOR &temp_caj
	
	
**-- VERIFICAR REGISTROS DE PAGOS
r=RECCOUNT()
		
IF r<=0
	messagebox('Error en Registro, No Existe forma de Pago de Factura Nro. ')
	*+alltrim(STR(wnro)),0+64,'Atencion')
	RETURN
ENDIF
	
			
IF r=1		&& Pago Unico


		**--Monto de Pago
		monto1=transform(monto,'99999999999999.99') 
		monto2=SUBSTR(monto1,1,14)+SUBSTR(monto1,16,2)
		monto_f=Padl(alltr(monto2), 16,'0')
		**MESSAGEBOX(monto_f)



		DO CASE 

		CASE tpago='EFE'
			texto=texto+'101'+Chr(13) + Chr(10)
			
		CASE tpago='CHE'
			texto=texto+'102'+Chr(13) + Chr(10)

		*CASE tpago='TAR'
		*	texto=texto+'103'+Chr(13) + Chr(10)

		CASE tpago='TAC'
			texto=texto+'103'+Chr(13) + Chr(10)

		CASE tpago='TAD' .or. tpago='TAR'
			texto=texto+'104'+Chr(13) + Chr(10)

		CASE tpago='TIA'
			texto=texto+'105'+Chr(13) + Chr(10)

		CASE tpago='TRA'
			texto=texto+'106'+Chr(13) + Chr(10)

		CASE tpago='OTR' 
			texto=texto+'107'+Chr(13) + Chr(10)
			
		OTHERWISE
			texto=texto+'101'+Chr(13) + Chr(10)

	ENDCASE


ELSE 


	SCAN FOR NRO=wnro_fac

			
		**--Monto de Pago
		
		monto1=transform(monto,'99999999999999.99') 
		monto2=SUBSTR(monto1,1,14)+SUBSTR(monto1,16,2)
		monto_f=Padl(alltr(monto2), 16,'0')
		**MESSAGEBOX(monto_f)
		
		
*!*			**--anterior
*!*			monto1=transform(monto,'9999999999.99') 
*!*			monto2=SUBSTR(monto1,1,10)+SUBSTR(monto1,12,2)
*!*			monto_f=Padl(alltr(monto2), 12,'0')
*!*			**MESSAGEBOX(monto_f)
		
		
		**MESSAGEBOX(monto_f)
		
			
		**//Acumular y Clasificar Forma de Pago
		DO CASE 

			CASE tpago='EFE'
				*texto=texto+'101'+Chr(13) + Chr(10)
				texto=texto+'201'+monto_f+Chr(13) + Chr(10)
				
			CASE tpago='CHE'
				texto=texto+'202'+monto_f+Chr(13) + Chr(10)

			CASE tpago='TAC'
				texto=texto+'203'+monto_f+Chr(13) + Chr(10)

			CASE tpago='TAD' .or. tpago='TAR'
				texto=texto+'204'+monto_f+Chr(13) + Chr(10)

			CASE tpago='TIA'
				texto=texto+'205'+monto_f+Chr(13) + Chr(10)

			CASE tpago='TRA'
				texto=texto+'206'+monto_f+Chr(13) + Chr(10)

			CASE tpago='OTR' 
				texto=texto+'207'+monto_f+Chr(13) + Chr(10)
	
		OTHERWISE
				texto=texto+'101'+Chr(13) + Chr(10)
		
		ENDCASE

				
	ENDSCAN

ENDIF 


**---------------------------------------------------------------
**//Grabar datos al archivo plano
**---------------------------------------------------------------
gniobytes=FWRITE(gntestfile,texto)    
glcloseok=Fclose(gntestfile) 
 
    
    
**---------------------------------------------------------------
**//Aperturar el Puerto Segun el Caso (USB/SERIAL)
**---------------------------------------------------------------
*MESSAGEBOX(com_open)
*Com1_open=OpenFpctrl('&xf08')  && DE FORMA SERIAL OK
*MESSAGEBOX(xf08)

DO CASE 

	CASE xf08='COM1'
		com1_open= OpenFpctrl('COM1')
	CASE xf08='COM2'
		com1_open= OpenFpctrl('COM2')
	CASE xf08='COM3'
		com1_open= OpenFpctrl('COM3')
	CASE xf08='COM4'
		com1_open= OpenFpctrl('COM4')
	CASE xf08='COM5'
		com1_open= OpenFpctrl('COM5')
	CASE xf08='COM6'
		com1_open= OpenFpctrl('COM6')
	CASE xf08='COM7'
		com1_open= OpenFpctrl('COM7')
	CASE xf08='COM8'
		com1_open= OpenFpctrl('COM8')
	CASE xf08='COM9'
		com1_open= OpenFpctrl('COM9')

	OTHERWISE

	   	MESSAGEBOX('ERROR, PUERTO NO CONFIGURADO '+'['+xf08+']')
		RETURN
	
ENDCASE

**--Validar (1Abierto 0Cerrado)
IF com1_open#1

   MESSAGEBOX('error, AL ABRIR PUERTO '+'['+xf08+']')

ELSE
   
    WAIT windows ('Documento enviado a printer fiscal ok ...') NOWAIT 
	
	**---------------------------------------------------------------
	**//Enviar datos a impresora  
	**---------------------------------------------------------------
		
	SendFileCmd(@lstatus,@lerror,warchivo) 
	com1_close=closefpctrl() 

ENDIF

RETURN



*!*	*--capturo datos fiscal ------------------------
*!*	wnro_arch=0
*!*	FOR wnro_arch=0 TO 10000
*!*	    wnro=ALLTRIM(TRANSFORM(wnro_arch,'999999'))
*!*	    warchivo='d:\fac_fis\output'+wnro+'.dat'
*!*	    IF FILE(warchivo)=.f.
*!*	       gntestfile1=Fcreate(warchivo) 
*!*	       EXIT  
*!*	     ENDIF
*!*	ENDFOR 
*!*	*-------------------------------
*!*	   texto1='' + Chr(13) + Chr(10)
*!*	   gniobytes=FWRITE(gntestfile1,texto1)   
*!*	   glcloseok1=Fclose(gntestfile1) 
*!*	   com1_open= OpenFpctrl('COM1')
*!*	   
*!*	   IF com1_open#1
*!*	     MESSAGEBOX('error')
*!*	     RETURN
*!*	   ENDIF
*!*	   
*!*	   cmd='S1' 
*!*	   uploadstatuscmd(@lstatus,@lerror,@cmd,warchivo) 
*!*	   com1_close=closefpctrl() 
*!*	*------------------------------ 
*!*	  *gntestfile1=FOPEN('c:\input1.dat',2)
*!*	   gntestfile1=FOPEN(warchivo,2)
*!*	   gniobytes=fgets(gntestfile1,texto1) 
*!*	*------variables para guardar----
*!*	 
*!*	   wfac_fis=SUBSTR(gniobytes,22,8)
*!*	   whor_fis=SUBSTR(gniobytes,77,6)
*!*	   wfec=SUBSTR(gniobytes,83,6)
*!*	   wfec_fis=CTOD(SUBSTR(wfec,1,2) +'/' + SUBSTR(wfec,3,2) +'/'+ SUBSTR(wfec,5,2)) 
*!*	   wmaq_fis=SUBSTR(gniobytes,67,10) 
*!*	   whor_fis=SUBSTR(whor_fis,1,2) + ':' + SUBSTR(whor_fis,3,2) + ':' + SUBSTR(whor_fis,5,2)   
*!*	   
*--------cierro archivo   
*!*	  glcloseok1=Fclose(gntestfile1) 

*-------------------------
*!*	RETURN 


**RETURN


**--ANTERIOR
*!*	    IF por_imp=0
*!*	    	**--Con Codigo Producto
*!*	       	*texto=texto+' '+pvp_f+can_f+nro_pro+' '+SUBSTR(des_pro,1,20)+Chr(13) + Chr(10)

*!*	    	**--Sin Codigo Producto
*!*	     	texto=texto+'d'+'0'+pvp_f+can_f+' '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10) 
*!*	     	

*!*	    ELSE 
*!*	    	**--Con Codigo Producto
*!*	        *texto=texto+'!'+pvp_f+can_f+nro_pro+' '+SUBSTR(des_pro,1,20)+Chr(13) + Chr(10)

*!*	    	**--Sin Codigo Producto
*!*	        texto=texto+'d'+'1'+pvp_f+can_f+' '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10)


*!*	    ENDIF 