**********************************************************
* Fecha de modificaci?n: Agosto 12 de 2000
*
* Crear un gr?fico en Ms Graph 8.0  con Fox y Ole
* 
* Se pretende Seleccionar:
*     1. El color para el titulo de los ejes x,y.
*     2. El color para el r?tulo de datos.
*     3. El color para ajustar el color interior de cada serie del conjunto
*
*  Con este ejemplo se busca dar mas creatividad a todos los foxeros para mejorar
*  las presentaciones de los gr?ficos y permitir al usuario que configure sus titulos,
*  tama?os, fuentes, colores o seleccionar el tipo de grafico que desee.
*
*  Espero les sirva como ejemplo
*
*  Este codigo es una adaptaci?n que encontre en la revista de Foxpress (Espa?a) www.fpress.com
*  los autores Principales son Carlos Zubiria, Modificado por Douglas Cruz (Muchas Gracias)
*  Terminado por:
*  Yony Alberto Restrepo Betancur
*  Medell?n - Colombia - SurAmerica 
*
*  Utilizo una funci?n que encontre en el portal de foxpro  http://clik.to/visualfox 
*
*    Bibliografia: Vbagrp9.chm de Office 2000
**********************************************************

public Grafico, TxtColorTitulos, TxtColorRotulos, TxtColorInterior

TxtColorTitulos=16711680 && Color para los titulos por defecto (Azul)
TxtColorRotulos=255 	&& Color para los titulos por defecto (Rojo)
TxtColorInterior=65408  && Color para los titulos por defecto (Verde)

Grafico = CREATEOBJECT('Form')  && Crea un formulario.
Grafico.caption="Gr?ficos con Fox y MS Graph 8.0"
Grafico.height=160
Grafico.width=290
Grafico.AutoCenter=.t.

Grafico.AddObject('CmdColorTitulos','CmdColorTitulos')  && Bot?n Color.
Grafico.AddObject('CmdColorRotulos','CmdColorRotulos')  && Bot?n R?tulos.
Grafico.AddObject('CmdColorInterior','CmdColorInterior')  && Bot?n Interior.
Grafico.AddObject('CmdGraficar','CmdGraficar')  && Bot?n Graficar.

Grafico.CmdColorTitulos.Visible =.T.  && Bot?n Color visible.
Grafico.CmdColorRotulos.Visible =.T.  && Bot?n Color visible.
Grafico.CmdColorInterior.Visible =.T.  && Bot?n Color visible.
Grafico.CmdGraficar.Visible =.T.  && Bot?n Grafico visible.

Grafico.SHOW  && Muestra el formulario.
*READ EVENTS  && Inicia el procesamiento de eventos.

DEFINE CLASS CmdColorTitulos AS COMMANDBUTTON  && Crea un bot?n de comando.
   Caption = 'Color Titulos...'  && T?tulo del bot?n de comando.
   Left = 50  && Columna del bot?n de comando.
   Top = 25  && Fila del bot?n de comando.
   Height = 25  && Alto del bot?n de comando.
   width=190    && Ancho del bot?n de comando.
   ForeColor=RGB(0,0,255)  && Color Azul
   
   PROCEDURE Click
    TxtColorTitulos=getcolor()
    tnColor=_Col2RGB(TxtColorTitulos)
    Thisform.CmdColorTitulos.Caption = 'Color Titulos...'+Tncolor  && Modificar T?tulo del bot?n de comando.
    Thisform.CmdColorTitulos.forecolor=&Tncolor
ENDDEFINE

DEFINE CLASS CmdColorRotulos AS COMMANDBUTTON  && Crea un bot?n de comando.
   Caption = 'Color Rotulos... '  && T?tulo del bot?n de comando.
   Left = 50  && Columna del bot?n de comando.
   Top = 60  && Fila del bot?n de comando.
   Height = 25  && Alto del bot?n de comando.
   width=190    && Ancho del bot?n de comando.
   ForeColor=RGB(255,0,0)  && Color Rojo
   
   PROCEDURE Click
    TxtColorRotulos=getcolor()
    tnColor=_Col2RGB(TxtColorRotulos)
    Thisform.CmdColorRotulos.Caption = 'Color Rotulosr...'+Tncolor  && Modificar T?tulo del bot?n de comando.
    Thisform.CmdColorRotulos.forecolor=&Tncolor
