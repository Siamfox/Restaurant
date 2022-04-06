*********************************************************************************
**FUNCTION epson40 220 &&  IMPRIME LAS FACTURAS DETAL \ EN PRINTER FISCAL EPSON *
*********************************************************************************

**---------------------------------------------------------------
**// DECLARACION VARIABLES 
**---------------------------------------------------------------
STORE 0  TO WTOT, WSTOT, WIVA, L,WDTO,CCANT_DEC
STORE '' TO CDIR1,CDIR2,CRIF,CNIT,CNOMBRE
STORE '' TO CCODIGO,CDESCRIP,PPRECIO,CCANTIDAD,CALICUOTA
STORE '' TO CUNIFRA,CDESCUENTO,CUNIDAD,CSERIAL
STORE '' TO CCIUDAD,CESTADO,CTELEF
STORE '' TO CDES_ITE,CDES_GEN
STORE '' TO RUTA,RUTAI,RUTAF,letras
STORE '' TO CPAGO,CCPAGO,CCPAGO1,CCPAGO2,CCPAGO3
STORE '' TO CVPAGO1,CVPAGO2,CVPAGO3
STORE '' TO CNCHEQUE,CNTARJETA,CBANCO


**---------------------------------------------------------------
**//Crear Temporal
TEMP2='TCAJ'+SUBSTR(ALLTRIM(ID()),1, (AT('#',ID())-2) )
**---------------------------------------------------------------

IF LEN(temp2)>12 
	messagebox('Nombre-Estacion, demasiado largo...'+CHR(13)+'Debe Cambiar o participar al Administrador de la Red',0+64,'Atencion...')
	RETURN
ENDIF

*----------------------------------------------------------------
**//Nro Factura a Imprimir
*----------------------------------------------------------------
WNRO=WFACTURA

**// GENERAR TEMPORAL
TEMFISCO()

SELECT 11
IF !LOCK1('&TEMP2','C')
    RETURN
ENDIF

**---------------------------------------------------------------
**// INICIO DEL PROCESO (VERIFICACION DATOS FACTURAS Y REGISTROS)
**// VERIFICAR FACTURA Y DATOS DEL ENCABEZADO
**---------------------------------------------------------------

**---------------------------------------------------------------
**//Apertura de Tablas necesarias segun estacion
**---------------------------------------------------------------
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

**---------------------------------------------------
**//Validar Factura y Registros
**---------------------------------------------------
**// Buscar Nro Factura
SEEK WNRO
IF EOF()
   	WAIT WINDOWS "!!! ERROR !!! MAESTRO FACTURA->FACTURA LISTAR INCORRECTA '+STR(WNRO))..." nowait
   RETURN
ENDIF


**// VERIFICAR REGISTROS DE LA FACTURA 
SELECT 8 &&REGISTROS FACTURAS
IF !LOCK1('&REGISTROS','C')
RETURN
ENDIF
SET INDEX TO &IND_II

**// BUSCAR REGISTROS
SEEK WNRO
IF EOF()
   WAIT WINDOWS'ннн ERROR !!!(REGISTROS)-> FACTURA A LISTAR INCORRECTA...' nowait
   RETURN
ENDIF
  
**--------------------------------------------------------------------
**// PROCESO REPORTE FISCAL(ENCABEZADO,REGISTROS,ARCHIVO PLANO FISCAL)
**--------------------------------------------------------------------
DAT_CLI()		&& DATOS DEL CLIENTE
DETA_FAC()		&& DETALLE DE LA FACTURA
PRO_FIS()    	&& PROCESO IMPRESION FISCAL

RETURN

**---------------------------------------------------------------
FUNCTION DAT_CLI  && ENCABEZADO DE LA FACTURA *
**---------------------------------------------------------------
**// Buscar Nro Factura
SELECT 7 && MAESTRO FACTURAS
SEEK WNRO

**---------------------------------------------------------------
**// CONDICION DE PAGO
**---------------------------------------------------------------
IF PAGO=1 && 'C '
  	CPAGO='CONTADO'
