**--Exportar Cliente con Formato Creado de Manera Lectura
**--nombre file : siamfox\data\cliente_exp.xlsx
**------------------------------------------------------------
m.sPathFileOpen=SYS(2003)+"\proveedor_exp.xlsx"
m.objExcel=CREATEOBJECT("excel.application")
m.objexcel.Workbooks.Open(m.sPathFileOpen)

*m.objExcel.Cells(6,2).Value='Exportacion Documento'
*m.objExcel.Cells(7,2).Value=ThisForm.cboOrigen.DisplayValue
*m.objExcel.Cells(8,2).Value=hoy(m.sDateI)
*m.objExcel.Cells(9,2).Value=hoy(m.sDateF)
m.nRow=3
m.nCount=0

**--Query de los campos segun condicion
SELECT nombre,rif,telefonos,dir1,dir2,ciudad,estado,email,web,activo ;
FROM FORCE proveedo ORDER BY 1 ASC INTO CURSOR proveedor_exp READWRITE

SELECT proveedor_exp 
m.nRecno=RECNO()
SCAN
m.nCount=m.nCount+1
m.objExcel.Cells(m.nRow,1).Value=ALLTRIM(nombre)
m.objExcel.Cells(m.nRow,2).Value=ALLTRIM(rif)
m.objExcel.Cells(m.nRow,3).Value=ALLTRIM(telefonos)
m.objExcel.Cells(m.nRow,4).Value=ALLTRIM(dir1)+ALLTRIM(dir2)
m.objExcel.Cells(m.nRow,5).Value=ALLTRIM(ciudad)
m.objExcel.Cells(m.nRow,6).Value=ALLTRIM(estado)
m.objExcel.Cells(m.nRow,7).Value=ALLTRIM(email)
m.objExcel.Cells(m.nRow,8).Value=ALLTRIM(web)
m.objExcel.Cells(m.nRow,9).Value=IIF(activo=.t.,'Activo','Inactivo')
m.nRow=m.nRow+1
ENDSCAN

MESSAGEBOX('Exportado Listado...!!!',1+64,'Atencion')

**--Mejorar colores y anchos campos
*m.objExcel.Range("A3","E"+LTRIM(STR(m.nCount+10))).Borders.LineStyle=1
*m.objexcel.Cells(m.nRow,3).Value=;
*!*	m.objExcel.SUM(m.objexcel.Range("C3","C"+LTRIM(STR(m.nCount+10))))

m.objExcel.Visible=.T.
RELEASE m.objExcel	
