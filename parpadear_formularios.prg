#Define FlashW_Stop 0 &&Para el Parpadeo de una ventana.
#Define FlashW_Caption 0x1 &&Hace Parpadear El Titulo de Una Ventana
#Define FlashW_Tray 0x2 &&Hace Parpadear la Ventana en la TaskBar
#Define FlashW_All 3&&Parpadea El Titulo de la ventana y en la Taskbar
#Define FlashW_Timer 0x4 &&Parpadea Infinitamente, o hasta Enviar Un FlashW_Stop
#Define FlashW_TimerNoFg 0xC &&Parpadea hasta que Se Active la Ventana
*** Declaracion de Las Apis
Declare Long FlashWindowEx In "user32" String @CFlashWInfo
Declare Long FindWindow In User32 String cClass, String cCaption
*** Inicia El Codigo
Local cFlashInfo
cFlashInfo =Space(20)
*** Creamos La Estructura
cFlashInfo = Num2dWord(20)+; &&Longitud de la Estructura 
Num2dWord(FindWindow(.Null.,'Calculadora'))+; &&Handle de la Ventana a "Flashear"
Num2dWord(FlashW_All+FlashW_TimerNoFg)+; &&Opciones
Num2dWord(5)+; && Cantidad de Veces que Parpadeara (0 =Infinito)
Num2dWord(0) && Tiempo entre Parpadeo (en Milisegundos, 0=Default)
*** Hacemos Parpadear la Ventana. 
FlashWindowEx(@cFlashInfo)

Procedure Num2dWord
Lparameter tnNum
Local c0,c1,c2,c3
lcresult = Chr(0)+Chr(0)+Chr(0)+Chr(0)
If tnNum < (2^31 - 1) then
c3 = Chr(Int(tnNum/(256^3)))
tnNum = Mod(tnNum,256^3)
c2 = Chr(Int(tnNum/(256^2)))
tnNum = Mod(tnNum,256^2)
c1 = Chr(Int(tnNum/256))
c0 = Chr(Mod(tnNum,256))
lcresult = c0+c1+c2+c3
Endif
Return lcresult
Endproc