PUBLIC oform 
oform=NewObject("ScrollForm") 
oform.show 

DEFINE CLASS ScrollForm AS form 
Top = 0 
Left = 0 
Height = 101 
Width = 168 
ScrollBars = 2 
Caption = "Use PgUp/PgDwn to Scroll Form" 
vertscrollpos = 0 
Name = "Form1" 
ADD OBJECT shape1 AS shape WITH ; 
Top = 12, ; 
Left = 12, ; 
Height = 421, ; 
Width = 553, ; 
Name = "Shape1" 
ADD OBJECT command1 AS ; 
commandbutton WITH ; 
Top = 24, ; 
Left = 36, ; 
Height = 27, ; 
Width = 84, ; 
Caption = "Close", ; 
Name = "Command1" 

PROCEDURE KeyPress 
LPARAMETERS nKeyCode,; 
nShiftAltCtrl 
IF nKeyCode=3 
Thisform.vertscrollpos=; 
Thisform.; 
vertscrollpos+; 
Thisform.height 
Thisform.SetViewPort(; 
0,Thisform.; 
vertscrollpos) 
Thisform.Refresh 
ENDIF 
IF nKeyCode=18 
Thisform.vertscrollpos; 
=Thisform.; 
vertscrollpos-thisform.; 
height 
Thisform.SetViewPort(; 
0,Thisform.; 
vertscrollpos) 
Thisform.Refresh 
ENDIF 
ENDPROC 
PROCEDURE command1.Click 
thisform.release 
ENDPROC 
ENDDEFINE