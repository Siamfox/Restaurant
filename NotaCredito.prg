*****************************************************
FUNCTION CAJA61 && ANULAR FACTURA O ITEM SELECCIONADO  
*****************************************************
PARAMETER XITEM
IF !CLAVE(1,0)
   RETURN
ENDIF
S:=ALERT('ннн AVISO !!!; Item(s) Marcados para Anular ; Seguro Desea Continuar;'+;
'---------------------',{'No','Si'})
IF S<>2 .or. LASTKEY()=27
   RETURN && CANCELA=.F.
ENDIF

**IF !CANCELA
**   RETURN
**ENDIF

TITULO='  Ctrol '    
PANTA(11,20,15,60,1)
*@ 13,21 SAY 'No. Ctrol Factura : '+TRANSFORM(WFAC3,'999999')    VALID WFAC3>0
SET COLOR TO &CEL_SET
@ 15,21 SAY '<ESC> Salir' 
SET COLOR TO &CLR_SET
@ 12,21 SAY 'No. Ctrol (COO)   : 'GET WCOO  PICT '999999' VALID WCOO>0
READ
@ 13,21 SAY 'No. Ctrol Factura : 'GET WFAC3 PICT '999999' VALID WFAC3>0
READ
IF LASTKEY()=27 .OR. WCOO=0 .OR. WFAC3=0
   ERROR('!!! Error !!!','Error en Datos incompletos')
   RETURN
ENDIF

S:=ALERT('ннн AVISO !!!; Datos Correctos, Desea Continuar;'+;
'---------------------',{'No','Si'})
IF S<>2 .or. LASTKEY()=27
   RETURN && CANCELA=.F.
ENDIF

SELECT 2    && MAESTRO DE FACTURAS
SEEK WFAC
IF !EOF()
   // VALIDAR TIPO DE ANULACION
      DO CASE
         CASE XITEM=1  && ANULAR UN ITEM O VARIOS ITEM
              // ANULACION PARCIAL DE LA FACTURA

         CASE XITEM=2  && ELIMINAR TODOS LOS ITEM
              IF FANULA='*'
                 ERROR('ннн ERROR !!!','Documento Completamente Anulado Anteriormente')
                 RETURN
              ELSE    
                 RLOCK()
                 REPLACE   FANULA WITH '*'  && PARA NO CONTABILIZAR EN CAJA
                 UNLOCK
                 PASA()
              ENDIF
      ENDCASE
ELSE
    NOPASA()
    ERROR('ннн ERROR !!!','Documento No Existe '+str(wfac))
    RETURN
ENDIF

SELECT 4    && REGISTROS DE LA FACTURA
SEEK WFAC
IF EOF()
   NOPASA()
   ERROR('ннн ERROR !!!','No se encontro Inicio Factura')
   RETURN
ELSE
   @ 24,2 SAY PADC('ннн AVISO !!!  Procesando por Favor Espere... ',78) COLOR 'GR+*/BG'
ENDIF

**********************************************************
// CICLO GRANDE PARA REEMPLAZAR LOS REGISTROS (ANULADOS)
**********************************************************
SELECT 4    && REGISTROS DE LA FACTURA
DO WHILE WFAC=FNRO 

   // FILTRAR POR ARTICULO ANULADOS
      DO CASE
         CASE XITEM=1  && ANULAR X ITEM SELECCIONADO
         CASE XITEM=2  && ANULAR TODOS LOS ITEM COMPLETOS
              RLOCK(); REPLACE FANULA     WITH '*' ; PASA(); UNLOCK
      ENDCASE

      IF FANULA=='*'
         // *** VARIABLES DE TRABAJO PARA EL ITEM A ANULAR ***
                WCODIGO=D->FCODIGO    ;   WCANT=D->FCANTIDAD
                WPRECIO=D->FBSI       ;   WCOSTO=D->FCOSTO
                WDESCRIP=D->FDESCRIP

         // *** REBAJAR COMISIONES AL VENDEDOR Y AUMENTAR SUS DEVOLUCIONES

            CAJA23()  // *** AGREGAR ARTICULOS AL INVENTARIO NUEVAMENTE ***
       
            CAJA24()  // *** ACTUALIZAR MOVIMIENTO DEL INVENTARIO ***

            CAJA25()  // *** ACTUALIZAR TOTALES GENERALES ***
      ENDIF

      SELECT 4
      SKIP

