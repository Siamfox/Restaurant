********************************************************************************
*FUNCTION SIAMEMO2 && GENERAR VARIABLES EN MEMORIA PERMISOLOGIA DE USUARIOS
********************************************************************************
PARAMETER xLogin,xClave

PUBLIC xu001	as character(25)	&& Nombres
PUBLIC xu002	as character(25)	&& Apellidos
PUBLIC xu003	as character(25)	&& Login
PUBLIC xu004	as character(25)	&& Cargo
PUBLIC xu005	as DATE(8)			&& Fecha Inicio
PUBLIC xu006	as DATE(8)			&& Fecha Final
PUBLIC xu007	as character(25)	&& Clave
PUBLIC xu008	as character(25)	&& Nivel
PUBLIC xu099	as LOGICAL			&& Activo

PUBLIC xu100	as LOGICAL	&& Modulo Basicos---------------------------------------------
PUBLIC xu101	as LOGICAL	&& Incluir 
PUBLIC xu102	as LOGICAL	&& Modificar 
PUBLIC xu103	as LOGICAL	&& Eliminar
PUBLIC xu104	as LOGICAL	&& Consultar
PUBLIC xu105	as LOGICAL	&& Imprimir

PUBLIC xu200	as LOGICAL	&& Modulo Ventas---------------------------------------------
PUBLIC xu201	as LOGICAL	&& Incluir 
PUBLIC xu202	as LOGICAL	&& Modificar 
PUBLIC xu203	as LOGICAL	&& Eliminar
PUBLIC xu204	as LOGICAL	&& Consultar
PUBLIC xu205	as LOGICAL	&& Imprimir
PUBLIC xu206	as LOGICAL	&& Borrar Item
PUBLIC xu207	as LOGICAL	&& Dscto por Item
PUBLIC xu208	as LOGICAL	&& Dscto General
PUBLIC xu209	as LOGICAL	&& Cambio Almacen
PUBLIC xu210	as LOGICAL	&& Cambio Precio
PUBLIC xu211	as LOGICAL	&& Precio 1
PUBLIC xu212	as LOGICAL	&& Precio 2
PUBLIC xu213	as LOGICAL	&& Precio 3
PUBLIC xu214	as LOGICAL	&& Cambio Garantia
PUBLIC xu215	as LOGICAL	&& Cambio Unidades Metricas

PUBLIC xu300	as LOGICAL	&& Modulo Almacen--------------------------------------------
PUBLIC xu301	as LOGICAL	&& Incluir 
PUBLIC xu302	as LOGICAL	&& Modificar 
PUBLIC xu303	as LOGICAL	&& Eliminar
PUBLIC xu304	as LOGICAL	&& ConsLOGICALltar
PUBLIC xu305	as LOGICAL	&& Imprimir

PUBLIC xu400	as LOGICAL	&& Modulo Compras--------------------------------------------
PUBLIC xu401	as LOGICAL	&& Incluir 
PUBLIC xu402	as LOGICAL	&& Modificar 
PUBLIC xu403	as LOGICAL	&& Eliminar
PUBLIC xu404	as LOGICAL	&& Consultar
PUBLIC xu405	as LOGICAL	&& Imprimir

PUBLIC xu500	as LOGICAL	&& Modulo Caja------------------------------------------------
PUBLIC xu501	as LOGICAL	&& Incluir 
PUBLIC xu502	as LOGICAL	&& Modificar 
PUBLIC xu503	as LOGICAL	&& Eliminar
PUBLIC xu504	as LOGICAL	&& Consultar
PUBLIC xu505	as LOGICAL	&& Imprimir

PUBLIC xu600	as LOGICAL	&& Modulo Cobros----------------------------------------------
PUBLIC xu601	as LOGICAL	&& Incluir 
PUBLIC xu602	as LOGICAL	&& Modificar 
PUBLIC xu603	as LOGICAL	&& Eliminar
PUBLIC xu604	as LOGICAL	&& Consultar
PUBLIC xu605	as LOGICAL	&& Imprimir
PUBLIC xu605	as LOGICAL	&& Imprimir

PUBLIC xu700	as LOGICAL	&& Modulo Pagos-----------------------------------------------
PUBLIC xu701	as LOGICAL	&& Incluir 
PUBLIC xu702	as LOGICAL	&& Modificar 
PUBLIC xu703	as LOGICAL	&& Eliminar
PUBLIC xu704	as LOGICAL	&& Consultar
PUBLIC xu705	as LOGICAL	&& Imprimir

PUBLIC xu800	as LOGICAL	&& Modulo Reportes--------------------------------------------
PUBLIC xu801	as LOGICAL	&& Incluir 
PUBLIC xu802	as LOGICAL	&& Modificar 
PUBLIC xu803	as LOGICAL	&& Eliminar
PUBLIC xu804	as LOGICAL	&& Consultar
PUBLIC xu805	as LOGICAL	&& Imprimir

