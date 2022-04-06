**----------------------------------------------------------------
**-- Prg. Respaldos directorio Data
**-- Ing. Pedro Piña
**----------------------------------------------------------------

**--Cerrar BD y Tablas
CLOSE DATABASES
CLOSE TABLES ALL

**--Entorno 
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
SET MULTILOCKS ON
SET SYSMENU OFF 

**--Ventana VFox
_screen.Caption ='Copia de Seguridad '
*_SCREEN.ADDOBJECT("oImg", "Image")
*_SCREEN.oImg.PICTURE = SYS(5)+"\siamsalon\imagenes\siamplus.jpg"
*_SCREEN.oImg.PICTURE = SYS(5)+"\siamsalon\imagenes\sarastylo.jpg"
*_SCREEN.oImg.VISIBLE = .T.
_screen.MaxButton=.f.
_screen.MinButton=.t.
_screen.BackColor=RGB(128,128,192)
_screen.AutoCenter= .T.
_screen.WindowState= 2
_screen.Closable=.f.

**--Variables
etiqueta = DTOS(DATE())							&& Etiqueta de Respaldo
dirOrigen='d:\siamresto\data\'					&& Directorio Origen
dirDestino='d:\backup\siamres\'+'&etiqueta'		&& Directorio Destino

WAIT WINDOW "Creando respaldo de Seguridad, por favor espere..." TIMEOUT .8

**---------------------------------------------------------------
**//Directorio donde se almacenaran los archivos 
**---------------------------------------------------------------
IF DIRECTORY('&dirdestino')=.f.
   MKDIR &dirdestino
ENDIF

sw=1

DO case

CASE sw=1
	**--Copiar todo el directorio
	COPY FILE '&dirOrigen'+'*.*' TO '&dirDestino'
	
CASE sw=2

	**--Copiar por tipo de archivos(detallados)
	COPY FILE '&dirOrigen'+'*.dcx' TO '&dirDestino'
	COPY FILE '&dirOrigen'+'*.dbc' TO '&dirDestino'
	COPY FILE '&dirOrigen'+'*.dct' TO '&dirDestino'
	COPY FILE '&dirOrigen'+'*.fpt' TO '&dirDestino'
	COPY FILE '&dirOrigen'+'*.dbf' TO '&dirDestino'
	COPY FILE '&dirOrigen'+'*.cdx' TO '&dirDestino'
	COPY FILE '&dirOrigen'+'*.idx' TO '&dirDestino'

	**--Copiar pkzip y pkunzip
	COPY FILE '&dirOrigen'+'pkzip.exe' TO '&dirDestino'
	COPY FILE '&dirOrigen'+'pkunzip.exe' TO '&dirDestino'

	**--Copiar Dll (printer fiscal y otros)
	COPY FILE '&dirOrigen'+'*.dll' TO '&dirDestino'
	
	**--Copiar Libreria de Bematech
	COPY FILE '&dirOrigen'+'*.cmd' TO '&dirDestino'
	
ENDCASE


**--Nota: debe estar el pkzip y pkunzip en el directorio Data
**--Empaquetar Backup nuevo 
WAIT WINDOW "Inciando Empaquetamiento, por favor espere..." TIMEOUT .8

CD &dirdestino

*!*	MESSAGEBOX('&DIRDESTINO')

!PKZIP -ex -spa55word &dirdestino

WAIT WINDOW "Terminó el respaldo de datos con éxito..." TIMEOUT .8

QUIT

RETURN



