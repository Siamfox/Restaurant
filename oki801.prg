*************************************************************************************************
**FUNCTION oki801  &&  IMPRIME LAS FACTURAS DETAL \ EN PRINTER FISCAL OKIDATA ML1120 80 COULUMNAS
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
STORE '' TO CDIR,CDIR1,CDIR2,CRIF,CNIT,CNOMBRE
STORE '' TO CCODIGO,CDESCRIP
STORE 0  TO PPRECIO,CCANTIDAD,CALICUOTA,CCANT_DEC
STORE 0  TO CCANTIDAD,CCANT_PZA
STORE '' TO CUNIFRA,CDESCUENTO,CUNIDAD,CSERIAL
STORE '' TO CCIUDAD,CESTADO,CTELEFONOS
STORE '' TO CDES_ITE,CDES_GEN
STORE '' TO RUTA,RUTAI,RUTAF,letras
STORE '' TO CPAGO,CCPAGO,CCPAGO1,CCPAGO2,CCPAGO3
STORE '' TO CVPAGO1,CVPAGO2,CVPAGO3
STORE '' TO CNCHEQUE,CNTARJETA,CBANCO


**-------------------------------------------------------
**// Creacion del Temporal
**TEMP2='TCAJ'+SUBSTR(ALLTRIM(ID()),1, (AT('#',ID())-2) )
TEMP2='TFIS80'
**-------------------------------------------------------

IF LEN(temp2)>12 
	messagebox('Nombre-Estacion, demasiado largo...'+CHR(13)+'Debe Cambiar o participar al Administrador de la Red',0+64,'Atencion...')
	RETURN
ENDIF


**//Nro Factura a Imprimir
WNRO=WFACTURA

**// GENERAR TEMPORAL
TEMFISCO()

SELECT 11
IF !LOCK1('&TEMP2','C')
    RETURN
ENDIF

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

SELECT 7 && FACTURAS MAESTRO
IF !LOCK1('&MAESTRO','C')
RETURN
ENDIF
SET INDEX TO &IND_I

SELECT 8 &&REGISTROS FACTURAS
IF !LOCK1('&REGISTROS','C')
RETURN
ENDIF
SET INDEX TO &IND_II

**--------------------------------------
**// VERIFICAR MAESTRO DE FACTURA 
**--------------------------------------
SELECT 7
SEEK WNRO
IF EOF()
   	WAIT WINDOWS "!!! ERROR !!! MAESTRO FACTURA->FACTURA LISTAR INCORRECTA '+STR(WNRO))..." nowait
   RETURN
ENDIF

**--------------------------------------
**// PASE DATOS A VARIABLES DE TRABAJO
**--------------------------------------
WDTO=G->DTO  && DESCUENTO GENERAL GLOBAL
cVEND=G->VEND
nDias=G->DIAS
cOrden=G->ORDEN


**--------------------------------------
**// VERIFICAR REGISTROS DE FACTURAS
**--------------------------------------
SELECT 8 &&REGISTROS FACTURAS
SEEK WNRO
IF EOF()
   WAIT WINDOWS'ннн ERROR !!!(REGISTROS)-> FACTURA A LISTAR INCORRECTA...' nowait
   RETURN
ENDIF
  
**----------------------------------------------------------------------------
**// INICIAR PROCESO REPORTE FISCAL(ENCABEZADO,REGISTROS,ARCHIVO PLANO FISCAL)
**----------------------------------------------------------------------------
DAT_CLI()              && DATOS DEL CLIENTE
DETA_FAC()             && DETALLE DE LA FACTURA
PRO_FIS()              && PROCESO FISCALIZACION

RETURN

**------------------------------------
FUNCTION DAT_CLI  && ENCABEZADO  *
**------------------------------------
**// PASE DATOS A VARIABLES DE TRABAJO

   SELECT 7 && MAESTRO FACTURAS
   SEEK WNRO

**// CONDICION DE PAGO
   IF PAGO=1 && 'C '
      CPAGO='CONTADO'
   ELSE
      CPAGO='CREDITO'
   ENDIF
   STORE PAGO TO NPAGO
   

**// FORMA DE PAGO
   **IF FEFECTIVO>0
      CCPAGO='Efectivo'
   **ELSE
   **   IF FCHEQUE>0
   **      CCPAGO='Cheque'
   **  ELSE
   **      CCPAGO='Tarjeta'
   **   ENDIF
   **ENDIF


