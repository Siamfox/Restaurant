*--------------------------------------------------------------------------------------------
*--- Inicio.prg
*--- Programa Principal del Sistema SiamFox version 2.009
*--- Prog. Ing. Pedro Piña
*--- 21/03/2008 / 30/07/2009
*--- 
*--------------------------------------------------------------------------------------------
PARAMETERS sta

*---------------------------------------------------
*--- Publicar Estacion activa
*---------------------------------------------------
PUBLIC xsta as character
STORE sta 	TO  xsta

*---------------------------------------------------
*--- Publicar Icono de Formularios
*---------------------------------------------------
PUBLIC xe10 as Character &&Permite iniciar sin icono en los formularios
*xe10='siamfox48.ico'
xe10='siamfoxplus99.ico'


*---------------------------------------------------
*--- Ventana de VisualFox 
*---------------------------------------------------
**CLEAR 
*!*	application.caption="Sistemas Empresa - application.caption"
*!*	*!*	_screen.windowstate=2
*!*	*!*	_screen.Caption="Siam Plus v2.11"
*!*	*!*	_screen.Icon='c:\siamfox\iconos\'+UPPER(ALLTRIM(xe10))
*!*	_screen.MaxButton=.f.
*!*	_screen.MinButton=.f.
**_screen.backcolor=8421376
*!*	_screen.Picture="c:\ivaempre\screens\moscow2.jpg"
*!*	_screen.AutoCenter =.f.


*----------------------------------------------------------------------------
*--- VALIDAR EXISTENCIA LICENCIA
*----------------------------------------------------------------------------
**LICENCIA()

*---------------------------------------------------
*--- Configurar el Ambiente de Trabajo
*---------------------------------------------------
SET HELP OFF
SET ECHO OFF
SET TALK OFF
SET SAFETY OFF 
SET EXCLUSIVE OFF 
SET MULTILOCKS ON
SET COMPATIBLE OFF
SET SYSMENU TO default
SET CONFIRM OFF 
SET CENTURY ON
SET DELETED ON 
SET EXACT ON
SET LOGERRORS ON 
SET BELL ON
SET CLOCK STATUS
SET DECIMALS TO 2
SET COLOR TO
SET DATE TO DMY
SET ESCAPE OFF 



*---------------------------------------------------
*--- Enrutar Almacenamiento y Programas 
*---------------------------------------------------
**lcArchivos="C:\Archivos de programa\Siamfox\data"
**druta=SYS(5)+lcArchivos
**pruta=SYS(5)+lcArchivos


druta=SYS(5)+CURDIR()  
pruta=SYS(5)+CURDIR()			


SET DEFAULT TO 	"&druta"+"DATA"
SET PATH 	TO 	"&pruta"+"PROG;"+;
				"&pruta"+"FORM;"+;
				"&pruta"+"IMAGENES;"+;
				"&pruta"+"IMAGENES2;"+;
				"&pruta"+"BITMAPS;"+;
				"&pruta"+"REPORTES;"+;
				"&pruta"+"MENU;"+;
				"&pruta"+"CLASES;"+;
				"&pruta"+"LIBRERIAS"


*-------------------------------------------
*--- Activar Procedimientos y Librerias
*-------------------------------------------
SET PROCEDURE TO FUNCION,MONTOALETRAS,ERRORES,RETORNOS
*******SET LIBRARY	  TO tm20vf32.fll
*SET PROCEDURE TO ScrnSave ADDITIVE
*SET CLASSLIB  TO Presenta.vcx ADDITIVE



*-------------------------------------------
*--- Activar Protector de Pantalla
*-------------------------------------------
*!*	oSaver = CREATEOBJECT('ScreenSaver')
*!*	RELEASE PROCEDURE ScrnSave


*-------------------------------------------
*--- Crear el objeto Presenta y Parametros
*-------------------------------------------
*---  CREATEOBJECT("Presenta", tcTitulo, tcImagen)
*---  Parámetros: tcTitulo: Título de la aplicación
*---              tcImagen: Imagen de fondo del formulario (.BMP, .JPG ó .GIF)

*!*	oPresenta = CREATEOBJECT("Presenta", "Sistema Administrativo ®", "siam.bmp")
*!*	oPresenta.SHOW

*!*	_SCREEN.VISIBLE = .F.

*!*	*--- Retardo para que se muestre completa la pantalla
*!*	DOEVENTS
*!*	DOEVENTS
*!*	DOEVENTS

					
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

*-------------------------------------------
*--- Activar Informe de Errores
*-------------------------------------------
IF xs06=.t.
	ON ERROR Do errores WITH ;
	ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
ENDIF

*--------------------------------------------------------------------
*---Declaración de la DLL que manejan la impresora fiscal okidata
*--------------------------------------------------------------------
*!*	PUBLIC lStatus, lError

