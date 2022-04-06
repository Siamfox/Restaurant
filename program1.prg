frmMyForm = CREATEOBJECT('Form')  && Create a Form
frmMyForm.Closable = .F.  && Disable the window pop-up menu

frmMyForm.AddObject('cmdCommand1','cmdMyCmndBtn')  && Add Command button
frmMyForm.AddObject('opgOptionGroup1','opgMyOptGrp') && Add Option Group
frmMyForm.AddObject('shpCircle1','shpMyCircle')  && Add Circle Shape
frmMyForm.AddObject('shpEllipse1','shpMyEllipse')  && Add Ellipse Shape
frmMyForm.AddObject('shpSquare','shpMySquare')  && Add Box Shape

frmMyForm.cmdCommand1.Visible =.T.  && "Quit" Command button visible

frmMyForm.opgOptionGroup1.Buttons(1).Caption = "\<Circle"
frmMyForm.opgOptionGroup1.Buttons(2).Caption = "\<Ellipse"
frmMyForm.opgOptionGroup1.Buttons(3).Caption = "\<Square"
frmMyForm.opgOptionGroup1.SetAll("Width", 100) && Set Option group width
frmMyForm.opgOptionGroup1.Visible = .T.  && Option Group visible
frmMyForm.opgOptionGroup1.Click  && Show the circle

frmMyForm.SHOW  && Display the form
READ EVENTS  && Start event processing

DEFINE CLASS opgMyOptGrp AS OptionGroup  && Create an Option Group
   ButtonCount = 3  && Three Option buttons
   Top = 10
   Left = 10
   Height = 75
   Width = 100

   PROCEDURE Click 
      ThisForm.shpCircle1.Visible = .F.  && Hide the circle
      ThisForm.shpEllipse1.Visible = .F.  && Hide the ellipse
      ThisForm.shpSquare.Visible = .F.  && Hide the square
      
      DO CASE
         CASE ThisForm.opgOptionGroup1.Value = 1
            ThisForm.shpCircle1.Visible = .T. && Show the circle
         CASE ThisForm.opgOptionGroup1.Value = 2 
            ThisForm.shpEllipse1.Visible = .T.  && Show the ellipse
         CASE ThisForm.opgOptionGroup1.Value = 3 
            ThisForm.shpSquare.Visible = .T.  && Show the square
      ENDCASE
ENDDEFINE

DEFINE CLASS cmdMyCmndBtn AS CommandButton  && Create Command button
   Caption = '\<Quit'  && Caption on the Command button
   Cancel = .T.  && Default Cancel Command button (Esc)
   Left = 125  && Command button column
   Top = 210  && Command button row
   Height = 25  && Command button height

   PROCEDURE Click
      CLEAR EVENTS  && Stop event processing, close Form
ENDDEFINE

DEFINE CLASS shpMyCircle AS SHAPE  && Create a circle
   Top = 10
   Left = 200
   Width = 100
   Height = 100
   Curvature = 99
   BackColor = RGB(255,0,0)  && Red
ENDDEFINE

DEFINE CLASS shpMyEllipse AS SHAPE  && Create an ellipse
   Top = 35
   Left = 200
   Width = 100
   Height = 50
   Curvature = 99
   BackColor = RGB(0,128,0)  && Green
ENDDEFINE

DEFINE CLASS shpMySquare AS SHAPE  && Create a square
   Top = 10
   Left = 200
   Width = 100
   Height = 100
   Curvature = 0
   BackColor = RGB(0,0,255)  && Blue
ENDDEFINE