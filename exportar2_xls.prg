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



**--Exportar Inventario con Formato Creado de Manera Lectura
**--nombre file : siamfox\data\inven_exp.xlsx
**------------------------------------------------------------
m.sPathFileOpen=SYS(2003)+"\inven_exp.xlsx"
m.objExcel=CREATEOBJECT("excel.application")
m.objexcel.Workbooks.Open(m.sPathFileOpen)

*m.objExcel.Cells(6,2).Value='Exportacion Documento'
*m.objExcel.Cells(7,2).Value=ThisForm.cboOrigen.DisplayValue
*m.objExcel.Cells(8,2).Value=hoy(m.sDateI)
*m.objExcel.Cells(9,2).Value=hoy(m.sDateF)
m.nRow=3
m.nCount=0

**--Query de los campos segun condicion
SELECT CODIGO,DESCRIP,REFERENCIA,PRE3,DEP_01 ;
FROM FORCE inven ORDER BY 1 ASC INTO CURSOR inven_exp READWRITE

SELECT inven_exp 
m.nRecno=RECNO()
SCAN
m.nCount=m.nCount+1
m.objExcel.Cells(m.nRow,1).Value=Codigo
m.objExcel.Cells(m.nRow,2).Value=Descrip
m.objExcel.Cells(m.nRow,3).Value=referencia
m.objExcel.Cells(m.nRow,4).Value=pre3
m.objExcel.Cells(m.nRow,5).Value=dep_01
m.nRow=m.nRow+1
ENDSCAN

*!*	m.objExcel.Range("A3","E"+LTRIM(STR(m.nCount+10))).Borders.LineStyle=1
*!*	m.objexcel.Cells(m.nRow,3).Value=;
*!*	*!*	m.objExcel.SUM(m.objexcel.Range("C3","C"+LTRIM(STR(m.nCount+10))))
m.objExcel.Visible=.T.

RELEASE m.objExcel