**// NOMBRE CLIENTE
  SELECT 3  && CLIENTES
  IF !LOCK1('CLIENTE','C')
		RETURN
  ENDIF
  SET INDEX TO CLI_RIF

  SEEK UPPER(ALLTRIM(G->CLIENTE))
	
  IF !EOF()
	  CRIF=UPPER(ALLTRIM(G->CLIENTE))	
	  CNOMBRE=ALLTRIM(C->NOMBRE)  &&40
   ELSE
	  WAIT WINDOWS 'ннн ERROR !!! CLIENTE SIN REGISTRO FISCAL(RIF) o SIN RAZON SOCIAL(NOMBRE)' &&nowait
      RETURN
   ENDIF
              
**// DIRECCION, CIUDAD, ESTADO Y TELEFONO
   IF C->DIR1<>SPACE(45)  &&MAXIMO 133
      CDIR1=ALLTRIM(C->DIR1)
      CDIR2=ALLTRIM(C->DIR2)
      CCIUDAD=ALLTRIM(C->CIUDAD)
      CESTADO=ALLTRIM(C->ESTADO)
      CTELEFONOS=ALLTRIM(C->TELEFONOS)

      *CDIR=ALLTRIM(C->DIR1)+' '+ALLTRIM(C->DIR2)+' '+;
           ALLTRIM(C->CIUDAD)+' '+ALLTRIM(C->ESTADO)+' '+ALLTRIM(C->TELEFONOS)
           
      *IF LEN(CDIR)>133
      *   CDIR=SUBSTR(CDIR,1,133)
      *  WAIT WINDOWS 'ннн ERROR !!! MAXIMO VALOR EN LONGITUD DIRECCION FISCAL ' &&nowait
      *ENDIF
	ELSE
      WAIT WINDOWS 'ннн ERROR !!! CLIENTE SIN DIRECCION FISCAL (DIRECCION) ' &&nowait
      RETURN
	ENDIF


**// CTROL DESCUENTO GENERAL
   WDTO=G->DTO  &&DESCUENTO GENERAL GLOBAL

RETURN

**---------------------------------------------------------------
FUNCTION DETA_FAC     && IMPRESION DETALLADA DE ITEM  
**---------------------------------------------------------------
DO WHILE .T.
   STORE '' TO CDES_ITE,CDES_GEN,CSERIAL

   SELECT 8 && **// (REGISTRO FACTURAS)
	**// CAPTURA DE DATOS REGISTRO PARA DATOS VARIABLES FISCALES

	**// CODIGO
	   CCODIGO=SUBSTR(ALLTRIM(CODIGO),1,13)

	**// DESCRIPCION
		IF xi15=.t.  && Control Manejo de Cantidad de Piezas
		   CDESCRIP=ALLTRIM(STR(CANT_PZA))+'Pz'+' '+SUBSTR(ALLTRIM(DESCRIP),1,34)
		ELSE
		   CDESCRIP=SUBSTR(ALLTRIM(DESCRIP),1,40)
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

       SELECT 8 && REGISTROS FACTURAS
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
	(FCODIGO    C(13,0),;  && CAMPO  1 CODIGO ART.
   	 FDESCRIP   C(40,0),;  && CAMPO  2 DESCRIPCION ART.
 	 FALICUOTA  N(5,2),;   && CAMPO  3 ALICUOTA ART.
	 FUNIFRA    C(1,0),;   && CAMPO  4 TIPO CANTIDAD (I)ENTERO (F)RACCION
	 FCANTIDAD  N(9,3),;   && CAMPO  5 CANTIDAD ART(S)
	 FCANT_DEC  C(1,0),;   && CAMPO  6 CANTIDAD DECIMALES PRECIO UNITARIO ART
	 FPRECIO	N(8,2),;   && CAMPO  7 PRECIO VALOR UNITARIO
	 FTIPO_DES  C(1,0),;   && CAMPO  8 TIPO DESCUENTO VALOR O PORCENTAJE
	 FDESCUENTO C(8,0),;   && CAMPO  9 VALOR DEL DESCUENTO
	 FUNIDAD    C(2,0),;   && CAMPO 10 UNIDAD DE MEDIDA ART.
	 FSERIAL    C(40,0))  && CAMPO 11 SERIAL ART.
	 	 
	 CLOSE DATABASES all
	 WAIT WINDOWS "Temporal Finalizado..." nowait
	