*!*	DECLARE INTEGER  OpenFpctrl      IN TFHKAIF.DLL  String lpPortName
*!*	DECLARE INTEGER  CloseFpctrl     IN TFHKAIF.DLL  
*!*	DECLARE INTEGER  CheckFprinter   IN TFHKAIF.DLL  
*!*	DECLARE INTEGER  ReadFpStatus    IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError
*!*	DECLARE INTEGER  SendCmd         IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @cmd
*!*	DECLARE INTEGER  SendNCmd        IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @bufferCmd
*!*	DECLARE INTEGER  SendFileCmd     IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @fileCmd
*!*	DECLARE INTEGER  UploadReportCmd IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @cmd,string @fileCmd
*!*	DECLARE INTEGER  UploadStatusCmd IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @cmd,string @fileCmd

*-------------------------------------------
*--- Delay de la Presentacion--
*-------------------------------------------
*!*	=INKEY(1)
*!*	oPresenta.RELEASE
*!*	*--- Para volver a mostrar la pantalla de VFP
*!*	_SCREEN.VISIBLE = .T.

*-------------------------------------------
*--- Formulario principal
*-------------------------------------------

*---------------------------------------------
*---Verificar Licencia
*---------------------------------------------
WAIT WINDOWS 'Verificando Activacion del Sistema, Por favor espere...' TIMEOUT 0.5 
licencia()


*---------------------------------------------------
*--- Validar Aplicacion Abierta Ventana de VisualFox 
*---------------------------------------------------
*!*	LOCAL lcold_caption
*!*	lcold_caption=_screen.Caption
*!*	IF VALIDARPANTALLA("SiamFox Plus v2.11 - Estacion: '+ALLTRIM(xsta)+' Usuario: '+alltrim(xu003)+'  - '+ALLTRIM(Modo)", .T.)=.T.
*!*	   _SCREEN.Caption="SiamFox Plus v2.11 - Estacion: '+ALLTRIM(xsta)+' Usuario: '+alltrim(xu003)+'  - '+ALLTRIM(Modo)"  && OJO AQUI VA EL CAPTION DE la APLICACION


*-------------------------------------------
*--- Verificar Seguridad de Acceso
*-------------------------------------------
DO FORM frmAcceso 


*---------------------------------------------
*---Verificar Existencias Tablas
*---------------------------------------------
WAIT WINDOWS 'Verificando Tablas del Sistema, Por favor espere...' TIMEOUT 0.5 
buscarTablas()

*-------------------------------------------
**--- Activar Menu Principal
*-------------------------------------------
DO SIAMENU.MPR				

*-------------------------------------------
*--- Activar Barra Principal del Menu
*-------------------------------------------
IF xs11=.t. 
	Barra1()
ENDIF


*-------------------------------------------
*--- Configurar entorno del Menu Principal
*-------------------------------------------
*CLEAR
IF xs05=.t.
modo='Centralizado'
ELSE
modo='Distribuido'
endif

_screen.Caption ='SiamFox Plus v2.11 - Estacion: '+ALLTRIM(xsta)+' Usuario: '+alltrim(xu003)+'  - '+ALLTRIM(Modo)
_screen.Icon='c:\siamfox\iconos\'+UPPER(ALLTRIM(xe10))
_SCREEN.ADDOBJECT("oImg", "Image")
_SCREEN.oImg.PICTURE = SYS(5)+"\siamfox\imagenes\siamplus.jpg"
****_SCREEN.oImg.PICTURE = SYS(5)+"\siamfox\imagenes\siamAgua5.jpg"
**_SCREEN.oImg.PICTURE = SYS(5)+"\siamfox\imagenes\siam2009plus_II.jpg"
***_SCREEN.oImg.PICTURE = SYS(5)+"\siamfox\imagenes\siam2009plus_III.jpg"
*_SCREEN.oImg.TOP = (_SCREEN.HEIGHT- _SCREEN.oImg.HEIGHT)/2
*_SCREEN.oImg.LEFT = (_SCREEN.WIDTH - _SCREEN.oImg.WIDTH)/2
*_SCREEN.oImg.anchor = 240
*_SCREEN.oImg.stretch = 2
_SCREEN.oImg.VISIBLE = .T.
_screen.MaxButton=.f.
_screen.MinButton=.t.
_screen.BackColor=RGB(193,193,230)
_screen.AutoCenter= .T.
_screen.WindowState= 2
_screen.Closable=.t.

ON SHUTDOWN CLEAR EVENTS	&& Activar(x) cierre en menuppal  
ON SHUTDOWN SALIR()			&& Activar/Desactivar(x) menuppal

READ EVENTS					&& Activar Lectura de Eventos
CLEAR EVENTS 				&& Activar(x) cierre en menuppal  

*!*	ENDIF
*!*	_screen.Caption=lcold_caption

*!*	*-------------------------------------------
*!*	*--- FIN PROGRAMA 
*!*	*-------------------------------------------
*!*	PROCEDURE SALIR()
*!*		IF MESSAGEBOX("<<<<<< Salir del Sistema >>>>>>",4+32+256,"Atencion") = 6
*!*			CLOSE TABLES all
*!*			CLOSE DATABASES ALL
*!*			QUIT
*!*		ENDIF 
*!*	ENDPROC  


RETURN





