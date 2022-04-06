PARAMETERS xNroPedido,xnatural,xmonto
**--swcondicion1,swcondicion2,swcondicion3
**--Validar segun decreto 2602 del 14/12/16 inicio 26/12/2016  y  finaliza en 26/03/2017

cancela=.f.
montonuevo=0
temp1='tmp_mon'+ALLTRIM(xsta)
temp2='tmp_imp'+ALLTRIM(xsta)


*!*	MESSAGEBOX(xnropedido)
*!*	MESSAGEBOX(xnatural)
*!*	MESSAGEBOX(xmonto)


*IF DATE()<=CTOD('26/03/2017')

	STORE .f. TO swcondicion1,swcondicion2,swcondicion3

	**--Validar Condicion Persona Natural
	IF xnatural='V' .or. xnatural='N' .or. xnatural='P' .or. xnatural='E' 
		swcondicion1=.t.
	ENDIF

	IF xmonto<=200000

		**--Procesar el cambio de impuesto del 12% al 10% con la tasa2 de la impresora fiscal

		SET OPTIMIZE ON 
		SELECT * FROM force impuestos WHERE codigo=4 INTO CURSOR  &temp2
		SET OPTIMIZE OFF 

		STORE alicuota TO xalicuotanew
		
		**BROWSE
		
		*MESSAGEBOX(xalicuotanew)

		SET OPTIMIZE ON 
		SELECT nro,precio,cantidad,alicuota,talicuota FROM force pedreg WHERE nro=xNroPedido INTO CURSOR  &temp1
		SET OPTIMIZE OFF 

		*browse
	
		SCAN for nro=xNroPedido 
		
			IF talicuota=1
				
				**xalicuota4=10
				precio1=precio/(1+alicuota*.01)
				montonuevo=montonuevo+precio1*cantidad*(1+xalicuotanew*.01)

			ELSE 

				montonuevo=montonuevo+precio*cantidad
			
			ENDIF 
		
		ENDSCAN 

		montonuevo=ROUND(montonuevo,2)
		
		**-- parcho
		USE 		

	ENDIF 
	
*ENDIF
RETURN 