RETURN


**---------------------------------------------------------------
FUNCTION DET_FISCO && CREAR DETALLE DEL REPORTE FISCAL
**---------------------------------------------------------------
SET DECIMALS TO 3

SELECT 11
FLOCK()
APPEND BLANK

REPLACE FCODIGO    WITH  CCODIGO    && CAMPO  1 CODIGO ART.
REPLACE FDESCRIP   WITH  CDESCRIP   && CAMPO  2 DESCRIPCION ART.
REPLACE FALICUOTA  WITH  CALICUOTA  && CAMPO  3 ALICUOTA ART.
*REPLACE FUNIFRA    WITH  CUNIFRA    && CAMPO  4 T/CANTIDAD (I)ENTERO (F)RACCION
REPLACE FCANTIDAD  WITH  CCANTIDAD  && CAMPO  5 CANTIDAD ART(S)
*REPLACE FCANT_DEC  WITH  CCANT_DEC  && CAMPO  6 CANTIDAD DECIMALES PRECIO UNITARIO ART
REPLACE FPRECIO    WITH  PPRECIO    && CAMPO  7 PRECIO VALOR UNITARIO
*REPLACE FTIPO_DES  WITH  '$'        && CAMPO  8 TIPO DESCUENTO ($)VALOR O (%)PORCENTAJE
REPLACE FDESCUENTO WITH  CDESCUENTO && CAMPO  9 VALOR DEL DESCUENTO
*REPLACE FUNIDAD    WITH  CUNIDAD    && CAMPO 10 UNIDAD DE MEDIDA
*REPLACE FSERIAL    WITH  CSERIAL    && CAMPO 11 SERIAL DEL ARTICULO

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


**---------------------------------------------------------------
**//Pase Variables
**---------------------------------------------------------------

STORE WNRO			TO WNRO_FAC
STORE CVEND			TO WNRO_VEN
STORE CNOMBRE		TO WNOM_CLI
STORE CDIR1			TO WDIR_CLI
STORE CDIR2			TO WDIR_CLI1
STORE CCIUDAD		TO WCIU_CLI
STORE CESTADO		TO WEST_CLI
STORE CRIF			TO WRIF_CLI
STORE CTELEFONOS	TO WTEL_CLI
STORE NDIAS			TO WPLA_FAC
STORE CORDEN		TO WORD_COM
STORE NPAGO			TO CON_CRD		


**//------------------------------------
**//Detalle Impresion Fiscal
**//------------------------------------

**SELECT 11
**oki802() 

**---------------------------------------------------------------
**//Directorio donde se almacenaran los archivos Planos
**---------------------------------------------------------------
IF DIRECTORY('c:\fac_fis')=.f.
   MKDIR c:\fac_fis
ENDIF

*--------------------------
wnro_arch=0
FOR wnro_arch=0 TO 10000
    wnro=ALLTRIM(TRANSFORM(wnro_arch,'999999'))
    warchivo='c:\fac_fis\input'+wnro+'.dat'
    IF FILE(warchivo)=.f.
       gntestfile=Fcreate(warchivo) 
       EXIT  
    ENDIF
ENDFOR 


*-----------------
SELECT 11 &&  det_temp
GO top
word_com=word_com
wpla_fac=wpla_fac

