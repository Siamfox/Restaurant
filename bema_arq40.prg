**// Funciones de las Operaciones No Fiscales 

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

TEXT 
"Billetes_100...."+xb100+"............"+cb100+;
"Billetes_50....."+xb50+ "............"+cb50+;
"Billetes_20....."+xb20+ "............"+cb20+;
"Billetes_10....."+xb10+ "............"+cb10+;
"................................................"+;
"Total Efectivo........................"+cTotal+;
"................................................"+;
"Firma Cajero____________________________________"+;
"................................................"+;
"................................................"+;
"Firma Supervisor________________________________")
										

ENDTEXT