ELSE
	CPAGO='CREDITO'
ENDIF

**---------------------------------------------------------------
**// FORMA DE PAGO
**---------------------------------------------------------------
**// PAGO REDUCIDO
**IF FEFECTIVO>0
  *    CCPAGO='Efectivo'
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

**---------------------------------------------------------------
**// NOMBRE CLIENTE
**---------------------------------------------------------------
SELECT 3  && CLIENTES
IF !LOCK1('CLIENTE','C')
	RETURN
ENDIF
SET INDEX TO CLI_RIF

SEEK UPPER(ALLTRIM(G->CLIENTE))
	
IF !EOF()
	 CRIF=UPPER(G->juridico)+'-'+UPPER(ALLTRIM(G->CLIENTE))	
	 CNOMBRE=SUBSTR(c->NOMBRE,1,40) &&40

	**CRIF=UPPER(ALLTRIM(G->CLIENTE))	
	**CNOMBRE=SUBSTR(c->NOMBRE,1,40) 
	CTELEF=ALLTRIM(C->TELEFONOS)
ELSE
	WAIT WINDOWS 'ннн ERROR !!! CLIENTE SIN REGISTRO FISCAL(RIF) o SIN RAZON SOCIAL(NOMBRE)' &&nowait
	RETURN
ENDIF
              
**---------------------------------------------------------------
**// DIRECCION, CIUDAD, ESTADO Y TELEFONO
**---------------------------------------------------------------
IF C->DIR1<>SPACE(40)  &&MAXIMO 40
     CDIR1=ALLTRIM(C->DIR1)
     CDIR2=ALLTRIM(C->DIR2)
     IF LEN(CDIR1)>40 OR LEN(CDIR2)>40
        *CDIR=SUBSTR(CDIR,1,40)
        WAIT WINDOWS 'ннн ERROR !!! MAXIMO VALOR EN LONGITUD DIRECCION FISCAL ' &&nowait
     ENDIF
ELSE
     WAIT WINDOWS 'ннн ERROR !!! CLIENTE SIN DIRECCION FISCAL (DIRECCION) ' &&nowait
     RETURN
ENDIF

**---------------------------------------------------------------
**// CTROL DESCUENTO GENERAL
**---------------------------------------------------------------
WDTO=G->DTO  &&DESCUENTO GENERAL GLOBAL

RETURN

**---------------------------------------------------------------
FUNCTION DETA_FAC     && DETALLADA DEL ITEM  
**---------------------------------------------------------------
DO WHILE .T.
   STORE '' TO CDES_ITE,CDES_GEN,CSERIAL

   SELECT 8 && **// (REGISTRO FACTURAS)

	   CCODIGO=SUBSTR(ALLTRIM(CODIGO),1,15)
	   CDESCRIP=SUBSTR(ALLTRIM(DESCRIP),1,38)   
	   CDESCRIP2=SUBSTR(ALLTRIM(REFERENCIA),1,38)   
	   CALICUOTA=padl (ALLTRIM (STR (alicuota,5,2)), 5, '0')
	   *TRANSFORM(ALICUOTA,'@ l 99,99') &&STRZERO(ALICUOTA)
	   CCANTIDAD=ALLTRIM(STR(CANTIDAD,7,3))

	   IF xV01=.T. && PRECIO CON IMPUESTO INCLUIDO
	         PPRECIO=ALLTRIM(STR(PRECIO/(1+ALICUOTA*.01),8,2))
	
	      **// DESCUENTO POR ITEM
	         CDES_ITE=PRECIO*CANTIDAD*DSCTO*.01
	         CDES_GEN=(PRECIO-CDES_ITE)*CANTIDAD*WDTO*.01
	         CDESCUENTO=ALLTRIM(STR(CDES_ITE+CDES_GEN))

	   ELSE           // PRECIO MAS IMPUESTO
	   
	        PPRECIO=ALLTRIM(STR(PRECIO,8,2))
	
	      **// DESCUENTO POR ITEM
	         CDES_ITE=PRECIO*CANTIDAD*DSCTO*.01
	         CDES_GEN=(PRECIO-CDES_ITE)*CANTIDAD*WDTO*.01
	         CDESCUENTO=ALLTRIM(STR(CDES_ITE+CDES_GEN,6,2))

	   ENDIF

	**// SERIAL ARTICULOS
	   **IF CARTSERIAL='S'
	      *IF D->FSERIAL<>''
	         **CSERIAL='S/N:'+ALLTRIM(h->SERIAL)
	         CSERIAL='...'+ALLTRIM(h->SERIAL)
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
   	 FDESCRIP   C(50,0),;  && CAMPO  2 DESCRIPCION ART.
   	 FDESCRIP2  C(50,0),;  && CAMPO  2 DESCRIPCION ART.
 	 FALICUOTA  C(5,0),;   && CAMPO  3 ALICUOTA ART.
	 FCANTIDAD  C(8,0),;   && CAMPO  5 CANTIDAD ART(S)
	 FPRECIO	C(8,0),;   && CAMPO  7 PRECIO VALOR UNITARIO
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
SELECT 11
FLOCK()
APPEND BLANK

