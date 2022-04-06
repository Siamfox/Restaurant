**// Funciones de las Operaciones No Fiscales 

DECLARE INTEGER Bematech_FI_InformeGerencial IN "BEMAFI32.DLL" STRING cTexto
DECLARE INTEGER Bematech_FI_CierraInformeGerencial IN "BEMAFI32.DLL"



**//Nota
**//Solamente maximo 618 caracteres


**-------------------------------
** -- Billetes
**-------------------------------

STORE SPACE(4)  TO xb100,xb50,xb20,xb10,xb5,xb2
STORE SPACE(10) TO cb100,cb50,cb20,cb10,cb5,cb2,ctotal

xb100=RTRIM(STR(nb100/100))
xb50=RTRIM(STR(nb50/50))
xb20=RTRIM(STR(nb20/20))
xb10=RTRIM(STR(nb10/10))
xb5=RTRIM(STR(nb5/5))
xb2=RTRIM(STR(nb2/2))

cb100=RTRIM(STR(nb100))
cb50=RTRIM(STR(nb50))
cb20=RTRIM(STR(nb20))
cb10=RTRIM(STR(nb10))
cb5=RTRIM(STR(nb5))
cb2=RTRIM(STR(nb2))


*!*	**-------------------------------
*!*	** -- Monedas
*!*	**-------------------------------
*!*	nm1=thisform.spinner7.value*1
*!*	nm50=thisform.spinner8.value*.50
*!*	nm25=thisform.spinner9.value*.25
*!*	nm10=thisform.spinner10.value*.10


*!*	**-------------------------------
*!*	** -- Totalizar
*!*	**-------------------------------
cTotal=RTRIM(STR(nb100+nb50+nb20+nb10+nb5+nb2+nm1+nm50+nm25+nm10))


iRetorno = Bematech_FI_InformeGerencial(+;
" "+CHR(13)+CHR(10)+;
"... Aqueo de Caja ..."+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
"Cajero        "+xu003+CHR(13)+CHR(10)+;
"Fecha y Hora  "+DTOC(DATETIME())+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
"Billetes(100)"+TRANSFORM(xb100,'9999')+"..."+TRANSFORM(cb100,'99999999.99')+CHR(13)+CHR(10)+;
"Billetes (50)"+TRANSFORM(xb50 ,'9999')+"..."+TRANSFORM(cb50 ,'99999999.99')+CHR(13)+CHR(10)+;
"Billetes (20)"+TRANSFORM(xb20 ,'9999')+"..."+TRANSFORM(cb20 ,'99999999.99')+CHR(13)+CHR(10)+;
"Billetes (10)"+TRANSFORM(xb10 ,'9999')+"..."+TRANSFORM(cb10 ,'99999999.99')+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
"Total Efectivo"+TRANSFORM(cTotal,'99999999.99')+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
"_____________________________________"+;
"Firma Cajero"+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
"_____________________________________"+;
"Firma Supervisor"+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10)+;
" "+CHR(13)+CHR(10))
										

iRetorno = Bematech_FI_CierraInformeGerencial() 