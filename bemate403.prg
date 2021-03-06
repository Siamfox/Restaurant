*********************************************************************************
**FUNCTION bemate40  &&  IMPRIME LAS FACTURAS DETAL \ EN PRINTER FISCAL BEMATECH*
*********************************************************************************

* Funciones del Cupon Fiscal   
DECLARE INTEGER Bematech_FI_AnulaCupon IN BemaFI32.DLL 
DECLARE INTEGER Bematech_FI_AbreCupon IN BemaFI32.DLL STRING @RIF 
DECLARE INTEGER Bematech_FI_AbreComprobanteDeVentaEx IN BemaFI32.DLL STRING, STRING, STRING  
DECLARE INTEGER Bematech_FI_VendeArticulo IN BemaFI32.DLL STRING, STRING, STRING, STRING, STRING , SHORT, STRING, STRING ,STRING  
DECLARE INTEGER Bematech_FI_VendeArticuloDepartamento IN BemaFI32.DLL STRING, STRING, STRING, STRING, STRING, STRING, STRING, STRING, STRING 
*DECLARE INTEGER Bematech_FI_AbreNotaDeCredito IN BemaFI32.DLL STRING Nombre STRING NumeroSerie STRING RIF STRING Dia STRING Mes STRING Ano STRING Hora STRING Minuto STRING Segundo STRING COO 
*DECLARE INTEGER Bematech_FI_DevolucionArticulo IN BemaFI32.DLL STRING Codigo STRING Descripcion STRING Alicuota STRING TipoCantidad STRING Cantidad INTEGER CasasDecimales STRING Valor STRING TipoDescuento STRING Descuento  
DECLARE INTEGER Bematech_FI_AnulaArticuloAnterior IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_AnulaArticuloGenerico IN BemaFI32.DLL STRING  
DECLARE INTEGER Bematech_FI_IniciaCierreCupon IN BemaFI32.DLL STRING , STRING ,STRING  
DECLARE INTEGER Bematech_FI_EfectuaFormaPago IN BemaFI32.DLL STRING ,STRING  
DECLARE INTEGER Bematech_FI_EfectuaFormaPagoDescripcionForma IN BemaFI32.DLL STRING, STRING , STRING  
DECLARE INTEGER Bematech_FI_FinalizarCierreCupon IN BemaFI32.DLL STRING  
DECLARE INTEGER Bematech_FI_CierraCupon IN BemaFI32.DLL STRING , STRING, STRING, STRING, STRING  
DECLARE INTEGER Bematech_FI_CierraCuponReducido IN BemaFI32.DLL STRING, STRING  
DECLARE INTEGER Bematech_FI_CancelaCupon IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_ExtenderDescripcionArticulo IN BemaFI32.DLL STRING  
DECLARE INTEGER Bematech_FI_UsaUnidadMedida IN BemaFI32.DLL STRING  
DECLARE INTEGER Bematech_FI_RectficaFormasPago IN BemaFI32.DLL STRING, STRING, STRING  

**// DECLARACION VARIABLES 
STORE 0  TO WTOT, WSTOT, WIVA, L,WDTO
STORE '' TO CDIR,CRIF,CNIT,CNOMBRE
STORE '' TO CCODIGO,CDESCRIP,PPRECIO,CCANTIDAD,CCANT_DEC,CALICUOTA
STORE '' TO CUNIFRA,CDESCUENTO,CUNIDAD,CSERIAL
STORE '' TO CCIUDAD,CESTADO
STORE '' TO CDES_ITE,CDES_GEN
STORE '' TO RUTA,RUTAI,RUTAF,letras
STORE '' TO CPAGO,CCPAGO,CCPAGO1,CCPAGO2,CCPAGO3
STORE '' TO CVPAGO1,CVPAGO2,CVPAGO3
STORE '' TO CNCHEQUE,CNTARJETA,CBANCO


**//*************Temporal******************************
TEMP2='TCAJ'+SUBSTR(ALLTRIM(ID()),1, (AT('#',ID())-2) )

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

**// INICIO DEL PROCESO (VERIFICACION DATOS FACTURAS Y REGISTROS)
**// VERIFICAR FACTURA Y DATOS DEL ENCABEZADO

SELECT 7 && FACTURAS MAESTRO
IF !LOCK1('FACTURA','C')
RETURN
ENDIF
SET INDEX TO FAC_NRO