ENDDO

CAJA21G() // *** CREAR REGISTROS EN NOTAS DE CREDITO (DEVOLUCIONES)

@ 24,2 SAY PADC('ннн AVISO !!!  Proceso Completo...',78) COLOR 'GR+*/BG'

****************************************************************
// *** Imprimir el documento por el formato del usuario*
// *** MEJORAR CUAL FORMATO SELECCIONAR DEPENDE DEL CLIENTE
****************************************************************
S2:=ALERT('ннн AVISO !!!;Imprimir Nota de Credito;'+;
    '----------.------------',{'No','Si'})
    IF S2<>2 .or. LASTKEY()=27
       RETURN  &&CANCELA2=.F.
    ENDIF
    **IF !CANCELA2
    **   RETURN
    **ENDIF

    **MENDEV40() // IMPRIME OK
    NCFIS40()  && NOTAS DE CREDTO FISCAL PARA BEMATECH 2100


RETURN

********************************************************************
FUNCTION CAJA21G && PROGRAMA DE GRABAR REGISTROS A NOTAS DE CREDITOS
*                && REGISTROS Y MAESTRO(ENCABEZADO)
********************************************************************
SELECT 5
IF !LOCK1('NCRE_REG','C')   && REGISTROS  NOTAS DE CREDITOS (MAESTRO)
RETURN
ENDIF
SET INDEX TO NCRE_REG

SELECT 7                    && NOTAS  ENCABEZADO (MAESTRO)
IF !LOCK1('NCREDITO','C')
RETURN
ENDIF
SET INDEX TO NCREDITO,FNCREDITO, ANCREDITO,KNCREDITO

GO BOTT
WNCRE=(FNRO+1)

AYUDA2('PROCESANDO DOCUMENTO AL MAESTRO DE NOTAS DE CREDITOS ...',24)

SELECT 2   && MAESTRO (NOTAS O FACTURAS)
SEEK WFAC
IF !EOF()

// PASE REGISTROS NOTAS DE_CREDITOS(DEVOLUCIONES)

   SELECT 7   && ENCABEZADO DE MAESTRO
   FLOCK()   
   APPEND BLANK

   REPLACE FNRO      WITH WNCRE                 && GRABA EL NRO. DE LA NOTA DE CREDITO NUEVA
   REPLACE FORDEN    WITH ALLTRIM(STR(WFAC3))   && GRABA EL NRO. DE FACTURA DETAL

// NRO, CTROL FISCAL (COO)
   REPLACE FCOO      WITH WCOO               && NRO. CTROL (COO) FISCAL

// FECHA Y HORA CREACION DE LA N/C FISCAL EN EL SISTEMA
   REPLACE KEYFECHA  WITH DTOS(DATE())       && FECHA SISTEMA
   REPLACE FFECHA    WITH CSFECHA            && FECHA SISTEMA
   REPLACE FTIME     WITH AMPM(TIME())       && HORA CONTROL

