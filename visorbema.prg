**---------------------------------------------------------------
FUNCTION VISORLIB() && Funciones del Visor Cliente
**---------------------------------------------------------------
*!*	Public Declare Function Bematech_CD_AbrePortaSerial Lib "BemaCD32.dll" (ByVal Porta As String) As Integer
*!*	Public Declare Function Bematech_CD_FechaPortaSerial Lib "BemaCD32.dll" () As Integer
*!*	Public Declare Function Bematech_CD_LimpaDisplay Lib "BemaCD32.dll" () As Integer
*!*	Public Declare Function Bematech_CD_ConfiguraModelo Lib "BemaCD32.dll" (ByVal Modelo As Integer) As Integer
*!*	Public Declare Function Bematech_CD_EnviaTexto Lib "BemaCD32.dll" (ByVal Texto As String, ByVal Linha As Integer, ByVal Coluna As Integer) As Integer
*!*	Public Declare Function Bematech_CD_EnviaComando Lib "BemaCD32.dll" (ByVal Comando As String, ByVal Tamanho As Integer) As Integer
*!*	Public Declare Function Bematech_CD_SetBaudRate Lib "BemaCD32.dll" (ByVal Taxa As Integer) As Integer
*!*	Public Declare Function Bematech_CD_SelecionaTipoCaracter Lib "BemaCD32.dll" (ByVal TipoCaracter As Integer) As Integer
*!*	Public Declare Function Bematech_CD_ApagaCursor Lib "BemaCD32.dll" () As Integer
*!*	Public Declare Function Bematech_CD_MostraCursor Lib "BemaCD32.dll" () As Integer
*!*	Public Declare Function Bematech_CD_ModoCursor Lib "BemaCD32.dll" (ByVal ModoCursor As Integer) As Integer
*!*	Public Declare Function Bematech_CD_MoveCursor Lib "BemaCD32.dll" (ByVal Direcao As String, ByVal Posicoes As Integer) As Integer
*!*	Public Declare Function Bematech_CD_MoveTexto Lib "BemaCD32.dll" (ByVal Direcao As String, ByVal Posicoes As Integer) As Integer
*!*	Public Declare Function Bematech_CD_PosicionaCursor Lib "BemaCD32.dll" (ByVal Linha As Integer, ByVal Coluna As Integer) As Integer
*!*	Public Declare Function Bematech_CD_PassaTexto Lib "BemaCD32.dll" (ByVal Texto As String, ByVal NumeroVezes As Integer, ByVal Velocidade As Integer) As Integer
*!*	Public Declare Function Bematech_CD_PiscaTexto Lib "BemaCD32.dll" (ByVal Texto As String, ByVal NumeroVezes As Integer, ByVal Velocidade As Integer) As Integer
*!*	Public Declare Function Bematech_CD_CentralizaTexto Lib "BemaCD32.dll" (ByVal Texto As String, ByVal LinhaCentralizar As Integer) As Integer
*!*	Public Declare Function Bematech_CD_LetraALetra Lib "BemaCD32.dll" (ByVal Texto As String, ByVal iPosicaoInicial As Integer, ByVal Velocidade As Integer) As Integer
*!*	Public Declare Function Bematech_CD_EnviaComandoDisplay Lib "BemaCD32.dll" (ByVal Comando As Integer) As Integer
*!*	Public Declare Function Bematech_CD_FixaPreco Lib "BemaCD32.dll" (ByVal Texto As String, ByVal Linhas As Integer) As Integer
*!*	Public Declare Function Bematech_CD_SomaPreco Lib "BemaCD32.dll" (ByVal Texto As String, ByVal Valor As String, ByVal FinalizaTotalizacao As Integer, ByVal cTextoFinal As String, ByVal ValorTotal As String) As Integer

**//Declaracion de Variables

DECLARE INTEGER Bematech_CD_AbrePortaSerial IN "BemaCD32.dll" string 
DECLARE INTEGER Bematech_CD_LimpaDisplay IN "BemaCD32.dll" 
DECLARE INTEGER Bematech_CD_FechaPortaSerial IN "BemaCD32.dll"
DECLARE INTEGER Bematech_CD_ConfiguraModelo IN "BemaCD32.dll" integer 
DECLARE INTEGER Bematech_CD_SetBaudRate IN "BemaCD32.dll" integer
DECLARE INTEGER Bematech_CD_EnviaTexto IN "BemaCD32.dll" string, integer, integer
DECLARE INTEGER Bematech_CD_FixaPreco IN "BemaCD32.dll" string, Integer
DECLARE INTEGER Bematech_CD_SomaPreco IN "BemaCD32.dll" string, string, integer, string, string
DECLARE INTEGER Bematech_CD_CentralizaTexto IN "BemaCD32.dll" string, integer, integer