SEEK WNRO
IF EOF()
   	WAIT WINDOWS "!!! ERROR !!! MAESTRO FACTURA->FACTURA LISTAR INCORRECTA '+STR(WNRO))..." nowait
   RETURN
ENDIF
***cRif=G->CLIENTE
WDTO=G->DTO  && DESCUENTO GENERAL GLOBAL


**// VERIFICAR REGISTROS DE LA FACTURA 
SELECT 8 &&REGISTROS FACTURAS
IF !LOCK1('FACREG','C')
RETURN
ENDIF
SET INDEX TO FAC_REG

**// BUSCAR REGISTROS
SEEK WNRO
IF EOF()
   WAIT WINDOWS'??? ERROR !!!(REGISTROS)-> FACTURA A LISTAR INCORRECTA...' nowait
   RETURN
ENDIF
  
**// GENERAR REPORTE FISCAL(ENCABEZADO,REGISTROS,ARCHIVO PLANO FISCAL)
DAT_CLI()              && DATOS DEL CLIENTE
DETA_FAC()             && DETALLE DE LA FACTURA
PRO_FIS()              && PROCESO FISCALIZACION

RETURN

************************************
FUNCTION DAT_CLI  && ENCABEZADO  *
************************************
**// PASE DATOS A VARIABLES DE TRABAJO

   SELECT 7 && MAESTRO FACTURAS
   SEEK WNRO

**// CONDICION DE PAGO
   IF PAGO=1 && 'C '
      CPAGO='CONTADO'
   ELSE
      CPAGO='CREDITO'
   ENDIF

**// FORMA DE PAGO
   **// PAGO REDUCIDO
   **IF FEFECTIVO>0
      CCPAGO='Efectivo'
   **ELSE
   **   IF FCHEQUE>0
   **      CCPAGO='Cheque'
   **  ELSE
   **      CCPAGO='Tarjeta'
   **   ENDIF
   **ENDIF

   **// PAGO EXTENDIDO
	*!*	   /*IF FEFECTIVO>0
	*!*	      CCPAGO1='Efectivo'
	*!*	      CVPAGO1=ALLTRIM(STR(FEFECTIVO))
	*!*	   ENDIF
	*!*	   IF FCHEQUE>0
	*!*	      CCPAGO2='Cheque'
	*!*	      CVPAGO2=ALLTRIM(STR(FCHEQUE))
	*!*	      CNCHEQUE=ALLTRIM(FNCHEQUE)
	*!*	      CBANCO=ALLTRIM(FBANCO)
	*!*	   ENDIF
	*!*	   IF FTARJETA>0
	*!*	      CCPAGO3='Tarjeta'
	*!*	      CVPAGO3=ALLTRIM(STR(FTARJETA))
	*!*	      CNTARJETA=ALLTRIM(FNTARJETA)
	*!*	      CBANCO=ALLTRIM(FBANCO)
	*!*	   ENDIF*/

**// NOMBRE CLIENTE
  SELECT 3  && CLIENTES
  IF !LOCK1('CLIENTE','C')
		RETURN
  ENDIF
  SET INDEX TO CLI_RIF

  SEEK UPPER(ALLTRIM(G->CLIENTE))
	
  IF !EOF()
	  CRIF=UPPER(ALLTRIM(G->CLIENTE))	
	  CNOMBRE=ALLTRIM(c->NOMBRE)  &&40
   ELSE
	  WAIT WINDOWS '??? ERROR !!! CLIENTE SIN REGISTRO FISCAL(RIF) o SIN RAZON SOCIAL(NOMBRE)' &&nowait
      RETURN
   ENDIF
              
**// DIRECCION, CIUDAD, ESTADO Y TELEFONO
   IF C->DIR1<>SPACE(45)  &&MAXIMO 133
      CDIR=ALLTRIM(C->DIR1)+' '+ALLTRIM(C->DIR2)+' '+;
           ALLTRIM(C->CIUDAD)+' '+ALLTRIM(C->ESTADO)+' '+ALLTRIM(C->TELEFONOS)
      IF LEN(CDIR)>133
         CDIR=SUBSTR(CDIR,1,133)
         WAIT WINDOWS '??? ERROR !!! MAXIMO VALOR EN LONGITUD DIRECCION FISCAL ' &&nowait
      ENDIF
   ELSE
      WAIT WINDOWS '??? ERROR !!! CLIENTE SIN DIRECCION FISCAL (DIRECCION) ' &&nowait
      RETURN
   ENDIF

