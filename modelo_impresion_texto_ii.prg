*!*	Bixolón:
*!*	** Imprimir

*!*	SET PRINTER TO NAME ALLTRIM(param.impticket)
*!*	SET CONSOLE OFF

*!*	*Se inicializa el codigo de Impresion de Tiket's
*!*	*??? CHR(27)+CHR(48)+CHR(27)+CHR(67)+CHR(44)
*!*	???  CHR(18)+CHR(27)+CHR(77)+CHR(15)
*!*	???  CHR(27)+CHR(77)+CHR(20)

*!*	*Código para Abrir la Caja de Dinero.
*!*	??? CHR(27)+'p'+CHR(0)+CHR(40)+CHR(250)        
*!*	??? CHR(7)

*!*	****
*!*	??? CHR(15)

*!*	****

*!*	??? CHR(10)+CHR(13)+PADC(ALLTRIM(vNomEmpr),40," ")
*!*	IF !EMPTY(vRfc)
*!*	        ??? CHR(10)+CHR(13)+PADC("RFC: "+ALLTRIM(vRfc),40," ")
*!*	ENDIF
*!*	??? CHR(10)+CHR(13)+PADC(ALLTRIM(vCalle)+" "+ALLTRIM(vColonia),40," ")
*!*	??? CHR(10)+CHR(13)+PADC(ALLTRIM(vCiudad),40," ")

*!*	IF !EMPTY(vCodPos)
*!*	        ??? CHR(10)+CHR(13)+PADC("C.P.: "+ALLTRIM(vCodPos),40," ")
*!*	ENDIF

*!*	IF !EMPTY(vtel1)
*!*	        ??? CHR(10)+CHR(13)+PADC("Tel.: "+ALLTRIM(vtel1),40," ")
*!*	ENDIF

*!*	??? CHR(10)+CHR(13)+""
*!*	??? CHR(10)+CHR(13)+""

*!*	??? "Cliente: "+ALLTRIM(c_ctevt.nomcte)
*!*	??? CHR(10)+CHR(13)+""

*!*	vHora = TIME()
*!*	??? CHR(10)+CHR(13)+"FECHA Y HORA: "+TTOC(DATETIME()) &&+" "+vHora
*!*	??? CHR(10)+CHR(13)+""
*!*	??? CHR(10)+CHR(13)+"Cant    Codigo     Precio U     Importe"
*!*	??? CHR(10)+CHR(13)+"----------------------------------------"

*!*	IF !param.notaresum
*!*	        SELECT vTablaPv
*!*	        vCantidad = 0
*!*	        SCAN
*!*	                ??? CHR(10)+CHR(13)+SUBSTR(descrip,1,40)
*!*	                vLinea = TRANSFORM(cantidad,"99")+"  "+codprod+"
*!*	"+TRANSFORM(preciou,"99,999.99")+"    "+TRANSFORM(totalr,"$99,999.99")
*!*	                ??? CHR(10)+CHR(13)+vLinea
*!*	                vCantidad = vCantidad + cantidad
*!*	        ENDSCAN
*!*	ELSE
*!*	        SELECT vTablaPv
*!*	        REPLACE codprod2 WITH SUBSTR(codprod,1,6) all
*!*	        
*!*	        ** Select para concentrar los registros por modelo.
*!*	        SELECT SUBSTR(codprod,1,6) as
*!*	codprod,SUBSTR(descrip,1,LEN(ALLTRIM(descrip))-9) as descrip,SUM(cantidad)
*!*	as cantidad,preciou,SUM(cantidad * preciou) as totalr;
*!*	        FROM vTablaPv;
*!*	        GROUP BY codprod2;
*!*	        INTO CURSOR NotaResum
*!*	        vCantidad = 0
*!*	        SCAN
*!*	                ??? CHR(10)+CHR(13)+SUBSTR(descrip,1,40)
*!*	                vLinea = TRANSFORM(cantidad,"99")+"  "+codprod+"
*!*	"+TRANSFORM(preciou,"99,999.99")+"    "+TRANSFORM(totalr,"$99,999.99")
*!*	                ??? CHR(10)+CHR(13)+vLinea
*!*	                vCantidad = vCantidad + cantidad
*!*	        ENDSCAN
*!*	        SELECT NotaResum
*!*	        USE
*!*	ENDIF

*!*	??? CHR(10)+CHR(13)+"----------------------------------------"
*!*	??? CHR(10)+CHR(13)+"Total de Articulos: "+ALLTRIM(STR(vCantidad))
*!*	??? CHR(10)+CHR(13)+" "
*!*	IF thisform.txtimpDesc.Value > 0
*!*	        ??? CHR(10)+CHR(13)+PADL("Descuento:
*!*	"+TRANSFORM(thisform.txtimpDesc.Value,"999,999.99"),40," ")
*!*	ENDIF
*!*	IF thisform.txtimpIva.Value > 0
*!*	        ??? CHR(10)+CHR(13)+PADL("Impuesto:
*!*	"+TRANSFORM(thisform.txtimpIva.Value,"999,999.99"),40," ")
*!*	ENDIF
*!*	*??? CHR(27)+CHR(69)+"1"
*!*	??? CHR(10)+CHR(13)+PADL("Total:
*!*	"+TRANSFORM(thisform.txttotpag.Value,"999,999.99"),40," ")
*!*	??? CHR(10)+CHR(13)+" "
*!*	*??? CHR(27)+CHR(69)+"0"
*!*	??? CHR(10)+CHR(13)+cantlet(thisform.txttotpag.value)
*!*	??? CHR(10)+CHR(13)+" "
*!*	??? CHR(10)+CHR(13)+PADC("*** GRACIAS POR SU COMPRA ***",40," ")
*!*	??? CHR(10)+CHR(13)+" "
*!*	??? CHR(10)+CHR(13)+"Su
*!*	Pago:"+TRANSFORM(thisform.txtpagacon.Value,"99,999.99")+"   Su
*!*	Cambio:"+TRANSFORM(thisform.txtCambio.Value,"99,999.99")
*!*	??? CHR(10)+CHR(13)+" "
*!*	??? CHR(10)+CHR(13)+"Cambio: "+factenc.serfac+factenc.folfac
*!*	??? CHR(10)+CHR(13)+" "
*!*	??? CHR(10)+CHR(13)+PADC("Devoluciones solo por defecto de fábrica",40," ")
*!*	??? CHR(10)+CHR(13)+" "
*!*	??? CHR(10)+CHR(13)+" "
*!*	??? CHR(10)+CHR(13)+" "
*!*	??? CHR(10)+CHR(13)+" "
*!*	??? CHR(10)+CHR(13)+" "
*!*	??? CHR(10)+CHR(13)+" "
*!*	??? CHR(10)+CHR(13)+" "

*!*	CLOSE PRINT
*!*	SET CONSOLE ON
*!*	SET PRINTER TO