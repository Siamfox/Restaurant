*******************************************************************************
FUNCTION bemate40  &&  IMPRIME LAS FACTURAS DETAL \ EN PRINTER FISCAL BEMATECH*
*******************************************************************************
* Funciones de Inicialización   

DECLARE INTEGER Bematech_FI_CambiaSimboloMoneda IN BemaFI32.DLL STRING  
DECLARE INTEGER Bematech_FI_ProgramaAlicuota IN BemaFI32.DLL STRING, INTEGER   
DECLARE INTEGER Bematech_FI_ProgramaHorarioVerano IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_NomeiaTotalizadorSinIcms IN BemaFI32.DLL INTEGER, STRING  
DECLARE INTEGER Bematech_FI_ProgramaRedondeo  IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_ProgramaTruncamiento IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_CrearDepartamento IN BemaFI32.DLL INTEGER, STRING  
DECLARE INTEGER Bematech_FI_LineasEntreCupones IN BemaFI32.DLL INTEGER  
DECLARE INTEGER Bematech_FI_EspacioEntreLineas IN BemaFI32.DLL INTEGER  
DECLARE INTEGER Bematech_FI_FuerzaImpactoAgujas IN BemaFI32.DLL INTEGER  
DECLARE INTEGER Bematech_FI_ResetaImpresora IN BemaFI32.DLL  

* Funciones del Cupon Fiscal   

DECLARE INTEGER Bematech_FI_AbreCupon IN BemaFI32.DLL STRING @RIF 
DECLARE INTEGER Bematech_FI_AbreComprobanteDeVentaEx IN BemaFI32.DLL STRING RIF STRING NOMBRE STRING DIRECCION  
DECLARE INTEGER Bematech_FI_VendeArticulo IN BemaFI32.DLL STRING, STRING, STRING, STRING, STRING , short, STRING, STRING ,STRING  
DECLARE INTEGER Bematech_FI_VendeArticuloDepartamento IN BemaFI32.DLL STRING, STRING, STRING, STRING, STRING, STRING, STRING, STRING, STRING 
DECLARE INTEGER Bematech_FI_AbreNotaDeCredito IN BemaFI32.DLL STRING Nombre STRING NumeroSerie STRING RIF STRING Dia STRING Mes STRING Ano STRING Hora STRING Minuto STRING Segundo STRING COO 
DECLARE INTEGER Bematech_FI_DevolucionArticulo IN BemaFI32.DLL STRING Codigo STRING Descripcion STRING Alicuota STRING TipoCantidad STRING Cantidad INTEGER CasasDecimales 
STRING Valor STRING TipoDescuento STRING Descuento  
DECLARE INTEGER Bematech_FI_AnulaArticuloAnterior IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_AnulaArticuloGenerico IN BemaFI32.DLL STRING  
DECLARE INTEGER Bematech_FI_IniciaCierreCupon IN BemaFI32.DLL STRING , STRING ,STRING  
DECLARE INTEGER Bematech_FI_EfectuaFormaPago IN BemaFI32.DLL STRING ,STRING  
DECLARE INTEGER Bematech_FI_EfectuaFormaPagoDescripcionForma IN BemaFI32.DLL STRING, STRING , STRING  
DECLARE INTEGER Bematech_FI_FinalizarCierreCupon IN BemaFI32.DLL STRING  
DECLARE INTEGER Bematech_FI_CierraCupon IN BemaFI32.DLL STRING , STRING, STRING, STRING, STRING  
DECLARE INTEGER Bematech_FI_CierraCuponReducido IN BemaFI32.DLL STRING, STRING  
DECLARE INTEGER Bematech_FI_CancelaCupon IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_ExternderDescripcionArticulo IN BemaFI32.DLL STRING  
DECLARE INTEGER Bematech_FI_UsaUnidadMedida IN BemaFI32.DLL STRING  
DECLARE INTEGER Bematech_FI_RectficaFormasPago IN BemaFI32.DLL STRING, STRING, STRING  

* Funciones de los Informes Fiscales   

DECLARE INTEGER Bematech_FI_ReduccionZ IN BemaFI32.DLL STRING, STRING  
DECLARE INTEGER Bematech_FI_LecturaX IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_LecturaXSerial IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_LecturaMemoriaFiscalFecha IN BemaFI32.DLL STRING, STRING  
DECLARE INTEGER Bematech_FI_LecturaMemoriaFiscalReduccion IN BemaFI32.DLL STRING, STRING  
DECLARE INTEGER Bematech_FI_LecturaMemoriaFiscalSerialFecha IN BemaFI32.DLL STRING, STRING  
DECLARE INTEGER Bematech_FI_LecturaMemoriaFiscalSerialReduccion IN BemaFI32.DLL STRING, STRING  

* Funciones de Operaciones No Fiscales   