// FECHA Y HORA REGISTRADOS EN LA FACTURA FISCAL
   REPLACE FECHA2    WITH B->FFECHA          && FECHA DE LA FACTURA
   REPLACE FTIME2    WITH B->FTIME           && HORA DE LA FACTURA

   REPLACE FVEND     WITH B->FVEND    ;  REPLACE FDOCUME   WITH B->FDOCUME
   REPLACE FCONTRI   WITH B->FCONTRI  ;  REPLACE FBULTO    WITH B->FBULTO
   REPLACE FRIF      WITH B->FRIF     ;  REPLACE FNIT      WITH B->FNIT
   REPLACE FVIA      WITH B->FVIA     ;  REPLACE FPAGO     WITH B->FPAGO
   REPLACE FDIAS     WITH B->FDIAS    ;  REPLACE FDTO      WITH B->FDTO
   REPLACE FIVA      WITH B->FIVA     ;  REPLACE FCONTRI   WITH B->FCONTRI
   REPLACE FJURIDICO WITH B->FJURIDICO;  REPLACE FPAGO     WITH B->FPAGO
   ***REPLACE FGIROS    WITH B->FGIROS
   REPLACE FCLIENTE  WITH B->FCLIENTE ;  REPLACE FNOMBRE   WITH B->FNOMBRE
   REPLACE FDIR1     WITH B->FDIR1    ;  REPLACE FDIR2     WITH B->FDIR2
   REPLACE FTELF     WITH B->FTELF    ;  REPLACE FNOTA1    WITH B->FNOTA1
   REPLACE FNOTA2    WITH B->FNOTA2   ;  REPLACE FNOTA3    WITH B->FNOTA3
   REPLACE FMAYDET   WITH 'D'  && DETAL
   REPLACE FACTUA    WITH 'A'  && CONTABILIZAR LA DEVOLUCION
   UNLOCK            
   *COMMIT

   SELECT 4   && GRABAR REGISTROS ANULADOS A TABLA NOTAS CREDITOS (REGISTROS)
   SEEK WFAC
   IF !EOF()

    DO WHILE WFAC=FNRO

       // FILTRAR POR ARTICULO ANULADOS 
          IF FANULA=='*'  

          // PASE DE RESGISTROS DE NOTAS DE CREDITO (DEVOLUCIONES)
             SELECT 5  && PASE DE RESGISTROS AL MAESTRO DE FACTURAS (REGISTROS)
             FLOCK()   
             APPEND BLANK
             REPLACE FNRO      WITH WNCRE       ; REPLACE FCODIGO   WITH D->FCODIGO
             REPLACE FREFEREN  WITH D->FREFEREN ; REPLACE FDESCRIP  WITH D->FDESCRIP
             REPLACE FMEDIDA   WITH D->FMEDIDA  ; REPLACE FCANTIDAD WITH D->FCANTIDAD
             REPLACE FBSI      WITH D->FBSI     ; REPLACE FBS       WITH D->FBS
             REPLACE FCOSTO    WITH D->FCOSTO   ; REPLACE FALICUOTA WITH D->FALICUOTA
             REPLACE FDSCTO    WITH D->FDSCTO   ; REPLACE FALTERNO  WITH D->FALTERNO 
             REPLACE FUNIDAD   WITH D->FUNIDAD  ; REPLACE FGTIA     WITH D->FGTIA
             REPLACE FCANBUL   WITH D->FCANBUL

          ENDIF
     
          SELECT 4
          SKIP

    ENDDO
   ENDIF
   UNLOCK
ENDIF
STORE WNCRE TO WFAC  && VALOR DE NUMERO DE NCREDITO A LISTAR
RETURN

**************************************************************************
FUNCTION CAJA23 && AGREGAR ARTICULOS AL INVENTARIO NUEVAMENTE          ***
                // INCREMENTAR AL INVENTARIO Y RESTAR VENTAS ARTICULOS ***
**************************************************************************
SELECT 5
IF !LOCK1('INVEN','C')
RETURN
ENDIF
SET INDEX TO IINVEN,DINVEN,RINVEN,AINVEN,LINVEN,MINVEN,XINVEN,ICODEBAR  && MINVEN=MARCA/XINVEN=MEDIDA

SELECT 5
SEEK WCODIGO
IF EOF()
   ERROR('ннн ERROR !!!','Codigo Art.<No Encontrado>, No se ingreso devolucion ->'+ALLTRIM(WCODIGO))
   RETURN
ENDIF

// REMPLAZAR EN INVENTARIO

RLOCK()
REPLACE EXIST     WITH (EXIST+WCANT)
REPLACE CANT_DEV  WITH (CANT_DEV+WCANT)
UNLOCK
*COMMIT
RETURN

*************************************************************
FUNCTION CAJA24 && ** ACTUALIZAR MOVIMIENTO DEL INVENTARIO **
*************************************************************
SELECT 2 && MAESTRO DE FACTURAS O DETAL
WFECHA=csfecha && B->FFECHA
WDOCUME=B->FDOCUME
WFAC=B->FNRO