**// CEDULA/RIF/NIT
 *  IF G->RIF<>SPACE(15) && .OR. FNIT<>SPACE(15)
 *     CRIF=ALLTRIM(G->RIF)
      **CNIT=ALLTRIM(FNIT)
 *  ELSE
 *     WAIT WINDOWS '??? ERROR !!! CLIENTE SIN REGISTRO FISCAL(RIF) ' &&nowait
 *     RETURN
 *  ENDIF

**// CTROL DESCUENTO GENERAL
   WDTO=G->DTO  &&DESCUENTO GENERAL GLOBAL

RETURN

*****************************************************************
FUNCTION DETA_FAC     && IMPRESION DETALLADA DE ITEM  
*****************************************************************
DO WHILE .T.
   STORE '' TO CDES_ITE,CDES_GEN,CSERIAL

   SELECT 8 && **// (REGISTRO FACTURAS)
	**// CAPTURA DE DATOS REGISTRO PARA DATOS VARIABLES FISCALES

	**// CODIGO
	   CCODIGO=SUBSTR(ALLTRIM(CODIGO),1,13)

	**// DESCRIPCION
	   CDESCRIP=SUBSTR(ALLTRIM(DESCRIP),1,29)   &&29

	**// ALICUOTA 
	   CALICUOTA=padl (ALLTRIM (STR (alicuota,5,2)), 5, '0')
	   *CALICUOTA=TRANSFORM(ALICUOTA,'@99,99') &&STRZERO(ALICUOTA)
	   IF ALICUOTA=0 && PRODUCTOS EXENTOS
	      CALICUOTA='II'  
	      *CALICUOTA="02"
	     ** CALICUOTA='00.00'
	      CDESCRIP=SUBSTR(ALLTRIM(DESCRIP),1,27)+'*'    &&CDESRIP+'*'
	   ENDIF

	**// CANTIDAD Y UNIDAD DE VENTA FRACIONADA O ENTERA (DECIMALES PARA LA CANTIDAD)
	   VALOR=CANTIDAD
	   IF INT((VALOR/2)*2)==CANTIDAD  && INTEGER
	      CCANTIDAD=ALLTRIM(STR(INT(CANTIDAD)))
	      CUNIFRA='I'
	      CUNIDAD='UN'
	      CCANT_DEC=2 && '2'
	   ELSE
	      CCANTIDAD=ALLTRIM(STR(cantidad,7,3))
	      CUNIFRA='F'
	      CCANT_DEC=3 &&'3'
	      STORE SUBSTR(UNIDAD,1,2) TO CUNIDAD
	   ENDIF

	**// PRECIO
	**// NOTA SE PASA EL PRECIO Y EL PRINTER CALCULA EL IMPUESTO
	   IF xV01=.T. && PRECIO CON IMPUESTO INCLUIDO
	      IF CUNIFRA='I'
	         PPRECIO=ALLTRIM(STR(PRECIO/(1+ALICUOTA*.01),9,2))
	      ELSE
	         PPRECIO=ALLTRIM(STR(PRECIO,9,2))
	      ENDIF

	      **// DESCUENTO POR ITEM
	         CDES_ITE=PRECIO*CANTIDAD*DSCTO*.01
	         CDES_GEN=(PRECIO-CDES_ITE)*CANTIDAD*WDTO*.01
	         CDESCUENTO=ALLTRIM(STR(CDES_ITE+CDES_GEN))
	   ELSE           // PRECIO MAS IMPUESTO
	      IF CUNIFRA='I'
	         PPRECIO=ALLTRIM(STR(PRECIO,9,2))
	      ELSE
	         PPRECIO=ALLTRIM(STR(PRECIO,9,2))
	      ENDIF
	      **// DESCUENTO POR ITEM
	         CDES_ITE=PRECIO*CANTIDAD*DSCTO*.01
	         CDES_GEN=(PRECIO-CDES_ITE)*CANTIDAD*WDTO*.01
	         CDESCUENTO=ALLTRIM(STR(CDES_ITE+CDES_GEN,6,2))
	   ENDIF

	**// SERIAL ARTICULOS
	   **IF CARTSERIAL='S'
	      *IF D->FSERIAL<>''
	         CSERIAL='S/N:'+ALLTRIM(h->SERIAL)
	      *ELSE
	      *   CSERIAL=''
	      *ENDIF
	  ** ENDIF

	   DET_FISCO()  && CREAR DETALLE FISCAL

           SELECT 8 && REGISTROS FACTURAS
	   SKIP

	   IF WNRO<>NRO .OR. EOF()
	      RETURN
	   ENDIF EOF

