*!*	*****************************************************************************
*!*	FUNCTION CAJA2 && PROGRAMA DE CONSULTAR Y ANULAR E IMPRIMIR
*!*	*              &&  NOTAS DE CREDITOS FACTURAS DETAL
*!*	******************************************************************************
*!*	PARAMETER ELIMINA
*!*	DO WHILE .T.

*!*	   STORE 0 TO WTDCTO,WTVENTA,WTCOSTO,WTOT,WSTOT,WIVA,WDTO
*!*	   STORE 0 TO L,WTGVENTA,WTGDCTO,WTGCOSTO
*!*	   WFAC=0
*!*	   WPAGO=SPACE(8)
*!*	   WCONTRI=SPACE(1)
*!*	   WANULA=SPACE(1)
*!*	   CANCELA=.T.
*!*	   CANCELA2=.T.
*!*	   RETURNING=.F.

*!*	   SELECT 3
*!*	   IF !LOCK1('CLIENTE','C')
*!*	      RETURN
*!*	   ENDIF
*!*	   SET INDEX TO ICLIENTE,IRIF,INOMBRE

*!*	   SELECT 2
*!*	   IF !LOCK1('FACDIA','C')
*!*	      RETURN
*!*	   ENDIF
*!*	   SET INDEX TO FACDIA
*!*	   GO BOTT
*!*	   WFAC=FNRO

*!*	   SELECT 4
*!*	   IF !LOCK1('FACD_REG','C')
*!*	      RETURN
*!*	   ENDIF
*!*	   SET INDEX TO FACD_REG

*!*	   IF WFAC=0 
*!*	      SELECT 2
*!*	      IF !LOCK1('DETAL','C')
*!*	         RETURN
*!*	      ENDIF
*!*	      SET INDEX TO DETAL

*!*	      SELECT 4
*!*	      IF !LOCK1('DET_REG','C')
*!*	         RETURN
*!*	      ENDIF
*!*	      SET INDEX TO DET_REG
*!*	   ENDIF

*!*	   SELECT 2
*!*	   IF ELIMINA=1
*!*	      TITULO='Anular Facturas Detal'
*!*	   ELSE
*!*	      TITULO='Consultar Facturas Detal'
*!*	   ENDIF
*!*	   PANTA(7,2,22,77,1)
*!*	   SET KEY  9 TO VENT_DETAL   && VENTANA DETAL DE FACTURAS ANTERIORES
*!*	   SET KEY 13 TO VENT_DETAL   && VENTANA DETAL DE FACTURAS ANTERIORES
*!*	   @ 10,26 SAY 'Tipee Nro Factura : 'GET WFAC PICT '99999999' VALID WFAC>0
*!*	   READ
*!*	   IF LASTKEY()=27 .AND. !RETURNING
*!*	      SALIDA()
*!*	      RETURN
*!*	   ENDIF

*!*	   IF EMPTY(WFAC) .OR. WFAC<=0
*!*	      LOOP
*!*	   ENDIF

*!*	   SELECT 2
*!*	   IF !LOCK1('FACDIA','C')
*!*	      RETURN
*!*	   ENDIF
*!*	   SET INDEX TO FACDIA

*!*	   SELECT 4
*!*	   IF !LOCK1('FACD_REG','C')
*!*	      RETURN
*!*	   ENDIF
*!*	   SET INDEX TO FACD_REG

*!*	   SELECT 2
*!*	   SEEK WFAC
*!*	   IF EOF()
*!*	      SELECT 2
*!*	      IF !LOCK1('DETAL','C')
*!*	         RETURN
*!*	      ENDIF
*!*	      SET INDEX TO DETAL

*!*	      SELECT 4
*!*	      IF !LOCK1('DET_REG','C')
*!*	         RETURN
*!*	      ENDIF
*!*	      SET INDEX TO DET_REG

