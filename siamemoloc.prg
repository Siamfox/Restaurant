********************************************************************************
*FUNCTION SIAMEMOLOC && GENERAR VARIABLES EN MEMORIA PARA PUNTOS
********************************************************************************
PARAMETERS STA2

**//Configuracion local buscar en C:(local) para cada estacion
*!*	PUBLIC xs05		AS LOGICAL			&& Distribucion de Caja(Centralizada(T) o Distribuida(F))
*!*	PUBLIC xs11		AS LOGICAL			&& Barra Principal Habiltada(T) o Deshabilitada(F))
*!*	PUBLIC xca01 	AS LOGICAL		  	&& Gaveta de Efectivo
*!*	PUBLIC xca02	AS LOGICAL			&& Visor Cliente
*!*	PUBLIC xf05		AS Character(25)	&& Modelo Printer Fiscal
*!*	PUBLIC xf06		AS Character(15)	&& Serial Printer Fiscal

**//Sistema 
*!*	PUBLIC xs01		AS LOGICAL			&& Activar Imprimir Pantalla o Impresora
*!*	PUBLIC xs02		AS LOGICAL 			&& Cambio de Precio en Linea
*!*	PUBLIC xs03		AS LOGICAL			&& Calculo de Costos (Ult_Costo(T) o CostoPro(F))
*!*	PUBLIC xs04		AS LOGICAL			&& Calculo de Ganancias (Costo(T) o Pecio Venta(F))
*!*	PUBLIC xs05		AS LOGICAL			&& Distribucion de Caja(Centralizada(T) o Distribuida(F))
*!*	PUBLIC xs06		AS LOGICAL			&& Informe de Erroes Habiltada(T) o Deshabilitada(F))
*!*	PUBLIC xs10		AS CHARACTER(15)	&& CodeBar Supervision
*!*	PUBLIC xs11		AS LOGICAL			&& Barra Principal Habiltada(T) o Deshabilitada(F))

*!*	**//Fiscales
*!*	PUBLIC xf01		AS Logical			&& Descripcion Extendida Impresion Fiscal(modelo Bematech 2100)
*!*	PUBLIC xf02		AS Logical			&& Cod. Articulo Impresion Fiscal(modelo Bematech 2100)
*!*	PUBLIC xf03		AS Logical			&& Activar Mensaje Fiscal (modelo Bematech 2100)
*!*	PUBLIC xf04		AS Interger			&& Nro Item(s) por Factura (solo c/formatos)
*!*	PUBLIC xf05		AS Character(25)	&& Modelo Printer Fiscal
*!*	PUBLIC xf06		AS Character(15)	&& Serial Printer Fiscal
*!*	PUBLIC xf07		AS Character(10)	&& Formato Printer Fiscal



**//Configuracion local buscar en C:(local) para cada estacion

**//Sistema 
	PUBLIC xs01		AS LOGICAL			&& Imprimir Pantalla(.t.)/impresora(.f.)
	PUBLIC xs05		AS LOGICAL			&& Distribucion de Caja(Centralizada(T) o Distribuida(F))
	PUBLIC xs11		AS LOGICAL			&& Barra Principal Habiltada(T) o Deshabilitada(F))
	PUBLIC xs99		AS DATE				&& Fecha de Operaciones Comandas
	
**//Caja
	PUBLIC xca01 	AS LOGICAL		  	&& Gaveta de Efectivo
	PUBLIC xca02	AS LOGICAL			&& Visor Cliente
	PUBLIC xca05	AS LOGICAL			&& Caja Rapida
	PUBLIC xca07	AS LOGICAL			&& Imprimir por Pantalla Caja-Comanda
	PUBLIC xca08	AS LOGICAL			&& Imprimir comandas