ENDDO
RETURN


**************************************************************
FUNCTION TEMFISCO  && CREAR TEMPORAL IMPRESION FISCAL
**************************************************************
WAIT WINDOWS "Creando Temporales..." nowait

IF FILE('&temp2'+'.dbf')
	DELETE FILE &temp2
ENDIF


**// CREACION ESTRUCTURA NUEVA CON LOS DATOS FISCALES
CREATE TABLE &temp2 ;
	(FCODIGO    C(13,0),;  && CAMPO  1 CODIGO ART.
   	 FDESCRIP   C(50,0),;  && CAMPO  2 DESCRIPCION ART.
 	 FALICUOTA  C(5,0),;   && CAMPO  3 ALICUOTA ART.
	 FUNIFRA    C(1,0),;   && CAMPO  4 TIPO CANTIDAD (I)ENTERO (F)RACCION
	 FCANTIDAD  C(8,0),;   && CAMPO  5 CANTIDAD ART(S)
	 FCANT_DEC  n(1,0),;   && CAMPO  6 CANTIDAD DECIMALES PRECIO UNITARIO ART
	 FPRECIO	C(9,0),;   && CAMPO  7 PRECIO VALOR UNITARIO
	 FTIPO_DES  C(1,0),;   && CAMPO  8 TIPO DESCUENTO VALOR O PORCENTAJE
	 FDESCUENTO C(8,0),;   && CAMPO  9 VALOR DEL DESCUENTO
	 FUNIDAD    C(2,0),;   && CAMPO 10 UNIDAD DE MEDIDA ART.
	 FSERIAL    C(40,0))   && CAMPO 11 SERIAL ART.
	 
	 CLOSE DATABASES all
	 WAIT WINDOWS "Temporal Finalizado..." nowait
	
RETURN


*********************************************************
FUNCTION DET_FISCO && CREAR DETALLE DEL REPORTE FISCAL
*********************************************************
SELECT 11
FLOCK()
APPEND BLANK

REPLACE FCODIGO    WITH  CCODIGO    && CAMPO  1 CODIGO ART.
REPLACE FDESCRIP   WITH  CDESCRIP   && CAMPO  2 DESCRIPCION ART.
REPLACE FALICUOTA  WITH  CALICUOTA  && CAMPO  3 ALICUOTA ART.
REPLACE FUNIFRA    WITH  CUNIFRA    && CAMPO  4 T/CANTIDAD (I)ENTERO (F)RACCION
REPLACE FCANTIDAD  WITH  CCANTIDAD  && CAMPO  5 CANTIDAD ART(S)
REPLACE FCANT_DEC  WITH  CCANT_DEC  && CAMPO  6 CANTIDAD DECIMALES PRECIO UNITARIO ART
REPLACE FPRECIO    WITH  PPRECIO    && CAMPO  7 PRECIO VALOR UNITARIO
REPLACE FTIPO_DES  WITH  '$'        && CAMPO  8 TIPO DESCUENTO ($)VALOR O (%)PORCENTAJE
REPLACE FDESCUENTO WITH  CDESCUENTO && CAMPO  9 VALOR DEL DESCUENTO
REPLACE FUNIDAD    WITH  CUNIDAD    && CAMPO 10 UNIDAD DE MEDIDA
REPLACE FSERIAL    WITH  CSERIAL    && CAMPO 11 SERIAL DEL ARTICULO

UNLOCK
RETURN

****************************************************************
FUNCTION PRO_FIS    && PROCESO IMPRESION FISCAL HACIA AL MONITOR
****************************************************************
**// FORMATO DEL COMANDO FISCAL
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


**//Secuencias de la Impresion Fiscal 32bits

*!*	iRetorno=Bematech_FI_VerificaImpresoraPrendida() 
*!*	iRetorno=Bematech_FI_AnulaCupon()
*!*	iRetorno=Bematech_FI_AbreComprobantedeVentaEx() 
*!*	iRetorno=Bematech_FI_ExtenderDescripcionArticulo()
*!*	iRetorno=Bematech_FI_VendeArticulo()
*!*	iRetorno=Bematech_FI_IniciaCierreCupon() 
*!*	iRetorno=Bematech_FI_EfectuaFormaPago()
*!*	iRetorno=Bematech_FI_FinalizarCierreCupon()
*!*	iRetorno=Bematech_FI_AccionaGaveta()

