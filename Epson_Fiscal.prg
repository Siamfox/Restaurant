*============================================================================
* Ejemplo:            Foxpro para impresoras fiscales Epson de Tickets 
* Requiere:           Cargar el driver para FoxPro con la funcion
*                     SET LIBRARY <driver fiscal>
*
* DONDE <driver fiscal> es la libreria segun la siguiente tabla
* ====================================================
* Lenguaje       Impresora           < driver fiscal>
* ====================================================
* VisualFoxPro    Todas               tm20vf32.fll
* FoxPro 2.6 Win  Todas               tm20vf16.fll 
* FoxPro 2.6 Dos  Todas               tm20plb.plb
* Valido para:        Impresoras fiscales EPSON
*============================================================================

SET TALK ON

*** IMPORTANTE: Elegir y cambiar el driver segun la tabla anterior

SET LIBRARY TO tm20vf32.fll
 
 * Abrir el puerto COM1 con IF_OPEN
 * SI la impresora esta en el COM2 cambiar COM1 a COM2
 * SI la impresora esta a 19200 cambiar la velocidad a 19200

 port = IF_OPEN("COM2",9600 ) 
 
 *Error en la apertura del puerto de comuniaciones
 
 IF port < 0      
  ? "Error en la apertura del puerto de comunicaciones"
  RETURN
 ENDIF


 STORE 1 TO mielecc

 DO WHILE .T.

 CLEAR

 SET MESSAGE TO 24 CENTER

 @ 1,20 PROMPT '1. Imprimir CierreZ' 
 @ 3,20 PROMPT '2. Imprimir Ticket'  
 @ 5,20 PROMPT '3. Imprimir Ticket-Factura'
 @ 7,20 PROMPT '4. Imprimir Documento No Fiscal'
 @ 11,20 PROMPT 'ESC = Salir'

 MENU TO mielecc

 DO CASE
	CASE mielecc = 1
         err = CierreZ()
	CASE mielecc = 2
         err = ImprimirTicket()
	CASE mielecc = 3
         err = ImprimirFactura()
        CASE mielecc = 4
 	 err = ImprimirNoFiscal()
	CASE mielecc = 0
              EXIT
 ENDCASE  
 ENDDO

 ** IMPORTANTE: Siempre cerrar puerto o quedara abierto e inaccesible

 err =  IF_CLOSE()

SET LIBRARY TO

** Function ImprimirNoFiscal()
Function ImprimirNoFiscal

 err = IF_WRITE("@OpenNonfiscalReceipt")
 err = IF_WRITE("@PrintNonfiscalText|TEXTO NO FISCAL")
 err = IF_WRITE("@CloseNonfiscalReceipt")

 IF err <> 0
    Do ReportarError
 ELSE
    ** Recuperar el numero de ticket de la respuesta fiscal 
    nfactura = VAL( IF_READ(3)) 
    return nfactura
 ENDIF
return err

** Function Cancelar Ticket

Function CancelTicket

   err = IF_WRITE("@SINCRO")

return err

** Function Imprimir Ticket

Function ImprimirTicket

  err = IF_WRITE("@OpenFiscalReceipt")
  err = IF_WRITE("@PrintFiscaltext|Texto fiscal")

  * item 1:  tasa 9%, y precio neto $2.5

  err = IF_WRITE("@PrintLineItem|Manzanas|1|2.5|0.09|M")

  **   HAGO UN PAGO POR $10
  err = IF_WRITE("@ReturnRecharge|PAGO|10.0|T")

  **  PIDO EL SUBTOTAL Y CIERRO EL TICKET

  err = IF_WRITE("@Subtotal")

  err = IF_WRITE("@CloseFiscalReceipt")

  ** si hay error cancelar el ticket
   IF err <> 0
    Do ReportarError
   ELSE
    ** Recuperar el numero de ticket de la respuesta fiscal 
    nfactura = VAL( IF_READ(3)) 
    return nfactura
   ENDIF
return err

** Function Imprimir Ticket Factura