DECLARE INTEGER Bematech_FI_InformeGerencial IN BemaFI32.DLL STRING   
DECLARE INTEGER Bematech_FI_InformeGerencialTEF IN BemaFI32.DLL STRING  
DECLARE INTEGER Bematech_FI_CierraInformeGerencial IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_RecebimentoNoFiscal IN BemaFI32.DLL STRING, STRING, STRING  
DECLARE INTEGER Bematech_FI_AbreComprobanteNoFiscalVinculado IN BemaFI32.DLL STRING, STRING, STRING  
DECLARE INTEGER Bematech_FI_UsaComprobanteNoFiscalVinculado IN BemaFI32.DLL STRING   
DECLARE INTEGER Bematech_FI_UsaComprobanteNboFiscalVinculadoTEF IN BemaFI32.DLL STRING  
DECLARE INTEGER Bematech_FI_CierraComprobanteNoFiscalVinculado IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_Sangria IN BemaFI32.DLL STRING  
DECLARE INTEGER Bematech_FI_Provision IN BemaFI32.DLL STRING, STRING  

* Funciones de informaciones da impresora   

DECLARE INTEGER Bematech_FI_VerificaEstadoImpresora IN BemaFI32.DLL INTEGER @n_ack, INTEGER @n_st1, INTEGER @n_st2   
DECLARE INTEGER Bematech_FI_RetornoAlicuotas IN BemaFI32.DLL STRING @ alicuotas   
DECLARE INTEGER Bematech_FI_VerificaTotalizadoresParciales IN BemaFI32.DLL STRING @ c_totalizadores   
DECLARE INTEGER Bematech_FI_SubTotal IN BemaFI32.DLL STRING @ csub   
DECLARE INTEGER Bematech_FI_DatosUltimaReduccion IN BemaFI32.DLL STRING @ c_datosreduccion   
DECLARE INTEGER Bematech_FI_MonitoramentoPapel IN BemaFI32.DLL INTEGER @ c_lineasimpresas   
DECLARE INTEGER Bematech_FI_MinutosPrendida IN BemaFI32.DLL STRING @ c_minutosprendida   
DECLARE INTEGER Bematech_FI_MinutosImprimiendo IN BemaFI32.DLL STRING @ c_minutosimprimiendo   
DECLARE INTEGER Bematech_FI_NumeroSerie IN BemaFI32.DLL STRING @ c_nserie   
DECLARE INTEGER Bematech_FI_NumeroCupon IN BemaFI32.DLL STRING @ nf   
DECLARE INTEGER Bematech_FI_NumeroOperacionesNoFiscales IN BemaFI32.DLL STRING @ c_operaciones   
DECLARE INTEGER Bematech_FI_NumeroCuponesAnulados IN BemaFI32.DLL STRING @ c_cuponsanulados   
DECLARE INTEGER Bematech_FI_NumeroReduccines IN BemaFI32.DLL STRING @ c_reducciones   
DECLARE INTEGER Bematech_FI_NumeroIntervenciones IN BemaFI32.DLL STRING @ c_intervenciones   
DECLARE INTEGER Bematech_FI_NumeroSustituicionesPropietario IN BemaFI32.DLL STRING @ c_sustituiciones   
DECLARE INTEGER Bematech_FI_NumeroCaja IN BemaFI32.DLL STRING @ c_numerocaja   
DECLARE INTEGER Bematech_FI_NumeroTinda IN BemaFI32.DLL STRING @ c_numerotienda   
DECLARE INTEGER Bematech_FI_VersionFirmware IN BemaFI32.DLL STRING @ c_versionfirmware   
DECLARE INTEGER Bematech_FI_CGC_IE IN BemaFI32.DLL STRING @ c_cgc, STRING @ c_ie   
DECLARE INTEGER Bematech_FI_GranTotal IN BemaFI32.DLL STRING @ c_grantotal   
DECLARE INTEGER Bematech_FI_Descuentos IN BemaFI32.DLL STRING @ c_descuentos   
DECLARE INTEGER Bematech_FI_Cancelamientos IN BemaFI32.DLL STRING @ c_cancelamientos   
DECLARE INTEGER Bematech_FI_UltimoArticuloVendido IN BemaFI32.DLL STRING @ c_ultimoarticulo   
DECLARE INTEGER Bematech_FI_ClichePropietario IN BemaFI32.DLL STRING @ c_clichepropietario   
DECLARE INTEGER Bematech_FI_SimboloMoneda IN BemaFI32.DLL STRING @ c_simbolomoneda   
DECLARE INTEGER Bematech_FI_FlagsFiscales IN BemaFI32.DLL INTEGER @ n_flagfiscales  
DECLARE INTEGER Bematech_FI_VerificaModoOperacion IN BemaFI32.DLL STRING @ c_modooperacion   
DECLARE INTEGER Bematech_FI_VerificaEpromConectada IN BemaFI32.DLL STRING @ c_flageprom   
DECLARE INTEGER Bematech_FI_ValorPagoUltimoCupon IN BemaFI32.DLL STRING @ c_valor   
DECLARE INTEGER Bematech_FI_FechaHoraImpresora IN BemaFI32.DLL STRING @ c_fecha, STRING @ c_hora   
DECLARE INTEGER Bematech_FI_ContadoresTotalizadoresNoFiscales IN BemaFI32.DLL STRING @ c_contadores   
DECLARE INTEGER Bematech_FI_VerificaTotalizadoresNoFiscales IN BemaFI32.DLL STRING @ c_totalizadores   
DECLARE INTEGER Bematech_FI_FechaHoraReduccion IN BemaFI32.DLL STRING @ c_fechareduccion, STRING @ c_horareduccion   
DECLARE INTEGER Bematech_FI_FechaMovimiento IN BemaFI32.DLL STRING @ c_fechamovimiento   
DECLARE INTEGER Bematech_FI_VerificaTruncamiento IN BemaFI32.DLL STRING @ c_flagtruncamiento   
DECLARE INTEGER Bematech_FI_VerificaAlicuotasIss IN BemaFI32.DLL STRING @ alicuotasiss   
DECLARE INTEGER Bematech_FI_Agregado IN BemaFI32.DLL STRING @ c_valorincrementos   
DECLARE INTEGER Bematech_FI_ContadorBilletePasaje IN BemaFI32.DLL STRING @ c_numerobilletes   
DECLARE INTEGER Bematech_FI_VerificaFormasPago IN BemaFI32.DLL STRING @ c_formaspago   
DECLARE INTEGER Bematech_FI_VerificaRecebimientoNoFiscal IN BemaFI32.DLL STRING @ c_recebimentos   
DECLARE INTEGER Bematech_FI_VerificaDepartamentos IN BemaFI32.DLL STRING @ c_departamentos   
DECLARE INTEGER Bematech_FI_VerificaTipoImpresora IN BemaFI32.DLL INTEGER @  n_tipoimpresora   
DECLARE INTEGER Bematech_FI_VerificaIndiceAlicuotasIss IN BemaFI32.DLL STRING @ c_indicealicuotasiss   
DECLARE INTEGER Bematech_FI_ValorFormaPago IN BemaFI32.DLL STRING @ c_formapago, STRING @ c_valor   
DECLARE INTEGER Bematech_FI_ValorTotalizadorNoFiscal IN BemaFI32.DLL STRING @ c_totalizador, STRING @ c_valor   

