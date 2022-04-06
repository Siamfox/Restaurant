*********************************************************************************
**FUNCTION SIAMEMO && GENERAR VARIABLES EN MEMORIA PARA EL MANEJO DEL SISTEMA PPAL
*********************************************************************************
**//Otros
PUBLIC xfPedidos 	as Logical 		&& Formulario Pedidos Activo
PUBLIC xfVentas	 	as Logical 		&& Formulario Ventas Activo
PUBLIC xfCotiza  	as Logical 		&& Formulario Cotizaciones Activo
PUBLIC xfptoVentas  as Logical 		&& Formulario Pto. de Ventas
PUBLIC xfComandas 	as Logical 		&& Formulario Pto. de Comandas
PUBLIC xfCompras	as Logical 		&& Formulario Compras
PUBLIC xvl1			as logical		&& Licencia

**//Empresarial
PUBLIC xe01		AS character(40)	&& Nombre1 Empresa
PUBLIC xe02		AS Character(40)	&& Nombre2 Empresa
PUBLIC xe03		as CHARACTER(50)	&& Direccion1 Empresa
PUBLIC xe04		AS CHARACTER(50)	&& Direccion2 Empresa
PUBLIC xe05		AS CHARACTER(30)	&& Telefonos Empresa
PUBLIC xe06		AS CHARACTER(30)	&& Correo Electronico Empresa
PUBLIC xe07		AS CHARACTER(30)	&& Web-Site Empresa
PUBLIC xe08		AS CHARACTER(20)	&& Registro Rif
PUBLIC xe09		AS CHARACTER(20)	&& Registro Nit
PUBLIC xe10		AS CHARACTER(30)	&& Logotipo o Icono

**//Sistema 
PUBLIC xs01		AS LOGICAL			&& Activar Imprimir Pantalla o Impresora
PUBLIC xs02		AS LOGICAL 			&& Cambio de Precio en Linea
PUBLIC xs03		AS LOGICAL			&& Calculo de Costos (Ult_Costo(T) o CostoPro(F))
PUBLIC xs04		AS LOGICAL			&& Calculo de Ganancias (Costo(T) o Pecio Venta(F))
PUBLIC xs05		AS LOGICAL			&& Distribucion de Caja(Centralizada(T) o Distribuida(F))
PUBLIC xs06		AS LOGICAL			&& Informe de Erroes Habiltada(T) o Deshabilitada(F))
PUBLIC xs10		AS CHARACTER(15)	&& CodeBar Supervision
PUBLIC xs11		AS LOGICAL			&& Barra Principal Habiltada(T) o Deshabilitada(F))
PUBLIC xs80		as logical 			&& Activar Seleccion de Mesa Primero
PUBLIC xs81		as logical 			&& Activar Cobro por consumo del 10%
PUBLIC xs82		as number 			&& Redondeo (0,1,2,3) decimales
PUBLIC xs99		AS DATE				&& Fecha de Operaciones Comandas

**//Fiscales
PUBLIC xf01		AS Logical			&& Descripcion Extendida Impresion Fiscal(modelo Bematech 2100)
PUBLIC xf02		AS Logical			&& Cod. Articulo Impresion Fiscal(modelo Bematech 2100)
PUBLIC xf03		AS Logical			&& Activar Mensaje Fiscal (modelo Bematech 2100)
PUBLIC xf04		AS Interger			&& Nro Item(s) por Factura (solo c/formatos)
PUBLIC xf05		AS Character(25)	&& Modelo Printer Fiscal
PUBLIC xf06		AS Character(15)	&& Serial Printer Fiscal
PUBLIC xf07		AS Character(10)	&& Formato Printer Fiscal
PUBLIC xf08		AS Character(4)		&& Puerto Impresora Fiscal
PUBLIC xserie	as character(3)		&& Serie Fiscal formatos Boleta y Factura