*!*	      SELECT 2
*!*	      SEEK WFAC
*!*	      IF EOF()
*!*	         ERROR('ญญญ ERROR !!!','Numero Factura No Existe')
*!*	         LOOP
*!*	      ENDIF
*!*	   ENDIF
*!*	   SAVE SCREEN TO DATOS
*!*	   CAJA22()
*!*	   RESTORE SCREEN FROM DATOS
*!*	ENDDO
*!*	RETURN

*!*	*******************************************************************************
*!*	FUNCTION  CAJA22 && MUESTRA LAS FACTURAS DETAL \ EN PANTALLA 
*!*	*******************************************************************************
*!*	@ 24,2 SAY PADC('Display Factura Numero '+STRZERO(WFAC,8)+' [Esc] Salir',78) COLOR 'GR+*/BG'
*!*	SET COLOR TO W+/BG+
*!*	CLEAR          
*!*	FOR I=0 TO 24
*!*	    @ I,0 SAY REPLICATE ('ฑ',80)
*!*	NEXT I

*!*	DO WHILE .T.
*!*	   SELECT 2  && MAESTRO FACTURAS
*!*	   SEEK WFAC
*!*	   IF EOF()
*!*	      ERROR('!!!  ERROR !!!','Numero Documento Incorrecto')
*!*	      RETURN
*!*	   ENDIF
*!*	   WDTO=FDTO
*!*	   WANULA=FANULA
*!*	   WCONTRI=FCONTRI

*!*	   SELECT 3
*!*	   SEEK B->FCLIENTE
*!*	   IF EOF() 
*!*	      ERROR('!!! ERROR !!!','Cliente No Existe '+STR(B->FCLIENTE))
*!*	   ENDIF

*!*	   SELECT 4
*!*	   SEEK WFAC
*!*	   IF EOF()
*!*	      ERROR('!!! ERROR !!!','Registros Documento Incorrectos')
*!*	      RETURN
*!*	   ENDIF

*!*	   E_DET2E()     && ENCABEZADO DE LA CONSULTA
*!*	   D_CAJA2()     && CALCULO DE LA FACTURA
*!*	   F_CAJA2()     && DETALLE TOTALES FINALES
*!*	   TBCONFAC()    && MOSTRAR REGISTROS DE FACTURA

*!*	   IF LASTKEY() = 27
*!*	      RETURN
*!*	   ENDIF

*!*	ENDDO
*!*	RETURN

*!*	********************************************************
*!*	FUNCTION D_CAJA2()   && CALCULO TOTALES DE LA FACTURA
*!*	********************************************************
*!*	SELECT 4  && REGISTROS FACTURAS
*!*	DO WHILE WFAC = FNRO

*!*	// ACUMULADOR DE TOTALES GENERALES Y DESCUENTOS POR ITEM

*!*	   WTVENTA=FBSI*FCANTIDAD
*!*	   WSTOT=WTVENTA*(100-FDSCTO)*.01
*!*	   WTCOSTO=WTCOSTO+(FCOSTO*FCANTIDAD)
*!*	   WTDCTO=WTDCTO+(WTVENTA-WSTOT)

*!*	   IF CIMPVP='S'            && PRECIOS MAS IMPUESTO
*!*	      IF WCONTRI='S'    && SI CONTRIBUYENTE
*!*	         WIVA=WIVA+(WSTOT*FALICUOTA/100)
*!*	         WTOT=WTOT+WSTOT
*!*	      ELSE
*!*	         WTOT=WTOT+WSTOT*(1+FALICUOTA*.01)
*!*	      ENDIF
*!*	   ELSE
*!*	      IF WCONTRI='S'
*!*	         WIVA=WIVA+(WSTOT-(WSTOT/(1+FALICUOTA*.01)))
*!*	         WTOT=WTOT+(WSTOT/(1+FALICUOTA*.01))
*!*	      ELSE
*!*	         WTOT=WTOT+WSTOT
*!*	      ENDIF
*!*	   ENDIF
*!*	   SKIP
*!*	ENDDO

