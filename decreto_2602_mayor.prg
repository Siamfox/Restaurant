PARAMETERS wnatural
**swcondicion1,swcondicion2,swcondicion3
**--Validar segun decreto 2602 del 14/12/16 inicio 26/12/2016  y  finaliza en 26/03/2017

IF DATE()<=CTOD('26/03/2017')

STORE .f. TO swcondicion1,swcondicion2,swcondicion3
temp_caj='tmp_caj'+alltrim(xu003)+alltrim(xsta)


**--Validar Condicion Persona Natural
*wnatural=SUBSTR(thisform.cJuridico.value,1,1)

IF wnatural='V' .or. wnatural='N' .or. wnatural='P' .or. wnatural='E' 
	swcondicion1=.t.
ENDIF

**--Validar Condicion del Monto y sus formas de pago
SET OPTIMIZE ON 
SELECT nro,fecha,tpago,monto,banco,detalle,serie FROM FORCE cajapagos2 WHERE wfactura=Nro INTO CURSOR &temp_caj
SET OPTIMIZE OFF 

**-- VERIFICAR cantidad de PAGOS registrados y tipo de pago
IF RECCOUNT()<=0
	messagebox('Error en Registro, No Existe forma de Pago de Factura Nro. '+alltrim(STR(wfactura)),0+64,'Atencion')
	return
ENDIF

SUM monto FOR nro=wfactura .and. fecha=DATE() TO xmonto
	
IF xmonto<=200000

	swcondicion2=.t.
	
	SCAN FOR wfactura=Nro
				
		**--Clasificar Forma de Pago
		IF 	tpago='EFE' .or. tpago='CHE' .OR. tpago='OTR' &&.or. tpago='TIA'
	         swcondicion3=.f.
			 exit					
		ELSE	
			swcondicion3=.t.		
		ENDIF

	ENDSCAN

ENDIF 

**--Validar las 3 condiciones y Procesar en caso positivo todas
IF swcondicion1=.t. .and. swcondicion2=.t. .and. swcondicion3=.t.


*!*		MESSAGEBOX('Factura sera afectada en el Monto en un (2%) de Descuento del iva,'+;
*!*					CHR(13)+'Decreto en Gaceta Nro. 41.052 del 14/12/2016 y providencia 122 del cumplimiento de deberes formales,'+;
*!*					CHR(13)+'por un lapso de 90 dias a partir del 26/12/2016'+;
*!*					CHR(13)+'Pulse Enter, para continuar...',0+64,'Atencion')


	**--Procesar el cambio de impuesto del 12% al 10% con la tasa2 de la impresora fiscal

	**--Registros Facturas
	SET OPTIMIZE ON 

	**--Actualizo el precio sin iva del 12%
	UPDATE facreg  SET precio=(precio/(1+alicuota*.01)) WHERE wfactura=Nro .and. talicuota=1 

	**--Actualizo el precio nuevo con el iva nuevo 10%
	UPDATE facreg  SET alicuota=10, talicuota=4, precio=(precio*(1+alicuota*.01)) WHERE wfactura=Nro .and. talicuota=1 

		
	SET OPTIMIZE OFF 

	
ELSE 
	*MESSAGEBOX('no se encontro cambio de tasa')
ENDIF
ENDIF