* Funciones de la Gaveta de Efectivo   

DECLARE INTEGER Bematech_FI_AccionaGaveta IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_VerificaEstadoGaveta IN BemaFI32.DLL INTEGER  

* Otras Funciones   

DECLARE INTEGER Bematech_FI_AbrePuertaSerial IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_CierraPuertaSerial IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_VerificaImpresoraPrendida IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_RetornoImpresora IN BemaFI32.DLL INTEGER @n_ack, INTEGER @n_st1, INTEGER @n_st2   
DECLARE INTEGER Bematech_FI_AperturaDelDia IN BemaFI32.DLL STRING, STRING  
DECLARE INTEGER Bematech_FI_CierreDelDia IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_ImprimeDepartamentos IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_ImprimeConfiguracionesImpresora IN BemaFI32.DLL   
DECLARE INTEGER Bematech_FI_VersionDll IN BemaFI32.DLL STRING @ Version   
DECLARE INTEGER Bematech_FI_LeerArchivoRetorno IN BemaFI32.DLL STRING @ Retorno 

**// DECLARACION VARIABLES 
STORE 0  TO WTOT, WSTOT, WIVA, L,WDTO
STORE '' TO CCLIENTE,CDIR,CRIF,CNIT
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

IF LEN(temp2)>12 .or. LEN(ctemenc)>12
	messagebox('Nombre-Estacion, demasiado largo...'+CHR(13)+'Debe Cambiar o participar al Administrador de la Red',0+64,'Atencion...')
	RETURN
ENDIF


**// CTROL MENSAJES FISCAL
*!*	IF CMENFIS='S'
*!*	    m=cMENFIS1+cMENFIS2+cMENFIS3+cMENFIS4+;
*!*	      cMENFIS5+cMENFIS6+cMENFIS7+cMENFIS8
*!*	ELSE
*!*	    m=''
*!*	ENDIF

*GARANTIA (1)A¤o EQUIPOS NUEVOS
*Excepto(Accesorios,Consumibles
*Mouse,Teclados,Cornetas)
*valida por defectos de fabrica
*no causados por impericia,negligencia
*maltrato,virus,liquidos cambios de voltaje y transporte


WNRO=WFAC

**// INICIO DEL PROCESO (VERIFICACION DATOS FACTURAS Y REGISTROS)

**// VERIFICAR FACTURA Y DATOS DEL ENCABEZADO
SELECT 2   && FACTURAS MAESTRO
SEEK WNRO
IF !LOCK1('FACTURA','C')
RETURN
ENDIF
SET INDEX TO FAC_NRO
IF EOF()
   	WAIT WINDOWS "!!! ERROR !!!','MAESTRO FACTURA->FACTURA LISTAR INCORRECTA '+STR(WNRO))..." nowait
   *MESSAGEBOX('­­­ ERROR !!!','(MAESTRO FACTURA)->FACTURA LISTAR INCORRECTA '+STR(WNRO))
   *NOPASA()
   RETURN
