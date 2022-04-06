CLEAR
DIMENSION gaMyListArray(10)
FOR gnCount = 1 to 10  && Fill the array with letters
STORE REPLICATE(CHR(gnCount+64),6) TO gaMyListArray(gnCount)
NEXT
frmMyForm = CREATEOBJECT('Form')  && Create a Form
frmMyForm.Closable = .f.  && Disable the Control menu box
frmMyForm.Move(150,10)  && Move the form
frmMyForm.AddObject('cmbCommand1','cmdMyCmdBtn')  && Add "Quit" Command button
frmMyForm.AddObject('lstListBox1','lstMyListBox')  && Add ListBox control
frmMyForm.lstListBox1.RowSourceType = 5  && Specifies an array
frmMyForm.lstListBox1.RowSource = 'gaMyListArray' && Array containing listbox items
frmMyForm.cmbCommand1.Visible =.T.  && "Quit" Command button visible
frmMyForm.lstListBox1.Visible =.T.  && "List Box visible
frmMyForm.SHOW  && Display the form
READ EVENTS  && Start event processing
DEFINE CLASS cmdMyCmdBtn AS CommandButton  && Create Command button
Caption = '\<Quit'  && Caption on the Command button
Cancel = .T.  && Default Cancel Command button (Esc)
Left = 125  && Command button column
Top = 210  && Command button row
Height = 25  && Command button height
PROCEDURE Click
CLEAR EVENTS  && Stop event processing, close Form
CLEAR  && Clear main Visual FoxPro window
ENDDEFINE
DEFINE CLASS lstMyListBox AS ListBox  && Create ListBox control
Left = 10  && List Box column
Top = 10  && List Box row
MultiSelect = .T.  && Allow selecting more than 1 item
PROCEDURE Click
ACTIVATE SCREEN
CLEAR
? "Selected items:"
? "---------------"
FOR nCnt = 1 TO ThisForm.lstListBox1.ListCount
IF ThisForm.lstListBox1.Selected(nCnt)  && Is item selected?
? SPACE(5) + ThisForm.lstListBox1.List(nCnt) && Show item
ENDIF
ENDFOR
ENDDEFINE