SELECT 7
IF !LOCK1('MOVINV','C')
RETURN
ENDIF
SET INDEX TO MMOVINV,IMOVINV,KMOVINV,CMOVINV,DMOVINV,SMOVINV

SELECT 7
GO BOTTOM
WTRAN=MTRAN+1

FLOCK()
APPEND BLANK
REPLACE MTRAN     WITH WTRAN        ; REPLACE MNRO      WITH WFAC
REPLACE KEYFECHA  WITH DTOS(WFECHA) ; REPLACE MFECHA    WITH WFECHA
REPLACE MCODIGO   WITH WCODIGO      ; REPLACE MREFEREN  WITH E->REFERENCIA
REPLACE MDESCRIP  WITH WDESCRIP
REPLACE MCANTIDAD WITH WCANT
REPLACE MCOSTO    WITH WCOSTO       ; REPLACE MDOCUME   WITH WDOCUME 
REPLACE MSTATU    WITH 'D' && DEVOLUCION
REPLACE MVENTA    WITH 'D' && Detal
REPLACE MPRECIO   WITH WPRECIO
REPLACE MCANT_ANT WITH E->EXIST-WCANT  && EXISTENCIA ANTERIOR P/MOVIMIENTOS
UNLOCK
*COMMIT
RETURN

*****************************************************
FUNCTION CAJA25 && REBAJAR TOTALES EN VENTAS AL DETAL
*****************************************************
SELECT 8
IF !LOCK1('TOTALES','C')
   RETURN
ENDIF
SET INDEX TO KTOTALES, ITOTALES

IF !NOREG('TOTALES')
   RETURN
ENDIF

// *** GRABAR CAMBIOS EN TOTALES 
RLOCK()
REPLACE TDEV_DET    WITH  TDEV_DET+WTGVENTA
REPLACE TCOSTODET   WITH  TCOSTODET-WTGCOSTO
REPLACE TDCTOS_DET  WITH  TDCTOS_DET-WTGDCTO
*COMMIT
RETURN

**************************************************
FUNCTION R_DEV40 && REIMPRIMIR DOCUMENTOS ANULADOS
**************************************************
IF B->FANULA=='*'
   SELECT 7  && MAESTRO DE DEVOLUCIONES
   IF !LOCK1('NCREDITO','C')
      RETURN
   ENDIF
   SET INDEX TO FNCREDITO,NCREDITO,ANCREDITO,KNCREDITO

   SEEK ALLTRIM(STR(WFAC))
   IF !EOF()
      IF FMAYDET=='D'
         wFac := FNRO
         **MENDEV40()  // IMPRIME OK
         NCFIS40()  && NOTAS DE CREDTO FISCAL PARA BEMATECH 2100
      ENDIF
   ELSE
      ERROR('ннн ERROR !!!','Numero Documento No Existe')
   ENDIF
ENDIF
RETURN

**************************************************
FUNCTION ANULITEM  && ANULAR UN ITEM SELECCIONADO
**************************************************
SELECT 4    && REGISTROS DE LA FACTURA
IF BOF() .OR. EOF()  
   NOPASA()
   ERROR('ннн ERROR !!!','No se encontro Item Seleccionado')
   RETURN
ELSE
   IF FANULA='*'
      S2:=ALERT('ннн AVISO !!!;Item ya Seleccionado para Anular ; Desea Desmarcar...?;'+;
      '---------------------',{'No','Si'})
      IF S2<>2 .or. LASTKEY()=27
      *ELSE
         RLOCK(); REPLACE FANULA     WITH ' ' ; PASA(); UNLOCK
         PASA()
         ERROR('ннн AVISO !!!','Item, Desmarcado')
      ENDIF
   ELSE
      RLOCK(); REPLACE FANULA     WITH '*' ; PASA(); UNLOCK
      SWANULA=1
   ENDIF

   @ 24,2 SAY PADC('ннн AVISO !!!  Item Marcado como Seleccionado... ',78) COLOR 'GR+*/BG'
ENDIF
RETURN