ENDIF
WDTO=FDTO  && DESCUENTO GENERAL GLOBAL


**// VERIFICAR REGISTROS DE LA FACTURA 
SELECT 4
IF !LOCK1('FACREG','C')
RETURN
ENDIF
SET INDEX TO FAC_REG

**// BUSCAR 
SEEK WNRO
IF EOF()
   *ERROR('­­­ ERROR !!!','(REGISTROS)-> FACTURA A LISTAR INCORRECTA ')
   WAIT WINDOWS'­­­ ERROR !!!','(REGISTROS)-> FACTURA A LISTAR INCORRECTA...' nowait
   RETURN
ENDIF


**// GENERAR TEMPORAL
   TEMFISCO()
   SELECT 9
   IF !LOCK1('&TEMP2','C')
      RETURN
   ENDIF

**// GENERAR REPORTE FISCAL(ENCABEZADO,REGISTROS,ARCHIVO PLANO FISCAL)
BEGIN SEQUENCE
   DAT_CLI()              && DATOS DEL CLIENTE
   DETA_FAC()             && DETALLE DE LA FACTURA
   PRO_FIS()              && PROCESO FISCALIZACION
END
RETURN

************************************
FUNCTION DAT_CLI  && ENCABEZADO  *
************************************
**// PASE DATOS A VARIABLES DE TRABAJO

   SELECT 2
   SEEK WNRO

**// CONDICION DE PAGO
   IF FPAGO='C '
      CPAGO='CONTADO'
   ELSE
      CPAGO='CREDITO'
   ENDIF

**// FORMA DE PAGO

   // PAGO REDUCIDO
   IF FEFECTIVO>0
      CCPAGO='Efectivo'
   ELSE
      IF FCHEQUE>0
         CCPAGO='Cheque'
      ELSE
         CCPAGO='Tarjeta'
      ENDIF
   ENDIF

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
   IF FNOMBRE<>SPACE(40)
      CCLIENTE=ALLTRIM(FNOMBRE)  &&40
   ELSE
      WAIT WINDOWS '­­­ ERROR !!!',' CLIENTE SIN RAZON SOCIAL (NOMBRE) ' nowait
      RETURN
   ENDIF
              
**// DIRECCION, CIUDAD, ESTADO Y TELEFONO
   IF FDIR1<>SPACE(45)  &&MAXIMO 133
      CDIR=ALLTRIM(FDIR1)+' '+ALLTRIM(FDIR2)+' '+;
           ALLTRIM(CCIUDAD)+' '+ALLTRIM(CESTADO)+' '+ALLTRIM(FTELF)
      IF LEN(CDIR)>133
         CDIR=SUBSTR(CDIR,1,133)
         WAIT WINDOWS '­­­ ERROR !!!',' MAXIMO VALOR EN DIRECCION FISCAL ' nowait
      ENDIF
   ELSE
      WAIT WINDOWS '­­­ ERROR !!!',' CLIENTE SIN DIRECCION FISCAL (DIRECCION) ' nowait
      RETURN
   ENDIF

**// CEDULA/RIF/NIT
   IF FRIF<>SPACE(15) && .OR. FNIT<>SPACE(15)
      CRIF=ALLTRIM(FRIF)
      **CNIT=ALLTRIM(FNIT)
   ELSE
      WAIT WINDOWS '­­­ ERROR !!!',' CLIENTE SIN REGISTRO FISCAL(RIF) ' nowait
      RETURN
   ENDIF

**// CTROL DESCUENTO GENERAL
   WDTO=FDTO  //DESCUENTO GENERAL GLOBAL

RETURN

*****************************************************************
FUNCTION DETA_FAC     && IMPRESION DETALLADA DE ITEM  
*****************************************************************
DO WHILE .T.
   STORE '' TO CDES_ITE,CDES_GEN,CSERIAL

   SELECT 4 **// (REGISTRO FACTURAS)
**// CAPTURA DE DATOS REGISTRO PARA DATOS VARIABLES FISCALES

**// CODIGO
   CCODIGO=SUBSTR(ALLTRIM(FCODIGO),1,13)

**// DESCRIPCION
   CDESCRIP=SUBSTR(ALLTRIM(FDESCRIP),1,50)   &&29

**// ALICUOTA 
   CALICUOTA=STRZERO(FALICUOTA)
   IF FALICUOTA=0 && PRODUCTOS EXENTOS
      CALICUOTA='II'  
   ENDIF

