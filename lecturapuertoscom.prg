*!*	*** rutina para abrir puerto serial de comunicaciones
*!*	public oCom
*!*	public SendCmd
*!*	public firstTime

*!*	* creAR OBJETO
*!*	SendCmd = .F. && para determinar si requiere enviar comando para

*!*	* obtener data
*!*	FirstTime = .T.
*!*	oCom = Createobject ("MSCOMMLIB.MSCOMM")
*!*	oCom.CommPort = 1
*!*	oCom.Settings = "9600,N,8,1"
*!*	oCom.inputlen = 0
*!*	oCom.inputmode = 0
*!*	oCom.Rthreshold = 1
*!*	oCom.Inbuffercount = 0
*!*	oCom.PortOpen = .T.


*!*	* VALIDAR SI HAY DATOS EN EL PUERTO, ESTO LO TENGO EN UN OBJ TIMER
*!*	* if thisform.txtpesobasc.value =0
*!*	ocom.portopen =.T.
*!*	thisform.btn.fillcolor = rgb (255,0,0)

*!*	*ESTE EVENTO ME DEVUELVE 2 SI HAY DATOS EN EL BUFFER

*!*	evento = ocom.Commevent
*!*	if evento = 2
*!*	*
*!*	oCom.inputlen = 1 && LE DIGO QUE LA LECTURA ES DE 1 EN 1 BYTES

*!*	RESULTADO = ""
*!*	ltmp = \'\'
*!*	X = 1
*!*	xcount = 10
*!*	lnume = \'\'

*!*	*
*!*	* messagebox(str(OCOM.INBUFFERSIZE))
*!*	DO WHILE X <= OCOM.INBUFFERSIZE
*!*	x1 = ocom.input && TOMA EL DATO DEL PUERTO
*!*	if x1 = chr(13) or x1 = chr(10)
*!*	ltmp = ltmp + " "
*!*	exit do
*!*	else
*!*	ltmp = ltmp + x1
*!*	endif
*!*	if val(x1)> 0 or x1 = "0" or x1 = "." or x1= \'-\'
*!*	lnume = lnume + x1
*!*	endif
*!*	X= X+1
*!*	ENDDO
*!*	resultado = ltmp
*!*	*resultado1 = val(resultado)
*!*	MESSAGEBOX ( resultado,"peso")

*!*	Ocom.inbuffercount =0

*!*	if val(lnume) <> 0
*!*	* wait window( \'leyendo peso\') nowait
*!*	thisform.txtpesobasc.value = val(lnume)
*!*	* thisform.txtkgs.value = thisform.txtpesobasc.value
*!*	* thisform.txtneto.value = thisform.txtkgs.value -
*!*	thisform.txttara.value
*!*	* thisform.refresh
*!*	thisform.btn.fillcolor = rgb (0,255,0)
*!*	endif
*!*	ocom.portopen =.F.
*!*	thisform.refresh


*!*	endif
*!*	***********