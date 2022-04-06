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

**-------------------------------------------------------
**// Creacion del Temporal
**TEMP2='TCAJ'+SUBSTR(ALLTRIM(ID()),1, (AT('#',ID())-2) )
TEMP2='TFIS80'
**-------------------------------------------------------

IF LEN(temp2)>12 
	messagebox('Nombre-Estacion, demasiado largo...'+CHR(13)+'Debe Cambiar o participar al Administrador de la Red',0+64,'Atencion...')
	RETURN
ENDIF

	messagebox('voy por aca...')

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
PRO_FIS()      && PROCESO FISCALIZACION

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

	STORE WNRO		TO WNRO_FAC &&NRO FACTURA
	STORE CLIENTE	TO cCliente	&&RIF CLIENTE
	STORE DTO		TO nDTO		&&DESCUENTO GENERAL GLOBAL
	STORE VEND		TO cVend	&&VENDEDOR
	STORE DIAS		TO nDias	&&DIAS
	STORE ORDEN		TO cORDEN	&&NRO.ORDEN	

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
		   CDESCRIP=ALLTRIM(STR(CANT_PZA))+'Pz'+' '+SUBSTR(ALLTRIM(DESCRIP),1,34)
		ELSE
		   CDESCRIP=SUBSTR(ALLTRIM(DESCRIP),1,19)
		ENDIF
		
	**// ALICUOTA 
	   calicuota=alicuota
	   IF ALICUOTA=0 && PRODUCTOS EXENTOS
	      CDESCRIP=CDESCRIP
	   ENDIF

	**// CANTIDAD Y UNIDAD DE VENTA FRACIONADA O ENTERA (DECIMALES PARA LA CANTIDAD)
	   *VALOR=CANTIDAD
	   ccantidad=cantidad

	**// PRECIO (NOTA SE PASA EL PRECIO Y EL PRINTER CALCULA EL IMPUESTO)
	   IF xV01=.T. && PRECIO CON IMPUESTO INCLUIDO

	      PPRECIO=PRECIO/(1+ALICUOTA*.01)

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
	 FUNIFRA    C(1,0),;   && CAMPO  4 TIPO CANTIDAD (I)ENTERO (F)RACCION
	 FCANTIDAD  N(9,3),;   && CAMPO  5 CANTIDAD ART(S)
	 FCANT_DEC  C(1,0),;   && CAMPO  6 CANTIDAD DECIMALES PRECIO UNITARIO ART
	 FPRECIO	N(8,2),;   && CAMPO  7 PRECIO VALOR UNITARIO
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
**// FORMATO DEL COMANDO FISCAL SEGUN MODELO PRINTER
**//  1.-CODIGO              | (STRING 13)
**//  2.-DESCRIPCION         | (STRING 29)
**//  3.-ALICUOTA            | (DIGITO 5 C/DEC. EJ. 09,00) (DIG DE 2 INDICE ALICUOTA)
**//  4.-TIPO_CANTIDAD       | (STRING  1) (I)ENTERO (F)FRACIONARIO
**//  5.-CANTIDAD            | (STRING (4) DIGITOS ENTERO (7) DIGITOS FRACIONARIO
**//  6.-CANTIDAD_DECIMAL    | (DIGITO  1) CANTIDAD DECIMAL VALOR UNITARIO (2 O 3)
**//  7.-VALOR UNITARIO      | (STRING (8) DIGITOS
**//  8.-TIPO DESCUENTO      | (STRING  1) ($ X VALOR) ( % X PORCE%)
**//  9.-VALOR DEL DESCUENTO | (DIGITO 8 C/DECIMAL X VALOR) (DIGITO 4 X PORCE%)
**// 10.-VALOR UNIDAD EMPAQ  | (STRING  2)

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
IF DIRECTORY('c:\fac_fis')=.f.
   MKDIR c:\fac_fis
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
*!*	word_com=word_com
*!*	wpla_fac=wpla_fac
l=0

**--Encabezado

**--Nombre Cliente 
l=l+1
wl='0'+ALLTRIM(TRANSFORM(l,'99'))   
IF !EMPTY(wNOM_CLI)
    texto=texto+'i'+wl+'Nombre: '+SUBSTR(wNOM_CLI,1,24)+ Chr(13) + Chr(10)
ENDIF      

**--Rif. Cliente
l=l+1
wl='0'+ALLTRIM(TRANSFORM(l,'99'))   
IF !EMPTY(WRIF_CLI) 
    texto=texto+'i'+wl+'Rif/CI:'+ALLTRIM(WRIF_CLI)+Chr(13)+ Chr(10)        
ENDIF 

**--Direccion 

**--Direccion Linea1
IF !EMPTY(wDIR_CLI1)   
   l=l+1
   IF LEN(ALLTRIM(STR(l)))=1
       wl='0'+ALLTRIM(TRANSFORM(l,'99'))
   ELSE
       wl=TRANSFORM(l,'99')   
   ENDIF 
   texto=texto+'i'+wl+SUBSTR(wDIR_CLI1,1,32)+ Chr(13) + Chr(10) 
ENDIF

**--Direccion Linea2
IF !EMPTY(wDIR_CLI2)
   l=l+1
   IF LEN(ALLTRIM(STR(l)))=1
       wl='0'+ALLTRIM(TRANSFORM(l,'99'))
   ELSE
      wl=TRANSFORM(l,'99')   
   ENDIF   
   texto=texto+'i'+wl+SUBSTR(wDIR_CLI2,1,32)+ Chr(13)+ Chr(10) 
ENDIF 

