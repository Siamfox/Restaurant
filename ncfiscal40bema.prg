*!*	************************************************************************
*!*	FUNCTION NCFIS40 && IMPRIME DEVOLUCIONES (NOTAS DE CREDITO 40COL FISCAL*
*!*	************************************************************************
*!*	// DECLARACION VARIABLES
*!*	STORE 0 TO WIVA ,L,PAG,WTOT,WCOO
*!*	STORE '' TO CCLIENTE,CDIR,CRIF,CNIT
*!*	STORE '' TO CCODIGO,CDESCRIP,PPRECIO,CCANTIDAD,CCANT_DEC,CALICUOTA
*!*	STORE '' TO CUNIFRA,CDESCUENTO,CUNIDAD,CSERIAL
*!*	STORE '' TO CCIUDAD,CESTADO
*!*	STORE '' TO CDES_ITE,CDES_GEN
*!*	STORE '' TO WSERIE
*!*	STORE '' TO RUTA,RUTAI,RUTAF,letras
*!*	STORE '' TO CDIA,CMES,CANO
*!*	STORE '' TO CHOR,CMIN,CSEG

*!*	// RUTEAR MANIPULACION DEL ARCHIVO TXT BEMAF16 Y 32
*!*	RUTEADOR()

*!*	TEMP2='TEM_CAJ'+ALLTRIM(STR(SWRED))

*!*	SELECT 7  && MAESTRO DE DEVOLUCIONES
*!*	IF !LOCK1('NCREDITO','C')
*!*	RETURN
*!*	ENDIF
*!*	SET INDEX TO NCREDITO,FNCREDITO,ANCREDITO,KNCREDITO

*!*	SEEK WFAC
*!*	IF EOF()
*!*	   ERROR('ннн ERROR !!!',' DEVOLUCION A LISTAR INCORRECTA ')
*!*	   RETURN
*!*	ENDIF

*!*	WFAC2=VAL(FORDEN) && GUARDAR VALOR DEL NRO. DE FACTURA
*!*	WDTO=FDTO

*!*	@ 24,0 SAY PADC('Lista Devolucion Nгmero '+STRZERO(WFAC,6)+' [Esc] Salir',80) COLOR 'GR++*/BG'

*!*	SELECT 5
*!*	IF !LOCK1('NCRE_REG','C')   && REGISTROS  NOTAS DE CREDITOS (MAESTRO)
*!*	RETURN
*!*	ENDIF
*!*	SET INDEX TO NCRE_REG
*!*	SEEK WFAC
*!*	IF EOF()
*!*	   ERROR('ннн ERROR !!!','(REGISTRO NOTAS)-> NOTA CREDITO A LISTAR INCORRECTA')
*!*	   RETURN
*!*	ENDIF

*!*	// GENERAR TEMPORAL 

*!*	   TEMNCFIS()

*!*	   SELECT 9
*!*	   IF !LOCK1('&TEMP2','C')
*!*	      RETURN
*!*	   ENDIF

*!*	// IMPRESION POR PANTALLA
*!*	   *IF !LISTADOS()
*!*	   *   RETURN
*!*	   *ENDIF

*!*	// GENERAR EL REPORTE
*!*	   BEGIN SEQUENCE
*!*	   E_NCFIS()   && ENCABEZADO FACTURA
*!*	   D_NCFIS()   && DETALLE DE IMPRESION
*!*	   P_NCFIS()   && PROCESO FISCALIZACION

*!*	   *F_NCFIS()  && FIN DE LA FACTURA
*!*	   *IMPRIME()   && RUTA DEL TEXTO
*!*	   END
*!*	   RETURN

*!*	******************************************************
*!*	FUNCTION E_NCFIS     &&RUTINA  IMPRIMIR ENCABEZADO  **
*!*	******************************************************
*!*	SELECT 7  && MAESTRO DE NOTAS DE CREDITO

*!*	// PASE DATOS A VARIABLES DE TRABAJO

*!*	   IF FNOMBRE<>SPACE(40)
*!*	      CCLIENTE=ALLTRIM(FNOMBRE)
*!*	   ELSE
*!*	      ERROR('!!! ERROR !!!','(MAESTRO NOTAS)->CLIENTE SIN RAZON SOCIAL (NOMBRE)')
*!*	      RETURN
*!*	   ENDIF

*!*	   IF FRIF<>SPACE(15)
*!*	      CRIF=ALLTRIM(FRIF)
*!*	   ELSE
*!*	      ERROR('!!! ERROR !!!','(MAESTRO NOTAS)->NUMERO RIF DEL CLIENTE ')
*!*	   ENDIF

*!*	// FECHA DE LA FACTURA FISCAL
*!*	   CDIA=SUBSTR(DTOC(FECHA2),1,2)
*!*	   CMES=SUBSTR(DTOC(FECHA2),4,2)
*!*	   CANO=SUBSTR(DTOC(FECHA2),9,2)

*!*	// HORA DE LA FACTURA FISCAL
*!*	   CHOR =SUBSTR(FTIME2,1,2)
*!*	   CMIN =SUBSTR(FTIME2,4,2)
*!*	   CSEG =SUBSTR(FTIME2,7,2)

*!*	// CONTROL OPERACIONES
*!*	   WCOO=FCOO  && NUMERO CONTROL (COO) TRANSACCION && '12345'
*!*	   IF WCOO=0
*!*	      ERROR('!!! ERROR !!!','(MAESTRO NOTAS)->SIN NRO. CTROL (COO) FISCAL ')
*!*	      RETURN
*!*	   ENDIF

*!*	// SERIAL IMPRESORA FISCAL
*!*	   WSERIE=CSERIE && '1FB8100000'
*!*	   IF WSERIE=SPACE(15)
*!*	      ERROR('!!! ERROR !!!','(MAESTRO MEMO)->SIN NRO. SERIAL IMPRESORA FISCAL ')
*!*	      RETURN
*!*	   ENDIF

*!*	RETURN


*!*	********************************************
*!*	FUNCTION D_NCFIS  && DETALLE DE LA IMPRESION 
*!*	********************************************
*!*	DO WHILE .T.

*!*	   SELECT 5

*!*	// CAPTURA DE DATOS REGISTRO PARA DATOS VARIABLES FISCALES

*!*	// CODIGO
*!*	   CCODIGO=SUBSTR(ALLTRIM(FCODIGO),1,13)

*!*	// DESCRIPCION
*!*	   CDESCRIP=SUBSTR(ALLTRIM(FDESCRIP),1,50)   &&29

*!*	// ALICUOTA 
*!*	   CALICUOTA=STRZERO(FALICUOTA)
*!*	   IF FALICUOTA=0 && PRODUCTOS EXENTOS
*!*	      CALICUOTA='II'  
*!*	   ENDIF

*!*	// CANTIDAD Y UNIDAD DE VENTA FRACIONADA O ENTERA (DECIMALES PARA LA CANTIDAD)
*!*	   VALOR=FCANTIDAD
*!*	   IF INT((VALOR/2)*2)==FCANTIDAD  // INTEGER
*!*	      CCANTIDAD=STR(INT(FCANTIDAD))
*!*	      CUNIFRA='I'
*!*	      CUNIDAD='UN'
*!*	      CCANT_DEC='2'
*!*	   ELSE
*!*	      CCANTIDAD=ALLTRIM(STR(FCANTIDAD))
*!*	      CUNIFRA='F'
*!*	      CCANT_DEC='3'
*!*	      STORE SUBSTR(FUNIDAD,1,2) TO CUNIDAD
*!*	   ENDIF

*!*	// PRECIO
*!*	// NOTA SE PASA EL PRECIO Y EL PRINTER CALCULA EL IMPUESTO
*!*	   IF CIMPVP='N'  // PRECIO CON IMPUESTO INCLUIDO
*!*	      IF CUNIFRA='I'
*!*	         PPRECIO=ALLTRIM(STR(FBS/CMONEDA))
*!*	      ELSE
*!*	         PPRECIO=ALLTRIM(STR(FBS))
*!*	      ENDIF

*!*	      // DESCUENTO POR ITEM
*!*	         CDES_ITE=FBS*FCANTIDAD*FDSCTO*.01/CMONEDA
*!*	         CDES_GEN=(FBS-CDES_ITE)*FCANTIDAD*WDTO*.01/CMONEDA
*!*	         CDESCUENTO=ALLTRIM(STR(CDES_ITE+CDES_GEN))
*!*	   ELSE           // PRECIO MAS IMPUESTO
*!*	      IF CUNIFRA='I'
*!*	         PPRECIO=ALLTRIM(STR(FBSI/CMONEDA))
*!*	      ELSE
*!*	         PPRECIO=ALLTRIM(STR(FBSI))
*!*	      ENDIF
*!*	      // DESCUENTO POR ITEM
*!*	         CDES_ITE=FBSI*FCANTIDAD*FDSCTO*.01/CMONEDA
*!*	         CDES_GEN=(FBSI-CDES_ITE)*FCANTIDAD*WDTO*.01/CMONEDA
*!*	         CDESCUENTO=ALLTRIM(STR(CDES_ITE+CDES_GEN))
*!*	   ENDIF

*!*	// SERIAL ARTICULOS
*!*	   *IF FSERIAL<>''
*!*	   *   CSERIAL='S/N:'+ALLTRIM(FSERIAL)
*!*	   *ENDIF

*!*	   R_NCFIS()  // CREAR DETALLE FISCAL
*!*	   SELECT 5

*!*	   SKIP

*!*	   IF WFAC<>FNRO .OR. EOF()
*!*	     ***mensaje
*!*	      RETURN && EXIT  
*!*	   ENDIF EOF
*!*	ENDDO
*!*	RETURN

*!*	**************************************************************
*!*	FUNCTION TEMNCFIS  && CREAR TEMPORAL IMPRESION FISCAL
*!*	**************************************************************
*!*	IF FILE('&TEMP2'+'.DBF')=.T.
*!*	   FERASE('&RUTA'+'&TEMP2'+'.DBF')
*!*	   FERASE('&RUTA'+'&TEMP2'+'.NTX')
*!*	   FERASE('&RUTA'+'BEMAFI32'+'.CMD')
*!*	   FERASE('&RUTA'+'BEMAFI16'+'.TXT')

*!*	   IF FILE('BEMAFI32'+'.CMD')=.T.
*!*	      ERROR('ннн ERROR !!!',' NO SE PUDO ELIMINAR ARCHIVO BEMAFI32.CMD ')
*!*	      RETURN
*!*	   ENDIF

*!*	   IF FILE('BEMAFI16'+'.TXT')=.T.
*!*	      ERROR('ннн ERROR !!!',' NO SE PUDO ELIMINAR ARCHIVO BEMAFI16.TXT ')
*!*	      RETURN
*!*	   ENDIF

*!*	   IF FERASE('&TEMP2'+'.DBF')>0 .OR. FERASE('&TEMP2'+'.NTX')>0
*!*	      ERROR('ннн ERROR !!!',' AL ELIMINAR ARCHIVOS TEMPORALES ')
*!*	      RETURN
*!*	   ENDIF

*!*	ENDIF

*!*	// CREACION ESTRUCTURA NUEVA CON LOS DATOS FISCALES
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
*!*	aadd(estructura, {'FSERIAL',    'C',40,0})  && CAMPO 10 UNIDAD DE MEDIDA ART.

*!*	DBCREATE('&TEMP2',estructura)  && Crear Temporal

*!*	RETURN

*!*	**************************************
*!*	FUNCTION F_NCFIS && FIN DE LA FACTURA
*!*	**************************************
*!*	**NOTAS_FAC4()  && IMPRIMIR NOTAS

*!*	**MEN_DEV40(CMENSA1)
*!*	**MEN_DEV40(CMENSA2)
*!*	**MEN_DEV40(CMENSA3)
*!*	**MEN_DEV40(CMENSA4)

*!*	SET PRINTER TO  
*!*	SET DEVICE  TO SCREEN          
*!*	RETURN

*!*	***********************************************
*!*	FUNCTION MEN_FIS40 && MENSAJES EN LA DEVOLUCION
*!*	***********************************************
*!*	PARAMETER MENSAJE
*!*	IF !EMPTY(MENSAJE)
*!*	   @ L,0 SAY  ALLTRIM(MENSAJE)
*!*	   L=L+1
*!*	ENDIF
*!*	RETURN

*!*	*********************************************************
*!*	FUNCTION R_NCFIS && CREAR DETALLE DEL REPORTE FISCAL
*!*	*********************************************************
*!*	SELECT 9
*!*	FLOCK()
*!*	APPEND BLANK

*!*	REPLACE FCODIGO    WITH  CCODIGO    && CAMPO  1 CODIGO ART.
*!*	REPLACE FDESCRIP   WITH  CDESCRIP   && CAMPO  2 DESCRIPCION ART.
*!*	REPLACE FALICUOTA  WITH  CALICUOTA  && CAMPO  3 ALICUOTA ART.
*!*	REPLACE FUNIFRA    WITH  CUNIFRA    && CAMPO  4 T/CANTIDAD (I)ENTERO (F)RACCION
*!*	REPLACE FCANTIDAD  WITH  CCANTIDAD  && CAMPO  5 CANTIDAD ART(S)
*!*	REPLACE FCANT_DEC  WITH  CCANT_DEC  && CAMPO  6 CANTIDAD DECIMALES PRECIO UNITARIO ART
*!*	REPLACE FPRECIO    WITH  PPRECIO    && CAMPO  7 PRECIO VALOR UNITARIO
*!*	REPLACE FTIPO_DES  WITH  '$'        && CAMPO  8 TIPO DESCUENTO ($)VALOR O (%)PORCENTAJE
*!*	REPLACE FDESCUENTO WITH  CDESCUENTO && CAMPO  9 VALOR DEL DESCUENTO
*!*	REPLACE FUNIDAD    WITH  CUNIDAD    && CAMPO 10 UNIDAD DE MEDIDA
*!*	**REPLACE FSERIAL    WITH  CSERIAL    && CAMPO 11 SERIAL DEL ARTICULO

*!*	UNLOCK
*!*	RETURN

*!*	****************************************************************
*!*	FUNCTION P_NCFIS    && PROCESO IMPRESION FISCAL HACIA AL MONITOR
*!*	****************************************************************
*!*	// FORMATO DEL COMANDO FISCAL
*!*	//  1.-CODIGO              | (STRING 13)
*!*	//  2.-DESCRIPCION         | (STRING 29)
*!*	//  3.-ALICUOTA            | (DIGITO 5 C/DEC. EJ. 09,00) (DIG DE 2 INDICE ALICUOTA)
*!*	//  4.-TIPO_CANTIDAD       | (STRING  1) (I)ENTERO (F)FRACIONARIO
*!*	//  5.-CANTIDAD            | (STRING (4) DIGITOS ENTERO (7) DIGITOS FRACIONARIO
*!*	//  6.-CANTIDAD_DECIMAL    | (DIGITO  1) CANTIDAD DECIMAL VALOR UNITARIO (2 O 3)
*!*	//  7.-VALOR UNITARIO      | (STRING (8) DIGITOS
*!*	//  8.-TIPO DESCUENTO      | (STRING  1) ($ X VALOR) ( % X PORCE%)
*!*	//  9.-VALOR DEL DESCUENTO | (DIGITO 8 C/DECIMAL X VALOR) (DIGITO 4 X PORCE%)
*!*	// 10.-VALOR UNIDAD EMPAQ  | (STRING  2)

*!*	// SIGNOS
*!*	// (&) ERROR Y CONTINUA
*!*	// (*) ERRR NO CONTINUA MUESTRA PANTALLA
*!*	// (%) ERROR IGNORADO
*!*	// ( ) ERROR NO CONTINUA
*!*	          
*!*	SET PRINTER TO BEMAFI16.TXT
*!*	SET DEVICE TO PRINT

*!*	L=L++
*!*	@ L,0 SAY '009|%'                              
*!*	L++
*!*	@ L,0 SAY '009|%'                              
*!*	L++
*!*	*@ L,0 SAY '276|'+CRIF+'|'+CCLIENTE+'|'+CDIR+'|%'
*!*	@ L,0 SAY '276|'+CCLIENTE+'|'+WSERIE+'|'+CRIF+;
*!*	             '|'+CDIA+'|'+CMES+'|'+CANO+'|'+CHOR+;
*!*	             '|'+CMIN+'|'+CSEG+'|'+STR(WFAC2)+'|%'
*!*	L++

*!*	SELECT 9
*!*	GO TOP

*!*	DO WHILE !EOF()
*!*	   DO CASE
*!*	      CASE CITEMLARGO='N'     // DESCRIPCION CORTA
*!*	           IF CITEMCOD='S'    // MOSTRAR CODIGO ITEM
*!*	              @ L,0 SAY '089|'+FCODIGO+'|'+substr(FDESCRIP,1,29)+'|'+FALICUOTA+'|'+FUNIFRA+'|'+FCANTIDAD+'|'+FCANT_DEC+'|'+FPRECIO+'|'+'$'+'|'+FDESCUENTO+'|%'
*!*	           ELSE
*!*	              @ L,0 SAY '089||'+substr(FDESCRIP,1,29)+'|'+FALICUOTA+'|'+FUNIFRA+'|'+FCANTIDAD+'|'+FCANT_DEC+'|'+FPRECIO+'|'+'$'+'|'+FDESCUENTO+'|%'
*!*	           ENDIF
*!*	      CASE CITEMLARGO='S'     // DESCRIPCION LARGA Y SERIAL(S)
*!*	           **IF CSERIAL#''
*!*	              **@ L,0 SAY '007|'+FDESCRIP+' '+ALLTRIM(FSERIAL)+'|%'
*!*	           **ELSE
*!*	              @ L,0 SAY '007|'+FDESCRIP+'|%'
*!*	           **ENDIF
*!*	           *L++
*!*	           *@ L,0 SAY '085|'+FUNIDAD+'|%'
*!*	           L++
*!*	           IF CITEMCOD='S'    // MOSTRAR CODIGO ITEM
*!*	              @ L,0 SAY '089|'+FCODIGO+'|'+SUBSTR(FDESCRIP,1,4)+'|'+FALICUOTA+'|'+FUNIFRA+'|'+FCANTIDAD+'|'+FCANT_DEC+'|'+FPRECIO+'|'+'$'+'|'+FDESCUENTO+'|%'
*!*	           ELSE               // NO MOSTRAR CODIGO ITEM
*!*	              @ L,0 SAY '089||'+SUBSTR(FDESCRIP,1,4)+'|'+FALICUOTA+'|'+FUNIFRA+'|'+FCANTIDAD+'|'+FCANT_DEC+'|'+FPRECIO+'|'+'$'+'|'+FDESCUENTO+'|%'
*!*	           ENDIF

*!*	      OTHERWISE
*!*	           @ L,0 SAY '089|'+FCODIGO+'|'+FDESCRIP+'|'+FALICUOTA+'|'+FUNIFRA+'|'+FCANTIDAD+'|'+FCANT_DEC+'|'+FPRECIO+'|'+'$'+'|'+FDESCUENTO+'|%'
*!*	   ENDCASE
*!*	   L++
*!*	   SKIP +1
*!*	ENDDO

*!*	   // CIERRA NOTA CREDITO
*!*	   *L++
*!*	   @ L,0 SAY '040|'+'D'+'|'+'$'+'|'+'0000'+'|%'
*!*	   L++
*!*	   @ L,0 SAY '082|'+'(COO)# '+STR(WCOO)+' !!!... Gracias por su Compra...!!!'+'|%'

*!*	SET PRINTER TO
*!*	SET DEVICE  TO SCREEN


*!*	// CORRER PARCHO PARA ELIMINAR PRIMERA LINEA DEL BEMAFI16.TXT
*!*	   ***RUTEADOR()
*!*	   EDITOR()

*!*	// PARCHO PARA XP IMPRESION RAPIDA
*!*	   RUN TYPE (' > &CLISTA')

*!*	// VERIFICAR STATUS
*!*	   *****lee_statu()   ojo mejorar rutas... 

*!*	RETURN