**// CANTIDAD Y UNIDAD DE VENTA FRACIONADA O ENTERA (DECIMALES PARA LA CANTIDAD)
   VALOR=FCANTIDAD
   IF INT((VALOR/2)*2)==FCANTIDAD  // INTEGER
      CCANTIDAD=STR(INT(FCANTIDAD))
      CUNIFRA='I'
      CUNIDAD='UN'
      CCANT_DEC='2'
   ELSE
      CCANTIDAD=ALLTRIM(STR(FCANTIDAD))
      CUNIFRA='F'
      CCANT_DEC='3'
      STORE SUBSTR(FUNIDAD,1,2) TO CUNIDAD
   ENDIF

**// PRECIO
**// NOTA SE PASA EL PRECIO Y EL PRINTER CALCULA EL IMPUESTO
   IF CIMPVP='N'  // PRECIO CON IMPUESTO INCLUIDO
      IF CUNIFRA='I'
         PPRECIO=ALLTRIM(STR(FBS/CMONEDA))
      ELSE
         PPRECIO=ALLTRIM(STR(FBS))
      ENDIF

      **// DESCUENTO POR ITEM
         CDES_ITE=FBS*FCANTIDAD*FDSCTO*.01/CMONEDA
         CDES_GEN=(FBS-CDES_ITE)*FCANTIDAD*WDTO*.01/CMONEDA
         CDESCUENTO=ALLTRIM(STR(CDES_ITE+CDES_GEN))
   ELSE           // PRECIO MAS IMPUESTO
      IF CUNIFRA='I'
         PPRECIO=ALLTRIM(STR(FBSI/CMONEDA))
      ELSE
         PPRECIO=ALLTRIM(STR(FBSI))
      ENDIF
      **// DESCUENTO POR ITEM
         CDES_ITE=FBSI*FCANTIDAD*FDSCTO*.01/CMONEDA
         CDES_GEN=(FBSI-CDES_ITE)*FCANTIDAD*WDTO*.01/CMONEDA
         CDESCUENTO=ALLTRIM(STR(CDES_ITE+CDES_GEN))
   ENDIF

**// SERIAL ARTICULOS
   **IF CARTSERIAL='S'
      *IF D->FSERIAL<>''
         CSERIAL='S/N:'+ALLTRIM(D->FSERIAL)
      *ELSE
      *   CSERIAL=''
      *ENDIF
  ** ENDIF

   DET_FISCO()  && CREAR DETALLE FISCAL

   SELECT 4
   SKIP

   IF WNRO<>FNRO .OR. EOF()
      RETURN
   ENDIF EOF

ENDDO
RETURN


**************************************************************
FUNCTION TEMFISCO  && CREAR TEMPORAL IMPRESION FISCAL
**************************************************************
**RUTEADOR()

IF FILE('&TEMP2'+'.DBF')=.T.
   FERASE('&RUTA'+'&TEMP2'+'.DBF')
   *FERASE('&RUTA'+'&TEMP2'+'.NTX')
   *FERASE('&RUTA'+'BEMAFI32'+'.CMD')
   *FERASE('&RUTA'+'BEMAFI16'+'.TXT')

*!*	   IF FILE('BEMAFI32'+'.CMD')=.T.
*!*	      ERROR('­­­ ERROR !!!',' NO SE PUDO ELIMINAR ARCHIVO BEMAFI32.CMD ')
*!*	      RETURN
*!*	   ENDIF

*!*	   IF FILE('BEMAFI16'+'.TXT')=.T.
*!*	      ERROR('­­­ ERROR !!!',' NO SE PUDO ELIMINAR ARCHIVO BEMAFI16.TXT ')
*!*	      RETURN
*!*	   ENDIF

   IF FERASE('&TEMP2'+'.DBF')>0 &&.OR. FERASE('&TEMP2'+'.NTX')>0
      WAIT windows '­­­ ERROR !!!',' AL ELIMINAR ARCHIVOS TEMPORALES ' nowait
      RETURN
   ENDIF

ENDIF

**// CREACION ESTRUCTURA NUEVA CON LOS DATOS FISCALES
*!*	estructura:={}
*!*	aadd(estructura, {'FCODIGO',    'C',13,0})  && CAMPO  1 CODIGO ART.
*!*	aadd(estructura, {'FDESCRIP',   'C',50,0})  && CAMPO  2 DESCRIPCION ART.
*!*	aadd(estructura, {'FALICUOTA',  'C', 5,0})  && CAMPO  3 ALICUOTA ART.
*!*	aadd(estructura, {'FUNIFRA',    'C', 1,0})  && CAMPO  4 TIPO CANTIDAD (I)ENTERO (F)RACCION
*!*	aadd(estructura, {'FCANTIDAD',  'C', 8,0})  && CAMPO  5 CANTIDAD ART(S)
*!*	aadd(estructura, {'FCANT_DEC',  'C', 1,0})  && CAMPO  6 CANTIDAD DECIMALES PRECIO UNITARIO ART
*!*	aadd(estructura, {'FPRECIO',    'C', 9,0})  && CAMPO  7 PRECIO VALOR UNITARIO
*!*	aadd(estructura, {'FTIPO_DES',  'C', 1,0})  && CAMPO  8 TIPO DESCUENTO VALOR O PORCENTAJE
*!*	aadd(estructura, {'FDESCUENTO', 'C', 8,0})  && CAMPO  9 VALOR DEL DESCUENTO
*!*	aadd(estructura, {'FUNIDAD',    'C', 2,0})  && CAMPO 10 UNIDAD DE MEDIDA ART.
*!*	aadd(estructura, {'FSERIAL',    'C',40,0})  && CAMPO 11 SERIAL ART.

