*!*	*!*	**---------------------------------------------------------------
*!*	*!*	**//Validar el Puerto 
*!*	*!*	**---------------------------------------------------------------

*!*	*!*	**-------------------------------------
*!*	*!*	**//Validar Estacion localmente Nro
*!*	*!*	**-------------------------------------
*!*	*!*	SELECT 15
*!*	*!*	USE MEMOLOC SHARED 

*!*	*!*	LOCATE FOR xSTA=STA
*!*	*!*	IF FOUND() &&!EOF()
*!*	*!*		
*!*	*!*		WAIT windows 'Generando Variables Estacion '+sta TIMEOUT 0.5
*!*	*!*		
*!*	*!*		**//Cargar Data a variables
*!*	*!*		STORE s05		TO xs05 	&& Distribucion de Caja(Centralizada(T) o Distribuida(F))
*!*	*!*		*STORE s11		to xs11 	&& Barra Principal Habiltada(T) o Deshabilitada(F))
*!*	*!*		*STORE f01		TO xf01 	&& Descripcion Extendida Impresion Fiscal(modelo Bematech 2100)
*!*	*!*		*STORE f02		TO xf02 	&& Cod. Articulo Impresion Fiscal(modelo Bematech 2100)
*!*	*!*		STORE f03		TO xf03 	&& Activar Mensaje Fiscal (modelo Bematech 2100)
*!*	*!*		STORE f04		TO xf04 	&& Nro Item(s) por Factura (solo c/formatos)
*!*	*!*		STORE f05		TO xf05 	&& Modelo Printer Fiscal
*!*	*!*		STORE f06		TO xf06 	&& Serial Printer Fiscal
*!*	*!*		STORE f07		TO xf07 	&& Formato Printer Fiscal
*!*	*!*		STORE f08		TO xf08		&& Puerto Printer Fiscal
*!*	*!*		STORE ca01 		TO xca01 	&& Gaveta de Efectivo
*!*	*!*		STORE ca02		TO xca02 	&& Visor Cliente
*!*	*!*		STORE i03		TO xi03 	&& Imprimir por Pantalla
*!*	*!*		*STORE i12		TO xi12		&& Campo de Busqueda Catalogo Inventario
*!*	*!*		*STORE i13		TO xi13		&& Modelo de Catalogo

*!*	*!*	ELSE
*!*	*!*		WAIT WINDOWS 'No se encontro variables locales de la estacion...'+sta TIMEOUT 0.5
*!*	*!*		return
*!*	*!*	ENDIF	

*!*	*!*	**-----------------------------------------------------------------------
*!*	*!*	**--Validar Segun Tipo Printer Fiscal y/o Puerto Serial
*!*	*!*	**-----------------------------------------------------------------------

*!*	*!*	*!*	thisform.combo3.AddListItem("")
*!*	*!*	*!*	thisform.combo3.AddListItem("Bematech Local")
*!*	*!*	*!*	thisform.combo3.AddListItem("Bematech Remota")
*!*	*!*	*!*	thisform.combo3.AddListItem("Epson LX-300F ")
*!*	*!*	*!*	thisform.combo3.AddListItem("Epson PF-220 ")
*!*	*!*	*!*	thisform.combo3.AddListItem("Samsung Bixolon")
*!*	*!*	*!*	thisform.combo3.AddListItem("Okidata") 
*!*	*!*	*!*	thisform.combo3.AddListItem("Camel")
*!*	*!*	*!*	thisform.combo3.AddListItem("NCR")
*!*	*!*	*!*	thisform.combo3.AddListItem("IBM")
*!*	*!*	*!*	thisform.combo3.AddListItem("Oliveti")
*!*	*!*	*!*	thisform.combo3.AddListItem("Aclas")

*!*	*!*	**-----------------------------------------------------------------
*!*	*!*	**--Gaveta Activa por Puerto Serial
*!*	*!*	**-----------------------------------------------------------------
*!*	*!*	IF xca01=.t.  

*!*	*!*		**--Abrir por Puerto Asignado como Gaveta desde Panel de Control
*!*	*!*		**--Dirigir segun Nombre del Printer/Gaveta/		
*!*	*!*		SET PRINTER TO NAME 'Impcaja'
*!*	*!*			
*!*	*!*		WAIT windows 'AVISO, ABRIENDO GAVETA DINERO ...' NOWAIT 