RETURN


**---------------------------------------------------------------
FUNCTION VISOR_ABRIRPUERTO() &&--Abrir Puerto Visor
**---------------------------------------------------------------
Porta = "COM3"
*WAIT windows 'Abrir Puerto'
iRetorno = Bematech_CD_AbrePortaSerial('&Porta')
If iRetorno = 0 
	messagebox('Error de comunicación',0+64,'Atencion')
	RETURN
ELSE 
	*messagebox('OK la comunicación',0+64,'Atencion')
ENDIF
RETURN

**---------------------------------------------------------------
FUNCTION VISOR_MODELO() &&--Configurar MODELO
**---------------------------------------------------------------
**--Configurar Modelo de Visor (21 BDP-100)
Modelo=21
*WAIT windows 'Configurando Modelo de Visor'
iRetorno= Bematech_CD_ConfiguraModelo(21)
DO case
CASE iRetorno = -2 
	messagebox('Error de comunicación',0+64,'Atencion')
	RETURN
CASE iRetorno=1 
	*messagebox('OK la comunicación',0+64,'Atencion')
ENDCASE
RETURN	


**---------------------------------------------------------------
FUNCTION VISOR_BAUDIOS() &&--Configurar Baudios
**---------------------------------------------------------------
*WAIT windows 'Configurando Baudios'
iRetorno = Bematech_CD_SetBaudRate(9600)
DO case
CASE iRetorno = 0 
	messagebox('Error con puerto de comunicación',0+64,'Atencion')
	RETURN
CASE iRetorno=1 
	*messagebox('OK la comunicación',0+64,'Atencion')
CASE iRetorno=-2 
	messagebox('Parametro Invalido',0+64,'Atencion')
	Bematech_CD_FechaPortaSerial()
	return
ENDCASE
RETURN

**---------------------------------------------------------------
FUNCTION VISOR_LIMPIAR() &&--Limpiar Pantalla Visor
**---------------------------------------------------------------
**--Limpiar Display
*WAIT windows 'Limpiar Display'
iRetorno = Bematech_CD_LimpaDisplay()
DO CASE 
	CASE iRetorno= 0
		messagebox('Error de comunicación',0+64,'Atencion')
		return
	CASE iRetorno=-1
		*messagebox('OK la comunicación',0+64,'Atencion')
	CASE iRetorno=-1
		messagebox('Error Puerto Serial Cerrado',0+64,'Atencion')
		return
ENDCASE
RETURN


**---------------------------------------------------------------
FUNCTION VISOR_BIENVENIDOS() &&--Saludo de Bienvenidos	
**---------------------------------------------------------------
*WAIT windows 'Enviando Texto'
texto='***  Bienvenidos ***'
iRetorno=Bematech_CD_EnviaTexto('&Texto',1,1)	
DO CASE 
	CASE iRetorno= 0
		messagebox('Error de comunicación',0+64,'Atencion')
		return
	CASE iRetorno=-1
		*messagebox('OK la comunicación',0+64,'Atencion')
	CASE iRetorno=-1
		messagebox('Error Puerto Serial Cerrado',0+64,'Atencion')
		return
CASE iRetorno=-2 
	messagebox('Parametro Invalido',0+64,'Atencion')
	Bematech_CD_FechaPortaSerial()
	return
ENDCASE	
RETURN

**---------------------------------------------------------------
FUNCTION VISOR_CAJAABIERTA() &&--Mensaje de Caja Abierta
**---------------------------------------------------------------
*WAIT windows 'Enviando Texto'
texto='  * Caja Abierta *  '
iRetorno=Bematech_CD_EnviaTexto('&Texto',2,1)	
DO CASE 
CASE iRetorno= 0
	messagebox('Error de comunicación',0+64,'Atencion')
	return
CASE iRetorno=-1
	*messagebox('OK la comunicación',0+64,'Atencion')
CASE iRetorno=-1
	messagebox('Error Puerto Serial Cerrado',0+64,'Atencion')
	return
CASE iRetorno=-2 
	messagebox('Parametro Invalido',0+64,'Atencion')
	Bematech_CD_FechaPortaSerial()
	return
ENDCASE	
RETURN


