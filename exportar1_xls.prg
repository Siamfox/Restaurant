*---------------------------------------------------
*--- Configurar el Ambiente de Trabajo
*---------------------------------------------------
SET HELP OFF
SET ECHO OFF
SET TALK OFF
SET SAFETY OFF 
SET EXCLUSIVE OFF 
SET MULTILOCKS ON
SET COMPATIBLE OFF
SET SYSMENU TO default
SET CONFIRM OFF 
SET CENTURY ON
SET DELETED ON 
SET EXACT ON
SET LOGERRORS ON 
SET BELL ON
SET CLOCK STATUS
SET DECIMALS TO 2
SET COLOR TO
SET DATE TO DMY
SET ESCAPE OFF 



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




LOCAL bs_nw,ult_yer
ult_yer = 2000

****clavempr = "tengo un campo con la empresa activa "

**** primero creo un cursor

IF !USED("inven")
USE inven SHARED
ENDIF

GOTO top
SELECT CODIGO,DESCRIP,REFERENCIA,MARCA,LINEA,MODELO,PRE1,PRE2,PRE3,PVPBUL,DEP_01,COSTO ;
FROM FORCE inven ORDER BY 1 ASC INTO CURSOR ptto_exp READWRITE

SELECT inven
use

*!*	eMessageTitle =' Exportando presupuesto'
*!*	eMessageText  = ' poner en ceros las cifras?'
*!*	nDialogType  = 4 + 16 + 256
*!*	* 4 = Yes and No buttons
*!*	* 16 = Stop sign icon
*!*	* 256 = Second button is default

*!*	nAnswer = MESSAGEBOX(eMessageText, nDialogType, eMessageTitle)

*!*	DO CASE
*!*	CASE nAnswer = 6
*!*	FOR gnCount = 6 TO 16 &&& FCOUNT( ) && Loop for number of fields
*!*	sf= FIELD(gnCount) && Display each field
*!*	SELECT ptto_exp
*!*	GOTO top
*!*	DO WHILE !EOF()
*!*	REPLACE &sf WITH 0
*!*	SKIP
*!*	enddo
*!*	NEXT

*!*	CASE nAnswer = 7

*!*	FOR gnCount = 6 TO 16 &&& FCOUNT( ) && Loop for number of fields
*!*	sf= FIELD(gnCount) && Display each field
*!*	SELECT ptto_exp
*!*	GOTO top
*!*	DO WHILE !EOF()
*!*	SKIP
*!*	enddo
*!*	NEXT

*!*	ENDCASE

SELECT ptto_exp


LOCAL num_fil


SELECT ptto_exp
GOTO top
num_fil = RECCOUNT()+15

IF FILE(SYS(2003)+"\ptto_exp.xls") = .t.
		answer = MESSAGEBOX("El archivo ptto_empty.xls ya existe" + CHR(13)+;
		"Pulse reintentar para eliminar el archivo actual," + CHR(13)+;
		" o cancelar el proceso",1+32," Archvo existente")

		DO case
		CASE answer = 2
			RETURN

		CASE answer = 1
			ERASE SYS(2003)+"\ptto_exp.xls"
			COPY TO SYS(2003)+"\ptto_exp.xls" TYPE xl5

		otherwise
			RETURN

		ENDCASE
ELSE
		COPY TO SYS(2003)+'\ptto_exp.xls' TYPE xl5
		MESSAGEBOX('Exportado...')
		
ENDIF


**-------------------------------------------------------------------------------------
**Ahora vamos a trabajar con una planilla ya creada. Creamos nuevamente el objeto Excel:
**-------------------------------------------------------------------------------------
loExcel=CREATEOBJECT("Excel.application")
loExcel.APPLICATION.VISIBLE=.T.

**Abrimos el libro Excel que ya existe:
loExcel.APPLICATION.workbooks.OPEN(SYS(2003)+"\ptto_empty.xls")

**Cambiamos el nombre de la hoja activa:
loExcel.APPLICATION.activesheet.NAME = "Ptto"

**Hacemos referencia directamente a "Ptto", y ponemos valores en una celda y le damos formato:
loExcel.APPLICATION.Sheets("Ptto").Rows("1:5").Insert

**loExcel.APPLICATION.Sheets("Ptto").cells(1,1).NumberFormat = "0.00%"


XLSheet = loExcel.APPLICATION.ActiveSheet

range_sq = "A6:u"+ALLTRIM(STR(num_fil))
range_sqr = '"'+range_sq+'"'

