*----------------------------------------------------------------------------
*--- VALIDAR EXISTENCIA LICENCIA
*----------------------------------------------------------------------------
*!*	*!*	ok=.f.
*!*	*!*	retorno=""
*!*	*!*	licencia=""
*!*	*!*	klave=""

*!*	*!*	**IF xvl1
*!*	*!*	IF !xvl1
*!*	*!*		licencia=INPUTBOX('Introduzca Nro. de Activacion ')
*!*	*!*		IF !EMPTY(licencia)
*!*	*!*			**//Correr y Validar clave
*!*	*!*			clave()
*!*	*!*			klave=retorno 
*!*	*!*			IF ALLTRIM(klave)==ALLTRIM(licencia)
*!*	*!*				ok=.t.
*!*	*!*				WAIT windows 'Registrando por favor espere...'+'-'+licencia TIMEOUT 0.5  
*!*	*!*			ENDIF
*!*	*!*			
*!*	*!*			IF ok
*!*	*!*				**//Apertura Tabla
*!*	*!*				SELECT 15
*!*	*!*				IF !LOCK1('MEMO','C')
*!*	*!*					RETURN
*!*	*!*				ENDIF
*!*	*!*				replace vl1		WITH .t.
*!*	*!*				USE 

*!*	*!*				**//Copiar el achivo oculto 
*!*	*!*				**pruta2=SYS(5)+'\windows\system32'
*!*	*!*				**COPY  FILE copia.obj TO   


*!*	*!*			ELSE
*!*	*!*				    WAIT windows '--------------------------------------------------------------------------LICENCIA INVALIDA-LLAME A Ing. Pedro Piña-Telefono Atencion:(0416) 936.80.05 --------------------------------------------------' nowait
*!*	*!*					messagebox('----------------------------------------------------------------------------'+CHR(13)+;
*!*	*!*					'-----------------------------------------------LICENCIA INVALIDA'+CHR(13)+;
*!*	*!*				  	'-----------------------------------------LLAME A Ing. Pedro Piña'+CHR(13)+;
*!*	*!*					'------------------------------Telefono Atencion:(0416) 936.80.05'+CHR(13)+;
*!*	*!*					'----------------------------------------------------------------------------',0+32,'Atencion')
*!*	*!*					

*!*	*!*					QUIT
*!*	*!*			ENDIF

*!*	*!*		ELSE
*!*	*!*			
*!*	*!*			messagebox('<<< ERROR CODIGO ACTIVACION >>> ',0+64,'Atencion')
*!*	*!*			QUIT
*!*	*!*			
*!*	*!*		ENDIF
*!*	*!*	ENDIF
*!*	*!*	RETURN

*!*			DO CASE 
*!*				CASE lower(licencia) = 's24a02ra'
*!*					ok=.t.
*!*				CASE lower(licencia) = 'a10maps1'
*!*					ok=.t.
*!*				CASE lower(licencia) = 'ta100mas'
*!*					ok=.t.

*!*		
*!*			ENDCASE 


*!*	**//Validar 
*!*	ARCHI="COPIA"
*!*	pruta2=SYS(5)+'\windows\system32'
*!*	SET PATH 	TO  '&pruta2'
*!*	IF !FILE('&ARCHI'+'.obj',1)

*!*	ELSE
*!*		messagebox('<<< NO EXISTE INSTALACION DEL PRODUCTO >>> ',0+64,'Atencion')
*!*	ENDIF