ENDDEFINE

DEFINE CLASS CmdColorInterior AS COMMANDBUTTON  && Crea un bot?n de comando.
   Caption = 'Color Interior...'  && T?tulo del bot?n de comando.
   Left = 50  && Columna del bot?n de comando.
   Top = 90  && Fila del bot?n de comando.
   Height = 25  && Alto del bot?n de comando.
   width=190    && Ancho del bot?n de comando.
   ForeColor=RGB(0,255,0) && Color Verde
 
   PROCEDURE Click
    TxtColorInterior=getcolor()
    tnColor=_Col2RGB(TxtColorInterior)
    Thisform.CmdColorInterior.Caption = 'Color Interior...'+Tncolor  && Modificar T?tulo del bot?n de comando.
    Thisform.CmdColorInterior.forecolor=&Tncolor
    Thisform.CmdColorInterior.refresh 
ENDDEFINE


DEFINE CLASS CmdGraficar AS COMMANDBUTTON  && Crea un bot?n de comando.
   Caption = 'Procesar Grafico...'  && T?tulo del bot?n de comando.
   Left = 50  && Columna del bot?n de comando.
   Top = 120  && Fila del bot?n de comando.
   Height = 25  && Alto del bot?n de comando.
   width=190    && Ancho del bot?n de comando.
   picture="C:\graficos\Bmp\nubes.bmp"

   PROCEDURE Click
    Wait windows "Espere por favor mientras procesa el gr?fico" nowait
    x=Time()
    public pantalla
    pantalla = createobject("form")
    pantalla.height=400
    pantalla.width=700
    Pantalla.Caption="Grafico Ms Graph 8.0"
    Pantalla.Autocenter=.t.
    
    pantalla.addobject("objeto", "olecontrol", "msgraph.chart.8")

    pantalla.objeto.top = 0
    pantalla.objeto.left = 0
    pantalla.objeto.height = pantalla.height
    pantalla.objeto.width = pantalla.width
    pantalla.visible = .t.
    pantalla.objeto.visible = .t.

    pantalla.lockscreen = .t.

    ** Definir el tipo de grafico -4100 es xl3DColumn
