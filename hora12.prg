PROCEDURE Hora12(tcHora)
#DEFINE FORMATO_AM " a.m."
#DEFINE FORMATO_PM " p.m."
LOCAL ln
IF EMPTY(tcHora)
tcHora = TIME()
ENDIF
IF BETWEEN(tcHora,"01","12")
tcHora = tcHora + FORMATO_AM
ELSE
ln = ABS(VAL(tcHora)-12)
tcHora = TRANSFORM(IIF(ln=0,12,ln),"@L 99") + ;
SUBSTR(tcHora,3,6) + ;
IIF(tcHora < "01",FORMATO_AM,FORMATO_PM)
ENDIF
RETURN tcHora
ENDPROC