*!*	DBCREATE('&TEMP2',estructura)  && Crear Temporal

CREATE TABLE AUXILIAR ;
	(FCODIGO    C(13,0}),; && CAMPO  1 CODIGO ART.
   	 FDESCRIP   C(50,0),;  && CAMPO  2 DESCRIPCION ART.
 	 FALICUOTA  C(5,0),;   && CAMPO  3 ALICUOTA ART.
	 FUNIFRA    C(1,0),;   && CAMPO  4 TIPO CANTIDAD (I)ENTERO (F)RACCION
	 FCANTIDAD  C(8,0),;   && CAMPO  5 CANTIDAD ART(S)
	 FCANT_DEC  C(1,0),;   && CAMPO  6 CANTIDAD DECIMALES PRECIO UNITARIO ART
	 FPRECIO	C(9,0),;   && CAMPO  7 PRECIO VALOR UNITARIO
	 FTIPO_DES  C(1,0),;   && CAMPO  8 TIPO DESCUENTO VALOR O PORCENTAJE
	 FDESCUENTO C(8,0),;   && CAMPO  9 VALOR DEL DESCUENTO
	 FUNIDAD    C(2,0),;   && CAMPO 10 UNIDAD DE MEDIDA ART.
	 FSERIAL    C(40,0))   && CAMPO 11 SERIAL ART.

RETURN


*********************************************************
FUNCTION DET_FISCO && CREAR DETALLE DEL REPORTE FISCAL
*********************************************************
SELECT 9
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

**// SIGNOS
**// (&) ERROR Y CONTINUA
**// (*) ERRR NO CONTINUA MUESTRA PANTALLA
**// (%) ERROR IGNORADO
**// ( ) ERROR NO CONTINUA
         
**SET PRINTER TO BEMAFI16.TXT
SET PRINTER  on
SET DEVICE TO PRINT

L=L++
@ L,0 SAY '009|%'                              
L++
@ L,0 SAY '009|%'                              
L++
*@ L,0 SAY '272|'+CRIF+'|'+CCLIENTE+'|'+CDIR1+CDIR2+' '+CCIUDAD+' '+CESTADO+' '+CTELF+'|%'
@ L,0 SAY '272|'+CRIF+'|'+CCLIENTE+'|'+CDIR+'|%'
L++

SELECT 9
GO TOP

DO WHILE !EOF()
   DO CASE
      CASE CITEMLARGO='N'     // DESCRIPCION CORTA
           IF CITEMCOD='S'    // MOSTRAR CODIGO ITEM
              @ L,0 SAY '089|'+FCODIGO+'|'+substr(FDESCRIP,1,29)+'|'+FALICUOTA+'|'+FUNIFRA+'|'+FCANTIDAD+'|'+FCANT_DEC+'|'+FPRECIO+'|'+'$'+'|'+FDESCUENTO+'|%'
           ELSE
              @ L,0 SAY '089||'+substr(FDESCRIP,1,29)+'|'+FALICUOTA+'|'+FUNIFRA+'|'+FCANTIDAD+'|'+FCANT_DEC+'|'+FPRECIO+'|'+'$'+'|'+FDESCUENTO+'|%'
           ENDIF
      CASE CITEMLARGO='S'     // DESCRIPCION LARGA Y SERIAL(S)
           IF CSERIAL#''
              @ L,0 SAY '007|'+FDESCRIP+' '+ALLTRIM(FSERIAL)+'|%'
           ELSE
              @ L,0 SAY '007|'+FDESCRIP+'|%'
           ENDIF
           *L++
           *@ L,0 SAY '085|'+FUNIDAD+'|%'
           L++
           IF CITEMCOD='S'    // MOSTRAR CODIGO ITEM
              @ L,0 SAY '089|'+FCODIGO+'|'+SUBSTR(FDESCRIP,1,4)+'|'+FALICUOTA+'|'+FUNIFRA+'|'+FCANTIDAD+'|'+FCANT_DEC+'|'+FPRECIO+'|'+'$'+'|'+FDESCUENTO+'|%'
           ELSE               // NO MOSTRAR CODIGO ITEM
              @ L,0 SAY '089||'+SUBSTR(FDESCRIP,1,4)+'|'+FALICUOTA+'|'+FUNIFRA+'|'+FCANTIDAD+'|'+FCANT_DEC+'|'+FPRECIO+'|'+'$'+'|'+FDESCUENTO+'|%'
           ENDIF

      OTHERWISE
              @ L,0 SAY '089|'+FCODIGO+'|'+FDESCRIP+'|'+FALICUOTA+'|'+FUNIFRA+'|'+FCANTIDAD+'|'+FCANT_DEC+'|'+FPRECIO+'|'+'$'+'|'+FDESCUENTO+'|%'
   ENDCASE
   L++
   SKIP +1