**//Fiscales
	PUBLIC xf01		AS Logical			&& Descripcion Extendida Impresion Fiscal(modelo Bematech 2100)
	PUBLIC xf02		AS Logical			&& Cod. Articulo Impresion Fiscal(modelo Bematech 2100)
	PUBLIC xf03		AS Logical			&& Activar Mensaje Fiscal (modelo Bematech 2100)
	PUBLIC xf04		AS Interger			&& Nro Item(s) por Factura (solo c/formatos)
	PUBLIC xf05		AS Character(25)	&& Modelo Printer Fiscal
	PUBLIC xf06		AS Character(15)	&& Serial Printer Fiscal
	PUBLIC xf07		AS Character(10)	&& Formato Printer Fiscal
	PUBLIC xf08		AS Character(10)	&& Puerto Printer Fiscal
	PUBLIC xserie	as character(3)		&& Serie Fiscal formatos Boleta y Factura

**--Inventario
	PUBLIC xi03		AS LOGICAL 			&& Busqueda Progresiva Inventario,Cliente,Proveedor
	PUBLIC xi12		AS INTEGER			&& Campo de Busqueda Catalogo Inventario
	PUBLIC xi13		AS INTEGER			&& Modelo Catalogo Inventario
	PUBLIC xi14		AS LOGICAL			&& Control Existencias x Apartados
	PUBLIC xi15		AS LOGICAL			&& Control Cantidad por Piezas
	PUBLIC xi16		AS LOGICAL			&& Control Existencias en ficha Articulo

**--Columnas en Botoneras
	PUBLIC xi17		AS INTEGER			&&Columnas Botonera Familias
	PUBLIC xi18		AS INTEGER			&&Columnas Botonera Platos
	PUBLIC xi19		AS INTEGER			&&Columnas Botonera Mesas
	*PUBLIC xi20		as integer			&&Deposito por Defecto Localmente


**//Apertura Tablas 
SELECT 15
IF !LOCK1('MEMOLOC','C')
RETURN
ENDIF
LOCATE FOR STA2=STA
IF FOUND() &&!EOF()
	
	WAIT windows 'Generando Variables Estacion '+sta TIMEOUT 0.5
	
	**//Cargar Data a variables
	STORE s01		TO xs01 	&& Imprimir por Pantalla
	STORE s05		TO xs05 	&& Distribucion de Caja(Centralizada(T) o Distribuida(F))
	STORE s11		TO xs11 	&& Barra Principal Habiltada(T) o Deshabilitada(F))
	*STORE f01		TO xf01 	&& Descripcion Extendida Impresion Fiscal(modelo Bematech 2100)
	*STORE f02		TO xf02 	&& Cod. Articulo Impresion Fiscal(modelo Bematech 2100)
	STORE f03		TO xf03 	&& Activar Mensaje Fiscal (modelo Bematech 2100)
	STORE f04		TO xf04 	&& Nro Item(s) por Factura (solo c/formatos)
	STORE f05		TO xf05 	&& Modelo Printer Fiscal
	STORE f06		TO xf06 	&& Serial Printer Fiscal
	STORE f07		TO xf07 	&& Formato Printer Fiscal
	STORE f08		TO xf08 	&& Puerto Printer Fiscal
	STORE ca01 		TO xca01 	&& Gaveta de Efectivo
	STORE ca02		TO xca02 	&& Visor Cliente
	STORE ca05		TO xca05 	&& Caja Rapida 
	STORE ca07		TO xca07 	&& Imprimir por pantalla Punto de Venta-Caja 
	STORE ca08		TO xca08 	&& Imprimir comandas
	STORE serie		TO xserie 	&& SErie Formstos Boleta y Factura
	
	STORE i12		TO xi12		&& Campo de Busqueda Catalogo Inventario
	STORE i13		TO xi13		&& Modelo de Catalogo
*!*		STORE i14		TO xi14 	&& Control Existencias x Apartados
*!*		STORE i15		TO xi15 	&& Control Cantidad por Piezas
*!*		STORE i16		TO xi16 	&& Control Existencias en ficha Articulo


	**--Columnas Botoneras
	STORE i17		TO xi17		&&Columnas Botonera Familias
	STORE i18		TO xi18		&&Columnas Botonera Platos
	STORE i19		TO xi19 	&&Columnas Botonera Mesas

	STORE i20		TO xv10		&&Deposito por defecto Localmente

ELSE
	WAIT WINDOWS 'No se encontro variables locales de la estacion...'+sta TIMEOUT 0.5
ENDIF	
RETURN