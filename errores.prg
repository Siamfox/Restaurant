*!*	******************************************************************************
*!*	PROCEDURE errhand &&Manejo de Errores
*!*	******************************************************************************
PARAMETER merror, mess, mess1, mprog, mlineno
**//Por Pantalla Errores Severos
CLEAR
_Screen. BackColor = RGB(255,255,255)
=messagebox("Ocurri� un error " + "en Programa " + mprog + chr(13)+;
CHR(13)+" Por favor, consulte a su programador",0+64,"�ATENCI�N!") 

**//Grabar Error en Archivo Plano ERRORES.LOG
*SET PRINTER off
SET printer TO errores.txt additive
??? 'Fecha y Hora             : ' + DTOC(DATE())+' - '+ time()+CHR(13)+CHR(10)
??? 'Error n�mero             : ' + LTRIM(STR(merror))+CHR(13)+CHR(10)
??? 'Mensaje de error         : ' + mess+CHR(13)+CHR(10)
??? 'L�nea de c�digo con error: ' + mess1+CHR(13)+CHR(10)
??? 'N�mero de l�nea del error: ' + LTRIM(STR(mlineno))+CHR(13)+CHR(10)
??? 'Programa con error       : ' + mprog +CHR(13)+CHR(10)
??? REPLICATE('-',120)+CHR(13)+CHR(10)

close database
quit
return

