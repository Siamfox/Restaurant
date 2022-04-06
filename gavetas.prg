**-----------------------------------------------------------------
**--Gaveta Activa por Segun Puerto Serial
**-----------------------------------------------------------------
**--Abrir por Puerto Asignado como Gaveta desde Panel de Control
**--Dirigir segun Nombre del Printer/Gaveta/		
*SET PRINTER TO NAME 'imp_caja'
	
SET PRINTER TO NAME 'EPSON TM-U220'

WAIT windows 'AVISO, ABRIENDO GAVETA DINERO ...' NOWAIT 

*!*	??? CHR(27) + 'p' + CHR(0) + CHR(100) + CHR(250)


**--Impresora Bixolo 270
*Samsung	 SRP 270	 27,112,0,25,250
*Samsung	 SRP 270A	 27,112,0,64,240
*Samsung	 SRP 270	 27,112,48,55,121
**<1B><70><30><37><79> && en hexadecimal

???CHR(27)+CHR(112)+CHR(0)+CHR(25)+CHR(250)
*!*	???CHR(27)+CHR(112)+CHR(0)+CHR(64)+CHR(240)
*!*	???CHR(27)+CHR(112)+CHR(48)+CHR(55)+CHR(121)


*Código para Abrir la Caja de Dinero.
*!*	??? CHR(27)+'p'+CHR(0)+CHR(40)+CHR(250)        
*!*	??? CHR(7)


SET PRINTER TO 
RETURN

