********************************************************************************************
** Inicio.prg
** Programa Principal del Sistema SiamFox
** Prog. Ing. Pedro Piña
** 21/03/2008 / 30/07/2009
**
*******************************************************************************************

PARAMETERS sta

*--- Publicar Estacion activa
PUBLIC xsta as character
STORE sta 	TO  xsta

*--- Publicar Icono de Formularios
PUBLIC xe10 as Character &&Permite iniciar sin icono en los formularios
xe10='siamfox48.ico'



*---------------------------------------------------
*--- Desactivar Eventos Anteriores en Memoria
*---------------------------------------------------
**CLEAR 
*!*	application.caption="Sistemas Empresa - application.caption"
_screen.windowstate=2
_screen.Caption="Siam Plus v2.11"
_screen.Icon='c:\siamfox\iconos\'+UPPER(ALLTRIM(xe10))
*!*	_screen.MaxButton=.f.
*!*	_screen.MinButton=.f.
**_screen.backcolor=8421376
*!*	_screen.Picture="c:\ivaempre\screens\moscow2.jpg"
*!*	_screen.AutoCenter =.f.

*-------------------------------------------
*--- Aquí hago todos los seteos
*--- o tareas mientras se muestra
*--- la presentación
*-------------------------------------------
**//Configurar el Ambiente
SET HELP off
SET ECHO OFF
SET TALK OFF
SET SAFETY OFF 
SET COLOR TO
SET CLOCK STATUS
SET CENTURY ON
SET DATE TO DMY
SET EXCLUSIVE OFF 
SET DELETED ON 
SET EXACT ON
SET COMPATIBLE OFF
SET LOGERRORS ON 
SET BELL ON
SET SYSMENU Off
****SET MULTILOCKS ON
**SET DECIMALS TO 2

*!*	**//Activar el Ambiente
*!*	CLEAR ALL
*!*	CLOSE ALL
*!*	CLEAR
*!*	CLEAR EVENTS
*!*	CLOSE DATABASES


**//Cargar Rutas del Sistema
SET DEFAULT TO 
SET PATH TO  && CURDIR()

sruta=SYS(5)+CURDIR()
pruta=SYS(5)+CURDIR()			

SET DEFAULT TO 	"&SRUTA"+"DATA"
SET PATH 	TO 	"&pruta"+"PROG;"+;
				"&pruta"+"FORM;"+;
				"&pruta"+"IMAGENES;"+;
				"&pruta"+"BITMAPS;"+;
				"&pruta"+"REPORTES;"+;
				"&pruta"+"MENU;"+;
				"&pruta"+"CLASES;"+;
				"&pruta"+"LIBRERIAS"


					
**//Activar Procedimientos
SET PROCEDURE TO FUNCION,MONTOALETRAS,ERRORES ADDITIVE


*---------------------------------------------------------------
*--- Captura Parametro indentificar estacion
*--- y correr el memo correspondiente
*--- Declarar Variables Publicas Globales y Local segun estacion 
*---------------------------------------------------------------
*---------------------------------------------------------------
*--- Captura Parametro indentificar estacion
*--- y correr el memo correspondiente
*--- Declarar Variables Publicas Globales y Local segun estacion 
*---------------------------------------------------------------
IF EMPTY(xsta) .or. xsta='1'
	xsta='1' 
	SIAMEMO()
	SIAMEMOLOC(xsta)
	WAIT WINDOWS 'Iniciando Estacion Principal...' TIMEOUT 0.5
ELSE
	xsta=sta
	SIAMEMO()
	SIAMEMOLOC(xsta)
	WAIT WINDOWS 'Iniciando Estacion '+xsta+' Multipuntos...' TIMEOUT 0.5 
ENDIF

**//Activar Informe de Errores
IF xs06=.t.
	ON ERROR Do errores WITH ;
	ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
ENDIF

=INKEY(1)
*--------------------------


**//Verificar Seguridad de Acceso
DO FORM frmAcceso 

**//Configurar entorno del Menu Principal
*CLEAR
_screen.Caption ='Siam v1.09 - Usuario: '+alltrim(xu003)+' Estacion: '+ALLTRIM(xsta)
_screen.Icon='c:\siamfox\iconos\'+UPPER(ALLTRIM(xe10))
_SCREEN.ADDOBJECT("oImg", "Image")
_SCREEN.oImg.PICTURE = "c:\siamfox\imagenes\siamAgua5.jpg"
*_SCREEN.oImg.TOP = (_SCREEN.HEIGHT- _SCREEN.oImg.HEIGHT)/2
*_SCREEN.oImg.LEFT = (_SCREEN.WIDTH - _SCREEN.oImg.WIDTH)/2
*_SCREEN.oImg.anchor = 240
*_SCREEN.oImg.stretch = 2
_SCREEN.oImg.VISIBLE = .T.
_screen.MaxButton=.f.
_screen.MinButton=.f.
*_screen.BackColor=RGB(193,193,230)
_screen.AutoCenter= .T.
_screen.WindowState= 2
_screen.Closable=.f.

**//Activar Menu Principal
**DO SIAMENU.MPR				&& Menu Principal

**//Activar Barra Principal del Menu
***barra1()

DO FORM frmptoVENTA

**//Salida 
SALIDA()
CLEAR ALL
CLOSE ALL
CLEAR
CLEAR EVENTS
CLOSE DATABASES
QUIT
RELEASE thisform
RETURN


*-------------------------------------------
*--- FINAL DEL PROGRAMA 
*-------------------------------------------





