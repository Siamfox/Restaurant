*-----------------------------
FUNCTION F_ActivaWin(cCaption)
*-----------------------------
LOCAL nHWD
DECLARE INTEGER FindWindow IN WIN32API ;
STRING cNULL, ;
STRING cWinName

DECLARE SetForegroundWindow IN WIN32API ;
INTEGER nHandle

DECLARE SetActiveWindow IN WIN32API ;
INTEGER nHandle

DECLARE ShowWindow IN WIN32API ;
INTEGER nHandle, ;
INTEGER nState

nHWD = FindWindow(0, cCaption)
IF nHWD > 0
	* VENTANA YA ACTIVA
	* LA "LLAMAMOS":
	ShowWindow(nHWD,9)

	* LA PONEMOS ENCIMA
	SetForegroundWindow(nHWD)

	* LA ACTIVAMOS
	SetActiveWindow(nHWD)
	RETURN .T.
ELSE
	* VENTANA NO ACTIVA
	RETURN .F.
ENDIF
