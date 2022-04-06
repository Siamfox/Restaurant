**--Funcion Imprimir archivo de texto(txt)
**--

PARAMETERS ximpresora

	*WAIT windows 'Imprimiendo archivo   '+'&xarchivo ' TIMEOUT .02
	WAIT windows 'Imprimiendo Impresora '+'&ximpresora ' TIMEOUT .02 


	*set printer to name getprinter() 	&& funciona perfectamente aca es la api para seleccionar muy bueno
	SET PRINTER TO NAME '&ximpresora' 	&& aca es directo contra la cola de impresion 
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

	****
	??? CHR(15)

	****

	?'...'
	
	set device to screen 
	set printer to 
	set printer off 
	set console on 

RETURN