*!*	// CALCULO DESCUENTO GENERAL EN TOTAL VENTA  E IMPUESTO
*!*	   WTDCTO =WTDCTO+(WTOT*WDTO*.01)+(WIVA*WDTO*.01)

*!*	// PASAR VALORES FINALES PARA ACTUALIZAR TOTALES
*!*	   STORE WTVENTA TO WTGVENTA
*!*	   STORE WTDCTO  TO WTGDCTO
*!*	   STORE WTCOSTO TO WTGCOSTO

*!*	RETURN

*!*	*******************************************
*!*	FUNCTION F_CAJA2  && DETALLE FINAL DE CAJA2
*!*	*******************************************
*!*	TITULO='Detalle Totales Documento.....'
*!*	PANTA(18,1,23,78,1)
*!*	WIVA=WIVA-(WIVA*WDTO*.01)  && CALCULO DEL IMPUESTO C/DESCUENTO
*!*	@ 19,46 SAY 'Sub-Total '
*!*	@ 19,65 SAY TRANSFORM(WTOT,'@E 99,999,999.99')
*!*	@ 20,46 SAY 'Descuento '+IIF(WDTO>0,TRANSFORM(STR(WDTO),'999,99%'),SPACE(6))
*!*	@ 20,65 SAY TRANSFORM(WTOT*WDTO*.01,'@E 99,999,999.99')
*!*	@ 21,46 SAY 'Impuesto '+ALLTRIM(CSIGLA)
*!*	@ 21,65 SAY TRANSFORM(WIVA,'@E 99,999,999.99')
*!*	@ 22,46 SAY 'Total.... '
*!*	@ 22,65 SAY TRANSFORM(WTOT-(WTOT*WDTO*.01)+WIVA,'@E 99,999,999.99')
*!*	L=L+1
*!*	IF WANULA='*'
*!*	PASA()
*!*	@ 22,2 SAY PADC(' ญญญ Factura Anulada !!!',43) COLOR 'GR++*/R+'
*!*	ENDIF

*!*	IF ELIMINA=1
*!*	AYUDA2('[F1] Anular [F3] Imp  [F4] Cod/Des [F5] Ant. [F6 '+CHR(179)+' '+CHR(17)+CHR(217)+'] Sig. [Esc] Salir',24)
*!*	ELSE
*!*	AYUDA2('            [F4] Cod/Des  [F5] Anterior  [F6 '+CHR(179)+' '+CHR(17)+CHR(217)+'] Siguiente  [Esc] Salir',24)
*!*	ENDIF

*!*	// INICIALIZAR VARIBALES Y ACUMULADOS
*!*	   STORE 0 TO WTDCTO,WTVENTA,WTCOSTO,WTOT,WSTOT,WIVA,WDTO

*!*	RETURN