*    pantalla.objeto.object.application.chart.charttype = -4100
    pantalla.objeto.object.application.chart.charttype = 51 &&93,97,
    
    
    ** Definir las series que posee el grafico (en este caso una serie)
    pantalla.objeto.object.application.datasheet.range("00").value = ""
    pantalla.objeto.object.application.datasheet.range("01").value = "Asistencias"
    pantalla.objeto.object.application.datasheet.range("02").value = "Inasistencias"
    pantalla.objeto.object.application.datasheet.range("03").value = "Retrasos"

    ** Llevar valores para la columna A
    pantalla.objeto.object.application.datasheet.range("A0").value = "Enero"
    pantalla.objeto.object.application.datasheet.range("A1").value = 21
    pantalla.objeto.object.application.datasheet.range("A2").value = 15
    pantalla.objeto.object.application.datasheet.range("A3").value = 13
    *pantalla.objeto.object.application.datasheet.range("A4").value = 19

    ** Llevar valores para la columna B
    pantalla.objeto.object.application.datasheet.range("B0").value = "Febrero"
    pantalla.objeto.object.application.datasheet.range("B1").value = 48
    pantalla.objeto.object.application.datasheet.range("B2").value = 15
    pantalla.objeto.object.application.datasheet.range("B3").value = 12
    *pantalla.objeto.object.application.datasheet.range("B4").value = 19

    ** Llevar valores para la columna C
    pantalla.objeto.object.application.datasheet.range("C0").value = "Marzo"
    pantalla.objeto.object.application.datasheet.range("C1").value = 4
    pantalla.objeto.object.application.datasheet.range("C2").value = 3
    pantalla.objeto.object.application.datasheet.range("C3").value = 7
    *pantalla.objeto.object.application.datasheet.range("C4").value = 1


    ** Borrar las filas que est?n llenas por defecto por el graph y no se van a utilizar
    ** si usted trabaja con 3 o m?s series no debe hacer lo siguiente.
   * pantalla.objeto.object.application.datasheet.rows("4").delete
   * pantalla.objeto.object.application.datasheet.rows("3").delete

    ** Borrar las columnas que est?n llenas por defecto por el graph y no se van a utilizar
    ** si usted trabaja con 4 o m?s columnas no debe hacer lo siguiente.
    pantalla.objeto.object.application.datasheet.columns("5").delete
    pantalla.objeto.object.application.datasheet.columns("4").delete

    ** Cambiar el titulo del grafico
    pantalla.objeto.object.application.chart.hastitle = .t.
    pantalla.objeto.object.application.chart.charttitle.text = "Ventas XXXX"

    ** Permite Modificar el color de las series con el color verde.
    pantalla.objeto.SeriesCollection(1).Interior.Color = TxtColorInterior && Seleccionado en le form.

    ** Lo siguiente activa el r?tulo de datos del primer punto de la serie uno (1) del gr?fico, 
    ** y establece el texto del r?tulo de datos.
    With pantalla.objeto
        With .SeriesCollection(1).Points(1)
             .HasDataLabel = .t.
             .DataLabel.Text = 24 && Valor de la columna A1.
             .DataLabel.Font.color = TxtColorRotulos && Seleccionado en le form.
        EndWith
    EndWith

    ** Lo siguiente activa el r?tulo de datos del segundo punto de la serie uno (1) del gr?fico, 
    ** y establece el texto del r?tulo de datos.
    With pantalla.objeto
        With .SeriesCollection(2).Points(1)
             .HasDataLabel = .t.
             .DataLabel.Text = 44 && Valor de la columna B1
             .DataLabel.Font.color = TxtColorRotulos && && Seleccionado en le form
        EndWith
    EndWith

    ** Lo siguiente activa el r?tulo de datos del segundo punto de la serie uno (1) del gr?fico, 
    ** y establece el texto del r?tulo de datos.
    With pantalla.objeto
        With .SeriesCollection(3).Points(1)
             .HasDataLabel = .t.
             .DataLabel.Text = 64 && Valor de la columna B1
             .DataLabel.Font.color = TxtColorRotulos && && Seleccionado en le form
        EndWith
    EndWith


    ** Modificar titulo, tama?o, color y fuente del eje X.
    With pantalla.objeto.Axes(1)
        .HasTitle = .t.
        With .AxisTitle
             .Caption = "Meses"
             .Font.Name = "bookman"  
             .Font.Size = 20
            .Font.color = TxtColorTitulos && Color seleccionado en el form
        EndWith
    EndWith

    ** Modificar titulo, tama?o, color y fuente del eje Y.
    With pantalla.objeto.Axes(2)
        .HasTitle = .t.
        With .AxisTitle
             .Caption = "Dias"
             .Font.Name = "bookman"  
             .Font.Size = 20
             .Font.color = TxtColorTitulos && Color seleccionado en el form.
        EndWith
    EndWith

    pantalla.lockscreen = .f.
    Wait windows "Proceso terminado" nowait

ENDDEFINE


*------------------------------------------------
FUNCTION _Col2RGB(tnColor)   && Esta funci?n fue copiada del portal de fox http://clik.to/visualfox 
*------------------------------------------------
* Pasa un n?mero de color a formato RGB.
* USO: _Col2RGB(1547)
* RETORNA: Caracter - "RGB(nR, nG, nB)"
*------------------------------------------------
  LOCAL lcRGB, ln
  lcRGB="RGB("
  FOR ln=1 TO 3
    lcRGB=lcRGB+TRAN(tnColor%256,"999")+IIF(ln=3, "", ",")
    tnColor=INT(tnColor/256)
  ENDFOR
  lcRGB=lcRGB+")"
  RETURN lcRGB
ENDFUNC
