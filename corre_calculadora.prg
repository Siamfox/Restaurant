* Antes de activar la calculadora:
IF NOT F_ActivaWin("Calculadora")
* La calculadora no está cargada:
RUN /N CALC.EXE
ENDIF