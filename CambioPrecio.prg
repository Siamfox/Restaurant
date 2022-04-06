*******************************************************  
FUNCTION INV9 && PROGRAMA DE CAMBIAR PRECIOS POR LINEAS
*******************************************************  
IF !CLAVE(1,0)
   RETURN
ENDIF

DO WHILE .T.
SET SOFTSEEK ON
SET CURSOR ON
SET INTENSI ON
WLINEA=0
WCALCULO='A'
WBASE=3
STORE 0 TO WPOR1, WPOR2, WPOR3
RETURNING=.F.

TITULO='Cambiar de Precios'
PANTA(7,2,22,77,1)
WCASE=1
@  8,3 PROMPT  '1_ Selecci¢n de L¡neas ' 
@  9,3 PROMPT  '2_ Todas    las L¡neas ' 
MENU TO WCASE
SAVE SCREE TO PANTA4
DO CASE
   CASE WCASE=1
        INV91()
   CASE WCASE=2
        INV92()
   CASE LASTKEY()=27
        EXIT
ENDCASE
RESTO SCREE FROM PANTA4
ENDDO
SALIDA()
RETURN

*****************************************************
FUNCTION INV91  && POR SELECCION
*****************************************************
SELECT 1
IF !LOCK1('LINEA','C')
RETURN
ENDIF
SET INDEX TO ILINEA,NLINEA

SELECT 2
IF !LOCK1('INVEN','C')
RETURN
ENDIF
SET INDEX TO LINVEN

@ 10,3 SAY 'Desde el N£mero de L¡nea ' 
@ 11,3 SAY 'Hasta el N£mero de L¡nea ' 

DO WHILE .T.
   SET CURSOR ON
   SET INTENSI ON
   STORE 0 TO WLINEA,WLINEA1,WLINEA2
   STORE 0 TO WPOR
   RETURNING=.F.

   SELECT 1
   SET KEY  9 TO TBLIN()
   SET KEY 13 TO TBLIN()
   @ 10,29 GET WLINEA PICT '9999'
   READ
   IF LASTKEY()=27 .AND. !RETURNING
      SALIDA()
      RETURN
   ENDIF
   IF EMPTY(WLINEA)
      SALIDA()
      RETURN
   ENDIF
   STORE WLINEA TO WLINEA1
   @ 10,30 SAY STRZERO(WLINEA1,4)

   STORE 0 TO WLINEA
   SET KEY  9 TO TBLIN()
   SET KEY 13 TO TBLIN()
   @ 11,29 GET WLINEA PICT '9999'
   READ
   IF LASTKEY()=27 .AND. !RETURNING
      STORE WLINEA1 TO WLINEA2
   ELSE
      STORE WLINEA TO WLINEA2
   ENDIF
   @ 11,30 SAY STRZERO(WLINEA2,4)
   INKEY(0)
   IF WLINEA1>WLINEA2
      ERROR('­­­ ERROR !!!','NUMERO DE LINEA COMIENZO ES MAYOR A LINEA FINAL')
   ENDIF
   STORE WLINEA1 TO WLINEA
   SET KEY  9 TO
   SET KEY 13 TO

   SELECT 1
   SEEK WLINEA
    IF EOF()
       ERROR('­­­ ERROR !!!','* LINEA NO EXISTE *')
       SALIDA()
       RETURN
    ENDIF

   SELECT 2 
   SEEK WLINEA
    IF EOF()
       ERROR('­­­ ERROR !!!','NO HAY PRODUCTOS EN ESTA LINEA '+STR(WLINEA))
       LOOP
    ENDIF

   @ 12,3 SAY 'Linea...'+ALLTRIM(A->LNOMBRE)
   @ 13,3 SAY 'Coloque % Mayor  ' GET WPOR1 PICT  '999.99'
   @ 14,3 SAY 'Coloque % Oferta ' GET WPOR2 PICT  '999.99'
   @ 15,3 SAY 'Coloque % P.V.P  ' GET WPOR3 PICT  '999.99'
   @ 16,3 SAY '<A>umentar o <D>isminuir Calculo ' GET WCALCULO PICT '!@' VALID WCALCULO $'AD' 
   @ 18,3 SAY 'Base de Calculo [1->Ultimo Costo] [2->Costo Promedio] [3->Precio]' GET WBASE PICT  '9' RANGE 1,3
   READ
   IF !CONFORME('­­­ AVISO !!!','Desea Procesar')
      LOOP
   ENDIF
   IF WPOR1=0 .AND. WPOR2=0 .AND. WPOR3=0
      ERROR('­­­ ERROR !!!','NO HAY ( % ) EN PRECIOS')
      SALIDA()
      RETURN
   ENDIF
  
   @ 24,0 SAY PADC('Procesando por Favor Espere...  [ESC] SALIR',80) color 'gr++*/bg' 

   SELECT 1  && Lineas
   SEEK WLINEA
   IF EOF()
      ERROR('­­­ ERROR !!!','NO HAY PRODUCTOS EN ESTA LINEA '+STR(WLINEA))
      LOOP
   ENDIF

   SELECT 2  && Inventario
   SEEK WLINEA
   IF EOF()
      ERROR('­­­ ERROR !!!','NO HAY PRODUCTOS EN ESTA LINEA '+STR(WLINEA))
      LOOP
   ENDIF
   DO WHILE WLINEA<=WLINEA2 .AND. !EOF()
      RLOCK()
      IF WCALCULO='A'
         DO CASE
            CASE WBASE=1 && Calcula en Base a Ultimo Costo
                 REPLACE PRE1 WITH ROUND(COSTO+(COSTO*WPOR1*.01),-1)
                 REPLACE PRE2 WITH ROUND(COSTO+(COSTO*WPOR2*.01),-1)
                 REPLACE PRE3 WITH ROUND(COSTO+(COSTO*WPOR3*.01),-1)
            CASE WBASE=2 && Calcula en Base a Costo Promedio
                 REPLACE PRE1 WITH ROUND(COSTO_PRO+(COSTO_PRO*WPOR1*.01),-1)
                 REPLACE PRE2 WITH ROUND(COSTO_PRO+(COSTO_PRO*WPOR2*.01),-1)
                 REPLACE PRE3 WITH ROUND(COSTO_PRO+(COSTO_PRO*WPOR3*.01),-1)
            CASE WBASE=3 && Calcula en Base a Precios
                 REPLACE PRE1 WITH ROUND(PRE1+(PRE1*WPOR1*.01),-1)
                 REPLACE PRE2 WITH ROUND(PRE2+(PRE2*WPOR2*.01),-1)
                 REPLACE PRE3 WITH ROUND(PRE3+(PRE3*WPOR3*.01),-1)
         ENDCASE
      ELSE
         && Calcula en Base a Precios
            REPLACE PRE1 WITH ROUND(PRE1/(1+WPOR1*.01),-1)  
            REPLACE PRE2 WITH ROUND(PRE2/(1+WPOR2*.01),-1)  
            REPLACE PRE3 WITH ROUND(PRE3/(1+WPOR3*.01),-1)
      ENDIF
      UNLOCK
      SKIP
      IF LINEA<>WLINEA 
         STORE LINEA TO WLINEA
         SALTOLIN5()
      ENDIF
   ENDDO
   COMMIT
   @ 24,0 SAY PADC('Procesando Terminado...  [ESC] SALIR',80) color 'gr++*/bg' 
   NOPASA()
   EXIT