*!*	*!*		??? CHR(27) + 'p' + CHR(0) + CHR(100) + CHR(250)


*!*	*!*		**--Impresora Bixolo 270
*!*	*!*		*Samsung	 SRP 270	 27,112,0,25,250
*!*	*!*		*Samsung	 SRP 270A	 27,112,0,64,240
*!*	*!*		*Samsung	 SRP 270	 27,112,48,55,121
*!*	*!*		**<1B><70><30><37><79> && en hexadecimal

*!*	*!*	*!*		???CHR(27)+CHR(112)+CHR(0)+CHR(25)+CHR(250)
*!*	*!*	*!*		???CHR(27)+CHR(112)+CHR(0)+CHR(64)+CHR(240)
*!*	*!*	*!*		???CHR(27)+CHR(112)+CHR(48)+CHR(55)+CHR(121)


*!*	*!*	*!*		*Código para Abrir la Caja de Dinero.
*!*	*!*	*!*		??? CHR(27)+'p'+CHR(0)+CHR(40)+CHR(250)        
*!*	*!*	*!*		??? CHR(7)


*!*	*!*		SET PRINTER TO 
*!*	*!*		RETURN
*!*	*!*		
*!*	*!*	ENDIF

*!*	*!*	**-----------------------------------------------------------------
*!*	*!*	**--Gaveta Conectada al Printer Fiscal
*!*	*!*	**-----------------------------------------------------------------
*!*	*!*	DO CASE

*!*	*!*	CASE xf05="Bematech Local"

