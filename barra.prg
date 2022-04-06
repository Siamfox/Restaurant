toolBarra.SHOW


*!*	IF xs11=.t. && Barra Habilitada
*!*		toolBarra = CREATEOBJ('miBarra')
*!*		toolBarra.SHOW
*!*	ELSE
*!*		RETURN
*!*	ENDIF


DEFINE CLASS miBarra AS Toolbar
ADD OBJECT btn1		AS CommandButton
*ADD OBJECT sep1 	AS Separator
ADD OBJECT btn2		AS CommandButton
*ADD OBJECT sep2 	AS Separator
ADD OBJECT btn3		AS CommandButton
*ADD OBJECT sep3 	AS Separator
ADD OBJECT btn4		AS CommandButton
*ADD OBJECT sep4 	AS Separator
ADD OBJECT btn5		AS CommandButton
*ADD OBJECT sep5 	AS Separator
ADD OBJECT btn14	AS CommandButton
ADD OBJECT btn15	AS CommandButton

ADD OBJECT btn6		AS CommandButton
ADD OBJECT sep6 	AS Separator
ADD OBJECT sep7 	AS Separator

ADD OBJECT btn7		AS CommandButton
*ADD OBJECT sep8 	AS Separator
ADD OBJECT btn8		AS CommandButton
*ADD OBJECT sep9 	AS Separator
ADD OBJECT btn9		AS CommandButton
*ADD OBJECT sep10 	AS Separator
ADD OBJECT btn10	AS CommandButton
ADD OBJECT btn16	AS CommandButton
*ADD OBJECT sep11 	AS Separator
ADD OBJECT btn11	AS CommandButton
*ADD OBJECT sep12 	AS Separator
ADD OBJECT btn12	AS CommandButton
ADD OBJECT btn17	AS CommandButton

ADD OBJECT sep13 	AS Separator
*ADD OBJECT sep14 	AS Separator

ADD OBJECT btn13	AS CommandButton

**//Ventas
btn1.HEIGHT = 35
btn1.WIDTH = 35
btn1.Caption = ""
btn1.picture = sys(5)+"\siamfox\bitmaps\note11.ico"
btn1.backcolor=RGB(193,193,215) 
btn1.tooltiptext="Facturar, Ventas Fiscales"

**//Caja (monitor Caja)
btn2.HEIGHT = 35
btn2.WIDTH = 35
btn2.Caption = ""
btn2.picture = SYS(5)+"\siamfox\bitmaps\money_2.ico"
btn2.backcolor=RGB(193,193,215) 
btn2.tooltiptext="Caja, Pagos Facturas"

**//Consultar Precios(monitor articulos)
btn3.HEIGHT = 35
btn3.WIDTH = 35
btn3.Caption = ""
btn3.picture = SYS(5)+"\siamfox\bitmaps\note04.ico"
btn3.backcolor=RGB(193,193,215) 
btn3.tooltiptext="Precios, Monitor de Precios"

**//Consultar Documentos
btn4.HEIGHT = 35
btn4.WIDTH = 35
btn4.Caption = ""
btn4.picture = SYS(5)+"\siamfox\bitmaps\search.ico"
btn4.backcolor=RGB(193,193,215) 
btn4.tooltiptext="Buscar, Consultar Documentos"

**//Pto de Ventas
btn5.HEIGHT = 35
btn5.WIDTH = 35
btn5.Caption = ""
btn5.picture = SYS(5)+"\siamfox\bitmaps\pc.ico"
btn5.backcolor=RGB(193,193,215) 
btn5.tooltiptext="Punto de Venta, Fiscal"

**//Calculadora
btn6.HEIGHT = 35
btn6.WIDTH = 35
btn6.Caption = ""
btn6.picture = SYS(5)+"\siamfox\bitmaps\calc5.ico"
btn6.backcolor=RGB(193,193,215) 
btn6.tooltiptext="Calculadora, Operaciones Matematicas Básicas"

**//Articulos
btn14.HEIGHT = 35
btn14.WIDTH = 35
btn14.Caption = ""
btn14.picture = SYS(5)+"\siamfox\bitmaps\mercancia.ico"
btn14.backcolor=RGB(193,193,215) 
btn14.tooltiptext="Articulos, Actualizar Articulos"

**//Compras
btn15.HEIGHT = 35
btn15.WIDTH = 35
btn15.Caption = ""
btn15.picture = SYS(5)+"\siamfox\bitmaps\cart.ico"
btn15.backcolor=RGB(193,193,215) 
btn15.tooltiptext="Compras, Ingreso Mercancia por Proveedores"


**********************SEGUNDO BLOQUE**************************************
**//Etiquetas
btn7.HEIGHT = 35
btn7.WIDTH = 35
btn7.Caption = ""
btn7.picture = SYS(5)+"\siamfox\bitmaps\labels.ico"
btn7.backcolor=RGB(193,193,215) 
btn7.tooltiptext="Etiquetas, Imprimir Etiquetas Articulos"

