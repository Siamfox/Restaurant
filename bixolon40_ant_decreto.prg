*************************************************************************************************
**FUNCTION bixolon40 &&  IMPRIME LAS FACTURAS DETAL \ EN PRINTER FISCAL BIXOLON-DACOM 40 COLUMNAS
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
TEMP2='TFIS40'
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
   WAIT WINDOWS'­­­ ERROR !!!(REGISTROS)-> FACTURA A LISTAR INCORRECTA...' nowait
   RETURN
ENDIF
  
**----------------------------------------------------------------------------
**// INICIAR PROCESO REPORTE FISCAL(ENCABEZADO,REGISTROS,ARCHIVO PLANO FISCAL)
**----------------------------------------------------------------------------
DAT_CLI()   && DATOS DEL CLIENTE
DETA_FAC()  && DETALLE DE LA FACTURA
PRO_FIS()   && PROCESO FISCALIZACION

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
	  *CRIF=UPPER(ALLTRIM(G->CLIENTE))	
	  CRIF=UPPER(G->JURIDICO)+'-'+UPPER(ALLTRIM(G->CLIENTE))	
	  CNOMBRE=ALLTRIM(C->NOMBRE)  &&40
   ELSE
	  WAIT WINDOWS '­­­ ERROR !!! CLIENTE SIN REGISTRO FISCAL(RIF) o SIN RAZON SOCIAL(NOMBRE)' &&nowait
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
      *  WAIT WINDOWS '­­­ ERROR !!! MAXIMO VALOR EN LONGITUD DIRECCION FISCAL ' &&nowait
      *ENDIF
	ELSE
      WAIT WINDOWS '­­­ ERROR !!! CLIENTE SIN DIRECCION FISCAL (DIRECCION) ' &&nowait
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

	**--ALICUOTA %
		calicuota=alicuota
		IF ALICUOTA=0 && PRODUCTOS EXENTOS
	      CDESCRIP=CDESCRIP
		ENDIF

	**--Tipo_ALICUOTA  
		cTipoAlicuota=talicuota	


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
	 FCANTIDAD  N(9,3),;   && CAMPO  5 CANTIDAD ART(S)
	 FPRECIO	N(8,2),;   && CAMPO  7 PRECIO VALOR UNITARIO
	 FDESCUENTO C(8,0))   && CAMPO  9 VALOR DEL DESCUENTO
	 	 
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
REPLACE FCANTIDAD  WITH  CCANTIDAD  && CAMPO  4 CANTIDAD ART(S)
REPLACE FPRECIO    WITH  PPRECIO    && CAMPO  5 PRECIO VALOR UNITARIO
REPLACE FDESCUENTO WITH  CDESCUENTO && CAMPO  6 VALOR DEL DESCUENTO

UNLOCK
RETURN

**---------------------------------------------------------------
FUNCTION PRO_FIS    && PROCESO IMPRESION FISCAL HACIA AL MONITOR
**---------------------------------------------------------------
**// FORMATO DEL COMANDO FISCAL SEGUN MODELO PRINTER
**//  1.-CODIGO              
**//  2.-DESCRIPCION         
**//  3.-ALICUOTA            
**//  4.-CANTIDAD            
**//  5.-VALOR UNITARIO      
**//  6.-VALOR DEL DESCUENTO 


**---------------------------------------------------------------
**//Pase Variables
**---------------------------------------------------------------

STORE WNRO				TO WNRO_FAC
STORE CVEND				TO WNRO_VEN
STORE CNOMBRE			TO WNOM_CLI
STORE CDIR1				TO WDIR1_CLI
STORE CDIR2				TO WDIR2_CLI
STORE CCIUDAD			TO WCIU_CLI
STORE CESTADO			TO WEST_CLI
STORE CRIF				TO WRIF_CLI
STORE CTELEFONOS		TO WTEL_CLI
STORE NDIAS				TO WPLA_FAC
STORE CORDEN			TO WORD_COM
STORE NPAGO				TO CON_CRD		
STORE ctipoalicuota		TO TIPO_IMP
			  

**//------------------------------------
**//Detalle Impresion Fiscal
**//------------------------------------

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


**-----------------------------------
**--Encabezado Factura con datos 
**-----------------------------------
IF con_crd=2
   wcondicion='Credito '
ELSE     
   wcondicion='Contado '
ENDIF