**---------------------------------------------------------------
FUNCTION VISOR_CAJACERRADA() &&--Mensaje de Caja Abierta
**---------------------------------------------------------------
*WAIT windows 'Enviando Texto'
texto='  * Caja Cerrada * '
iRetorno=Bematech_CD_EnviaTexto('&Texto',2,1)	
DO CASE 
CASE iRetorno= 0
	messagebox('Error de comunicación',0+64,'Atencion')
	return
CASE iRetorno=-1
	*messagebox('OK la comunicación',0+64,'Atencion')
CASE iRetorno=-1
	messagebox('Error Puerto Serial Cerrado',0+64,'Atencion')
	return
CASE iRetorno=-2 
	messagebox('Parametro Invalido',0+64,'Atencion')
	Bematech_CD_FechaPortaSerial()
	return
ENDCASE	
RETURN
	
	
**---------------------------------------------------------------
FUNCTION VISOR_ENVIATEXTO() &&--Envia Texto
**---------------------------------------------------------------
PARAMETERS articulo, valor, total
*WAIT windows 'Enviando Texto'
texto1=SUBSTR(ALLTRIM(articulo),1,11)+RIGHT(SPACE(9)+valor,9)
iRetorno=Bematech_CD_EnviaTexto('&Texto1',1,1)	
DO CASE 
	CASE iRetorno= 0
		messagebox('Error de comunicación',0+64,'Atencion')
		return
	CASE iRetorno=-1
		*messagebox('OK la comunicación',0+64,'Atencion')
	CASE iRetorno=-1
		messagebox('Error Puerto Serial Cerrado',0+64,'Atencion')
		return
	CASE iRetorno=-2 
		messagebox('Parametro Invalido',0+64,'Atencion')
		Bematech_CD_FechaPortaSerial()
		return
ENDCASE	

texto2=RIGHT(SPACE(20)+'Sub-Total:'+total,20)
iRetorno=Bematech_CD_EnviaTexto('&Texto2',2,1)	
DO CASE 
	CASE iRetorno= 0
		messagebox('Error de comunicación',0+64,'Atencion')
		return
	CASE iRetorno=-1
		*messagebox('OK la comunicación',0+64,'Atencion')
	CASE iRetorno=-1
		messagebox('Error Puerto Serial Cerrado',0+64,'Atencion')
		return
	CASE iRetorno=-2 
		messagebox('Parametro Invalido',0+64,'Atencion')
		Bematech_CD_FechaPortaSerial()
		return
ENDCASE	
RETURN	


**---------------------------------------------------------------
FUNCTION VISOR_TOTALaPAGAR() &&--Envia Texto
**---------------------------------------------------------------
PARAMETERS Total
texto1='Gracias por Comprar*'
iRetorno=Bematech_CD_EnviaTexto('&Texto1',1,1)	
DO CASE 
	CASE iRetorno= 0
		messagebox('Error de comunicación',0+64,'Atencion')
		return
	CASE iRetorno=-1
		*messagebox('OK la comunicación',0+64,'Atencion')
	CASE iRetorno=-1
		messagebox('Error Puerto Serial Cerrado',0+64,'Atencion')
		return
	CASE iRetorno=-2 
		messagebox('Parametro Invalido',0+64,'Atencion')
		Bematech_CD_FechaPortaSerial()
		return
ENDCASE	

*texto2=RIGHT(SPACE(20)+total,20)
texto2='Total Pago:'+RIGHT(SPACE(9)+total,9)
iRetorno=Bematech_CD_EnviaTexto('&Texto2',2,1)	
DO CASE 
	CASE iRetorno= 0
		messagebox('Error de comunicación',0+64,'Atencion')
		return
	CASE iRetorno=-1
		*messagebox('OK la comunicación',0+64,'Atencion')
	CASE iRetorno=-1
		messagebox('Error Puerto Serial Cerrado',0+64,'Atencion')
		return
	CASE iRetorno=-2 
		messagebox('Parametro Invalido',0+64,'Atencion')
		Bematech_CD_FechaPortaSerial()
		return
ENDCASE	
RETURN

	
**---------------------------------------------------------------
FUNCTION VISOR_CERRARPUERTO() &&--Cerrar Puerto
**---------------------------------------------------------------
*WAIT windows 'Cerrar Puerto'
iRetorno=Bematech_CD_FechaPortaSerial()
DO CASE 
	CASE iRetorno= 0
		messagebox('Error Puerto Cerrado',0+64,'Atencion')
		return
	CASE iRetorno=-1
		*messagebox('OK la comunicación',0+64,'Atencion')
ENDCASE
RETURN
