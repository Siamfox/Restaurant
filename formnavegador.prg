PUBLIC oForm
oForm = NEWOBJECT("MiExplorador")
oForm.SHOW
DEFINE CLASS MiExplorador AS FORM
  TOP = 0
  LEFT = 0
  DOCREATE = .T.
  CAPTION = "PortalFox :: Nada corre como un zorro"
  WINDOWSTATE = 0
  NAME = "Form1"
  WIDTH = 800
  HEIGHT = 600
  ADD OBJECT olecontrol1 AS OLECONTROL WITH ;
    TOP = 10, ;
    LEFT = 10, ;
    WIDTH = 780, ;
    HEIGHT = 580, ;
    NAME = "Olecontrol1", ;
    OLECLASS = "Shell.Explorer.2"
  PROCEDURE RESIZE
    THIS.olecontrol1.HEIGHT = THIS.HEIGHT - 20
    THIS.olecontrol1.WIDTH = THIS.WIDTH - 20
  ENDPROC
  PROCEDURE olecontrol1.REFRESH
    NODEFAULT
  ENDPROC
  PROCEDURE olecontrol1.INIT
    THIS.NAVIGATE("http://siamfox.globered.com")
  ENDPROC
ENDDEFINE

