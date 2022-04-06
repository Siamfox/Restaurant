parameters csocio
wsocio=csocio
*messagebox(wsocio)

**//tabla registros
**//variables de trabajo
*saldebe=0
*salhaber=0
xsaldo=0


**--Buscar el socio por el rif

*Setear Indice ppal
SELECT 3 && 
SET ORDER TO 1 

SEEK ALLTRIM(wsocio)

IF EOF()
	messagebox('Codigo Socio Incorrecto '+ALLTRIM(wretorno),0+64,'Atencion')
	RETURN .F.
		
ELSE
	
		IF activo=.t.
			STORE ALLTRIM(rif)				TO	wcliente
		ELSE
			
			messagebox('Codigo Inactivo, consultar con Supervisor '+ALLTRIM(wretorno),0+64,'Atencion')
			RETURN .F.
		
		ENDIF 	
ENDIF 

**temp1='temp_cob'+alltrim(xsta)+alltrim(xu003)


**--Temporal
temp1='temp_cob'+ALLTRIM(xsta)+ALLTRIM(xu003)

SELECT 5 && Maestro de Cobros
USE FAC_COB SHARED
SET INDEX TO COB_NRO, COB_RIF

Select fac_cob.nro, fac_cob.docume, fac_cob.fecha_emi, fac_cob.fecha_ven, fac_cob.cod_vend, fac_cob.concepto, fac_cob.monto,;
SUM(trncob.debe-trncob.haber) as Saldos  ;
from fac_cob ;
LEFT OUTER JOIN trncob on fac_cob.nro = trncob.nro;
where fac_cob.rif=wcliente .and. fac_cob.cancela<>.t. .and. fac_cob.fecha_ven<=date() ;
group by fac_cob.nro, fac_cob.docume, fac_cob.fecha_emi, fac_cob.fecha_ven, fac_cob.cod_vend, fac_cob.concepto, fac_cob.monto ;
order by fac_cob.nro into cursor &temp1

*BROWSE

*SET STEP ON 
**--Calculo del Saldo 
scan 
    if isnull(saldos)=.t.
	  	saldo=saldo+monto
	else
		saldo=saldo+(monto+saldos)
	endif 
endscan

*messagebox(saldo)

**--
**--validar solo los vencidos 
**--
if saldo>0

	**--desactivar para su no atencion
	select 3
*!*		use cliente shared 
*!*		set index to cli_rif,cli_nom
*!*		
*!*		seek upper(alltrim(wsocio))
*!*		
*!*		if !eof()
			
			if empty(autorizar)
				replace activo with .f.
				replace autorizar with date()
			else

				*messagebox('cliente con palanca') 
				
			endif 
	
*!*			endif

endif 

return saldo
**thisform.nsaldo.value=saldo

RETURN

**--anterior 
**--Modo saldo historial (debe-haber) tipo contabilidad
*!*	select 5
*!*	use fac_cob shared
*!*	set index to cob_rif

*!*	**select * from fac_cob where rif=upper(alltrim(wsocio)) .and. cancela<>.t. .and. fecha_ven<=date() into cursor &temp1

*!*	scan for rif=upper(alltrim(wsocio)) .and. cancela<>.t. .and. fecha_ven<=date()
*!*		**--vencidas
*!*			saldebe=saldebe+debe
*!*			salhaber=salhaber+haber
*!*			saldo=saldebe-salhaber
*!*			
*!*	endscan


