*!*	**************************************
*!*	*-- Class: sonidos (c:fuentescesaclasescesa.vcx)
*!*	*-- ParentClass: custom
*!*	*-- BaseClass: custom
*!*	*-- Forma de uso:
*!*	*-- MyMedia = CreateObject("Sonidos")
*!*	*-- MyMedia.Abresonido("C:MultimediaMusicaShopin.wav")
*!*	*-- MyMedia.Play()
*!*	*-- Para detener el sonido en cualquier momento utiliza MyMedia.ClosePlay()
*!*	*-- Para hacer una pausa utiliza Mymedia.Pause()
*!*	*-- Divierte.-- recuerda que todo es posible en Foxpro
*!*	**************************************
*!*	DEFINE CLASS sonidos AS CUSTOM

*!*	  mcierror = 0
*!*	  mcierrorstring = "Objeto no localizado"
*!*	  NAME = "sonidos"
*!*	  openplay = .F.

*!*	  *----------
*!*	  * PROCEDURE AbreSonido
*!*	  *----------
*!*	  PROCEDURE AbreSonido
*!*	    PARAMETERS cFileName
*!*	    cFileName=ALLTRIM(cFileName)
*!*	    *!* Revisamos el estado del archivo de sonidos
*!*	    cCmd = ("STATUS FoxMedia READY")
*!*	    IF THIS.doMCI(cCmd) = "true" THEN
*!*	      *!* If one is, close it
*!*	      cCMD = ("CLOSE FoxMedia WAIT")
*!*	      THIS.doMCI(cCmd)
*!*	      *!* And use the custom Disable method of the form to disable
*!*	      *!* all appropriate controls
*!*	      THISFORM.ctrlMedia1.DISABLE(.T.)
*!*	    ENDIF

*!*	    *!* Prompt the user for the media file to open
*!*	    IF !EMPTY(cFileName)
*!*	      IF !FILE(cFileName)
*!*	        cFileName = GETFILE("avi|mov|wav|mid|cda","Archivo a ejecutar")
*!*	      ENDIF
*!*	    ELSE
*!*	      cFileName = GETFILE("avi|mov|wav|mid|cda","Archivo a ejecutar")
*!*	    ENDIF
*!*	    IF !EMPTY(cFileName) THEN

*!*	      _SCREEN.MOUSEPOINTER = 11

*!*	      *!* Need to use window handle functions in FoxTools
*!*	      *	SET LIBRARY TO HOME() + ".FOXTOOLS.FLL"
*!*	      SET LIBRARY TO FOXTOOLS.FLL
*!*	      EXTERNAL PROCEDURE MainHWND
*!*	      EXTERNAL PROCEDURE _WhToHwnd
*!*	      EXTERNAL PROCEDURE _WOnTop

*!*	      * Returns Handle of Main VFP Window
*!*	      Main_hWnd = MainHWND()

*!*	      * Get Handle of the form with FOXTOOLS.FLL
*!*	      cur_window = _WhToHwnd(_WOnTop())

*!*	      NullPointer = 0

*!*	      *!* Set up open MCI command into string variable
*!*	      cCmd = ('OPEN "' + cFileName + '" alias FoxMedia' + ;
*!*	        ' style child parent ' + ALLTRIM(STR(cur_window)) + ' WAIT')

*!*	      *!* Execute the MCI command
*!*	      THIS.doMCI(cCmd)

*!*	      *!* Check to see if MCI command succeeded
*!*	      IF THIS.MCIerror > 0 THEN
*!*	        *!* If not, it might be a non-visual media
*!*	        *!* We'll try to open it without setting the window parent
*!*	        cCmd = ('OPEN "' + cFileName + '" alias FoxMedia WAIT')
*!*	        THIS.doMCI(cCmd)
*!*	        IF THIS.MCIerror > 0 THEN
*!*	          *!* Nope, still won't open.  Some other error.
*!*	          *!* Let's show the user the MCI error and get out
*!*	          MESSAGEBOX(THIS.MCIerrorString)
*!*	          _SCREEN.MOUSEPOINTER = 0
*!*	          RETURN
*!*	        ELSE
*!*	          *!* It's not a visual media, so let's show a label
*!*	          *!* to let the user know the media has been loaded
*!*	          *			THIS.lblNonVisual.visible = .T.
*!*	        ENDIF
*!*	      ELSE
*!*	        *!* It does have visual media, so we need to set up the window
*!*	        *!* it will play in.