*!*	**************************************************
*!*	FUNCTION E_DET2E    && ENCABEZADO DE LA CONSULTA
*!*	**************************************************
*!*	TITULO='Consultar Documento'
*!*	PANTA(0,1,5,78,1)
*!*	SELECT 2
*!*	*IF FDOCUME='FC'
*!*	DO CASE
*!*	   CASE FPAGO='C'
*!*	        WPAGO='CONTADO'
*!*	   CASE FPAGO='CR'
*!*	        WPAGO='CREDITO'
*!*	   OTHERWISE
*!*	        WPAGO='CONTADO'
*!*	ENDCASE
*!*	*ENDIF
*!*	L=1
*!*	@ L,2   SAY 'Cliente : '+STR(FCLIENTE)+' - '+SUBSTR(FNOMBRE,1,40)
*!*	@ L,58  SAY 'Nro. : '+STRZERO(FNRO,7) COLOR 'GR+/B'
*!*	L=L+1
*!*	@ L,2   SAY 'Pago : '+WPAGO+' '+ALLTRIM(STR(FDIAS))+' dกas'
*!*	@ L,58  SAY 'Orden: '+ALLTRIM(FORDEN) COLOR 'GR+/B'
*!*	L=L+1
*!*	@ L,2   SAY ALLTRIM(FDIR1)+' '+ALLTRIM(FDIR2)
*!*	@ L,58  SAY 'Fecha: '+DTOC(csFECHA)
*!*	L=L+1
*!*	@ L,2  SAY 'Telf.: '+ALLTRIM(C->TELE1)+' - '+'Rif.: '+ALLTRIM(C->RIF)+' - '+'Nit.: '+ALLTRIM(C->NIT)
*!*	@ L,58  SAY 'Vend.: '+STRZERO(VAL(FVEND),3)
*!*	L=L+1
*!*	*@ L,2  SAY 'Telf.: '+ALLTRIM(FTELF)+' - '+'Rif.: '+ALLTRIM(FRIF)+' - '+'Nit.: '+ALLTRIM(FNIT)
*!*	*L=L+1
*!*	PANTA(6,1,17,78,0)   && 7,16
*!*	RETURN
*!*	*MEDIANO(FNRO,1,45)

*!*	*************************************************
*!*	FUNCTION CAJA61 && ANULAR FACTURA DE CAJA DETAL 
*!*	*************************************************
*!*	IF !CLAVE(1,0)
*!*	   RETURN
*!*	ENDIF
*!*	S:=ALERT('ญญญ AVISO !!!;Desea Anular la Factura;'+;
*!*	'---------------------',{'No','Si'})
*!*	IF S<>2 .or. LASTKEY()=27
*!*	   CANCELA=.F.
*!*	ENDIF

*!*	IF !CANCELA
*!*	   RETURN
*!*	ENDIF

*!*	SELECT 2    && MAESTRO DE FACTURAS
*!*	SEEK WFAC
*!*	IF !EOF()
*!*	   IF FANULA='*'
*!*	      ERROR('ญญญ ERROR !!!','Documento Anulado Anteriormente')
*!*	      RETURN
*!*	   ELSE
*!*	      RLOCK()
*!*	      REPLACE   FANULA WITH '*'  && PARA NO CONTABILIZAR EN CAJA
*!*	      UNLOCK
*!*	      PASA()                                                
*!*	   ENDIF
*!*	ELSE
*!*	    NOPASA()
*!*	    ERROR('ญญญ ERROR !!!','Documento No Existe')
*!*	    RETURN
*!*	ENDIF

*!*	SELECT 4    && REGISTROS DE LA FACTURA
*!*	SEEK WFAC
*!*	IF EOF()
*!*	   NOPASA()
*!*	   ERROR('ญญญ ERROR !!!','No se encontro Inicio Factura')
*!*	   RETURN
*!*	ELSE
*!*	   @ 24,2 SAY PADC('ญญญ AVISO !!!  Procesando por Favor Espere... ',78) COLOR 'GR+*/BG'
*!*	ENDIF

*!*	**********************************************************
*!*	// CICLO GRANDE PARA REEMPLAZAR LOS REGISTROS (ANULADOS)
*!*	**********************************************************
*!*	SELECT 4    && REGISTROS DE LA FACTURA
*!*	DO WHILE WFAC=FNRO
*!*	   RLOCK(); REPLACE FANULA     WITH '*' ; PASA(); UNLOCK  

*!*	   // *** VARIABLES DE TRABAJO ***
*!*	      WCODIGO=D->FCODIGO ;   WCANT=D->FCANTIDAD
*!*	      WPRECIO=D->FBSI    ;   WCOSTO=D->FCOSTO
*!*	      
*!*	      CAJA21G() // *** CREAR REGISTROS EN NOTAS DE CREDITO (DEVOLUCIONES)
*!*	                  
*!*	               // *** REBAJAR COMISIONES AL VENDEDOR Y AUMENTAR SUS DEVOLUCIONES