Function ImprimirFactura
   
   err = IF_WRITE("@OpenFiscalReceipt|INCEPAR LTDA|J123456789")
   
   * item 1:  tasa 9%, y precio neto $10.5
   err = IF_WRITE("@PrintLineItem|ARTICULO 1|1|10.50|0.09|M")
   
   *  item 2: tasa 0% (Exento) y precio neto $12.50
   err = IF_WRITE("@PrintLineItem|ARTICULO 2|1|12.50|0.09|M")

   **   HAGO UN PAGO POR $100
   err = IF_WRITE("@ReturnRecharge|PAGO|100.0|T")

   **  PIDO EL SUBTOTAL Y CIERRO LA FACTURA

   err = IF_WRITE("@Subtotal")

   err = IF_WRITE("@CloseFiscalReceipt")
   
   ** si hay error cancelar la factura
   IF err <> 0
    Do ReportarError
   ELSE
    nfactura = VAL( IF_READ(3))
    return nfactura
   ENDIF
  
return err

** Function Imprimir CierreZ

Function CierreZ
   err = IF_WRITE("@DailyClose|Z")
return err


PROCEDURE ReportarError

 DECLARE aPRNStat[16]
 DECLARE aFISStat[16]

 STORE 1 TO nI
 
 cMsg = ""

 aPRNStat[01] = "Bit  1 " + "Impresora Ocupada"
 aPRNStat[02] = "Bit  2 " + "Impresora Seleccionada"
 aPRNStat[03] = "Bit  3 " + "Error en la Impresora"
 aPRNStat[04] = "Bit  4 " + "Impresora Fuera de L¡nea"
 aPRNStat[05] = "Bit  5 " + "Poco papel auditor¡a"
 aPRNStat[06] = "Bit  6 " + "Poco papel"
 aPRNStat[07] = "Bit  7 " + "Buffer impresora lleno"
 aPRNStat[08] = "Bit  8 " + "Buffer impresora vacio"
 aPRNStat[09] = "Bit  9 " + "Sin uso"
 aPRNStat[10] = "Bit 10 " + "Sin uso"
 aPRNStat[11] = "Bit 11 " + "Sin uso"
 aPRNStat[12] = "Bit 12 " + "Sin uso"
 aPRNStat[13] = "Bit 13 " + "Caj¢n de Dinero Abierto"
 aPRNStat[14] = "Bit 14 " + "Sin uso"
 aPRNStat[15] = "Bit 15 " + "Impresora sin Papel"
 aPRNStat[16] = "Bit 16 " + "Bits 0-6 Activados"

 **  Estados FISCALES (EPSON!!!)

 aFISStat[01] =  "Bit  1 " + "Checkeo de Memoria Fiscal !MAL!"
 aFISStat[02] =  "Bit  2 " + "Checkeo RAM de Trabajo !MAL!"
 aFISStat[03] =  "Bit  3 " + "Bater¡a BAJA "
 aFISStat[04] =  "Bit  4 " + "Comando NO Reconocido "
 aFISStat[05] =  "Bit  5 " + "Campo de Datos INVALIDO "
 aFISStat[06] =  "Bit  6 " + "Comando Inv lido para el Estado L¢gico del Equipo"
 aFISStat[07] =  "Bit  7 " + "Se va a producir el OVERFLOW en los Acumuladores del equipo"
 aFISStat[08] =  "Bit  8 " + "La memoria Fiscal esta LLENA "
 aFISStat[09] =  "Bit  9 " + "La memoria fiscal se esta por LLENAR"
 aFISStat[10] =  "Bit 10 " + "El Impresor tiene N£mero de Serie(Certificado)"
 aFISStat[11] =  "Bit 11 " + "El controlador Fiscal esta Fiscalizado"
 aFISStat[12] =  "Bit 12 " + "Se llego al M ximo de Items o se requiere un cierre del d¡a"
 aFISStat[13] =  "Bit 13 " + "Documento Fiscal Abierto"
 aFISStat[14] =  "Bit 14 " + "Documento Abierto "
 aFISStat[15] =  "Bit 15 " + "Factura abierta, Hoja Suelta"
 aFISStat[16] =  "Bit 16 " + "OR de bits 0-8 da 1 "


 ? "Estado de la impresora:" + CHR(13) + CHR(10)

 FOR nI = 1 TO 16
    IF IF_ERROR1(nI) > 0
      cMsg = cMsg + aPRNStat[nI] + CHR(13)+CHR(10)
    ENDIF
 NEXT

 ? cMsg

 cMsg = ""

 ? "Estado del controlador fiscal:"  + CHR(13) + CHR(10)

 FOR nI = 1 TO 16
    IF IF_ERROR2(nI) > 0
      cMsg = cMsg + aFISStat[nI] + CHR(13)+CHR(10)
    ENDIF
 NEXT

 ? cMsg

 IF INKEY(0) <> 0
 ENDIF

RETURN

