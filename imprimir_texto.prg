**--Funcion Imprimir archivo de texto(txt)
**--

PARAMETERS xarchivo &&,ximpresora

*!*	MESSAGEBOX(xarchivo)
*!*	MESSAGEBOX(ximpresora)

*f=fopen("temporal.txt") 
f=fopen(xarchivo+".txt") 
*!*	if f>0 

*!*		WAIT windows 'Imprimiendo archivo   '+'&xarchivo ' &&TIMEOUT .02
*!*		WAIT windows 'Imprimiendo Impresora '+'&ximpresora ' && TIMEOUT .02 


	*set printer to name getprinter() 	&& funciona perfectamente aca es la api para seleccionar muy bueno
	*SET PRINTER TO NAME '&ximpresora' 	&& aca es directo contra la cola de impresion 
	set device to printer 
	set console off 
	set printer on 
	


*!*		*Se inicializa el codigo de Impresion de Tiket's
*!*		*??? CHR(27)+CHR(48)+CHR(27)+CHR(67)+CHR(44)
*!*		???  CHR(18)+CHR(27)+CHR(77)+CHR(15)
*!*		???  CHR(27)+CHR(77)+CHR(20)

*!*		*Código para Abrir la Caja de Dinero.
*!*		??? CHR(27)+'p'+CHR(0)+CHR(40)+CHR(250)        
*!*		??? CHR(7)

*!*		****
*!*		??? CHR(15)

*!*		****

	do while !feof(f) 
		cadena=fgets(f) 
		?cadena 
		*MESSAGEBOX(ALLTRIM(cadena))
	enddo 
	

*!*	ELSE

*!*		MESSAGEBOX('Error, no se encontro archivo plano/(txt) para impresion...') 
*!*		
*!*	ENDIF 

set printer off 
set console on 
set printer to 
set device to screen

RETURN

**--Borrar archvo txt
*fclose(xarchivo+".txt") 
*a=LOCFILE(xarchivo+".txt")
*MESSAGEBOX(a)
*!*	IF !EMPTY(a)
*!*		DELETE FILE xarchivo.txt
*!*	ENDIF 



*!*	SET CONSOLE OFF 
*!*	SET DEVICE TO PRINT 
*!*	SET PRINTER TO 
*!*	SET PRINTER TO NAME Epson LX-300 Fact 

*!*	REPORT FORM &pdirc.reportes\pedvta ALL FOR pedido2.numsold=mpedini2 ; 
*!*	       TO PRINT NOCONSOLE 

*!*	SET DEVICE TO SCREEN 
*!*	SET PRINTER off 
*!*	SET PRINTER TO 
*!*	SET CONSOLE ON 


*!*	NET USE LPT1: \BARRA\PERSISTENT:YES