ENDDO
   **// FORMA DE PAGO REDUCIDO (1) SOLO PAGO
   *L++
   @ L,0 SAY '029'+'|'+CCPAGO+'|'+CPAGO+' Op# '+str(WNRO)+' '+m+'|%'

   **// FORMA DE PAGO EXTENDIDO (N) FORMAS DE PAGO
   /*L++
   @ L,0 SAY '040|D|%|0000|&'
   L++
   IF CCPAGO1#''
      @ L,0 SAY '023|'+CCPAGO1+'|'+CVPAGO1+'|&'
      L++
   ENDIF
   IF CCPAGO2#''
      @ L,0 SAY '024|'+CCPAGO2+'|'+CVPAGO2+'|'+CBANCO+' '+CNCHEQUE+'|&'
      L++
   ENDIF
   IF CCPAGO3#''
      @ L,0 SAY '024|'+CCPAGO3+'|'+CVPAGO3+'|'+CBANCO+' '+CNTARJETA+'|&'
   ENDIF*/

   **// CIERRA TICKET CON FORMAS DE PAGO
   *L++
   *@ L,0 SAY '082|'+CPAGO+'... Gracias por su Compra...!!!  LA GARANTIA ES POR 12 MESES SOLO EN EQUIPOS NUEVOS Y EQUIPOS VENDIDOS POR NUESTRA CASA MATRIZ |&'

   **// ABRIR GAVETA 
   L++
   @ L,0 SAY '004|%'
   L++


SET PRINTER TO
SET DEVICE  TO SCREEN


**// CORRER PARCHO PARA ELIMINAR PRIMERA LINEA DEL BEMAFI16.TXT
**   EDITOR()

**// PARCHO PARA XP IMPRESION RAPIDA
**   RUN TYPE (' > &CLISTA')

**// VERIFICAR STATUS
   *****lee_statu()   ojo mejorar rutas... 

RETURN

**********************
FUNCTION EDITOR
**********************
LOCAL cString
IF (cString := MEMOREAD("&RUTA"+"BEMAFI16.txt")) == ""
    ERROR('­­­ ERROR !!!',' Error de Lectura Archivo BEMAFI16')
    RETURN .F.
ELSE
    MEMOWRIT("&RUTA"+"BEMAFI16.txt", STUFF(cString,1,7,""))
    ****ft_FDELETE(1)
    *rutaI='&ruta'+'BEMAFI16.TXT'
    *rutaF='&ruta'+'BEMAFI32.CMD'
    COPY FILE &rutaI TO &rutaF
    RETURN .T.
ENDIF
RETURN

