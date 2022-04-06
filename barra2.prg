PUBLIC tbrDesktop
tbrDesktop = CREATEOBJ('mytoolbar')
tbrDesktop.SHOW

DEFINE CLASS myToolBar  AS Toolbar
ADD OBJECT btnBold 		AS CommandButton
ADD OBJECT sep1      	AS Separator
ADD OBJECT btnItalics 	AS CommandButton

btnBold.HEIGHT = 20
btnBold.WIDTH = 50
btnBold.Caption = "Bold"
btnItalics.HEIGHT = 20
btnItalics.WIDTH = 50
btnItalics.Caption = "Italic"
btnItalics.FontBold = .F.

LEFT   = 1
TOP = 1
WIDTH = 25

CAPTION = "Desktop Attributes"

PROCEDURE Activate
this.btnBold.FontBold = _SCREEN.FONTBOLD
this.btnItalics.FontItalic = _SCREEN.FONTITALIC
ENDPROC

PROCEDURE btnBold.CLICK
_SCREEN.FONTBOLD = !_SCREEN.FONTBOLD
This.FontBold =_SCREEN.FONTBOLD
ENDPROC

PROCEDURE btnItalics.CLICK
_SCREEN.FONTITALIC = !_SCREEN.FONTITALIC
This.FontItalic = _SCREEN.FONTITALIC
ENDPROC
ENDDEFINE
