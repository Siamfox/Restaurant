******************************************************************
**//Calcular Totales Segun Caso con Impuesto o sin Impuesto
******************************************************************
*FUNCTION TOTALES3() &&Calcular Totales en Modificacion Documentos
******************************************************************
nImpuesto=0
nTotal=0

SELECT 9
SET ORDER TO 1
SEEK nNro
IF !EOF()
DO WHILE NRO=nNRO
	store	CANTIDAD	to WCANTIDAD 
	store	PRECIO		to WPRECIO   
	store	DSCTO		to WDSCTO    
	store	ALICUOTA	to WALICUOTA
	
	**//Caso Con Precio_con_Impuesto
	IF xv01=.T. 
	
			nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
			nsub_impuesto=nsub_total-nsub_total/(1+WALICUOTA*.01)

			nImpuesto=nImpuesto+nsub_impuesto
			ntotal=ntotal+nsub_total

	ELSE && Caso Precio_+_Impuesto
	
			nsub_total=wcantidad*(wprecio-(wprecio*wdscto/100))
			nsub_impuesto=nsub_total*walicuota/100

			nImpuesto=nImpuesto+nsub_impuesto
			ntotal=ntotal+nsub_total+nsub_total*walicuota/100
			
	ENDIF

	SKIP 1

ENDDO
ENDIF
RETURN
