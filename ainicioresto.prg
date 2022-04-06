*--------------------------------------------------------------------------------------------
*--- Inicio.prg
*--- Programa Principal del Sistema SiamFox version 2.009
*--- Prog. Ing. Pedro Piña
*--- 15/06/2014
*--- 
*--------------------------------------------------------------------------------------------
PARAMETERS sta

*--- Publicar Estacion activa
PUBLIC xsta as character
STORE sta 	TO  xsta

*--- Publicar Icono de Formularios
PUBLIC xe10 as Character &&Permite iniciar sin icono en los formularios
xe10='siamchef.ico'

*!*	*---------------------------------------------------
*!*	*--- Fondo del Menu Principal
*!*	*---------------------------------------------------
*!*	_screen.windowstate=2
*!*	*!*	_screen.Caption="Siam Sara Stylo v1.11"
*!*	*!*	_screen.Icon='c:\siamSalon\iconos\'+UPPER(ALLTRIM(xe10))
*!*	_screen.Closable=.f.
*!*	*!*	*!*	*!*	******_SCREEN.VISIBLE = .F.

*!*	*----------------------------------------------------------------------------
*!*	*--- VALIDAR EXISTENCIA LICENCIA
*!*	*----------------------------------------------------------------------------
*!*	ARCHI="COPIA"
*!*	pruta=SYS(5)+'\windows\system32'
*!*	SET PATH 	TO  '&pruta'
*!*	IF !FILE('&ARCHI'+'.obj',1)
*!*	MESSAGEBOX('<<< LICENCIA INVALIDA LLAME AL GRUPO SIAMFOX C.A       '+CHR(13)+;
*!*	'<<< (0212)564.45.74 / (0416)936.80.05 / (0416)538.27.98 '+CHR(13)+;
*!*	'<<< ----------------------------------------------------'+CHR(13)+;
*!*	'<<< siamfoxplus@hotmail.com'+CHR(13)+;
*!*	'<<< ventas@gruposiamfox.com'+CHR(13)+;
*!*	'<<< administracion@gruposiamfox.com'+CHR(13)+;
*!*	'<<< www.gruposiamfox.com',0+16,'Atencion')
*!*	QUIT
*!*	ELSE
*!*	WAIT windows '<<< Validando Licencia, por favor espere...!!! >>> ' TIMEOUT 0.5 
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
**SET SYSMENU TO default
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
SET SYSMENU off
SET ESCAPE OFF 


*---------------------------------------------------
*--- Enrutar Almacenamiento y Programas 
*---------------------------------------------------
*!*	druta=SYS(5)+CURDIR()  
*!*	pruta=SYS(5)+CURDIR()

