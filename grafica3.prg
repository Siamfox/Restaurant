************Programa  3********************
* Crea una tabla con un campo general y un 
* gráfico
close all
erase migraph.dbf
IF ! FILE("migraph.dbf")
   CREATE TABLE migraph (graph_fld G)
   graph_var = " " + chr(9) + ;
      "Resultados" + chr(13) + chr(10) ;
       + "Tipo 1" + chr(9) + "5" + chr(13);
       + chr(10) + "Tipo 2" ;
       + chr(9) + "10" + chr(13) + chr(10)
   APPEND BLANK
   APPEND GENERAL graph_fld CLASS ;
      "MsGraph.Chart" DATA graph_var
ELSE
   IF ! USED("migraph")
      USE migraph IN 0
   ENDIF
ENDIF

PUBLIC oForm
oForm = CREATEOBJECT("form")
oForm.ADDOBJECT("Ole1","OleBoundControl")
oForm.ADDOBJECT("Command1","MyCommand")
oForm.Ole1.ControlSource = ;
 "migraph.graph_fld"
oForm.height=350
oForm.width=520
oForm.Caption = "MiGraph"
oForm.Ole1.Height = 300
oForm.Ole1.Width  = 500
oForm.Ole1.HasTitle = .T.
oForm.Ole1.ChartTitle.Caption = "Chart ;
  que muestra por fila o por columna"
oForm.Ole1.ChartTitle.Font.Name = "Arial"
oForm.Ole1.ChartTitle.Font.Size = 12
oForm.Ole1.ChartTitle.Font.Bold = .T.
oForm.Ole1.Type = 3
oForm.Visible=.t.
oForm.Ole1.Visible=.t.
oForm.Command1.Visible=.t.
oForm.Ole1.Object.Application.PlotBy=1

DEFINE CLASS MyCommand AS COMMANDBUTTON
     Caption = 'Mostrar por Columna'
     Visible = .T.
     Left = 200
     Top = 290
     Height = 30
     Width = 125

PROCEDURE Click
  IF oForm.Ole1.Object.;
        Application.PlotBy = 1
     oForm.Ole1.Object.;
        Application.PlotBy = 2
     oForm.Command1.;
     Caption = 'Mostrar ;
         por Fila'
  ELSE
    oForm.Ole1.Object.;
         Application.PlotBy = 1
    oForm.Command1.;
         Caption = 'Mostrar ;
         por Columna'
  ENDIF
  Thisform.Refresh

ENDDEFINE