**//Ventas
PUBLIC xv01		AS LOGICAL 			&& Precio con Impuesto Incluido
PUBLIC xv02 	AS LOGICAL		  	&& libre
PUBLIC xv03		AS LOGICAL			&& Libre
PUBLIC xv04 	AS Logical 			&& Activar Descuento por Item
PUBLIC xv05		AS LOGICAL 			&& Supervisar Cambio de Precio en Ventas
PUBLIC xv06		AS LOGICAL 			&& Supervisar Cambio de Almacen
PUBLIC xv07		AS LOGICAL 			&& Supervisar Borrar Item
PUBLIC xv08		AS LOGICAL 			&& Supervisar Modificar
PUBLIC xv09		AS LOGICAL 			&& Precio por Defecto
PUBLIC xv10		AS LOGICAL			&& Deposito por Defecto
PUBLIC xv11		AS LOGICAL			&& Descuento General
PUBLIC xv12		AS LOGICAL			&& Supervisar Eliminar Documento
PUBLIC xv13		AS LOGICAL			&& Supervisar Dsctos x item
PUBLIC xv14		AS LOGICAL			&& ACT. TRANSPORTE
PUBLIC xv15		AS LOGICAL			&& ACT. NRO. DE ORDEN
PUBLIC xv16		AS LOGICAL			&& Control Cambio Moneda Extranjera

**//PtodeVentas
PUBLIC xpv01	AS LOGICAL 			&& Supervisar cambios de Precios
PUBLIC xpv02	AS LOGICAL		  	&& Descuentos x Item
PUBLIC xpv03	AS LOGICAL			&& Desccuento General
PUBLIC xpv04 	AS Logical 			&& Supervisar Borrar Item
PUBLIC xpv05	AS LOGICAL 			&& Supervisar Modificar
PUBLIC xpv06	AS LOGICAL 			&& Precio x Defecto
PUBLIC xpv07	AS LOGICAL 			&& Supervisar Eliminar Pedido
PUBLIC xpv08	AS LOGICAL 			&& Supervisar con Clave y TarjetaCodeBar
PUBLIC xpv09	AS LOGICAL 			&& Ctrol de Vendedores para comisiones
PUBLIC xpv09	AS LOGICAL 			&& Ctrol de Vendedores para comisiones


**//Caja
PUBLIC xca01 	AS LOGICAL		  	&& Gaveta de Efectivo
PUBLIC xca02	AS LOGICAL			&& Visor Cliente
PUBLIC xca03	AS LOGICAL			&& Supervisar Eliminacion Documento(Pedido)
PUBLIC xca04	AS LOGICAL			&& Supervisar Modificacion Documento(Pedido)
PUBLIC xca05	AS LOGICAL			&& Caja Rapida
PUBLIC xca06	AS Character(4)		&& Puerto Visor Cliente
PUBLIC xca07	AS LOGICAL			&& Imprimir por pantalla Punto de Venta-Caja
PUBLIC xca08	AS LOGICAL			&& Imprimir comandas


**//Inventario
PUBLIC xi01		AS LOGICAL			&& Ctrol existencias en Negativo
PUBLIC xi02		AS LOGICAL 			&& Costo Encriptado
PUBLIC xi03		AS LOGICAL 			&& Busqueda Progresiva Inventario,Cliente,Proveedor
PUBLIC xi04		AS LOGICAL			&& Buscar Codigo de Barra
PUBLIC xi05		AS LOGICAL			&& Manejo de Empaques
PUBLIC xi06		AS LOGICAL			&& Manejo de Depositos
PUBLIC xi07		AS LOGICAL			&& Manejo de Garantias
PUBLIC xi08	 	AS LOGOCAL 			&& Manejo de Matriz
PUBLIC xi09		AS LOGICAL 			&& Control Existencias en Ventas
PUBLIC xi10	 	AS LOGCAL			&& Control Existencias en Notas
PUBLIC xi11		AS LOGICAL 			&& Control Existencias en Pedidos
PUBLIC xi12		AS INTEGER			&& Campo de Busqueda Catalogo Inventario
PUBLIC xi13		AS INTEGER			&& Modelo Catalogo Inventario
PUBLIC xi14		AS LOGICAL			&& Control Existencias x Apartados
PUBLIC xi15		AS LOGICAL			&& Control Cantidad por Piezas
PUBLIC xi16		AS LOGICAL			&& Control Existencias en ficha Articulo