ENDDO
SET SOFTSEEK OFF
SALIDA()
RETURN

*****************************************************
FUNCTION INV92  && TODAS LAS LINEAS
*****************************************************
SET CURSOR ON
SET INTENSI ON
STORE 0 TO WLINEA
WCALCULO='A'
STORE 0 TO WPOR1, WPOR2, WPOR3

SELECT 2
IF !LOCK1('INVEN','C')
RETURN
ENDIF
SET INDEX TO LINVEN

@ 12,3 SAY 'Linea...(Todas)'
@ 13,3 SAY 'Coloque % Mayor  ' GET WPOR1 PICT  '999.99'
@ 14,3 SAY 'Coloque % Oferta ' GET WPOR2 PICT  '999.99'
@ 15,3 SAY 'Coloque % P.V.P  ' GET WPOR3 PICT  '999.99'
@ 16,3 SAY '<A>umentar o <D>isminuir Calculo ' GET WCALCULO PICT '!@' VALID WCALCULO $'AD' 
@ 18,3 SAY 'Base de Calculo [1->Ultimo Costo] [2->Costo Promedio] [3->Precio]' GET WBASE PICT  '9' RANGE 1,3
READ
IF !CONFORME('­­­ AVISO !!!','Desea Procesar')
   RETURN
ENDIF
IF WPOR1=0 .AND. WPOR2=0 .AND. WPOR3=0
   ERROR('­­­ ERROR !!!','NO HAY (%) EN PRECIOS')
   SALIDA()
   RETURN
ENDIF
  
@ 24,0 SAY PADC('Procesando por Favor Espere...  [ESC] SALIR',80) color 'gr++*/bg' 

SELECT 2
GO TOP
DO WHILE !EOF()
   RLOCK()
   IF WCALCULO='A'
      DO CASE
         CASE WBASE=1 && Calcula en Base a Ultimo Costo
              REPLACE PRE1 WITH ROUND(COSTO+(COSTO*WPOR1*.01),-1)
              REPLACE PRE2 WITH ROUND(COSTO+(COSTO*WPOR2*.01),-1)
              REPLACE PRE3 WITH ROUND(COSTO+(COSTO*WPOR3*.01),-1)
         CASE WBASE=2 && Calcula en Base a Costo Promedio
              REPLACE PRE1 WITH ROUND(COSTO_PRO+(COSTO_PRO*WPOR1*.01),-1)
              REPLACE PRE2 WITH ROUND(COSTO_PRO+(COSTO_PRO*WPOR2*.01),-1)
              REPLACE PRE3 WITH ROUND(COSTO_PRO+(COSTO_PRO*WPOR3*.01),-1)
         CASE WBASE=3 && Calcula en Base a Precios
              REPLACE PRE1 WITH ROUND(PRE1+(PRE1*WPOR1*.01),-1)
              REPLACE PRE2 WITH ROUND(PRE2+(PRE2*WPOR2*.01),-1)
              REPLACE PRE3 WITH ROUND(PRE3+(PRE3*WPOR3*.01),-1)
      ENDCASE
   ELSE
      && Calcula en Base a Precios
         REPLACE PRE1 WITH ROUND(PRE1/(1+WPOR1*.01),-1)  
         REPLACE PRE2 WITH ROUND(PRE2/(1+WPOR2*.01),-1)  
         REPLACE PRE3 WITH ROUND(PRE3/(1+WPOR3*.01),-1)  
   ENDIF
   SKIP
ENDDO
COMMIT
@ 24,0 SAY PADC('Procesando Terminado...  [ESC] SALIR',80) color 'gr++*/bg' 
NOPASA()
SALIDA()
RETURN
