*OCULTA BARRA DE TAREAS DE WINDOWS
*!* Oculta la barra de tareas de windows
*!* Sintaxis: HideTaskBar()
*!* Valor devuelto:
*!* Argumentos:
FUNCTION HideTaskBar

*!* Constantes para ocultar o mostrar la barra de tareas de windows
* Sgte linea notificada por Hugo Ranea 20/06/2001
#DEFINE TOGGLE_HIDEWINDOW 128
LOCAL lnHwnd
*!* Valores
lnHwnd = 0
*!* Instrucciones DECLARE DLL para manipular la barra de tareas
DECLARE INTEGER FindWindowA IN Win32API STRING lpClassName,;
STRING lpWindowName
DECLARE INTEGER SetWindowPos IN Win32API INTEGER hwnd,;
INTEGER hwndInsertAfter, INTEGER x, INTEGER y, INTEGER cx,;
INTEGER cy, INTEGER wFlags
*!* Valores
lnHwnd = FindWindowA('Shell_traywnd', '')
*!* Ocultar la barra de tareas
IF lnHwnd <> 0
SetWindowPos(lnHwnd, 0, 0, 0, 0, 0, TOGGLE_HIDEWINDOW)
ENDIF
ENDFUNC