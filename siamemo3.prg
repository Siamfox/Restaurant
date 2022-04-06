********************************************************************************
**FUNCTION SIAMEMO3 && MEMO PARA INSTALACION
********************************************************************************
PARAMETER xLogin,xClave

PUBLIC xu001	as character(25)	&& Nombres
PUBLIC xu002	as character(25)	&& Apellidos
PUBLIC xu003	as character(25)	&& Login
PUBLIC xu008	as character(25)	&& Nivel
PUBLIC xu099	as LOGICAL			&& Activo


PUBLIC xu900	as LOGICAL	&& Modulo Utilidades------------------------------------------
PUBLIC xu901	as LOGICAL	&& Incluir 
PUBLIC xu902	as LOGICAL	&& Modificar 
PUBLIC xu903	as LOGICAL	&& Eliminar
PUBLIC xu904	as LOGICAL	&& Consultar
PUBLIC xu905	as LOGICAL	&& Imprimir


xu001='Instalador'		&& Nombres
xu002='.'				&& Apellidos
xu003='Install'
xu008='01-Instalador'	&& Nivel
xu099=.t.				&& Activo
xu900=.t.				&& Menu Utilitarios
xu901=.t.				&& Incluir
xu902=.t.				&& Modificar
xu903=.t.				&& Eliminar
xu904=.t.				&& Consultar
xu905=.t.

RETURN