l=1
  wl='0'+ALLTRIM(TRANSFORM(l,'99'))
  texto='i'+wl+'Cond. Pago: '
  IF con_crd=2
     texto=texto+'Credito'+SPACE(2)
  ELSE    
     texto=texto+'Contado'+SPACE(2)
  ENDIF
  texto=texto+'Ref: '+ ALLTRIM(STR(wnro_fac))+ ' Vend.'+wNRO_VEN +Chr(13) + Chr(10)
  *-------------------
  l=l+1
  wl='0'+ALLTRIM(TRANSFORM(l,'99'))
  texto=texto+'i'+wl+'------------------------------------------------------------------------------' +Chr(13) + Chr(10)
  *-------------------
  l=l+1
  wl='0'+ALLTRIM(TRANSFORM(l,'99'))   
  IF !EMPTY(wNOM_CLI)
       texto=texto+'i'+wl+ SUBSTR(wNOM_CLI,1,50)+ Chr(13) + Chr(10)
  ENDIF      
  *-------------------  
  IF !EMPTY(wDIR_CLI)   
      l=l+1
      IF LEN(ALLTRIM(STR(l)))=1
         wl='0'+ALLTRIM(TRANSFORM(l,'99'))
      ELSE
         wl=TRANSFORM(l,'99')   
      ENDIF 
	  texto=texto+'i'+wl+SUBSTR(wDIR_CLI,1,50)+ Chr(13) + Chr(10) 
  ENDIF
  *------------------- 
  IF !EMPTY(wDIR_CLI1)
      l=l+1
      IF LEN(ALLTRIM(STR(l)))=1
         wl='0'+ALLTRIM(TRANSFORM(l,'99'))
      ELSE
         wl=TRANSFORM(l,'99')   
      ENDIF   
	  texto=texto+'i'+wl+SUBSTR(wDIR_CLI1,1,50)+ Chr(13)+ Chr(10) 
  ENDIF 
  *--------------------

  IF !EMPTY(wciu_CLI) OR !EMPTY(west_CLI)
      l=l+1
      IF LEN(ALLTRIM(STR(l)))=1
         wl='0'+ALLTRIM(TRANSFORM(l,'99'))
      ELSE
         wl=TRANSFORM(l,'99')   
      ENDIF  
      tex1=ALLTRIM(wciu_cli)+ space(3)+ALLTRIM(west_cli)
      texto=texto+'i'+wl+SUBSTR(tex1,1,50) + Chr(13)+ Chr(10) 
  ENDIF   
  *------------------

  tex1='' 
  IF !EMPTY(WRIF_CLI) 
      *WRIF=SUBSTR(wRIF_CLI,1,1)+'-'+SUBSTR(wRIF_CLI,2,8)+'-'+SUBSTR(wRIF_CLI,10,1)
      tex1='Rif/CI:'+ALLTRIM(WRIF_CLI)  
*!*	      *tex1='Rif. :'+ALLTRIM(RIF_CLI)
*!*	  ELSE
*!*	      tex1= 'Cedula :'+ALLTRIM(wCEI_CLI)
  ENDIF 
  IF !EMPTY(tex1)
      tex1=SUBSTR(tex1+SPACE(22),1,22)
      *l=l+1
      *IF LEN(ALLTRIM(STR(l)))=1
      *   wl='0'+ALLTRIM(TRANSFORM(l,'99'))
      *ELSE
      *   wl=TRANSFORM(l,'99')   
      *ENDIF 
  	  *texto=texto+'i'+wl+tex1+ Chr(13)+ Chr(10)      
  ENDIF
  *----------------
  tex2=''    
  IF !EMPTY(wTEL_CLI)
      tex2= 'Tlf.:'+ ALLTRIM(wTEL_CLI)
  ENDIF
  tex2=SUBSTR(tex2+SPACE(20),1,20)
      
  l=l+1
  IF LEN(ALLTRIM(STR(l)))=1
      wl='0'+ALLTRIM(TRANSFORM(l,'99'))
  ELSE
      wl=TRANSFORM(l,'99')   
  ENDIF       
  *----------------
  texto=texto+'i'+wl+tex1+tex2+ Chr(13) + Chr(10)
  *--------------------
  
  l=l+1
  IF LEN(ALLTRIM(STR(l)))=1
     wl='0'+ALLTRIM(TRANSFORM(l,'99'))
  ELSE
     wl=TRANSFORM(l,'99')   
  ENDIF 
  texto=texto+'i'+wl+'------------------------------------------------------------------------------' +Chr(13) + Chr(10)
  
  *--------temino encabezado---
*!*	  l=l+1
*!*	  IF LEN(ALLTRIM(STR(l)))=1
*!*	     wl='0'+ALLTRIM(TRANSFORM(l,'99'))
*!*	  ELSE
*!*	     wl=TRANSFORM(l,'99')   
*!*	  ENDIF 

