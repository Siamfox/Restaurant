*!******************************************************************************
*!
*! Procedure FUENTE
*!
*!
*!******************************************************************************
Procedure fuente
	fontwin="c:\windows\fonts\"
	fuentettf="liquidcrystaldisplay.TTF"

	If File(fontwin+fuentettf) = .T.
		*messagebox("Si existe")
	Else
		Copy File "liquidcrystaldisplay.TTF" To "c:\windows\fonts\liquidcrystaldisplay.TTF"
	Endif

RETURN
