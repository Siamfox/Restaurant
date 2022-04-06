**************************
** Tabla Facturas
**************************
ARCHI='FACTURA'
ARCHI2='FACTURAS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

archi='FACREG'
archi2='REGISTROS FACTURAS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF


*********************************	
** Tabla INVENTARIO
*********************************
archi='INVEN'
archi2='INVENTARIOS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

*********************************	
** Tablas-Combos
********************************		
archi='COMBOS'
archi2='COMBOS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

archi='COMBOREG'
archi2='REGISTROS DE COMBOS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF


**************************
** Tabla Pedidos
**************************
archi='PEDIDO'
archi2='PEDIDOS DE VENTAS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF


archi='PEDREG'
archi2='REGISTROS DE PEDIDOS DE VENTAS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

***********************************
** Tabla Clientes
***********************************
archi='CLIENTE'
archi2='CLIENTES'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

***********************************
** Tabla Proveedores
***********************************
archi='PROVEEDO'
archi2='PROVEEDORES'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF


***********************************
** Tabla Vendedores
***********************************
archi='VENDEDOR'
archi2='VENDEDORES'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF


***********************************
** Tabla Cajas 
***********************************
archi='CAJA1'
archi2='MONITOR DE CAJAS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

archi='CAJAPAGOS'
archi2='REGISTROS PAGOS EN CAJA'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

*****************************************************
** Tabla MovInv &&Movimientos de Inventarios
*****************************************************
archi='MOVINV'
archi2='MOVIMIENTOS DE INVENTARIOS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

************************************
** Tabla Lineas
************************************
archi='LINEA'
archi2='LINEAS DE VENTAS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF


**************************
** Tabla Cobros
**************************
archi='FAC_COB'
archi2='COBROS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

**************************
** Tabla Pagos
**************************
archi='FAC_PAG'
archi2='PAGOS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF


**************************
** Tabla Compras
**************************
archi='COMPRAS'
archi2='COMPRAS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

archi='COMREG'
archi2='REGISTROS DE COMPRAS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

************************************
** Tabla Cotizaciones
************************************
archi='COTIZA'
archi2='PRESUPUESTOS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

archi='COTREG'
archi2='REGISTROS DE PRESUPUESTOS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

**************************
** Tabla Notas de Entrega
**************************
archi='NOTAS'
archi2='NOTAS DE  ENTREGAS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

archi='NOTREG'
archi2='REGISTROS DE NOTAS DE ENTREGAS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

************************************
** Tabla Usuarios
************************************
archi='USUARIOS'
archi2='USUARIOS DEL SISTEMA'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF


************************************
** Tabla Impuestos
************************************
archi='IMPUESTOS'
archi2='IMPUESTOS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF


************************************
** Tabla Depositos
************************************
*!*	IF THISFORM.CONTAINER1.CHKDEPOSITOS.VALUE=1
*!*		USE DEPOSITO EXCLUSIVE
*!*			INDEX ON DEPOSITO	TO DEP_DEP

*!*			INDEX ON DEPOSITO	TAG DEP_DEP
*!*			
*!*			CLOSE DATABASES 
*!*	ENDIF

**************************
** Tabla Apartados
**************************
archi='APARTADO'
archi2='APARTADOS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

archi='APAREG'
archi2='REGISTROS DE APARTADOS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

**************************
** Tabla Tranferencias
**************************
archi='TRANFER'
archi2='TRANFERENCIAS DEPOSITOS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF

archi='TRANREG'
archi2='REGISTROS DE TRANSFERENCIAS DEPOSITOS'
WAIT WINDOWS "Verificando Tabla "+alltrim(archi)+"..." NOWAIT 
IF !VALFILE_ii('&archi') &&VALIDAR SI EXISTE TABLA
	messagebox('<<< ERROR, FATAL No se Encontro tabla >>> '+ALLTRIM(archi2),0+64,'Atencion')
	*RETURN
ENDIF


*******FIN PROCESO+********************************************
***SET EXCLUSIVE OFF 
****CLOSE DATABASES ALL

WAIT WINDOWS "Proceso Terminado..." nowait