*!*	*!*		**--Bematech Librerias
*!*	*!*		DECLARE INTEGER Bematech_FI_AccionaGaveta IN "BEMAFI32.DLL"
*!*	*!*		DECLARE INTEGER Bematech_FI_VerificaEstadoGaveta IN "BEMAFI32.DLL" (INTEGER @EstadoGaveta
*!*	*!*		iRetorno = Bematech_FI_AccionaGaveta()

*!*	*!*	CASE xf05=ALLTRIM("Aclas") .or. xf05="Samsung Bixolon" .or. xf05="Okidata"

*!*	*!*		PUBLIC lStatus, lError

*!*	*!*		**--The factory Librerias
*!*	*!*		DECLARE INTEGER  OpenFpctrl      IN TFHKAIF.DLL  String lpPortName
*!*	*!*		DECLARE INTEGER  CloseFpctrl     IN TFHKAIF.DLL  
*!*	*!*		DECLARE INTEGER  CheckFprinter   IN TFHKAIF.DLL  
*!*	*!*		DECLARE INTEGER  ReadFpStatus    IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError
*!*	*!*		DECLARE INTEGER  SendCmd         IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @cmd
*!*	*!*		DECLARE INTEGER  SendNCmd        IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @bufferCmd
*!*	*!*		DECLARE INTEGER  SendFileCmd     IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @fileCmd
*!*	*!*		DECLARE INTEGER  UploadReportCmd IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @cmd,string @fileCmd
*!*	*!*		DECLARE INTEGER  UploadStatusCmd IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @cmd,string @fileCmd
*!*	*!*		
*!*	*!*		LOCAL lStatus,lError
*!*	*!*		LOCAL lRespuesta,lRespuesta2

*!*	*!*		lRespuesta=.t.
*!*	*!*		lRespuesta2=0
*!*	*!*		lStatus=0
*!*	*!*		lError=0

*!*	*!*		**--'0' Imprime Leyenda "Apertura de Caja"
*!*	*!*		**--'W' Abre Gaveta Solamente
*!*	*!*		
*!*	*!*		lCadena="W"   
*!*	*!*		sendCmd(@lStatus,@lError,lCadena)

*!*	*!*		IF !Respuesta

*!*	*!*			WAIT WINDOWS "Status:"+ALLTRIM(STR(lStatus))+", "+"Error:"+ALLTRIM(STR(lError))
*!*	*!*			lRespuestas=closefpctrl()

*!*	*!*		ELSE

*!*	*!*			WAIT windows 'AVISO, ABRIENDO GAVETA DINERO ...' NOWAIT 
*!*	*!*			lRespuestas=closefpctrl()

*!*	*!*		ENDIF


*!*	*!*		
*!*	*!*		OTHERWISE
*!*	*!*	**		MESSAGEBOX('Estacion no configurada como Caja',0+64,'Aviso')


*!*	*!*	ENDCASE
*!*	*!*	RETURN





abregaveta2()




***------------------------------------------------
	
*!*	**--Bematech
*!*	DECLARE INTEGER Bematech_FI_AccionaGaveta IN "BEMAFI32.DLL"
*!*	DECLARE INTEGER Bematech_FI_VerificaEstadoGaveta IN "BEMAFI32.DLL" (INTEGER @EstadoGaveta
*!*	iRetorno = Bematech_FI_AccionaGaveta()


**--Puerto Serial
**--Libreria para manejo del puerto
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

*!*	*com1_open= OpenFpctrl('COM3')

*!*	com1_open= OpenFpctrl('COM1')

*!*	*MESSAGEBOX('&xca10')     
*!*	*Epson TM-88V 27,112,48,55,121
*!*	cString=CHR(27)+CHR(112)+CHR(48)+CHR(55)+CHR(121)
*!*	*cString='abretecoñodetumadre111111'

*!*	 
*!*	IF com1_open#1
*!*	    MESSAGEBOX('ERROR, AL ABRIR PUERTO GAVETA DE DINERO ...')
*!*	 	RETURN
*!*	ELSE
*!*	    *MESSAGEBOX('Aviso, abriendo gaveta de dinero ...')
*!*	    WAIT windows 'AVISO, ABRIENDO GAVETA DINERO ...' NOWAIT 
*!*	ENDIF

*!*	LOCAL lStatus,lError
*!*	LOCAL lRespuesta,lRespuesta2

*!*	lRespuesta=.t.
*!*	lRespuesta2=0
*!*	lStatus=0
*!*	lError=0

*!*	**--Enviar al puerto la cadena
*!*	SendFileCmd(@lstatus,@lerror,cString) 

*!*	**//Cerrar el puerto
*!*	com1_close=closefpctrl() 


***------------------------------------------------

**--Dirigir por puerto
*puerto=ALLTRIM(xca10)+':'
*SET PRINTER TO &puerto   &&com2:

*!*	SET PRINTER TO com1:
*!*	@ 0,0 SAY  '11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111' 
*!*	SET PRINTER TO 
*!*	WAIT windows 'AVISO, ABRIENDO GAVETA DINERO ...' NOWAIT 

***------------------------------------------------
*!*	SET CONSOLE ON 
*!*	SET DEVICE TO PRINTER 
*!*	SET PRINTER TO COM1
*!*	???CHR(27)+CHR(112)
*!*	SET PRINTER TO 
*!*	???'----------------------------------'&&
*!*	???CHR(10)
*!*	WAIT windows 'AVISO, ABRIENDO GAVETA DINERO ...' NOWAIT 
*!*	SET PRINTER TO
*!*	SET PRINTER OFF
*!*	SET CONSOLE OFF



*!*	SET console off


***------------------------------------------------
*!*	  llError = .F.
*!*	  ON ERROR llError = .T.
*!*	  SET PRINTER TO NAME (Gaveta)
*!*	  SET PRINTER ON
*!*	  ??? CHR(27) + 'p' + CHR(0) + CHR(100) + CHR(250)
*!*	  SET PRINTER OFF
*!*	  SET PRINTER TO DEFAULT
*!*	  SET PRINTER TO NAME (Gaveta)
*!*	  SET CONSOLE OFF
*!*	*!*	  SET PRINTER ON
*!*	*!*	  ? 'Caja abierta a las :', DATETIME()
*!*	*!*	  ? '.'
*!*	*!*	  ? '.'
*!*	*!*	  ? '.'
*!*	*!*	  ? '.'
*!*	*!*	  ? '.'
*!*	*!*	  ? '.'
*!*	*!*	  SET PRINTER OFF
*!*	*!*	  SET PRINTER TO DEFAULT
*!*	  SET CONSOLE ON
*!*	  ON ERROR

***------------------------------------------------