**(Condicion, Factura y Vendedor)
texto='i'+'01'+'Cond. Pago:'+wcondicion+'Trans:'+ALLTRIM(STR(wnro_fac))+Chr(13) + Chr(10)

**(Nombre Cliente)
texto=texto+'i'+'02'+SUBSTR(wNOM_CLI,1,38)+ Chr(13) + Chr(10)

**(Direccion Cliente)
texto=texto+'i'+'03'+SUBSTR(wDIR1_CLI,1,38)+ Chr(13)+ Chr(10) 
*texto=texto+'i'+'04'+SUBSTR(wDIR2_CLI,1,38)+ Chr(13)+ Chr(10) 

**(Ciudad y Estado)
*tex1=ALLTRIM(wciu_cli)+'-'+ALLTRIM(west_cli)
*texto=texto+'i'+'05'+SUBSTR(tex1,1,38) + Chr(13)+ Chr(10) 

**(Rif/C.I)
tex1='Rif/CI:'+ALLTRIM(WRIF_CLI)
tex2='Tlf.:'+ ALLTRIM(wTEL_CLI)
texto=texto+'i'+'04'+tex1+'  '+tex2+ Chr(13) + Chr(10)

**(Vendedor/Cajero)
texto=texto+'i'+'05'+'Vend.'+wNRO_VEN +Chr(13) + Chr(10)

texto=texto+'i'+'06'+'--------------------------------------' +Chr(13) + Chr(10)



**-----------------------------------------
**--Ciclo del Detalle Factura  
**-----------------------------------------
SCAN
  
	**---------------------------------------------------------------
	**//Pase de Variables
	**---------------------------------------------------------------
		STORE FPRECIO 			TO PVP_PRO
		STORE FCANTIDAD			TO CAN_PRO
		STORE FALICUOTA			TO POR_IMP
		STORE ALLTRIM(FDESCRIP)	TO DES_PRO
		STORE ALLTRIM(FCODIGO)	TO COD_PRO
			  
		pvp=TRANSFORM(PVP_PRO,'99999999.99')
		pvp=SUBSTR(pvp,1,8)+SUBSTR(pvp,10,2)
		le=LEN(ALLTRIM(pvp))
		pvp_f=SUBSTR('0000000000',1,10-le)+ALLTRIM(pvp)
		       
		can=TRANSFORM(can_PRO,'99999.999')
		can=SUBSTR(can,1,5)+SUBSTR(can,7,3)
		le=LEN(ALLTRIM(can))
		can_f=SUBSTR('00000000',1,8-le)+ALLTRIM(can)
    
		*!*	     IF can_pro=1
		*!*	        can2=ALLTRIM(TRANSFORM(can_PRO,'9999.99'))
		*!*	        pvp2=ALLTRIM(TRANSFORM(pvp_PRO,'9999999.99'))
		*!*	        texto=texto+'@'+can2 +' x ' + 'Bs '+pvp2+Chr(13) + Chr(10)
		*!*	     ENDIF    



	**---------------------------------------------------------------
	**//Tipo de Impuesto ('!' Imp. TASA 1) ('' Ex TASA 2) ( # TASA 3)
	**---------------------------------------------------------------
	
 	    DO CASE
 	    
 	 
	    CASE tipo_imp=1 	&& Tasa Imp 1
	    
	    	**Con Codigo 
	    	  *texto=texto+'!'+pvp_f+can_f+cod_pro+' '+SUBSTR(des_pro,1,38)+Chr(13) + Chr(10)

			**Sin Codigo 
	    	  texto=texto+'!'+pvp_f+can_f+' '+SUBSTR(des_pro,1,38)+Chr(13) + Chr(10)    
	    	  
	    	  *MESSAGEBOX(tipo_imp)

 	    CASE tipo_imp=2 .or. por_imp=0 .or. EMPTY(tipo_imp)		&& Tasa 2 Exento 
 	    
 	    	**Con Codigo
       		  *texto=texto+' '+pvp_f+can_f+cod_pro+' '+SUBSTR(des_pro,1,38)+Chr(13) + Chr(10)
	
			**Sin Codigo
       		  texto=texto+' '+pvp_f+can_f+' '+SUBSTR(des_pro,1,38)+Chr(13) + Chr(10)

	    	  *MESSAGEBOX(tipo_imp)
	    	 
		
 	    CASE tipo_imp=3  &&CASE por_imp=22	&& Tasa3  Imp 3
 	    
	    	**Con Codigo 
    	 	  *texto=texto+'#'+pvp_f+can_f+cod_pro+' '+SUBSTR(des_pro,1,38)+Chr(13) + Chr(10) 

			**Sin Codigo 
	    	  texto=texto+'#'+pvp_f+can_f+' '+SUBSTR(des_pro,1,38)+Chr(13) + Chr(10)    
    	 	

	    	  *MESSAGEBOX(tipo_imp)

	    CASE tipo_imp=4 	&& Tasa Imp 4 Iva al 10% por pagos electronicos
	    
	    	**Con Codigo 
	    	  *texto=texto+'"'+pvp_f+can_f+cod_pro+' '+SUBSTR(des_pro,1,38)+Chr(13) + Chr(10)

			**Sin Codigo 
	    	  texto=texto+'"'+pvp_f+can_f+' '+SUBSTR(des_pro,1,38)+Chr(13) + Chr(10)    
	    	  
	    	  *MESSAGEBOX(tipo_imp)
	    	  
    	ENDCASE