WITH XLSheet.Range(&range_sqr).Borders(3)&&xlEdgeLeft
XLSheet.Columns().AutoFit
ENDWITH

* .LineStyle = xlContinuous
* .Weight = xlThin
* .ColorIndex = xlAutomatic


lcRango= "A1:u"+ALLTRIM(STR(num_fil))

range_s2 = "A7:u"+ALLTRIM(STR(num_fil))
range_s2r = '"'+range_s2+'"'

range_s3 = "F7:S"+ALLTRIM(STR(num_fil))
range_s3r = '"'+range_s3+'"'

WITH XLSheet.Range(&range_s2r)
.Font.Size= 9
.Interior.ColorIndex = 19
ENDWITH

WITH XLSheet.Range(&range_s3r)
.Font.Size= 9
.Interior.ColorIndex = 2

ENDWITH


*** FORMULAMOS

FOR i = 7 TO num_fil
fxm = '"=suma(f'+ALLTRIM(STR(i))+ ':q' + ALLTRIM(STR(i)) + ')"'
loExcel.APPLICATION.Sheets("Ptto").cells(i,18).value = (&fxm) &&"=(A1+B1)")
ENDFOR


loExcel.APPLICATION.Sheets("Ptto").cells(1,3).VALUE = "Formato de presupuesto"
* .HorizontalAlignment=xlCenter &&Aliniar al centro *
* .VerticalAlignment=xlCenter
**** formato del encabezado principal
WITH XLSheet.Range("c1:o1")
.Merge
.Font.Bold=.t.
.Font.Size=16
*.HorizontalAlignment=xlCenter
.Interior.ColorIndex = 20

ENDWITH

WITH XLSheet.Range("a6:u6")
.Borders(2)
.Font.Bold=.t.
.Font.Size= 9
*.HorizontalAlignment=xlCenter
.Interior.ColorIndex = 22

ENDWITH

WITH XLSheet.Range("a6:u6")
.Borders(2)
.Font.Bold=.t.
.Font.Size= 9
*.HorizontalAlignment=xlCenter
.Interior.ColorIndex = 22

ENDWITH


*** .Interior.ColorIndex = 15 GRIS 10 VERDE 1 NEGRO 2 BLANCO 3 ROJO 4 VERDE CLARO
** 5 AZUL INTENSO 6 AMARILLO 7 FUISHA 8 CYAN 9 MARRON 11 AZUL FUERTE12 AMARILLO OBSCURO
** 13 MORADO 14 VERDE AZUL 16 GRIS 17 LILA 19 AMARILLO CLARO 20 AZUL


*!*	loExcel.APPLICATION.Sheets("Ptto").cells(2,3).VALUE = "Instrucciones: Llenar los datos de importes para presupuesto (la informacion puedes manipularla en otras hojas"
*!*	**loExcel.APPLICATION.Sheets("Ptto").cells(1,1).NumberFormat = "#,##0.00"
*!*	loExcel.APPLICATION.Sheets("Ptto").cells(3,3).VALUE = "en esta hoja no moficiar nombres ni columnas , no olvides anotar el año ejercicio y revisa que todoas las familias se consideraron"
*!*	loExcel.APPLICATION.Sheets("Ptto").cells(4,3).VALUE = "Para importar a Gennie grabe la información en un archivo excel a partir de la fila 6"

*!*	LOCAL lcImagen, lcPlanilla, lo
*!*	*-- Selecciono imagen y nombre de planilla (xls)
*!*	lcImagen = MYPATH+"\SALIDAGRAFICA.BMP" &&&GETPICT()
*!*	*-- Selecciono la celda donde estará la posición de la imagen

*!*	loExcel.Cells(1,1).Select
*!*	loExcel.ActiveSheet.Pictures.Insert(lcImagen).Select
*!*	loExcel.Selection.ShapeRange.LockAspectRatio = 0
*!*	loExcel.Selection.ShapeRange.Height = 58 && pixeles
*!*	loExcel.Selection.ShapeRange.Width = 90 && pixeles

*** configurar area de impresion

with loExcel.APPLICATION.ActiveSheet.PageSetup
.TopMargin = 30
.BottomMargin = 40
.RightMargin = 15
.LeftMargin = 15
.LeftFooter = cempresa + " Archivo para prueba exportacion  "
.PrintHeadings = .f.
.Orientation = xlLandscape
.PaperSize = xlPaperLetter
.PrintArea = lcRango

ENDWITH


loExcel.APPLICATION.activeworkbook.SAVE

**loExcel.APPLICATION.QUIT && no cierro excel porque quiero ver el archivo

**RELEASE loExcel