*!*	  texto=texto+'i'+wl+'Cantidad    Precio        /      Codigo    Descripcion' + Chr(13)+ Chr(10)
  *----------------
  *l=l+1
  *  IF LEN(ALLTRIM(STR(l)))=1
  *   wl='0'+ALLTRIM(TRANSFORM(l,'99'))
  *ELSE
  *   wl=TRANSFORM(l,'99')   
  *ENDIF  
  *texto=texto+'i'+wl+'------------------------------------------------------------------------------' +Chr(13) + Chr(10)
  
  *-------------------
  SCAN
  
	**---------------------------------------------------------------
	**//Pase de Variables
	**---------------------------------------------------------------
		STORE FPRECIO 			TO PVP_PRO
		STORE FCANTIDAD			TO CAN_PRO
		STORE FALICUOTA			TO POR_IMP
		STORE ALLTRIM(FDESCRIP)	TO DES_PRO
		STORE ALLTRIM(FCODIGO)	TO NRO_PRO
			  
		pvp=TRANSFORM(PVP_PRO,'99999999.99')
		pvp=SUBSTR(pvp,1,8)+SUBSTR(pvp,10,2)
		le=LEN(ALLTRIM(pvp))
		pvp_f=SUBSTR('0000000000',1,10-le)+ALLTRIM(pvp)
		       
		can=TRANSFORM(can_PRO,'99999.999')
		can=SUBSTR(can,1,5)+SUBSTR(can,7,3)
		le=LEN(ALLTRIM(can))
		can_f=SUBSTR('00000000',1,8-le)+ALLTRIM(can)
    
     *texto=texto+'@'+'Cod :'+nro_pro+Chr(13) + Chr(10)
*!*	     IF can_pro=1
*!*	        can2=ALLTRIM(TRANSFORM(can_PRO,'9999.99'))
*!*	        pvp2=ALLTRIM(TRANSFORM(pvp_PRO,'9999999.99'))
*!*	        texto=texto+'@'+can2 +' x ' + 'Bs '+pvp2+Chr(13) + Chr(10)
*!*	     ENDIF    
     
	*Impuesto '' Ex '!' Imp1	
     IF por_imp=0
        *texto=texto+' '+pvp_f+can_f+'   '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10)
         texto=texto+' '+pvp_f+can_f+nro_pro+'   '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10)
     ELSE 
        *texto=texto+'!'+pvp_f+can_f+'   '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10)
        texto=texto+'!'+pvp_f+can_f+nro_pro+'   '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10)
     ENDIF 
     
     *texto=texto+'#'+pvp_f+can_f+nro_pro+'   '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10) &totales x impuesto
     *IF !EMPTY(keyfecha)
     *    texto=texto+'@'+keyfecha+Chr(13) + Chr(10)
     *ENDIF    
  ENDSCAN

   texto=texto+'@'+'                     '+Chr(13) + Chr(10)
 
   *-------orden de compra
    
    tex3=' '  
	  IF wpla_fac>0

	      wpla_fac=ALLTRIM(TRANSFORM(wpla_fac,'999'))
	      tex3= 'Plazo : '+ wpla_fac +' dias'
	      texto=texto+'@'+tex3+Chr(13) + Chr(10)
	  ENDIF
  
      tex3=' '    
	  IF !EMPTY(word_com)
	      tex3= 'Nota de Entrega : '+ ALLTRIM(word_com) 
	      texto=texto+'@'+tex3+Chr(13) + Chr(10)
	  ENDIF
  
	  texto=texto+'P'+'H'+'91'+'TELEFONOS:'+Chr(13) + Chr(10)
	  texto=texto+'P'+'H'+'92'+'0414-271.4156 / 0414-90344.45'+Chr(13) + Chr(10)
	  texto=texto+'P'+'H'+'93'+'0424-120.95.00'+Chr(13) + Chr(10)
	  texto=texto+'P'+'H'+'94'+'e-mail: carnegomez@gmail.com'+Chr(13) + Chr(10)

	**---------------------------------------------------------------
	**//Grabar datos al archivo plano
	**---------------------------------------------------------------
     texto=texto+'101'+Chr(13) + Chr(10)
	 gniobytes=FWRITE(gntestfile,texto)    
	 glcloseok=Fclose(gntestfile) 
   
    
	**---------------------------------------------------------------
	**//Aperturar el Puerto Segun el Caso
	**---------------------------------------------------------------
     com1_open= OpenFpctrl('COM1')
     
      IF com1_open#1
         MESSAGEBOX('error, AL ABRIR PUERTO...')
         RETURN
      ENDIF

	**---------------------------------------------------------------
	**//Enviar datos a impresora  
	**---------------------------------------------------------------
	
	  SendFileCmd(@lstatus,@lerror,warchivo) 
	  com1_close=closefpctrl() 

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