IF EMPTY(xsta) .or. xsta='1'

	druta=LOWER('\SiamResto\')			&&+SYS(5)+CURDIR()  
	pruta=LOWER('\SiamResto\')			&&+SYS(5)+CURDIR()			

ELSE

	druta=LOWER('\\Caja\SiamResto\')			&&+SYS(5)+CURDIR()  
	pruta=LOWER('\\Caja\SiamResto\')			&&+SYS(5)+CURDIR()			

ENDIF 


*!*	MESSAGEBOX('&druta')
*!*	MESSAGEBOX('&pruta')

SET DEFAULT TO 	"&druta"+"DATA"
SET PATH 	TO 	"&pruta"+"PROG;"+;
				"&pruta"+"FORM;"+;
				"&pruta"+"IMAGENES;"+;
				"&pruta"+"BITMAPS;"+;
				"&pruta"+"REPORTES;"+;
				"&pruta"+"MENU;"+;
				"&pruta"+"CLASES;"+;
				"&pruta"+"ICONOS;"+;
				"&pruta"+"LIBRERIAS"


*-------------------------------------------
*--- Activar Procedimientos y Librerias
*-------------------------------------------
*SET PROCEDURE TO FUNCION,MONTOALETRAS,ERRORES,RETORNOS,CODEBAR
SET PROCEDURE TO FUNCION,MONTOALETRAS,ERRORES,RETORNOS,foxbarcode,gpImage2



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


**--
**--Validar aplicativo esta activo
**--
 IF !IS_RUN('siamresto.exe')  && QUE NO SE CARGE 2 VECES EL SISTEMA
 	*WAIT WINDOWS 'Aplicacion ya se encuentra activa...' TIMEOUT 1.5
 	MESSAGEBOX('Aplicacion ya se encuentra abierta...',0+64,'Atencion')
	CLEAR DLLS
	CLEAR EVENTS 
	RETURN(.F.)
  ENDIF

**--Otra forma de no activar dos veces el aplicativo
IF NOT F_ActivaWin("bienvenida")
	DO FORM bienvenida
	*DO FORM frmmenuppal1
ENDIF


*--------------------------------------------------------------------
*---Declaración de la DLL que manejan la impresora fiscal okidata/Aclas
*--------------------------------------------------------------------
PUBLIC lStatus, lError

DECLARE INTEGER  OpenFpctrl      IN TFHKAIF.DLL  String lpPortName
DECLARE INTEGER  CloseFpctrl     IN TFHKAIF.DLL  
DECLARE INTEGER  CheckFprinter   IN TFHKAIF.DLL  
DECLARE INTEGER  ReadFpStatus    IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError
DECLARE INTEGER  SendCmd         IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @cmd
DECLARE INTEGER  SendNCmd        IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @bufferCmd
DECLARE INTEGER  SendFileCmd     IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @fileCmd
DECLARE INTEGER  UploadReportCmd IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @cmd,string @fileCmd
DECLARE INTEGER  UploadStatusCmd IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @cmd,string @fileCmd

*---------------------------------------------
*---Verificar Licencia
*---------------------------------------------
WAIT WINDOWS 'Verificando Activacion del Sistema, Por favor espere...' TIMEOUT 0.5 
licencia()


*---------------------------------------------
*---Verificar Existencias Tablas
*---------------------------------------------
WAIT WINDOWS 'Verificando Tablas del Sistema, Por favor espere...' TIMEOUT 0.5 
***buscarTablas()


*-------------------------------------------
**--Activar Libreria FoxyPreviewer
*-------------------------------------------
DO FoxyPreviewer.App




*-------------------------------------------
*--- Configurar entorno del Menu Principal
*-------------------------------------------
CLEAR

**--Propiedades de Pantalla
_screen.MaxHeight=1024
_screen.MaxWidth=1280
_screen.WindowState= 2 
_screen.Closable= .F. 
_screen.Caption="SiamChef v1.14 -" + cfecha(DATE())  
_screen.Icon='c:\siamResto\iconos\'+UPPER(ALLTRIM(xe10))

*!*	IF xs05=.t.
*!*	modo='Centralizado'
*!*	ELSE
*!*	modo='Distribuido'
*!*	endif
*!*	_screen.Caption ='Siam Sara Stylo v1.11 - Usuario: '+alltrim(xu003)+' Estacion: '+ALLTRIM(xsta)+' - '+ALLTRIM(Modo)
*!*	_screen.Icon='c:\siamsalon\iconos\'+UPPER(ALLTRIM(xe10))
*!*	_SCREEN.ADDOBJECT("oImg", "Image")
*!*	*_SCREEN.oImg.PICTURE = SYS(5)+"\siamsalon\imagenes\siamplus.jpg"
*!*	_SCREEN.oImg.PICTURE = SYS(5)+"\siamsalon\imagenes\sarastylo.jpg"
*!*	*_SCREEN.oImg.TOP = (_SCREEN.HEIGHT- _SCREEN.oImg.HEIGHT)/2
*!*	*_SCREEN.oImg.LEFT = (_SCREEN.WIDTH - _SCREEN.oImg.WIDTH)/2
*!*	*_SCREEN.oImg.anchor = 240
*!*	*_SCREEN.oImg.stretch = 2
*!*	_SCREEN.oImg.VISIBLE = .T.
*!*	_screen.MaxButton=.f.
*!*	_screen.MinButton=.t.
*!*	*_screen.BackColor=RGB(240,240,240)
*!*	_screen.BackColor=RGB(128,128,192)
*!*	**_screen.BackColor=RGB(0,64,128)
*!*	_screen.AutoCenter= .T.
*!*	_screen.WindowState= 2
*!*	_screen.Closable=.t.

*ON SHUTDOWN CLEAR EVENTS	&& Activar(x) cierre en menuppal  
*ON SHUTDOWN SALIR()		&& Activar/Desactivar(x) menuppal

READ EVENTS					&& Activar Lectura de Eventos

QUIT

RETURN