REPLACE FCODIGO    WITH  CCODIGO    && CAMPO  1 CODIGO ART.
REPLACE FDESCRIP   WITH  CDESCRIP   && CAMPO  2 DESCRIPCION ART.
REPLACE FDESCRIP2  WITH  CDESCRIP2  && CAMPO  2 SERIALES/REFERENCIAS
REPLACE FALICUOTA  WITH  CALICUOTA  && CAMPO  3 ALICUOTA ART.
REPLACE FCANTIDAD  WITH  CCANTIDAD  && CAMPO  5 CANTIDAD ART(S)
REPLACE FPRECIO    WITH  PPRECIO    && CAMPO  7 PRECIO VALOR UNITARIO
REPLACE FDESCUENTO WITH  CDESCUENTO && CAMPO  9 VALOR DEL DESCUENTO
REPLACE FUNIDAD    WITH  CUNIDAD    && CAMPO 10 UNIDAD DE MEDIDA
REPLACE FSERIAL    WITH  CSERIAL    && CAMPO 11 SERIAL DEL ARTICULO

UNLOCK
RETURN


**---------------------------------------------------------------
FUNCTION PRO_FIS()    && PROCESO IMPRESION FISCAL
**---------------------------------------------------------------

mtotal=0

m.cabecera=+;
'FACTURA   : '+STR(WNRO)+ CHR(13)+CHR(10)+;
'NOMBRE    : '+LEFT(ALLTRIM(cnombre), 38)+ CHR(13)+CHR(10)+;
'DIRECCION1: '+LEFT(ALLTRIM(cDIR1), 38)+ CHR(13)+CHR(10)+;
'DIRECCION2: '+LEFT(ALLTRIM(cDIR2), 38)+ CHR(13)+CHR(10)+;
'RIF       : '+LEFT(ALLTRIM(crif), 18)+ CHR(13)+CHR(10)+;     
'TELEFONO  : '+LEFT(ALLTRIM(ctelef), 25)+ CHR(13)+CHR(10)+; 
'DESCRIPCION                           |CODIGO          |CANTIDAD|%IVA |PREC/UNITA|'+ CHR(13)+CHR(10)

SELECT 11
GO TOP