*!*	iRetorno=Bematech_FI_CierraCuponReducido()




**//Verificar Printer Encendida
*!*	iRetorno=Bematech_FI_VerificaImpresoraPrendida()

*!*	IF iRetorno=1
*!*		WAIT WINDOWS "Printer Encendido..."  &&NOWAIT 
*!*	ELSE
*!*		WAIT WINDOWS "Printer Apagado..."  
*!*		RETURN
*!*	ENDIF

**//Anula Cupon Anterior
iRetorno=Bematech_FI_AnulaCupon()
IF iRetorno=1
	WAIT WINDOWS "Anulando Cupon Anterior" &&nowait
ENDIF
	

**//Abrir Cupon Extendido (Encabezado)
iRetorno=Bematech_FI_AbreComprobantedeVentaEx(cRif,cNombre,cDir) 


**//Detalle Impresion Fiscal
SELECT 11
GO TOP

*!*	CITEMLARGO='S'
*!*	CITEMCOD='S'

DO WHILE !EOF()

	**//Activar Descripcion Extendida
	****iRetorno=Bematech_FI_ExtenderDescripcionArticulo(FDESCRIP+' '+ALLTRIM(FSERIAL)) 
	
	**//Venta Articulo
	*iRetorno = Bematech_FI_VendeArticulo( alltrim(fCodigo), SUBSTR(fDescrip,1,4), falicuota, Funifra, alltrim(fcantidad), VAL(fcant_dec), fprecio, ftipo_des, fdescuento )
DECLARE INTEGER Bematech_FI_VendeArticulo IN BemaFI32.DLL STRING, STRING, STRING, STRING, STRING , SHORT, STRING, STRING ,STRING  
iRetorno = Bematech_FI_VendeArticulo( alltrim(fCodigo), ALLTRIM(fDescrip), falicuota, Funifra, alltrim(fcantidad), fcant_dec, fprecio, ftipo_des, fdescuento )

	IF iRetorno<>1
		DO CASE 
			CASE iRetorno= 0
				WAIT WINDOWS 'Error de comunicaci?n'
				return
			CASE iRetorno=1
				WAIT WINDOWS 'OK' &&NO WAIT 
			CASE iRetorno=-2
				WAIT WINDOWS '-2: Par?metro inv?lido en la funci?n'
				return
			CASE iRetorno=-3
				WAIT WINDOWS 'Al?cuota no programada'
				return
			CASE iRetorno=-4
				WAIT WINDOWS '-4: El archivo de inicializaci?n BemaFI32.ini no fue encontrado en el directorio de sistema del Windows' 
				return
			CASE iRetorno=-5
				WAIT WINDOWS '-5: Error al abrir la puerto de comunicaci?n'
				return
		ENDCASE
	ENDIF

   SKIP +1
ENDDO

**//Cierre Cupon Reducido
**//FORMA DE PAGO REDUCIDO (1) SOLO PAGO
iRetorno=Bematech_FI_CierraCuponReducido(CCPAGO,CPAGO+"|Op# "+TRANSFORM(WNRO,"9999999")+"|Gracias, vuelva siempre !!!")  


**//Otra Forma de Cierre

**//Inicia Cierre Cupon
**okiRetorno = Bematech_FI_IniciaCierreCupon("A","%","0000") 

**IF iRetorno=1
**    WAIT WINDOWS '!!! Inicia CierreCupon !!!!--OK' nowait
**ENDIF


**//Forma de Pago
***OKiRetorno = Bematech_FI_EfectuaFormaPago(ccpago,"500")

**// Finaliza Cierre Cupon
**okiRetorno = Bematech_FI_FinalizarCierreCupon("Op# "+str(WNRO)+"!!! Gracias, vuelva siempre !!!")



**//Verificar Estado de la Gaveta
*!*	iRetorno = Bematech_FI_VerificaEstadoGaveta(@Estado)

*!*	if Estado = 0
*!*		MessageBox("Gaveta Cerrada")
*!*	else
*!*		MessageBox("Gaveta Abierta")
*!*	endif

*!*	**// ABRIR GAVETA 
** Variable memoria de gaveta
*!*	iRetorno = Bematech_FI_AccionaGaveta()

*!*	IF iRetorno=1
*!*	    WAIT WINDOWS '??? Ok !!! Abrir Gaveta' nowait
*!*	ENDIF




RETURN
