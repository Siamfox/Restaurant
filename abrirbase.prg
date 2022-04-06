SET DEFAULT TO 
SET PATH TO  && CURDIR()

sruta=SYS(5)+CURDIR()
pruta=SYS(5)+CURDIR()			

SET DEFAULT TO 	"&SRUTA"+"DATA"
SET PATH 	TO 	"&pruta"+"PROG;"+;
				"&pruta"+"FORM;"+;
				"&pruta"+"IMAGENES;"+;
				"&pruta"+"BITMAPS;"+;
				"&pruta"+"REPORTES;"+;
				"&pruta"+"MENU;"+;
				"&pruta"+"CLASES;"+;
				"&pruta"+"LIBRERIAS"
				
CLOSE DATABASES
OPEN DATABASE siamdb  	&& Open testdata database
DISPLAY DATABASE  		&& Displays table information
