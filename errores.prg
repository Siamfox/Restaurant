*!*	******************************************************************************
*!*	PROCEDURE errhand &&Manejo de Errores
*!*	******************************************************************************
PARAMETER merror, mess, mess1, mprog, mlineno
**//Por Pantalla Errores Severos
CLEAR
_Screen. BackColor = RGB(255,255,255)
=messagebox("Ocurrió un error " + "en Programa " + mprog + chr(13)+;
CHR(13)+" Por favor, consulte a su programador",0+64,"¡ATENCIÓN!") 

**//Grabar Error en Archivo Plano ERRORES.LOG
*SET PRINTER off
SET printer TO errores.txt additive
??? 'Fecha y Hora             : ' + DTOC(DATE())+' - '+ time()+CHR(13)+CHR(10)
??? 'Error número             : ' + LTRIM(STR(merror))+CHR(13)+CHR(10)
??? 'Mensaje de error         : ' + mess+CHR(13)+CHR(10)
??? 'Línea de código con error: ' + mess1+CHR(13)+CHR(10)
??? 'Número de línea del error: ' + LTRIM(STR(mlineno))+CHR(13)+CHR(10)
??? 'Programa con error       : ' + mprog +CHR(13)+CHR(10)
??? REPLICATE('-',120)+CHR(13)+CHR(10)

close database
quit
return