*!*	        *!* Get the window handle of the window playing the video
*!*	        cCmd = "status FoxMedia window handle wait"
*!*	        hWin = INT(VAL(THIS.doMCI(cCmd)))

*!*	        *!* Once we have the window handle, we need to position
*!*	        *!* the video window to be the same position and size
*!*	        *!* as our player rectangle on the form
*!*	        x1Pos = THISFORM.player.LEFT
*!*	        y1Pos = THISFORM.player.TOP
*!*	        x2Pos = THISFORM.player.WIDTH
*!*	        y2pos = THISFORM.player.HEIGHT

*!*	        *!* Use the SetWindowPos Windows function to set position and size
*!*	        setWindowPos(hWin,0,x1Pos,y1Pos,x2Pos,y2Pos,0)

*!*	        *!* Everything's done, let's show the video
*!*	        cCmd = ("WINDOW FoxMedia state show")
*!*	        THIS.doMCI(cCmd)

*!*	      ENDIF

*!*	      *!* Set the device to use milliseconds when setting/getting position
*!*	      THIS.doMCI("SET FoxMedia time format milliseconds")

*!*	      *!* Enable all appropriate controls
*!*	      THISFORM.CtrlMedia1.DISABLE(.F.)

*!*	      *THISFORM.lblLoading.visible = .F.
*!*	      _SCREEN.MOUSEPOINTER = 0
*!*	    ENDIF
*!*	  ENDPROC

*!*	  *----------
*!*	  * PROCEDURE PLAY
*!*	  *----------
*!*	  PROCEDURE PLAY

*!*	    *!* First need to see if the media is at the end
*!*	    *!* by comparing the total length with the current position
*!*	    nMediaLength = VAL(THIS.doMCI("STATUS FoxMedia length"))
*!*	    nMediaPosition = VAL(THIS.doMCI("STATUS FoxMedia position"))

*!*	    IF nMediaPosition >= nMediaLength THEN
*!*	      *!* The media is at the end, so we need to seek back to the start
*!*	      *!* of the clip before playing
*!*	      THIS.doMCI("SEEK FoxMedia to start WAIT")
*!*	    ENDIF

*!*	    *!* Now we can play the media
*!*	    THIS.doMCI("PLAY FoxMedia")
*!*	    IF THIS.MCIerror > 0 THEN
*!*	      THIS.showMCIerror
*!*	    ELSE
*!*	      THISFORM.CtrlMedia1.timer1.INTERVAL = 360
*!*	    ENDIF
*!*	  ENDPROC

*!*	  *----------
*!*	  * PROCEDURE closeplay
*!*	  *----------
*!*	  PROCEDURE closeplay
*!*	    cCmd = "CLOSE FoxMedia"
*!*	    THIS.doMCI(cCmd)
*!*	    IF THIS.MCIerror > 0 THEN
*!*	      THIS.showMCIerror
*!*	    ENDIF

*!*	    THISFORM.CtrlMedia1.timer1.INTERVAL = 0
*!*	    THISFORM.CtrlMedia1.DISABLE(.T.)
*!*	  ENDPROC

*!*	  *----------
*!*	  * PROCEDURE showmcierror
*!*	  *----------
*!*	  PROCEDURE showmcierror
*!*	    *!* This method shows the last MCI error string that occured.
*!*	    MESSAGEBOX(THIS.MCIerrorString + " (" + STR(THIS.MciError) + ")")
*!*	  ENDPROC

*!*	  *----------
*!*	  * PROCEDURE getmcierror
*!*	  *----------
*!*	  PROCEDURE getmcierror
*!*	    LPARAMETERS cError
*!*	    LOCAL lcErrorString,nError