**//Reportes
btn8.HEIGHT = 35
btn8.WIDTH = 35
btn8.Caption = ""
btn8.picture = SYS(5)+"\siamfox\bitmaps\printer2.ico"
btn8.backcolor=RGB(193,193,215) 
btn8.tooltiptext="Reportes, Imprimir Listados Compras y Ventas"

**//Graficar
btn9.HEIGHT = 35
btn9.WIDTH = 35
btn9.Caption = ""
btn9.picture = SYS(5)+"\siamfox\bitmaps\graph07.ico"
btn9.backcolor=RGB(193,193,215) 
btn9.tooltiptext="Graficar, e Imprimir Estadisticas"

**//Ayuda en Linea
btn10.HEIGHT = 35
btn10.WIDTH = 35
btn10.Caption = ""
btn10.picture = SYS(5)+"\siamfox\bitmaps\help.ico"
btn10.backcolor=RGB(193,193,215) 
btn10.tooltiptext="Ayuda, en Linea del Sistema"

**//Usuarios
btn16.HEIGHT = 35
btn16.WIDTH = 35
btn16.Caption = ""
btn16.picture = SYS(5)+"\siamfox\bitmaps\access.ico"
btn16.backcolor=RGB(193,193,215) 
btn16.tooltiptext="Usuario, Cambio de Usuario"

**//Utilidades
btn11.HEIGHT = 35
btn11.WIDTH = 35
btn11.Caption = ""
btn11.picture = SYS(5)+"\siamfox\bitmaps\tools.ico"
btn11.backcolor=RGB(193,193,215) 
btn11.tooltiptext="Utilitarios, Utilidades del Sistema"

**//Configurar Estacion
btn12.HEIGHT = 35
btn12.WIDTH = 35
btn12.Caption = ""
btn12.picture = SYS(5)+"\siamfox\bitmaps\rulers.ico"
btn12.backcolor=RGB(193,193,215) 
btn12.tooltiptext="Configurar, Valores de Entorno a la Estacion"

**//Menu Cobros y Pagos
btn17.HEIGHT = 35
btn17.WIDTH = 35
btn17.Caption = ""
btn17.picture = SYS(5)+"\siamfox\bitmaps\carpeta1.ico"
btn17.backcolor=RGB(193,193,215) 
btn17.tooltiptext="Cuentas, Clientes y Proveedores"

**//Salir
btn13.HEIGHT = 35
btn13.WIDTH = 35
btn13.Caption = ""
btn13.picture = SYS(5)+"\siamfox\bitmaps\flecharedonda_izq_e.bmp"
btn13.backcolor=RGB(193,193,215) 
btn13.tooltiptext="Salir, del Sistema"

Left = 750
Top = 1
Width = 40

CAPTION = ""

**PROCEDURE Activate
*ThisForm.Ventas.FontBold = _SCREEN.FONTBOLD
*ThisForm.Proveedores.FontBold = _SCREEN.FONTBOLD
*ThisForm.Ventas.FontBold = _SCREEN.FONTBOLD
*MiBarra.Commands='=messagebox("STOP",64,"MSG");=messagebox("REFRESH",64,"MSG");=messagebox("HOME",64,"MSG")'
**ENDPROC


PROCEDURE btn1.click
DO FORM frmfac
ENDPROC

PROCEDURE btn2.click
DO FORM frmcaj_mon
ENDPROC

PROCEDURE btn3.click
DO FORM frmart_mon
ENDPROC

PROCEDURE btn4.click
DO FORM frmcon_doc
ENDPROC

PROCEDURE btn5.click
DO FORM frmptoventa
ENDPROC

PROCEDURE btn6.click
*ACTIVATE WINDOW calculator
*CLEAR TYPEAHEAD
*KEYBOARD CHR(82)
NODEFAULT 
run /n calc.exe
ENDPROC

PROCEDURE btn14.click
DO FORM frmart
ENDPROC

PROCEDURE btn15.click
DO FORM frmcom
ENDPROC


*****SEGUNDO BLOQUE*******

PROCEDURE btn7.click
DO FORM frmetiq
ENDPROC

PROCEDURE btn8.click
DO FORM frmmenureportes
ENDPROC

PROCEDURE btn9.click
GRAFICA3()
ENDPROC

PROCEDURE btn10.click
DO FORM frmayuda1
ENDPROC

PROCEDURE btn11.click
DO FORM frmmenutilidades
ENDPROC

PROCEDURE btn12.click
DO FORM frmentornoloc
ENDPROC

PROCEDURE btn16.click
DO FORM frmusua
ENDPROC

PROCEDURE btn17.click
DO FORM frmmenucuentas 
ENDPROC

PROCEDURE btn13.click
SALIR()
ENDPROC

**//Proceso Dockear la Barra
PROCEDURE INIT
This.Dock(0)
ENDPROC