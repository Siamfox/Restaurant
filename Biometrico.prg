**//Conexion a la Base de Datos
lcArchivoMDB="C:\Archivos de programa\Hydra\dbase.mdb"
***lcArchivoMDB="C:\Program Files\Hydra\t01\dbase.mdb"
lcConnString="Driver={Microsoft Access Driver (*.mdb)};"+;
             "Dbq="+lcArchivoMDB
              &&+";Uid=Admin;Pwd=;"

lnHandle = SQLStringConnect(lcConnString)


SET DECIMALS TO 3

*** Nos conectamos a la base de datos ....
lnHandle = SQLStringConnect(lcConnString)
IF lnHandle > 0
    *** Intentamos obtener las tablas
    IF SQLTables(lnHandle,"TABLE","cTables") > 0
        **** Realizamos el recorrido de los tablas obtenidas
        *SCAN
                
           *** Obtenemos el nombre de la entidad 
           lcTabla= "tickets"  &&ALLTRIM(EVALUATE(FIELD(3,"cTables")))
           
           *** Tranformar cadenas para el Query
           lcQuery="SELECT nume,code,item,price,units,weight,iva FROM "+lcTabla
           &&+"WHERE scanner" 
          
           WAIT WINDOW "Extrayendo Datos de la tabla: "+lcTabla NOWAIT
          
           *** Ejecutamos la consulta segun la entidad actual
           IF SQLEXEC(lnHandle,lcQuery,"cImport") > 0
              *BROWSE
              *Copiamos a una tabla fisica
                COPY TO (lcTabla)
                 USE IN (SELECT("cImport"))
            ENDIF
         *ENDSCAN
         USE IN (SELECT("cTables"))
        **** Desconectarnos de la fuente remota 
        =SQLDisconnect(lnHandle)
    ELSE
     **** Manejo de Errores
       IF AERROR(laError) > 0
         Messagebox("Error al obtener entidades:"+laError[2])
       ELSE
         Messagebox("Error inesperado al obtener entidades...")
       ENDIF
    ENDIF
ELSE
     IF AERROR(laError) > 0
       Messagebox("Error al intentar conectar:"+laError[2])
     ELSE
       MESSAGEBOX("Error inesperado al intentar conectar")
     ENDIF
ENDIF

SET DECIMALS TO 2
RETURN