*!*	    *!* This method is called from the doMCI to retrieve the last
*!*	    *!* MCI error string.
*!*	    *!* This function also saves the last error number and string
*!*	    *!* into properties associated with the form.

*!*	    nError=0
*!*	    IF TYPE("cError")="C"
*!*	      IF LEFT(cError,7)="*ERROR*"
*!*	        nError=VAL(SUBSTR(cError,8))
*!*	      ENDIF
*!*	    ENDIF

*!*	    IF TYPE("cError")="N"
*!*	      nError=cError
*!*	    ENDIF

*!*	    cErrorString=SPACE(256)
*!*	    =mciGetErrorString(nError,@cErrorString,LEN(cErrorString))

*!*	    THIS.MciError = nError
*!*	    THIS.MCIerrorString = cErrorString

*!*	    RETURN TRIM(CHRTRAN(cErrorString,CHR(0),""))
*!*	  ENDPROC

*!*	  *----------
*!*	  * PROCEDURE domci
*!*	  *----------
*!*	  PROCEDURE domci
*!*	    LPARAMETERS cMCIcmd

*!*	    *!* This method takes a MCI command string and executes it using
*!*	    *!* the Windows API function mciSendString

*!*	    *!* If the function executes successfully, the result is returned.
*!*	    *!* Otherwise, the error string is returned.
*!*	    cRetString = SPACE(80)
*!*	    nRetValue = mciSendString(cMCIcmd,@cRetString,LEN(cRetString),0)

*!*	    cErr = THIS.getMCIerror(nRetValue)
*!*	    IF nRetValue > 0
*!*	      RETURN CeRR
*!*	    ENDIF

*!*	    RETURN TRIM(STRTRAN(cRetString,CHR(0),""))
*!*	  ENDPROC

*!*	  *----------
*!*	  * PROCEDURE pausa
*!*	  *----------
*!*	  PROCEDURE pausa

*!*	    *!* Check to see if there is media acutally playing
*!*	    IF THIS.doMCI("STATUS FoxMedia mode") = "playing" THEN

*!*	      *!* Yes there is, so execute the PAUSE MCI command
*!*	      THIS.doMCI("PAUSE FoxMedia")
*!*	      IF THIS.MCIerror > 0 THEN
*!*	        THIS.showMCIerror
*!*	      ELSE
*!*	        THISFORM.CtrlMedia1.timer1.INTERVAL = 0
*!*	      ENDIF
*!*	    ELSE
*!*	      THIS.PLAY()
*!*	    ENDIF
*!*	  ENDPROC

*!*	  *----------
*!*	  * PROCEDURE INIT
*!*	  *----------
*!*	  PROCEDURE INIT
*!*	    *!* This is the primary Windows API function that is used to
*!*	    *!* send MCI commands
*!*	    DECLARE INTEGER mciSendString ;
*!*	      IN WinMM.DLL ;
*!*	      STRING cMCIString,;
*!*	      STRING @cRetString,;
*!*	      INTEGER nRetLength,;
*!*	      INTEGER hInstance

*!*	    *!* This function allows us to retrieve the last MCI error that occured
*!*	    DECLARE INTEGER mciGetErrorString ;
*!*	      IN WINMM.DLL ;
*!*	      INTEGER nErrorno, ;
*!*	      STRING @cBuffer, ;
*!*	      INTEGER nBufSize

*!*	    *!* When MCI plays a video, it creates its own Window.  By using
*!*	    *!* this Windows API function we can position this Window to be
*!*	    *!* in the same position as our Player rectangle on the form
*!*	    DECLARE INTEGER SetWindowPos ;
*!*	      IN User32 ;
*!*	      INTEGER, INTEGER, INTEGER, INTEGER, INTEGER, INTEGER, INTEGER
*!*	  ENDPROC


*!*	ENDDEFINE
*!*	*
*!*	*-- EndDefine: sonidos
*!*	**************************************