*!*	      CAJA23()  // *** AGREGAR ARTICULOS AL INVENTARIO NUEVAMENTE ***
*!*	       
*!*	      CAJA24()  // *** ACTUALIZAR MOVIMIENTO DEL INVENTARIO ***

*!*	      CAJA25()  // *** ACTUALIZAR TOTALES GENERALES ***

*!*	   SELECT 4
*!*	   SKIP
*!*	ENDDO
*!*	@ 24,2 SAY PADC('ญญญ AVISO !!!  Proceso Completo...',78) COLOR 'GR+*/BG'

*!*	****************************************************************
*!*	// *** Imprimir el documento por el formato del usuario*
*!*	// *** MEJORAR CUAL FORMATO SELECCIONAR DEPENDE DEL CLIENTE
*!*	****************************************************************
*!*	S2:=ALERT('ญญญ AVISO !!!;Desea Imprimir la Nota de Credito;'+;
*!*	    '----------.------------',{'No','Si'})
*!*	    IF S2<>2 .or. LASTKEY()=27
*!*	       CANCELA2=.F.
*!*	    ENDIF
*!*	    IF !CANCELA2
*!*	       RETURN
*!*	    ENDIF

*!*	    MENDEV40()

*!*	RETURN

*!*	********************************************************************
*!*	FUNCTION CAJA21G && PROGRAMA DE GRABAR REGISTROS A NOTAS DE CREDITOS
*!*	*                && REGISTROS Y MAESTRO(ENCABEZADO)
*!*	********************************************************************
*!*	SELECT 5
*!*	IF !LOCK1('NCRE_REG','C')   && REGISTROS  NOTAS DE CREDITOS (MAESTRO)
*!*	RETURN
*!*	ENDIF
*!*	SET INDEX TO NCRE_REG

*!*	SELECT 7                   && NOTAS  ENCABEZADO (MAESTRO)
*!*	IF !LOCK1('NCREDITO','C')
*!*	RETURN
*!*	ENDIF
*!*	SET INDEX TO NCREDITO,FNCREDITO, ANCREDITO,KNCREDITO

*!*	GO BOTT
*!*	WNCRE=(FNRO+1)

*!*	AYUDA2('PROCESANDO DOCUMENTO AL MAESTRO DE NOTAS DE CREDITOS ...',24)

*!*	SELECT 2   && MAESTRO (NOTAS O FACTURAS)
*!*	SEEK WFAC
*!*	IF !EOF()

*!*	   // PASE REGISTROS NOTAS DE_CREDITOS(DEVOLUCIONES)

*!*	   SELECT 7   && ENCABEZADO DE MAESTRO
*!*	   FLOCK()   
*!*	   APPEND BLANK

*!*	   REPLACE FNRO      WITH WNCRE                && GRABA EL NRO. DE LA NOTA DE CREDITO NUEVA
*!*	   REPLACE FORDEN    WITH ALLTRIM(STR(WFAC))   && GRABA EL NRO. DE FACTURA DETAL