**--anterior
     
*!*	*!*		**---------------------------------------------------------------
*!*	*!*		**//Tipo de Impuesto ('' Ex TASA 2) ('!' Imp. TASA 1) ( # TASA 3)
*!*	*!*		**---------------------------------------------------------------
*!*	*!*	 	    DO CASE
*!*	*!*	 	    CASE por_imp=0 		&& Tasa Ex 
*!*	*!*	       		  texto=texto+' '+pvp_f+can_f+cod_pro+'   '+SUBSTR(des_pro,1,38)+Chr(13) + Chr(10)
*!*	*!*	       		  
*!*	*!*		    CASE por_imp>0 		&& Tasa Imp 1
*!*	*!*		    	 texto=texto+'!'+pvp_f+can_f+cod_pro+'   '+SUBSTR(des_pro,1,38)+Chr(13) + Chr(10)
*!*	*!*		    	 
*!*	*!*			*CASE por_imp=22	&& Tasa Imp 3
*!*	*!*	    	 	*texto=texto+'#'+pvp_f+can_f+nro_pro+'   '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10) 
*!*	*!*	    	 	
*!*	*!*	    	ENDCASE
*!*	*!*	 
	**-----------------------------------------------------
	**//Este comando permite imprimir mensajes comerciales 
	**//necesarios para la descripción de un artículo O SERIALES
	**-----------------------------------------------------
		**texto=texto+'@'+'sn:xxxxxxxxxxxxxxxxxxxxxxxxx'+Chr(13) + Chr(10)
   		texto=texto+'@'+'Cod :'+COD_pro+Chr(13) + Chr(10)

ENDSCAN


**--Descuento General
IF wdto>0

	dto_f=STR(wdto,6,2)
	dto_f=SUBSTR(dto_f,1,3)+SUBSTR(dto_f,5,2)
	le=LEN(ALLTRIM(dto_f))
	dto_f=SUBSTR('00000',1,4-le)+ALLTRIM(dto_f)

	**--SubTotal
	texto=texto+'3'+ Chr(13) + Chr(10)

	**--Calculo Descuento
	texto=texto+'p'+'-'+dto_f+ Chr(13) + Chr(10)

ENDIF


**----------------------------------------------------------
**--Mensajes al pie de factura
**----------------------------------------------------------

*-------orden de compra
    
*!*	    tex3=' '  
*!*		  IF wpla_fac>0
*!*		      wpla_fac=ALLTRIM(TRANSFORM(wpla_fac,'999'))
*!*		      tex3= 'Plazo : '+ wpla_fac +' dias'
*!*		      texto=texto+'@'+tex3+Chr(13) + Chr(10)
*!*		  ENDIF
*!*	  
*!*	      tex3=' '    
*!*		  IF !EMPTY(word_com)
*!*		      tex3= 'Nota de Entrega : '+ ALLTRIM(word_com) 
*!*		      texto=texto+'@'+tex3+Chr(13) + Chr(10)
*!*		  ENDIF
  
**texto=texto+'P'+'H'+'91'+'TELEFONOS:'+Chr(13) + Chr(10)
**--Lecuna Cars
	*texto=texto+'P'+'H'+'92'+'0212-576.1789'+Chr(13) + Chr(10)
	*texto=texto+'P'+'H'+'93'+' '+Chr(13) + Chr(10)
	*texto=texto+'P'+'H'+'94'+'e-mail: lecunacars2014@gmail.com'+Chr(13) + Chr(10)