*********************************************************
FUNCTION RUTEADOR  // LOCALIZADOR RUTA DEL SISTEMA
*********************************************************
DIRE='SIAM'                   && DIRECTORIO DEL SISTEMA
UNID:={'C:','D:','E:','F:','G:','H:','I:','J:','K:','L:','M:','N:','O:','P:','Q:','R:','S:','T:','U:','V:','W:','X:','Y:','Z:'}
FOR Z=1 TO LEN(UNID)
    IF FILE(UNID[Z]+'\&DIRE\DATA\MEMO.MEM')=.T.
       RUTA=ALLTRIM(UNID[Z]+'\&DIRE\DATA\')
       EXIT
    ENDIF
NEXT Z
rutaI='&ruta'+'BEMAFI16.TXT'
rutaF='&ruta'+'BEMAFI32.CMD'
SET DEFAULT TO &RUTA
RETURN 


*!*	*************************************************************
*!*	FUNCTION LEE_STATU  // LEE EL STATU DEL COMANDO Y SUS ERRORES
*!*	*************************************************************
*!*	STORE 0 TO ST1,ST2,I
*!*	STORE '' TO Mens1,Mens2
*!*	**// verificar Archivo Status
*!*	   DO WHILE .T.
*!*	       IF FILE('C:\SIAM\DATA\STATUS.TXT')=.F.
*!*	          *ERROR('­­­ ERROR !!!',' NO SE ENCONTRO ARCHIVO DE STATUS DEL PRINTER ')
*!*	          *RETURN
*!*	          INKEY(2)
*!*	          *I++
*!*	          *LOOP
*!*	       ELSE
*!*	          EXIT
*!*	       ENDIF
*!*	   ENDDO
*!*	   ft_fuse('C:\SIAM\DATA\STATUS.TXT',0,64)
*!*	   iRetorno=FT_FREADLN()
*!*	   ft_fuse()
*!*	   **@ 0,1 say iRetorno
*!*	IF val(substr(iRetorno,1,1))=6
*!*	   aArray:=GT_S2ARR('&iRetorno',',')
*!*	   St1=VAL(aArray[2])
*!*	   St2=VAL(aArray[3])
*!*	   **@ 1,1 SAY St1 PICT '999'
*!*	   **@ 1,5 SAY St2 PICT '999'

*!*	IF ST1>0 .OR. ST2>0  // HUBO ERROR

*!*	**//**Codificando o ST1

*!*	If St1 >= 128  // bit 7 
*!*	St1 = St1 - 128 
*!*	Mens1 = "Fin de Papel" 
*!*	endIf 
*!*	If St1 >= 64   // bit 6 
*!*	St1 = St1 - 64 
*!*	Mens1 = "Poco Papel" 
*!*	endif 
*!*	If St1 >= 32   // bit 5 
*!*	St1 = St1 - 32 
*!*	Mens1 = "Error en el Reloj" 
*!*	endif 
*!*	If St1 >= 16   // bit 4 
*!*	St1 = St1 - 16 
*!*	Mens1 = "Impresora con Error" 
*!*	endif 
*!*	If St1 >= 8    // bit 3 
*!*	St1 = St1 - 8 
*!*	Mens1 = "Comando no empieza con ESC" 
*!*	endif 
*!*	If St1 >= 4   // bit 2 
*!*	St1 = St1 - 4 
*!*	Mens1 = "Comando Inexistente" 
*!*	endif 
*!*	If St1 >= 2   // bit 1 
*!*	St1 = St1 - 2 
*!*	Mens1 = "Cupón Abierto" 
*!*	endif 
*!*	If St1 >= 1   // bit 0 
*!*	St1 = St1 - 1 
*!*	Mens1 = "Numero de Parametro(s) Invalido(s)" 
*!*	endif 

*!*	**// **Codificando o ST2 

*!*	If St2 >= 128 // bit 7 
*!*	St2 = St2 - 128 
*!*	Mens2 = "Tipo de Parametro de Comando Invalido" 
*!*	endif 
*!*	If St2 >= 64  // bit 6 
*!*	St2 = St2 - 64 
*!*	Mens2 = "Memoria Fiscal LLena" 
*!*	endif 
*!*	If St2 >= 32  // bit 5 
*!*	St2 = St2 - 32 
*!*	Mens2 = "Error en la Memória RAM" 
*!*	endif 
*!*	If St2 >= 16  // bit 4 
*!*	St2 = St2 - 16 
*!*	Mens2 = "Alicuota No Programada" 
*!*	endif 
*!*	If St2 >= 8   // bit 3 
*!*	St2 = St2 - 8 
*!*	Mens2 = "Capacidad de Alicuotas Llena" 
*!*	endif 
*!*	If St2 >= 4   // bit 2 
*!*	St2 = St2 - 4 
*!*	Mens2 = "Cancelamiento No Permitido" 
*!*	endif 
*!*	If St2 >= 2   // bit 1 
*!*	St2 = St2 - 2 
*!*	Mens2 = "RIF del Propietario No Programado" 
*!*	endif 
*!*	If St2 >= 1   // bit 0 
*!*	St2 = St2 - 1 
*!*	Mens2 = "Comando No Ejecutado" 
*!*	endif

*!*	  ERROR('­­­ ERROR !!!','&Mens1'+' '+'&Mens2')

*!*	ELSE

*!*	  **AVISO('­­­ AVISO !!! No se encontro Error...!')
*!*	  @ 24,0 SAY ' ­­­ AVISO !!! No se encontro Error...!'
*!*	  INKEY(2)

*!*	ENDIF

*!*	ELSE
*!*	   ERROR('­­­ ERROR !!!','ERROR DE COMUNICACION CON EL PRINTER ')
*!*	ENDIF
*!*	RETURN



*!*	/*NOTA: Garantia se requiere la presentacion de la factura de compra con el(los)serial(es) de (los) producto(s)
*!*	y es valida solo por defectos de fabricacion, en ningun caso cubre defectos causados por transporte,impericia,negligencia
*!*	,maltrato,virus,uso inadecuado,derrame de liquidos y flutuaciones del voltaje.'+'(180) Dias Garantia: Tarj.(Madre,Video,
*!*	Sonido),Disco,Floppy,DVD (1)A¤o en Impresoras y Monitores directamente con el Fabricante Sin Garantia: Memorias,Case,
*!*	Mouse,Joystick,Accesorios,Diskettes,Consumibles,Mouse,Teclados*/


**// TEMPORALMENTE ELIMINADO BUSQ DEL CLIENTE
*!*	/*SELECT 3
*!*	IF !LOCK1('CLIENTE','C')
*!*	RETURN
*!*	ENDIF
*!*	SET INDEX TO ICLIENTE,IRIF,INOMBRE
*!*	SEEK WCLIENTE
*!*	IF EOF()
*!*	   ERROR('­­­ ERROR !!!','(MAESTRO CLIENTE)->CLIENTE NO EXISTE '+STR(WCLIENTE))
*!*	   RETURN
*!*	ENDIF
*!*	CCIUDAD=CIUDAD
*!*	CESTADO=ESTADO*/