m.renglones=ALLTRIM(m.cabecera)
DO WHILE !EOF() 

      m.renglones=ALLTRIM(m.renglones)+CHR(13)+CHR(10)+LEFT(ALLTRIM(fdescrip)+SPACE(38), 38)+'|'+LEFT(ALLTRIM(fcodigo)+SPACE(16), 16)+'|'+ ;
      RIGHT(SPACE(8)+ALLTRIM(fcantidad), 8)+'|'+RIGHT(SPACE(5)+ALLTRIM(falicuota), 5)+'|'+RIGHT(SPACE(10)+ALLTRIM(fprecio), 10)

		mtotal=mtotal+VAL(fcantidad)*VAL(fprecio)*(1+VAL(falicuota)*.01)
		
      *INSERTAR UNA LINEA DE DESCRIPCION SECUNDARIA O SERIALES 
      IF !EMPTY(ALLTRIM(fdescrip2))
            m.renglones=ALLTRIM(m.renglones)+CHR(13)+CHR(10)+LEFT(ALLTRIM(fdescrip2)+SPACE(38), 38)+'|'+LEFT(SPACE(16), 16)+'|'+ ;
            RIGHT(SPACE(8)+ALLTRIM('1.000'), 8)+'|'+RIGHT(SPACE(5)+ALLTRIM('0.00'), 5)+'|'+RIGHT(SPACE(10)+ALLTRIM('0.00'), 10)
      ENDIF
 
   SKIP +1
   LOOP
   EXIT  

ENDDO

wdto=ALLTRIM(STR(wdto,5,2))
mtotal=ALLTRIM(STR(mtotal,10,2))
EFECTIVO=ALLTRIM(mtotal)

*!*	CHEQUE='0,00'
*!*	TARJETA='0,00'
*!*	CREDITO='0,00' 
commt1='Gracias por su compra...' 
commt2='No se Aceptan DEVOLUCIONES'
commt3='Registro Nro. '+ALLTRIM(STR(wnro))
commt4='' 			&&un comentario de 38 a 50 chr'

CHEQUE=''
TARJETA=''
CREDITO=''
factdev='' 
fechdev='' 
horadev='' 
coob=''  


m.textofactura=ALLTRIM(m.renglones)+CHR(13)+CHR(10)+ ;
'DESCUENTO :'+RIGHT(SPACE(13)+ALLTRIM(wdto), 13)+ '%'+CHR(13)+CHR(10)+;   
'TOTAL     :'+RIGHT(SPACE(13)+ALLTRIM(mtotal), 13)+ CHR(13)+CHR(10)+;
'EFECTIVO  :'+RIGHT(SPACE(13)+ALLTRIM(EFECTIVO), 13)+ CHR(13)+CHR(10)+;
'CHEQUE    :'+RIGHT(SPACE(13)+ALLTRIM(CHEQUE), 13)+ CHR(13)+CHR(10)+;
'TARJETA   :'+RIGHT(SPACE(13)+ALLTRIM(TARJETA), 13)+ CHR(13)+CHR(10)+; 
'CREDITO   :'+RIGHT(SPACE(13)+ALLTRIM(CREDITO), 13)+ CHR(13)+CHR(10)+;
'COMentario1:|'+LEFT(ALLTRIM(commt1), 38)+ CHR(13)+CHR(10)+; 
'COMentario2:|'+LEFT(ALLTRIM(commt2), 38)+ CHR(13)+CHR(10)+; 
'COMentario3:|'+LEFT(ALLTRIM(commt3), 38)+ CHR(13)+CHR(10)+;
'COMentario4:|'+LEFT(ALLTRIM(commt4), 38)+ CHR(13)+CHR(10)
*'FACTDEVOL:  |'+LEFT(ALLTRIM(factdev), 38)+ CHR(13)+CHR(10)+; 
*'FECHADEVOL: |'+LEFT(ALLTRIM(fechdev), 38)+ CHR(13)+CHR(10)+; 
*'HORADEVOL:  |'+LEFT(ALLTRIM(horadev), 38)+ CHR(13)+CHR(10)+; 
*'COO-BEMATEC:|'+LEFT(ALLTRIM(coob), 38)  


**//Crear el texto
SET SAFETY OFF
CLEAR

m.archivofinal='C:\FACTURAS\siamfox.001'
=STRTOFILE(ALLTRIM(textofactura), archivofinal)  

SET SAFETY ON

RETURN
