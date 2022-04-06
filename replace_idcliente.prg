*---------------------------------------------------
*--- Enrutar Almacenamiento y Programas 
*---------------------------------------------------
**lcArchivos="C:\Archivos de programa\Siamfox\data"
**druta=SYS(5)+lcArchivos
**pruta=SYS(5)+lcArchivos


druta=SYS(5)+CURDIR()  
pruta=SYS(5)+CURDIR()			


SET DEFAULT TO 	"&druta"+"DATA"
SET PATH 	TO 	"&pruta"+"PROG;"+;
				"&pruta"+"FORM;"+;
				"&pruta"+"IMAGENES;"+;
				"&pruta"+"IMAGENES2;"+;
				"&pruta"+"BITMAPS;"+;
				"&pruta"+"REPORTES;"+;
				"&pruta"+"MENU;"+;
				"&pruta"+"CLASES;"+;
				"&pruta"+"LIBRERIAS"


USE cliente
GO top
DO WHILE !eof()
	replace id WITH SUBSTR(juridico,1,2)
	replace rif WITH SUBSTR(rif,3,12)
	replace activo WITH .t.
	SKIP 1
ENDDO
RETURN
