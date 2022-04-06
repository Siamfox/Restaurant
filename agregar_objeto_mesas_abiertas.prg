**--Crear Mesas

*!*	ADD OBJECT txt1 AS textbox WITH ;
*!*			left = 80,width=200,top = 0
*!*		ADD OBJECT txt2 AS textbox WITH ;
*!*			left = 80,width=200,top = 30
*!*		ADD OBJECT txt3 AS textbox WITH ;
*!*			left = 80,width=200,top=60
*!*		ADD OBJECT txtCust_id AS TEXTBOX WITH ;
*!*			top = 5,left = 300,readonly = .t.,disabled=.t.
*!*		ADD OBJECT cmdNext AS commandButton WITH ;
*!*			caption="Next",top = 120
*!*		ADD OBJECT cmdPrev AS commandButton WITH ;
*!*			caption="Prev",top = 120,left=110
*!*		ADD OBJECT cmdSave AS commandButton WITH ;
*!*			caption="Save",top = 120,left=220


frmMyForm = CREATEOBJECT('Form')  && Create a Form
frmMyForm.Closable = .F.  && Disable the Control menu box

frmMyForm.AddObject('cmdCmndBtn1','cmdMyCmndBtn1')  && Up Cmnd button
frmMyForm.AddObject('cmdCmndBtn2','cmdMyCmndBtn2')  && Down Cmnd button
frmMyForm.AddObject('cmdCmndBtn100','cmdMyCmndBtn100')  && Quit Cmnd button


*frmMyForm.AddObject('text','cmdMytext1')  && Cuadro de texto


*ADD OBJECT txt1 AS textbox WITH ;
		left = 80,width=200,top = 0


frmMyForm.cmdCmndBtn1.Visible =.T.  
frmMyForm.cmdCmndBtn2.Visible =.T.  
frmMyForm.cmdCmndBtn100.Visible =.T.  


frmMyForm.SHOW  && Display the form
frmmyform.WindowState= 2

*this.setall('fontsize',14)

READ EVENTS  && Start event processing

DEFINE CLASS cmdMyCmndBtn1 AS COMMANDBUTTON  && Create Command button
WordWrap= .T.
fontsize=8
Left = 10  && Command button column
Top = 10  && Command button row
width = 100 
Height = 120  && Command button height
Caption = 'Mesa 1' +CHR(13)+' Pedro Piña'+CHR(13)+CHR(13)+'Mozo '+CHR(13)+' Juan '+CHR(13)+CHR(13)+'45000.00'  && Caption on the Command button


PROCEDURE Click
CLEAR EVENTS  && Stop event processing, close Form
ENDDEFINE


DEFINE CLASS cmdMyCmndBtn2 AS CommandButton  && Create Command button
WordWrap= .T.
fontsize=8
Left = 115  && Command button column
Top = 10  && Command button row
width = 100 
Height = 120  && Command button height
Caption = 'Socio -  s002'+CHR(13)+'Sara Tortoza'+CHR(13)+CHR(13)+'Mozo '+CHR(13)+' Juan '+CHR(13)+CHR(13)+' 120000.00'  && Caption on the Command button

PROCEDURE Click
CLEAR EVENTS  && Stop event processing, close Form
ENDDEFINE

DEFINE CLASS cmdMyCmndBtn100 AS CommandButton  && Create Command button
Cancel = .T.  && Default Cancel Command button (Esc)
Left = 10  && Command button column
Top = 380  && Command button row
Height = 60  && Command button height
Caption = '\<Salir'  && Caption on the Command button

PROCEDURE Click
CLEAR EVENTS  && Stop event processing, close Form
ENDDEFINE