**-Moto Cross Brake
	*texto=texto+'P'+'H'+'92'+' '+Chr(13) + Chr(10)
	*texto=texto+'P'+'H'+'93'+' '+Chr(13) + Chr(10)
	*texto=texto+'P'+'H'+'94'+'e-mail: motocrossbrake@hotmail.com'+Chr(13) + Chr(10)
	*texto=texto+'P'+'H'+'94'+'e-mail: invmgp162611@outlook.es'+Chr(13) + Chr(10)


**--anterior
*!*	**----------------------------------------------------------------------
*!*	**//Pago Directo Este comando permite cerrar una factura y asignar 
*!*	**//el monto total a un medio de pago. Abre la gaveta de dinero.
*!*	**//Validar forma de Pago segun tabla
*!*	**--'1'
*!*	**--01-04 efectivo
*!*	**--05-08 cheque
*!*	**--09-12 tarjeta1
*!*	**--13-16 tarjeta2
*!*	**----------------------------------------------------------------------
*!*	**texto=texto+'101'+Chr(13) + Chr(10)


**----------------------------------------------------------------------
**//Pago Directo Este comando permite cerrar una factura y asignar 
**//el monto total a un medio de pago. Abre la gaveta de dinero.
**//Validar forma de Pago segun tabla
**--'1'Pago Directo / '2' Medio de Pago
**--01-01 efectivo
**--02-02 cheque
**--03-03 tarjetaCredito
**--04-04 tarjetaDebito
**--05-05 Tickets Alimentacion
**--06-06 Transferencias
**--07-07 Otros
**----------------------------------------------------------------------
DO CASE 
	
	CASE  con_crd=1  && Contado

	
		SELECT nro,tpago,monto,banco,detalle,serie FROM FORCE cajapagos WHERE wNro_fac=Nro INTO CURSOR &temp_caj
	
	
	
		**-- VERIFICAR REGISTROS DE PAGOS
		IF RECCOUNT()<=0
			messagebox('Error en Registro, No Existe forma de Pago de Factura Nro. '+alltrim(STR(wnro)),0+64,'Atencion')
			RETURN
		ENDIF
	

		SCAN FOR NRO=wnro_fac
	
			**--Monto de Pago
			monto1=transform(monto,'9999999999.99') 
			monto2=SUBSTR(monto1,1,10)+SUBSTR(monto1,12,2)
			monto_f=Padl(alltr(monto2), 12,'0')
			**MESSAGEBOX(monto_f)
			
				
			**--Acumular y Clasificar Forma de Pago
			**--Medio de Pagos
			DO CASE 

				CASE tpago='EFE'
					texto=texto+'101'+Chr(13) + Chr(10)
					*texto=texto+'201'+monto_f+Chr(13) + Chr(10)
					
				CASE tpago='CHE'
					texto=texto+'102'+Chr(13) + Chr(10)
					*texto=texto+'202'+monto_f+Chr(13) + Chr(10)

*!*					CASE tpago='TAR'
*!*						texto=texto+'103'+Chr(13) + Chr(10)
*!*						*texto=texto+'203'+monto_f+Chr(13) + Chr(10)

				CASE tpago='TAC'
					texto=texto+'103'+Chr(13) + Chr(10)
					*texto=texto+'203'+monto_f+Chr(13) + Chr(10)

				CASE tpago='TAD' .or. tpago='TAR'
					texto=texto+'104'+Chr(13) + Chr(10)
					*texto=texto+'204'+monto_f+Chr(13) + Chr(10)

				CASE tpago='TIA'
					texto=texto+'105'+Chr(13) + Chr(10)
					*texto=texto+'205'+monto_f+Chr(13) + Chr(10)

				CASE tpago='TRA'
					texto=texto+'106'+Chr(13) + Chr(10)
					*texto=texto+'206'+monto_f+Chr(13) + Chr(10)

				CASE tpago='OTR' 
					texto=texto+'107'+Chr(13) + Chr(10)
					*texto=texto+'207'+monto_f+Chr(13) + Chr(10)

			ENDCASE
			
		ENDSCAN

	CASE  con_crd=2  && Credito
	
			texto=texto+'101'+Chr(13) + Chr(10)

ENDCASE

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
*!*	    warchivo='c:\fac_fis\output'+wnro+'.dat'
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
*!*	*--------cierro archivo   
*!*	  glcloseok1=Fclose(gntestfile1) 

*!*	*-------------------------
*!*	RETURN 


RETURN