**--Columnas en Botoneras
PUBLIC xi17		AS INTEGER			&& Columnas Botonera Familias
PUBLIC xi18		AS INTEGER			&& Columnas Botonera Platos
PUBLIC xi19		AS INTEGER			&& Columnas Botonera Mesas


**//Apertura Tablas 
SELECT 15
USE MEMO SHARED 
IF !EOF()
	GO top 
	**//Cargar Data a variables
	
	**//Otros
	STORE .f.		TO xfPedidos 	&& Formulario Pedido Activo
	STORE .f.		TO xfVentas 	&& Formulario Pedido Activo
	STORE .f.		TO xfCotiza		&& Formulario Pedido Activo
	STORE .f. 		TO xfptoVentas	&& Formulario Pto. de Ventas
	STORE .f. 		TO xfComandas	&& Formulario Pto. de Comandas
	STORE .f. 		TO xfCompras	&& Formulario Compras
	STORE vl1		TO xvl1			&& Licencia

	**//Empresarial
	STORE e01		TO xe01	&& Nombre1 Empresa
	STORE e02		TO xe02 && Nombre2 Empresa
	STORE e03		TO xe03	&& Direccion1 Empresa
	STORE e04		TO xe04 && Direccion2 Empresa
	STORE e05		TO xe05 && Telefonos Empresa
	STORE e06		TO xe06 && Correo Electronico Empresa
	STORE e07		TO xe07 && Web-Site Empresa
	STORE e08		TO xe08 && Registro Rif
	STORE e09		TO xe09 && Registro Nit
	STORE e10		TO xe10 && Logotipo o Icono
	
	**//Sistema 
	STORE s01		TO xs01 && Activar Imprimir Pantalla o Impresora
	STORE s02		TO xs02 && Cambio de Precio en Linea
	STORE s03		TO xs03 && Calculo de Costos (Ult_Costo(T) o CostoPro(F))
	STORE s04		TO xs04 && Calculo de Ganancias (Costo(T) o Pecio Venta(F))
	STORE s05		TO xs05 && Distribucion de Caja(Centralizada(T) o Distribuida(F))
	STORE s06		TO xs06 && Informe de Errores Habilitada(T) o Deshabilitada(F)
	STORE s10		TO xs10 && CodeBar Supervision
	STORE s11		TO xs11 && Barra Principal Habiltada(T) o Deshabilitada(F))
	**STORE s12		TO xs12 && Tipo de Venta Mayor o Detal
	STORE s30		TO xs30	&& Activar Multimonedas
	STORE s80		TO xs80 && Activar Seleccion de Mesa Primero
	STORE s81		TO xs81 && Activar Cobro consumo del 10%
	STORE s82		TO xs82	&& Activar Redondeo (0-redondeo 0 decimal / 1-redondeo 1 decimal / 2-redondeo 2 decimales / 3-redondeo 3 decimales)	

	
	**//Fiscales
	STORE f01		TO xf01 && Descripcion Extendida Impresion Fiscal(modelo Bematech 2100)
	STORE f02		TO xf02 && Cod. Articulo Impresion Fiscal(modelo Bematech 2100)
	STORE f03		TO xf03 && Activar Mensaje Fiscal (modelo Bematech 2100)
	STORE f04		TO xf04 && Nro Item(s) por Factura (solo c/formatos)
	STORE f05		TO xf05 && Modelo Printer Fiscal
	STORE f06		TO xf06 && Serial Printer Fiscal
	STORE f07		TO xf07 && Formato Printer Fiscal
	*STORE f08		TO xf08	&& Puerto Impresora Fiscal
	STORE serie		TO xserie && SErie Formstos Boleta y Factura

	**//Ventas
	STORE v01		TO xv01 && Precio con Impuesto Incluido
	STORE v02 		TO xv02 && Libre
	STORE v03		TO xv03 && Libre
	STORE v04 		TO xv04 && Activar Descuento por Item
	STORE v05		TO xv05 && Supervisar Cambio de Precio en Ventas
	STORE v06		TO xv06 && Supervisar Cambio de Almacen
	STORE v07		TO xv07 && Supervisar Borrar Item
	STORE v08		TO xv08 && Supervisar Modificar
	STORE v09		TO xv09 && Precio por Defecto
	STORE v10		TO xv10 && Deposito por Defecto
	STORE v11		TO xv11	&& Descuento General
	STORE v12		TO xv12	&& Supervisar Eliminar Documento
	STORE v13		TO xv13	&& Supervisar Dsctos x item
	STORE v14		TO xv14	&& Activar Manejo de Transporte
	STORE v15		TO xv15	&& Activar Manejo de Nro. de Orden
	STORE v16		TO xv16	&& Activar Cambio Moneda Extranjera

	**//PtodeVentas
	STORE pv01		TO xpv01 && Supervisar cambios de Precios
	STORE pv02		TO xpv02 && Descuentos x Item
	STORE pv03		TO xpv03 && Desccuento General
	STORE pv04 		TO xpv04 && Supervisar Borrar Item
	STORE pv05		TO xpv05 && Supervisar Modificar
	STORE pv06		TO xpv06 && Precio x Defecto
	STORE pv07		TO xpv07 && Supervisar Eliminar Pedido
	STORE pv08		TO xpv08 && Supervisar con Clave y TarjetaCodebar
	STORE pv09		TO xpv09 && Control Vendedores para comisiones

	**//Caja
	STORE ca01 		TO xca01 && Gaveta de Efectivo
	STORE ca02		TO xca02 && Visor Cliente
	STORE ca03		to xca03 && Supervisar Eliminacion Documento(Pedido)
	STORE ca04		to xca04 && Supervisar Modificacion Documento(Pedido)
	STORE ca05		TO xca05 && Caja Rapida
	*STORE ca06		TO xca06 && Puerto Visor Cliente
	STORE ca07		TO xca07 && Imprimir por pantalla punto de Venta-Caja 
	STORE ca08		TO xca08 && Imprimir comandas

	**//Inventario
	STORE i01		TO xi01 && Ctrol existencias en Negativo
	STORE i02		TO xi02 && Costo Encriptado
	STORE i03		TO xi03 && Busqueda Progresiva Inventario,Cliente,Proveedor
	STORE i04		TO xi04 && Buscar Codigo de Barra
	STORE i05		TO xi05 && Manejo de Empaques
	STORE i06		TO xi06 && Manejo de Depositos
	STORE i07		TO xi07 && Manejo de Garantias
	STORE i08	 	TO xi08	&& Manejo de Matriz
	STORE i09		TO xi09 && Control Existencias en Ventas
	STORE i10	 	TO xi10	&& Control Existencias en Notas
	STORE i11		TO xi11	&& Control Existencias en Pedidos
	STORE i12		TO xi12	&& Campo de Busqueda Catalogo Inventario
	STORE i13		TO xi13	&& Modelo Catalogo Inventario
	STORE i14		TO xi14 && Control Existencias x Apartados
	STORE i15		TO xi15 && Control Cantidad por Piezas
	STORE i16		TO xi16 && Control Existencias en ficha Articulo

	**--Columnas en Botoneras
	STORE i17		TO	xi17 &&Columnas Botonera Familias
	STORE i18		TO	xi18 &&Columnas Botonera Platos
	STORE i19		TO	xi18 &&Columnas Botonera Mesas

ENDIF	
RETURN
