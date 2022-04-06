**************** Programa 1***************
#DEFINE TAB CHR(9)
#DEFINE CRLF CHR(13)+CHR(10)

MCGDATA = TAB+'1-Tri'+TAB+'2-Tri'+TAB+'3-Tri'+TAB+'4-Tri'+CRLF+;
			'Asistencias'+TAB+'21'+TAB+'18'+TAB+'20'+ TAB+'20'+CRLF+;
			'Inasistencias'+TAB+'0'+TAB+'3'+TAB+'1'+TAB+'1'+CRLF+;
			'Retrasos'+TAB+'0'+TAB+'0'+TAB+'0'+TAB+'0'




create cursor testgen (genfld1 g)
append blank
append general genfld1 ;
class "msgraph.Chart.8" data ;
	MCGDATA

oForm = createobject("Form")
with oForm
  .height = 400
  .width = 600
  .addobject("miGraph","OleBoundControl")
  with .miGraph
        .height = oForm.height - 20
  	.width = oForm.width
 	.left = 0
  	.top = 0
  	.ControlSource = "testgen.Genfld1"
  	.ChartType= 54
  	.visible = .T.
  	.refresh
  	
	endwith
endwith
oform.visible=.T.
READ EVENTS

**//TipodeGraficos
**  	51 (sencillo) BARRAS CONTINUAS
**  	54 (BARRAS CONTINUAS) 3D
**		58 (BARRAS CONTINUAS) HORIZONTAL
**		63 (DISPERSION)
**		65 (DISPERSION)
**		70 (TORTAS) 3D PREFERIBLE UNA SERIE
**		92 (CONICO) CONTINUO
**      93 (CONICO) EN UN SOLO
**      97 (CONICO) HORIZONTAL
**      98 (CONICO) 3D
**		99 (TRIANGULAR) 3D SEPARADO
**		100 (TRINGULAR) 3D EN UN SOLO
**		110 (TRIANGULAR) 3D HORIZONTAL
**  	-4100 (CUADRADO 3D)
**		87 (BURBUJAS) PREFERIBLE UNA SERIE
