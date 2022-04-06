*!*	function Analisa_iRetorno()
*!*	parameters iRetorno

*!*	if iRetorno <> 1
*!*		do case
*!*	        case iRetorno = 0
*!*	             MessageBox( "Error de Comunicación !", "Error" )
*!*	        case iRetorno = -2
*!*	             MessageBox( "Parámetro Inválido !", "Error" )     
*!*	        case iRetorno = -3
*!*	             MessageBox( "Alicuota no programada !", "Atención" )     
*!*	        case iRetorno = -18
*!*	             MessageBox( "No fue posible abrir el archivo INTPOS.001 !" )     
*!*	        case iRetorno = -19
*!*	             MessageBox( "Parámetro diferentes !", "Atención" )     
*!*	        case iRetorno = -20
*!*	             MessageBox( "Transación cancelada por el Operador !", "Atención" )     
*!*	        case iRetorno = -21
*!*	             MessageBox( "La transación no fue aprobada !", "Atención" )     
*!*	        case iRetorno = -22
*!*	             MessageBox( "No fue posible finalizar la impresión !", "Atención" )     
*!*	        case iRetorno = -23
*!*	             MessageBox( "No fue posible finalizar la operación !", "Atención" )              
*!*	    endcase
*!*	else
*!*	    iACK = 0
*!*	  	iST1 = 0
*!*	  	iST2 = 0
*!*	  	cMSJError = ""
*!*	  	iRetorno = Bematech_FI_RetornoImpresora( @iACK, @iST1, @iST2 )   
*!*	    if iACK = 21 
*!*	    	= MessageBox("La impresora ha retornado NAK !", 16+0+0, [Atención] )
*!*	    else
*!*			if ( iST1 <> 0 ) .OR. ( iST2 <> 0 )
*!*	       		&& Analisa ST1

*!*	            if ( iST1 >= 128 ) 
*!*	                iST1 = iST1 - 128
*!*	                cMSJError = cMSJError + "Fin de Papel" + chr(13)
*!*	            endif    
*!*	            if ( iST1 >= 64 )
*!*	               	iST1 = iST1 - 64
*!*	               	cMSJError = cMSJError + "Poco Papel" + chr(13)
*!*	            endif
*!*	            if ( iST1 >= 32 ) 
*!*	               	iST1 = iST1 - 32
*!*	               	cMSJError = cMSJError + "Error en el Reloj" + chr(13)
*!*	            endif
*!*	 		    if ( iST1 >= 16 ) 
*!*					iST1 = iST1 - 16
*!*					cMSJError = cMSJError + 'Impresora con error' + chr(13)
*!*				endif
*!*				if ( iST1 >= 8 ) 
*!*					iST1 =  iST1 - 8 
*!*					cMSJError =  cMSJError + "Primer dato del comando no fue ESC" + chr(13) 
*!*				endif
*!*			    if iST1 >= 4 
*!*					iST1 =  iST1 - 4 
*!*					cMSJError =  cMSJError + "Comando inexistente" + chr(13) 
*!*				endif
*!*	 		    if iST1 >= 2  
*!*	                iST1 =  iST1 - 2 
*!*	                cMSJError =  cMSJError + "Cupón fiscal abierto" + chr(13) 
*!*	            endif    
*!*	            if iST1 >= 1  
*!*	                iST1 =  iST1 - 1 
*!*	                cMSJError =  cMSJError + "Número de parámetros inválidos" + chr(13) 
*!*	            endif

*!*	            && Analisa ST2

*!*	            if iST2 >= 128  
*!*	                iST2 =  iST2 - 128 
*!*	                cMSJError =  cMSJError + "Tipo de parámetro de comando inválido" + chr(13) 
*!*	            endif    
*!*	            if iST2 >= 64  
*!*	                iST2 =  iST2 - 64 
*!*	                cMSJError =  cMSJError + "Memória fiscal llena" + chr(13) 
*!*	            endif    
*!*	            if iST2 >= 32  
*!*	                iST2 =  iST2 - 32 
*!*	                cMSJError =  cMSJError + "Error en la CMOS" + chr(13) 
*!*	            endif 
*!*	            if iST2 >= 16  
*!*	                iST2 =  iST2 - 16 
*!*	                cMSJError =  cMSJError + "Alicuota no programada" + chr(13) 
*!*	            endif
*!*	            if iST2 >= 8  
*!*	                iST2 =  iST2 - 8 
*!*	                cMSJError =  cMSJError + "Capacidad de Alicuota Programables llena" + chr(13) 
*!*	            endif
*!*	            if iST2 >= 4  
*!*	                iST2 =  iST2 - 4 
*!*	                cMSJError =  cMSJError + "Cancelamiento no permitido" + chr(13) 
*!*	            endif
*!*	            if iST2 >= 2  
*!*	                iST2 =  iST2 - 2 
*!*	                cMSJError =  cMSJError + "RIF del propietario no Programados" + chr(13) 
*!*	            endif
*!*	            if iST2 >= 1  
*!*	                iST2 =  iST2 - 1 
*!*	                cMSJError =  cMSJError + "Comando no ejecutado" + chr(13) 
*!*	            endif
*!*	           && Exhibe mensaje de error  
*!*	            MessageBox (cMSJError, "Atención" )
*!*	   
*!*	       endif     
*!*	   
*!*	   return (STR (iRetorno) )
*!*	   endif
*!*	endif