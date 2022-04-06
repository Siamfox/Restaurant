DECLARE INTEGER Bematech_FI_VerificaImpresoraPrendida IN BemaFI32.DLL 
DECLARE INTEGER Bematech_FI_LecturaX IN BemaFI32.DLL  
DECLARE INTEGER Bematech_FI_VerificaImpresoraPrendida IN BemaFi32.DLL


iRetorno = Bematech_FI_LecturaX() 

iRetorno = Bematech_FI_VerificaImpresoraPrendida() 

IF iRetorno=0
	messagebox('error comunicacion',0+64,'Atencion')
	RETURN
ELSE
	iRetorno=99
ENDIF

RETURN


************************************************************
FUNCTION LEE_STATU  // LEE EL STATU DEL COMANDO Y SUS ERRORES
*************************************************************
STORE 0 TO ST1,ST2,I
STORE '' TO Mens1,Mens2
**// verificar Archivo Status

IF ST1>0 .OR. ST2>0  // HUBO ERROR

**//**Codificando o ST1

If St1 >= 128  // bit 7 
St1 = St1 - 128 
Mens1 = "Fin de Papel" 
endIf 
If St1 >= 64   // bit 6 
St1 = St1 - 64 
Mens1 = "Poco Papel" 
endif 
If St1 >= 32   // bit 5 
St1 = St1 - 32 
Mens1 = "Error en el Reloj" 
endif 
If St1 >= 16   // bit 4 
St1 = St1 - 16 
Mens1 = "Impresora con Error" 
endif 
If St1 >= 8    // bit 3 
St1 = St1 - 8 
Mens1 = "Comando no empieza con ESC" 
endif 
If St1 >= 4   // bit 2 
St1 = St1 - 4 
Mens1 = "Comando Inexistente" 
endif 
If St1 >= 2   // bit 1 
St1 = St1 - 2 
Mens1 = "Cupón Abierto" 
endif 
If St1 >= 1   // bit 0 
St1 = St1 - 1 
Mens1 = "Numero de Parametro(s) Invalido(s)" 
endif 

**// **Codificando o ST2 

If St2 >= 128 // bit 7 
St2 = St2 - 128 
Mens2 = "Tipo de Parametro de Comando Invalido" 
endif 
If St2 >= 64  // bit 6 
St2 = St2 - 64 
Mens2 = "Memoria Fiscal LLena" 
endif 
If St2 >= 32  // bit 5 
St2 = St2 - 32 
Mens2 = "Error en la Memória RAM" 
endif 
If St2 >= 16  // bit 4 
St2 = St2 - 16 
Mens2 = "Alicuota No Programada" 
endif 
If St2 >= 8   // bit 3 
St2 = St2 - 8 
Mens2 = "Capacidad de Alicuotas Llena" 
endif 
If St2 >= 4   // bit 2 
St2 = St2 - 4 
Mens2 = "Cancelamiento No Permitido" 
endif 
If St2 >= 2   // bit 1 
St2 = St2 - 2 
Mens2 = "RIF del Propietario No Programado" 
endif 
If St2 >= 1   // bit 0 
St2 = St2 - 1 
Mens2 = "Comando No Ejecutado" 
endif

  ERROR('­­­ ERROR !!!','&Mens1'+' '+'&Mens2')

ELSE

  **AVISO('­­­ AVISO !!! No se encontro Error...!')
  @ 24,0 SAY ' ­­­ AVISO !!! No se encontro Error...!'
  INKEY(2)

ENDIF

ELSE
   ERROR('­­­ ERROR !!!','ERROR DE COMUNICACION CON EL PRINTER ')
ENDIF
RETURN