*!*	   REPLACE KEYFECHA  WITH dtos(date());  REPLACE FFECHA    WITH csfecha
*!*	   REPLACE FVEND     WITH B->FVEND    ;  REPLACE FDOCUME   WITH B->FDOCUME
*!*	   REPLACE FCONTRI   WITH B->FCONTRI  ;  REPLACE FBULTO    WITH B->FBULTO
*!*	   REPLACE FRIF      WITH B->FRIF     ;  REPLACE FNIT      WITH B->FNIT
*!*	   REPLACE FVIA      WITH B->FVIA     ;  REPLACE FPAGO     WITH B->FPAGO
*!*	   REPLACE FDIAS     WITH B->FDIAS    ;  REPLACE FDTO      WITH B->FDTO
*!*	   REPLACE FIVA      WITH B->FIVA     ;  REPLACE FCONTRI   WITH B->FCONTRI
*!*	   REPLACE FJURIDICO WITH B->FJURIDICO;  REPLACE FPAGO     WITH B->FPAGO
*!*	   ***REPLACE FGIROS    WITH B->FGIROS
*!*	   REPLACE FCLIENTE  WITH B->FCLIENTE ;  REPLACE FNOMBRE   WITH B->FNOMBRE
*!*	   REPLACE FDIR1     WITH B->FDIR1    ;  REPLACE FDIR2     WITH B->FDIR2
*!*	   REPLACE FTELF     WITH B->FTELF    ;  REPLACE FNOTA1    WITH B->FNOTA1
*!*	   REPLACE FNOTA2    WITH B->FNOTA2   ;  REPLACE FNOTA3    WITH B->FNOTA3
*!*	   REPLACE FMAYDET   WITH 'D'  && DETAL
*!*	   REPLACE FACTUA    WITH 'A'  && CONTABILIZAR LA DEVOLUCION
*!*	   UNLOCK            
*!*	   COMMIT

*!*	   SELECT 4   && GRABAR REGISTROS A TABLA NOTAS DE CREDITOS (REGISTROS)
*!*	   SEEK WFAC
*!*	   IF !EOF()
*!*	      DO WHILE WFAC=FNRO

*!*	      // PASE DE RESGISTROS DE NOTAS DE CREDITO (DEVOLUCIONES)

*!*	      SELECT 5  && PASE DE RESGISTROS AL MAESTRO DE FACTURAS (REGISTROS)
*!*	      FLOCK()   
*!*	      APPEND BLANK
*!*	      REPLACE FNRO      WITH WNCRE       ; REPLACE FCODIGO   WITH D->FCODIGO
*!*	      REPLACE FREFEREN  WITH D->FREFEREN ; REPLACE FDESCRIP  WITH D->FDESCRIP
*!*	      REPLACE FMEDIDA   WITH D->FMEDIDA  ; REPLACE FCANTIDAD WITH D->FCANTIDAD
*!*	      REPLACE FBSI      WITH D->FBSI     ; REPLACE FBS       WITH D->FBS
*!*	      REPLACE FCOSTO    WITH D->FCOSTO   ; REPLACE FALICUOTA WITH D->FALICUOTA
*!*	      REPLACE FDSCTO    WITH D->FDSCTO   ; REPLACE FALTERNO  WITH D->FALTERNO 
*!*	      REPLACE FUNIDAD   WITH D->FUNIDAD  ; REPLACE FGTIA     WITH D->FGTIA
*!*	      REPLACE FCANBUL   WITH D->FCANBUL

*!*	      SELECT 4
*!*	      SKIP

*!*	      ENDDO
*!*	   ENDIF
*!*	   UNLOCK
*!*	ENDIF
*!*	STORE WNCRE TO WFAC
*!*	RETURN

*!*	**************************************************************************
*!*	FUNCTION CAJA23 && AGREGAR ARTICULOS AL INVENTARIO NUEVAMENTE          ***
*!*	                // INCREMENTAR AL INVENTARIO Y RESTAR VENTAS ARTICULOS ***
*!*	**************************************************************************
*!*	SELECT 5
*!*	IF !LOCK1('INVEN','C')
*!*	RETURN
*!*	ENDIF
*!*	SET INDEX TO IINVEN,DINVEN,RINVEN,AINVEN,LINVEN,MINVEN,XINVEN,ICODEBAR  && MINVEN=MARCA/XINVEN=MEDIDA

*!*	SELECT 5
*!*	SEEK WCODIGO
*!*	IF EOF()
*!*	   ERROR('ญญญ ERROR !!!','Codigo Producto No Encontrado '+ALLTRIM(WCODIGO))
*!*	   RETURN
*!*	ENDIF

*!*	// REMPLAZAR EN INVENTARIO