PUBLIC xu900	as LOGICAL	&& Modulo Utilidades------------------------------------------
PUBLIC xu901	as LOGICAL	&& Incluir 
PUBLIC xu902	as LOGICAL	&& Modificar 
PUBLIC xu903	as LOGICAL	&& Eliminar
PUBLIC xu904	as LOGICAL	&& Consultar
PUBLIC xu905	as LOGICAL	&& Imprimir


**//Tabla Usuarios Select 1
SELECT 99
SET ORDER TO USU_LOG

**//Datos Usuarios
STORE u001	TO xu001	&& Nombres
STORE u002	TO xu002	&& Apellidos
STORE u003	TO xu003	&& Login
STORE u004	TO xu004	&& Cargo
STORE u005	TO xu005	&& Fecha Inicio
STORE u006	TO xu006	&& Fecha Final
STORE u007	TO xu007	&& Clave
STORE u008	TO xu008	&& Nivel
STORE u099	TO xu099	&& Activo

**//Modulo Basicos
STORE u100	TO xu100	&& Modulo Basicos---------------------------------------------
STORE u101	TO xu101	&& Incluir 
STORE u102	TO xu102	&& Modificar 
STORE u103	TO xu103	&& Eliminar
STORE u104	TO xu104	&& Consultar
STORE u105	TO xu105	&& Imprimir

**//Modulo Ventas
STORE u200	TO xu200	&& Modulo Ventas---------------------------------------------
STORE u201	TO xu201	&& Incluir 
STORE u202	TO xu202	&& Modificar 
STORE u203	TO xu203	&& Eliminar
STORE u204	TO xu204	&& Consultar
STORE u205	TO xu205	&& Imprimir
STORE u206	TO xu206	&& Borrar Item
STORE u207	TO xu207	&& Dscto por Item
STORE u208	TO xu208	&& Dscto General
STORE u209	TO xu209	&& Cambio Almacen
STORE u210	TO xu210	&& Cambio Precio
STORE u211	TO xu211	&& Precio 1
STORE u212	TO xu212	&& Precio 2
STORE u213	TO xu213	&& Precio 3
STORE u214	TO xu214	&& Cambio Garantia
STORE u215	TO xu215	&& Cambio Unidades Metricas

**//Modulo Almacen
STORE u300	TO xu300	&& Modulo Almacen--------------------------------------------
STORE u301	TO xu301	&& Incluir 
STORE u302	TO xu302	&& Modificar 
STORE u303	TO xu303	&& Eliminar
STORE u304	TO xu304	&& Conschkultar
STORE u305	TO xu305	&& Imprimir

**//Modulo Compras
STORE u400	TO xu400	&& Modulo Compras--------------------------------------------
STORE u401	TO xu401	&& Incluir 
STORE u402	TO xu402	&& Modificar 
STORE u403	TO xu403	&& Eliminar
STORE u404	TO xu404	&& Consultar
STORE u405	TO xu405	&& Imprimir

**//Modulo Caja
STORE u500	TO xu500	&& Modulo Caja------------------------------------------------
STORE u501	TO xu501	&& Incluir 
STORE u502	TO xu502	&& Modificar 
STORE u503	TO xu503	&& Eliminar
STORE u504	TO xu504	&& Consultar
STORE u505	TO xu505	&& Imprimir

**//Modulo Cobros
STORE u600	TO xu600	&& Modulo Cobros----------------------------------------------
STORE u601	TO xu601	&& Incluir 
STORE u602	TO xu601	&& Modificar 
STORE u603	TO xu602	&& Eliminar
STORE u604	TO xu603	&& Consultar
STORE u605	TO xu604	&& Imprimir
STORE u605	TO xu605	&& Imprimir

**//Modulo Pagos
STORE u700	TO xu700	&& Modulo Pagos-----------------------------------------------
STORE u701	TO xu701	&& Incluir 
STORE u702	TO xu702	&& Modificar 
STORE u703	TO xu703	&& Eliminar
STORE u704	TO xu704	&& Consultar
STORE u705	TO xu705	&& Imprimir

**//Modulo Reportes
STORE u800	TO xu800	&& Modulo Reportes--------------------------------------------
STORE u801	TO xu801	&& Incluir 
STORE u802	TO xu802	&& Modificar 
STORE u803	TO xu803	&& Eliminar
STORE u804	TO xu804	&& Consultar
STORE u805	TO xu805	&& Imprimir

**//Modulo Utilidades
STORE u900	TO xu900	&& Modulo Utilidades------------------------------------------
STORE u901	TO xu901	&& Incluir 
STORE u902	TO xu902	&& Modificar 
STORE u903	TO xu903	&& Eliminar
STORE u904	TO xu904	&& Consultar
STORE u905	TO xu905	&& Imprimir

RETURN
