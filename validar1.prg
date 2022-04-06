SET PATH TO HOME( )
CLEAR
IF FILE('foxuser.dbf')
WAIT WINDOW 'El archivo de recursos de Visual FoxPro existe'
ELSE
WAIT WINDOW 'El archivo de recursos de Visual FoxPro no existe'
ENDIF