*!*	RLOCK()
*!*	REPLACE EXIST     WITH (EXIST+WCANT)
*!*	REPLACE CANT_DEV  WITH (CANT_DEV+WCANT)
*!*	UNLOCK
*!*	COMMIT
*!*	RETURN

*!*	*************************************************************
*!*	FUNCTION CAJA24 && ** ACTUALIZAR MOVIMIENTO DEL INVENTARIO **
*!*	*************************************************************
*!*	SELECT 2 && MAESTRO DE FACTURAS O DETAL
*!*	WFECHA=csfecha && B->FFECHA
*!*	WDOCUME=B->FDOCUME
*!*	WFAC=B->FNRO

*!*	SELECT 7
*!*	IF !LOCK1('MOVINV','C')
*!*	RETURN
*!*	ENDIF
*!*	SET INDEX TO MMOVINV,IMOVINV,KMOVINV,CMOVINV,DMOVINV,SMOVINV

*!*	SELECT 7
*!*	GO BOTTOM
*!*	WTRAN=MTRAN+1

*!*	FLOCK()
*!*	APPEND BLANK
*!*	REPLACE MTRAN     WITH WTRAN        ; REPLACE MNRO      WITH WFAC
*!*	REPLACE KEYFECHA  WITH DTOS(WFECHA) ; REPLACE MFECHA    WITH WFECHA
*!*	REPLACE MCODIGO   WITH WCODIGO      ; REPLACE MREFEREN  WITH E->REFERENCIA
*!*	REPLACE MDESCRIP  WITH E->DESCRIP   ; REPLACE MCANTIDAD WITH WCANT
*!*	REPLACE MCOSTO    WITH WCOSTO       ; REPLACE MDOCUME   WITH WDOCUME 
*!*	REPLACE MSTATU    WITH 'D' && DEVOLUCION
*!*	REPLACE MVENTA    WITH 'D' && Detal
*!*	REPLACE MPRECIO   WITH WPRECIO
*!*	REPLACE MCANT_ANT WITH E->EXIST-WCANT  && EXISTENCIA ANTERIOR P/MOVIMIENTOS
*!*	UNLOCK
*!*	COMMIT
*!*	RETURN

*!*	*****************************************************
*!*	FUNCTION CAJA25 && REBAJAR TOTALES EN VENTAS AL DETAL
*!*	*****************************************************
*!*	SELECT 8
*!*	IF !LOCK1('TOTALES','C')
*!*	   RETURN
*!*	ENDIF
*!*	SET INDEX TO KTOTALES, ITOTALES

*!*	IF !NOREG('TOTALES')
*!*	   RETURN
*!*	ENDIF

*!*	// *** GRABAR CAMBIOS EN TOTALES 
*!*	RLOCK()
*!*	REPLACE TDEV_DET    WITH  TDEV_DET+WTGVENTA
*!*	REPLACE TCOSTODET   WITH  TCOSTODET-WTGCOSTO
*!*	REPLACE TDCTOS_DET  WITH  TDCTOS_DET-WTGDCTO
*!*	COMMIT
*!*	RETURN

*!*	**************************************************
*!*	FUNCTION R_DEV40 && REIMPRIMIR DOCUMENTOS ANULADOS
*!*	**************************************************
*!*	IF B->FANULA=='*'
*!*	   SELECT 7  && MAESTRO DE DEVOLUCIONES
*!*	   IF !LOCK1('NCREDITO','C')
*!*	      RETURN
*!*	   ENDIF
*!*	   SET INDEX TO FNCREDITO,NCREDITO,ANCREDITO,KNCREDITO

*!*	   SEEK ALLTRIM(STR(WFAC))
*!*	   IF !EOF()
*!*	      IF FMAYDET=='D'
*!*	         wFac := FNRO
*!*	         MENDEV40()
*!*	      ENDIF
*!*	   ELSE
*!*	      ERROR('ญญญ ERROR !!!','Numero Documento No Existe')
*!*	   ENDIF
*!*	ENDIF
*!*	RETURN