*!*	**--Ciudad y Estado Cliente
*!*	IF !EMPTY(wciu_CLI) OR !EMPTY(west_CLI)
*!*		l=l+1
*!*	    IF LEN(ALLTRIM(STR(l)))=1
*!*	       wl='0'+ALLTRIM(TRANSFORM(l,'99'))
*!*	    ELSE
*!*	       wl=TRANSFORM(l,'99')   
*!*	    ENDIF  
*!*	    tex1=ALLTRIM(wciu_cli)+ space(3)+ALLTRIM(west_cli)
*!*	    texto=texto+'i'+wl+SUBSTR(tex1,1,32) + Chr(13)+ Chr(10) 
*!*	ENDIF   

*!*	**--Telefono Cliente
*!*	l=l+1
*!*	wl='0'+ALLTRIM(TRANSFORM(l,'99'))   
*!*	IF !EMPTY(wTEL_CLI)
*!*		texto=texto+'i'+wl+'Telf.: '+ ALLTRIM(wTEL_CLI)+ Chr(13) + Chr(10)
*!*	ENDIF

**--Referencia Nro Factura
l=l+1
wl='0'+ALLTRIM(TRANSFORM(l,'99'))
texto=texto+'i'+wl+'Nro. Factura Dev.: '+ALLTRIM(STR(wnro_fac))+Chr(13) + Chr(10)

**--Vendedor o Cajero
l=l+1
wl='0'+ALLTRIM(TRANSFORM(l,'99'))
texto=texto+'i'+wl+'Caj/Vend: '+ALLTRIM(wNRO_VEN)+Chr(13) + Chr(10)

**--Fecha/Hora NotadeCredito
l=l+1
wl='0'+ALLTRIM(TRANSFORM(l,'99'))
fecha=DTOC(DATE())
hora =ALLTRIM(TIME())
texto=texto+'i'+wl+'Fecha: '+fecha+' - Hora: '+hora+Chr(13) + Chr(10)

  
*--------temino encabezado---

	  
*--------Impresion Registros
SCAN
  
**//Pase de Variables
	STORE FPRECIO 			TO PVP_PRO
	STORE FCANTIDAD			TO CAN_PRO
	STORE FALICUOTA			TO POR_IMP
	STORE ALLTRIM(FDESCRIP)	TO DES_PRO
	STORE ALLTRIM(FCODIGO)	TO NRO_PRO
		
	*MESSAGEBOX(fprecio) 
	
	**--Precio		  
	pvp=TRANSFORM(PVP_PRO,'99999999.99')
	pvp=SUBSTR(pvp,1,8)+SUBSTR(pvp,10,2)
	le=LEN(ALLTRIM(pvp))
	pvp_f=SUBSTR('0000000000',1,10-le)+ALLTRIM(pvp)

	*MESSAGEBOX(pvp_f) 
		       
	**--Cantidad
	can=TRANSFORM(can_PRO,'99999.999')
	can=SUBSTR(can,1,5)+SUBSTR(can,7,3)
	le=LEN(ALLTRIM(can))
	can_f=SUBSTR('00000000',1,8-le)+ALLTRIM(can)
    
	**--Impuesto('0' Exento /'1' Imp_1 / '2' Imp_2 / '3' Imp_3)
    IF por_imp=0
    	**--Con Codigo Producto
       	*texto=texto+' '+pvp_f+can_f+nro_pro+' '+SUBSTR(des_pro,1,20)+Chr(13) + Chr(10)

    	**--Sin Codigo Producto
     	texto=texto+'d'+'0'+pvp_f+can_f+' '+SUBSTR(des_pro,1,20)+Chr(13) + Chr(10)
     	

    ELSE 
    	**--Con Codigo Producto
        *texto=texto+'!'+pvp_f+can_f+nro_pro+' '+SUBSTR(des_pro,1,20)+Chr(13) + Chr(10)

    	**--Sin Codigo Producto
        texto=texto+'d'+'1'+pvp_f+can_f+' '+SUBSTR(des_pro,1,20)+Chr(13) + Chr(10)


    ENDIF 
	
	**--Sumatoria del Documento Fiscal
	wtotal=wtotal+can_pro*pvp_pro*(1+por_imp*.01)
     

ENDSCAN

**--Notas  
*texto=texto+'P'+'H'+'91'+'TELEFONOS:'+Chr(13) + Chr(10)
*texto=texto+'P'+'H'+'92'+'0212-993.43.20'+Chr(13) + Chr(10)
*texto=texto+'P'+'H'+'93'+''+Chr(13) + Chr(10)
*texto=texto+'P'+'H'+'94'+''+Chr(13) + Chr(10)



**---------------------------------------------------------------
**--Cierre Devolucion y Medio de Pago 
**--Medio de Pago 00-16 Pago y Monto de Pago (12 digitos 10.2)
**---------------------------------------------------------------
wdto=ALLTRIM(STR(wdto,5,2))

**--Solo
*tot=TRANSFORM(wtotal,'9999999999.99')
*tot=SUBSTR(tot,1,10)+SUBSTR(tot,12,2)
*le=LEN(ALLTRIM(tot))
*tot_f=SUBSTR('000000000000',1,12-le)+ALLTRIM(tot)
*texto=texto+'f01'+tot_f+Chr(13) + Chr(10)

texto=texto+'f01'+'000000000000'+Chr(13) + Chr(10)


**--Con Medio de Pago
*wtotal=PADL(ALLTRIM(STR(wtotal,10,2)),12,'0')
*texto=texto+'f01'+wtotal+Chr(13) + Chr(10)

**Mejorar 
**padl



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
