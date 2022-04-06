************** Programa 2***********
#define xlBubble3DEffect  87
#DEFINE TAB CHR(9)
#DEFINE CRLF CHR(13)+CHR(10)
create cursor test (degree i, seno ;
 n(8,4) NULL, coseno n(8,4))
for ix = 1 to 90
 insert into test values ;
       (ix,cos(ix)*ix,sin(ix)*ix)
endfor
45
scan next 30     
  replace seno with .null.       
endscan

wait window nowait "Cargando..."
MCGDATA = ""
nCols = fcount()
for ix = 1 to nCols
    MCGDATA = MCGDATA + ;
      iif(empty(MCGDATA),"",;
      TAB)+field(ix)
endfor
MCGDATA = MCGDATA + CRLF
scan
  for ix = 1 to nCols
     MCGDATA = MCGDATA + ;
     iif(ix=1,"",TAB)+nvl;
     (str(evaluate(field(ix))),"")
  endfor
  MCGDATA = MCGDATA + CRLF
endscan

create cursor testgen (genfld1 g)
append blank
append general genfld1 class ;
"msgraph.Chart.8" data MCGDATA
oForm = createobject("Form")
with oForm
.height = 400
.width = 600
.addobject("myGraph","OleBoundControl")
with .myGraph
  .height = oForm.height - 20
  .width = oForm.width
  .left = 0
  .top = 0
  .ControlSource = "testgen.Genfld1"     
  .hastitle = .t.
  .haslegend = .t.
  .ChartTitle.caption = "Título del Chart"
  .object.application.plotby = 2
  .ChartType= xlBubble3DEffect
  .visible = .T.
  .refresh
endwith
endwith
oform.visible=.T.
read events

