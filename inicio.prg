*--------------------------------------------------------------------------------------------
*--- Inicio.prg
*--- Programa Principal del Sistema SiamFox version 2.009
*--- Prog. Ing. Pedro Piña
*--- 21/03/2008 / 30/07/2009
*--- 
*--------------------------------------------------------------------------------------------
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
*!*	CLEAR ALL
*!*	CLOSE ALL
*!*	CLEAR
*!*	CLEAR EVENTS
*!*	CLOSE DATABASES
*!*	*SET FILTER 	TO 
*!*	SET DEFAULT TO 
*!*	SET PATH 	TO  


*----------------------------------------------------------------------------
*--- VALIDAR EXISTENCIA LICENCIA
*----------------------------------------------------------------------------
*!*	ARCHI="COPIA"
*!*	pruta=SYS(5)+'\windows\system32'
*!*	SET PATH 	TO  '&pruta'
*!*	IF !FILE('&ARCHI'+'.obj',1)
*!*	WAIT windows '<<< LICENCIA INVALIDA LLAME AL (0426) 611.32.08 Ing. Pedro Piña >>> '
*!*	QUIT
*!*	ELSE
*!*	*messagebox('<<< nO CONSEGUI NADA PA LANTE >>> ',0+64,'Atencion')
*!*	ENDIF

*---------------------------------------------------
*--- Configurar el Ambiente de Trabajo
*---------------------------------------------------
SET HELP OFF
SET ECHO OFF
SET TALK OFF
SET SAFETY OFF 
SET EXCLUSIVE OFF 
SET MULTILOCKS OFF
SET COMPATIBLE OFF
SET SYSMENU OFF
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


*---------------------------------------------------
*--- Enrutar Almacenamiento y Programas 
*---------------------------------------------------
druta=SYS(5)+CURDIR()  
pruta=SYS(5)+CURDIR()			

SET DEFAULT TO 	"&druta"+"DATA"
SET PATH 	TO 	"&pruta"+"PROG;"+;
				"&pruta"+"FORM;"+;
				"&pruta"+"IMAGENES;"+;
				"&pruta"+"BITMAPS;"+;
				"&pruta"+"REPORTES;"+;
				"&pruta"+"MENU;"+;
				"&pruta"+"CLASES;"+;
				"&pruta"+"LIBRERIAS"

*------------------------------------------------------
*--- Antes cargar la configuracion local de la estacion
*------------------------------------------------------
*!*	*drutaloc=SYS(5)+CURDIR()
*!*	*prutaloc=SYS(5)+CURDIR()			

*!*	*SET DEFAULT TO "&drutaloc"+"DATA"
*!*	*SET PATH 	TO 	"&prutaloc"+"PROG;"+;
*!*					"&prutaloc"+"FORM;"+;
*!*					"&prutaloc"+"IMAGENES;"+;
*!*					"&prutaloc"+"BITMAPS;"+;
*!*					"&prutaloc"+"REPORTES;"+;
*!*					"&prutaloc"+"MENU;"+;
*!*					"&prutaloc"+"CLASES;"+;
*!*					"&prutaloc"+"LIBRERIAS"
				

*-------------------------------------------
*--- Activar Procedimientos y Librerias
*-------------------------------------------
SET PROCEDURE TO FUNCION,MONTOALETRAS,ERRORES,RETORNOS
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
*!*	IF xs11=.t. 
*!*		Barra1()
*!*	ENDIF


*-------------------------------------------
*--- Configurar entorno del Menu Principal
*-------------------------------------------
*CLEAR
IF xs05=.t.
modo='Centralizado'
ELSE
modo='Distribuido'
endif
_screen.Caption ='Siam Plus v2.11 - Usuario: '+alltrim(xu003)+' Estacion: '+ALLTRIM(xsta)+' - '+ALLTRIM(Modo)
_screen.Icon='c:\siamfox\iconos\'+UPPER(ALLTRIM(xe10))
_SCREEN.ADDOBJECT("oImg", "Image")
_SCREEN.oImg.PICTURE = SYS(5)+"\siamfox\imagenes\siamAgua5.jpg"
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

*ON SHUTDOWN CLEAR EVENTS	&& Activar(x) cierre en menuppal  
*ON SHUTDOWN cerrar()		&& Desactivar (x) 
READ EVENTS					&& Activar Lectura de Eventos

*-------------------------------------------
*--- FIN PROGRAMA 
*-------------------------------------------
**SALIDA()
SALIR()
CLEAR ALL
CLOSE ALL
CLEAR
CLEAR EVENTS
CLOSE DATABASES
**RELEASE thisform
QUIT

*-------------------------------------------
*--- FINAL DEL PROGRAMA 
*-------------------------------------------
*!*	ON SHUTDOWN cerrar ()
*!*	application.caption="Sistemas Empresa - application.caption"
*!*	CLEAR 
*!*	_screen.windowstate=2
*!*	_screen.MaxButton=.f.
*!*	_screen.MinButton=.f.
*!*	_screen.Caption=" Sistemas Empresa "
*!*	_screen.backcolor=8421376
*!*	_screen.Picture="c:\ivaempre\screens\moscow2.jpg"
*!*	_screen.AutoCenter =.f.
*!*	_screen.Icon = "C:\ivaempre\iconos\PC.ICO"
*!*	* 16776960 agua marina
*!*	_screen.BackColor=10485760
*!*	SET DATE FRENCH
*!*	SET DEFAULT TO "c:\ivaempre"
*!*	SET DELETED ON 
*!*	DO MENUPRIN.MPR
*!*	READ EVENTS
*!*	PROCEDURE cerrar ()
*!*	IF MESSAGEBOX("DESEA SALIR DEL SISTEMA IVA EMPRESA?",4+32,"SALIR") = 6
*!*		QUIT
*!*	ENDIF 
*!*	ENDPROC  




