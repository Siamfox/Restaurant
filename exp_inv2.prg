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
SELECT codigo,descrip,referencia,pre3,dep_01 FROM force inven ORDER BY 1 ASC INTO CURSOR inven_exp READWRITE

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

MESSAGEBOX('Exportado Listado...!!!',1+64,'Atencion')

**--Mejorar colores y anchos campos
*m.objExcel.Range("A3","E"+LTRIM(STR(m.nCount+10))).Borders.LineStyle=1
*m.objexcel.Cells(m.nRow,3).Value=;
*!*	m.objExcel.SUM(m.objexcel.Range("C3","C"+LTRIM(STR(m.nCount+10))))

m.objExcel.Visible=.T.
RELEASE m.objExcel	
