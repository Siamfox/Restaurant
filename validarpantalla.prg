*!*	LOCAL lcold_caption
*!*	lcold_caption=_screen.Caption

FUNCTION validarpantalla
    LPARAMETERS pccaption, plmax
    LOCAL lnhwnd
    DECLARE INTEGER FindWindow IN Win32API STRING lpClassName, STRING lpWindowName
    DECLARE INTEGER BringWindowToTop IN Win32API INTEGER HWND
    DECLARE INTEGER SendMessage IN Win32API INTEGER HWND, INTEGER Msg, INTEGER WParam, INTEGER LPARAM
    lnhwnd = findwindow( 0, pccaption )
    IF lnhwnd > 0
        bringwindowtotop(lnhwnd)           && Mandar la ventana de la aplicación al frente
        IF plmax = .T.
            sendmessage(lnhwnd, 274, 61488, 0) && Maximizar la ventana de la aplicación
        ENDIF
        RETURN .F.
    ENDIF
    RETURN .T.
ENDFUNC