*!*	************************ 
*!*	Procedure imprime_ptoVta 
*!*	************************ 
*!*	* Author: Luis Alberto Turbi 
*!*	* Fecha 01-07-2005 
*!*	* Revision 25-06-2010 
*!*	************************* 
*!*	Lparameters cSalida 
*!*	Local nRegistros As Integer 
*!*	Store 0 To nRegistros 
*!*	If Empty(cSalida) 
*!*	        cSalida = "P"  && Pantalla 
*!*	Endif 
*!*	*!*        If Set("PRINTER") = "OFF" Or Set("DEVICE")#"PRINTER" 
*!*	*!*                Wait Windows "Impresora Fuera de Lugar.... Procediendo a 
*!*	Incializarla" Nowait Timeout 3 
*!*	*!*                =InicializaImpresora() 
*!*	*!*                Wait Clear 
*!*	*!*        Endif 
*!*	*If cSalida = "P"  && Pantalla 
*!*	Local cArchivo As Character 
*!*	Store "tmp"+Substr(Sys(2015),3,6)+".txt" To cArchivo 
*!*	Select mdesfac2 
*!*	Go Top 
*!*	*  Preparación inicial 
*!*	Set Printer Off 
*!*	Set Console Off 
*!*	Set Alternate To (cArchivo) 
*!*	Set Alternate On 
*!*	*Else 
*!*	*        Set Console Off 
*!*	*        Set Device To Printer 
*!*	*        Set Printer On 
*!*	*        Select CONFIG 
*!*	*        Set Printer To lpt1 
*!*	*Endif 
*!*	If Upper(Left(Allt(Os(1)),10))="WINDOWS NT" Or Upper(Left(Allt(Os(1)), 
*!*	10))="WINDOWS 5." 
*!*	*Si es Windows XP no se hará nada, únicamente si fuese otro Windows 
*!*	Else 
*!*	*        ???Chr(130) 
*!*	Endif 
*!*	*@0,0 Say Chr(27)+"p"+Chr(0)+Chr(200)+Chr(255)  &&Abrir caja.  de 
*!*	Dinero 
*!*	*?Chr(27)+Chr(97)+Chr(1)   &&Agrandar el tamaño de la letra 
*!*	*?Padc("GRUPO ALCA", 40, Space(1)) Font 'Courier',10  Style 'BN' 
*!*	?Padc(Upper(Alltrim(mdesfac2.EMPRESA)), 40, Space(1)) Font 'Courier', 
*!*	14 Style 'BU' 
*!*	?Padc("RNC: "+Upper(Alltrim(mdesfac2.rnc)), 40, Space(1)) Font 
*!*	'Courier',8 
*!*	*?Chr(27)+Chr(97)+Chr(0)   &&Regrearlo a su estado natural 
*!*	*???Chr(15) &&CONDEN = 15 ==>CONDENSADO 
*!*	?Proper(Substr(mdesfac2.direccion,1,40)) Font 'Courier',6 
*!*	?Padc("Tel.: "+Alltrim(mdesfac2.telefono1)+" 
*!*	"+Alltrim(mdesfac2.telefono2), 40, Space(1)) Font 'Courier',6 
*!*	?Iif(mdesfac2.TP_FACTURA="CONT","FACTURA AL CONTADO","FACTURA A 
*!*	CREDITO")+Space(3)+"FECHA: "+Dtoc(mdesfac2.fecha) Font 'Courier',8 
*!*	*?Chr(27)+Chr(97)+Chr(1)   &&Agrandar el tamaño de la letra 
*!*	?"CLIENTE: "+Iif(mdesfac2.EXPEDIENTE 
*!*	="000001",mdesfac2.NOMBRECLI,mdesfac2.NOMBRES) Font 'Courier',6 
*!*	?Padc("FACTURA NO "+ Padl(Allt(Str(mdesfac2.NO_FACTURA)),6,"0"), 40, 
*!*	Space(1)) Font 'Courier',8 
*!*	?Padc("NCF: "+Alltrim(cNCF_FT)+Padl(Alltrim(Str(nNCF_FTS)),8,"0"), 40, 
*!*	Space(1))  Font 'Courier',8 
*!*	?Padc(Iif(Substr(Alltrim(cNCF_FT),9,3)="101","*** VALIDA PARA CREDITO 
*!*	FISCAL ***","*** CONSUMIDOR FINAL ***"), 40, Space(1)) 
*!*	*?Chr(27)+Chr(97)+Chr(0)   &&Regrearlo a su estado natural 
*!*	?Padc('=', 40, '=') Font 'Courier',8                && Raya 
*!*	?Padc(" CANT     DESCRIPCION       IMPORTE   ", 40, Space(1)) Font 
*!*	'Courier',8 
*!*	?Padc('=', 40, '=') Font 'Courier',8                && Raya 
*!*	Scan 
*!*	**Acá viene el bloque de impresión de la factura o recibo 
*!*	*        ?Str(mdesfac2.cantidad, 
*!*	6,0),Alltrim(mdesfac2.des_pro),Alltrim(mdesfac2.unidad),Alltrim(Transform((mdesfac2.cantidad*mdesfac2.precio) 
*!*	+mdesfac2.ITBIS,'@Z 999,999.99')) 
*!*	* 02-05-2010 Porblema del redeondeo Carolina 
*!*	        ?Str(mdesfac2.cantidad, 
*!*	6,0),Alltrim(mdesfac2.des_pro),Iif(Isnull(Alltrim(mdesfac2.unidad)),"",Alltrim(mdesfac2.unidad)), ; 
*!*	                iif(mdesfac2.precio=0 And Allt(mdesfac2.COD_PRO)<>"000001","BONO 
*!*	OFE.",Alltrim(Transform((mdesfac2.valor),'@Z 999,999.99'))) 
*!*	        nRegistros=nRegistros+1 
*!*	Endscan 
*!*	?Padc('=', 40, '=') Font 'Courier',8                && Raya 
*!*	Go Top 
*!*	?Padl("SUBTOTAL....:"+Transform(mdesfac2.Valor_brut,"999,999,999.99"), 
*!*	40, Space(1))         Font 'Courier',8 Style 'I' 
*!*	?Padl("DESCUENTO...:"+Transform(mdesfac2.Descuento2,"999,999,999.99"), 
*!*	40, Space(1))         Font 'Courier',8 Style 'I' 
*!*	?Padl("ITBIS.......:"+Transform(mdesfac2.Itebis,"999,999,999.99"), 40, 
*!*	Space(1))                Font 'Courier',8 Style 'I' 
*!*	* ?Padl("10% PROPINA.:"+Transform(mdesfac2.TOTAL10,"999,999,999.99"), 
*!*	40, Space(1))                Font 'Courier',8 Style 'I' && 10% para los meseros 
*!*	VERSION RESTAURANT 
*!*	?Padl("TOTAL NETO..:"+Transform(mdesfac2.valor2,"999,999,999.99"), 40, 
*!*	Space(1))                Font 'Courier',8 Style 'B' 
*!*	?"" 
*!*	?Padl("FORMA DE PAGO..:"+Iif(VAL_EFE>0," EFE ","")+Iif(VAL_TAR>0," TAR 
*!*	","")+Iif(VAL_CHE>0," CHE ","")+Iif(credito>0," CRED ","") 
*!*	+Iif(NUMNOTACR>0," NT CR ",""), 40, Space(1))                Font 'Courier',8 Style 
*!*	'I' 
*!*	?Padl("PAGO........:"+Transform((VAL_EFE+VAL_TAR 
*!*	+VAL_CHE),"999,999,999.99"), 40, Space(1))                Font 'Courier',8 Style 'I' 
*!*	?Padl("DEVUELTA....:"+Transform(mdesfac2.devuelta,"999,999,999.99"), 
*!*	40, Space(1))                 Font 'Courier',8 Style 'I' 
*!*	* ?"Cantidad de Renglones.:",Alltrim(Transform(nRegistros,"@Z 
*!*	999,999,999.99")) Font 'Courier',8 Style 'I' 
*!*	?Padc(Upper(Alltrim(mdesfac2.cnota)), 40, Space(1)) 
*!*	?"Cajera: ",Allt(mdesfac2.usuario)+Space(5)+"Vendedor: 
*!*	",Allt(mdesfac2.user_prefact) Font 'Courier',6 
*!*	?Padc("GRACIAS", 40, Space(1)) 
*!*	**Acá al final debe cortar el papel 
*!*	?Chr(10) 
*!*	?Chr(27)+"p"+Chr(0)+Chr(200)+Chr(255)  &&Abrir caja. 
*!*	If Upper(Left(Allt(Os(1)),10))<>"WINDOWS NT" Or Upper(Left(Allt(Os(1)), 
*!*	10))="WINDOWS 5." 
*!*	        ? 
*!*	        ? 
*!*	        ? 
*!*	        ? 
*!*	*!*                ?Chr(27)+Chr(64) 
*!*	*!*                ?Chr(27)+Chr(97)+Chr(100)+Chr(10)  &&Avanzar el papel 
*!*	*!*                ?Chr(27)+"m"  &&Corte Parcialmente 
*!*	Else 
*!*	*Si no es XP no hace nada 
*!*	Endif 
*!*	Set Alternate Off 
*!*	Set Alternate To 
*!*	If cSalida = "P"  && Pantalla 
*!*	        Modify File (cArchivo) Noedit 
*!*	Else 
*!*	        Select CONFIG 
*!*	        If CONFIG.lPrintName 
*!*	                If Empty(CONFIG.printName) 
*!*	                        Set Printer To lpt1 
*!*	                Else 
*!*	                        Set Printer To Name (Alltrim(CONFIG.printName)) 
*!*	                Endif 
*!*	        Else 
*!*	                Set Printer To lpt1 
*!*	        Endif 
*!*	        Set Printer On 
*!*	        Set Device To Printer 
*!*	        ! Type &cArchivo > prn 
*!*	        Set Printer To 
*!*	        Set Printer To Defaul 
*!*	Endif 
*!*	Set Console On 
*!*	Set Printer To 
*!*	Set Printer To Default 
*!*	Set Device To Screen 
*!*	Endproc 