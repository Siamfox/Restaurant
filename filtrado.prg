LPARAMETERS tcSql, tcAlias
LOCAL lnSelect, lcSql
*** Guardar el área de trabajo
lnSelect = SELECT(0)
*** No existe el cursor
IF NOT USED( tcAlias )
  *** Crearlo directamente
  lcSql = tcSql + " INTO CURSOR " + tcAlias + " READWRITE"
  &lcSql
ELSE
  *** El cursor existe, utilizo un select seguro
  lcSql = tcSql + " INTO CURSOR curdummy"
  &lcSql
  *** Limpiar y actualizar el cursor de trabajo
  SELECT (tcAlias)
  ZAP IN (tcAlias)
  APPEND FROM DBF('curdummy')
  USE IN curdummy 
ENDIF
*** Restablecer el área de trabajo y devolver el estado
SELECT (lnSelect)
RETURN USED(tcAlias)