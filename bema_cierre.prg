**// Funciones de las Operaciones No Fiscales 

DECLARE INTEGER Bematech_FI_InformeGerencial IN "BEMAFI32.DLL" STRING cTexto
DECLARE INTEGER Bematech_FI_CierraInformeGerencial IN "BEMAFI32.DLL"


**//Nota
**//Solamente maximo 618 caracteres


**-----------------------------------------------
**//Impresion Fiscal
**-----------------------------------------------
**TEXT 

iRetorno = Bematech_FI_InformeGerencial(+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
"Cierre de Caja"+CHR(13)+CHR(10)+;
"Cajero "+xCajero+CHR(13)+CHR(10)+;
"Fecha  "+DTOC(xfecha)+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
"Total Impuesto..."+transform(TotalI,'9999,999.99')+CHR(13)+CHR(10)+;
"Total Base......."+TRANSFORM(TotalB,'9999,999.99')+CHR(13)+CHR(10)+;
"Total Exento....."+TRANSFORM(TotalEx,'9999,999.99')+CHR(13)+CHR(10)+;
"Total_Ventas....."+transform(TotalB+TotalI+TotalEx,'9999,999.99')+CHR(13)+CHR(10)+;
"Total Efectivo..."+TRANSFORM(TotalEf,'9999,999.99')+CHR(13)+CHR(10)+;
"Total Cheque....."+transform(TotalCh,'9999,999.99')+CHR(13)+CHR(10)+;
"Total Tarjeta...."+transform(TotalTa,'9999,999.99')+CHR(13)+CHR(10)+;
"Total Otro......."+transform(TotalOt,'9999,999.99')+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
"_____________________________________"+CHR(13)+CHR(10)+;
"Firma Cajero"+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
"_____________________________________"+CHR(13)+CHR(10)+;
"Firma Supervisor"+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10))
										

iRetorno = Bematech_FI_CierraInformeGerencial() 

**ENDTEXT


RETURN