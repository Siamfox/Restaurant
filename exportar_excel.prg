**--Exportar con Formato Excel
**--nombre file : exportados\exp_xxxxxxxxxx.xls
**------------------------------------------------------------
SET DELETED ON 

**--Otra Forma
**---------------------------------------------------------------
**//Directorio donde se almacenaran los archivos
**---------------------------------------------------------------
IF DIRECTORY('c:\exportados')=.f.
   MKDIR c:\exportados
ENDIF

export to (cFile) TYPE XL5

MESSAGEBOX('Exportado Listado,a la carpeta exportados de la Unidad ',1+64,'Atencion')
RETURN
