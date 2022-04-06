PUBLIC lStatus, lError

DECLARE INTEGER  OpenFpctrl      IN TFHKAIF.DLL  String lpPortName
DECLARE INTEGER  CloseFpctrl     IN TFHKAIF.DLL  
DECLARE INTEGER  CheckFprinter   IN TFHKAIF.DLL  
DECLARE INTEGER  ReadFpStatus    IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError
DECLARE INTEGER  SendCmd         IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @cmd
DECLARE INTEGER  SendNCmd        IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @bufferCmd
DECLARE INTEGER  SendFileCmd     IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @fileCmd
DECLARE INTEGER  UploadReportCmd IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @cmd,string @fileCmd
DECLARE INTEGER  UploadStatusCmd IN TFHKAIF.DLL  LONG @lStatus ,LONG @lError,STRING @cmd,string @fileCmd


IF DIRECTORY('d:\fac_fis')=.f.
   MKDIR d:\fac_fis
ENDIF
*--------------------------
wnro_arch=0
FOR wnro_arch=0 TO 10000
    wnro=ALLTRIM(TRANSFORM(wnro_arch,'999999'))
    warchivo='d:\fac_fis\input'+wnro+'.dat'
    IF FILE(warchivo)=.f.
       gntestfile=Fcreate(warchivo) 
       EXIT  
    ENDIF
ENDFOR 


*-----------------
SELECT 11 &&  det_temp
GO top
word_com=word_com
wpla_fac=wpla_fac

l=1
  wl='0'+ALLTRIM(TRANSFORM(l,'99'))
  texto='i'+wl+'Cond. Pago: '
  IF con_crd=2
     texto=texto+'Credito'+SPACE(2)
  ELSE    
     texto=texto+'Contado'+SPACE(2)
  ENDIF
  texto=texto+'Ref: '+ ALLTRIM(STR(wnro_fac))+ ' Vend.'+wNRO_VEN +Chr(13) + Chr(10)
  *-------------------
  l=l+1
  wl='0'+ALLTRIM(TRANSFORM(l,'99'))
  texto=texto+'i'+wl+'------------------------------------------------------------------------------' +Chr(13) + Chr(10)
  *-------------------
  l=l+1
  wl='0'+ALLTRIM(TRANSFORM(l,'99'))   
  IF !EMPTY(wNOM_CLI)
       texto=texto+'i'+wl+ SUBSTR(wNOM_CLI,1,50)+ Chr(13) + Chr(10)
  ENDIF      
  *-------------------  
  IF !EMPTY(wDIR_CLI)   
      l=l+1
      IF LEN(ALLTRIM(STR(l)))=1
         wl='0'+ALLTRIM(TRANSFORM(l,'99'))
      ELSE
         wl=TRANSFORM(l,'99')   
      ENDIF 
  texto=texto+'i'+wl+SUBSTR(wDIR_CLI,1,50)+ Chr(13) + Chr(10) 
  ENDIF
  *------------------- 
  IF !EMPTY(wDIR_CLI1)
      l=l+1
      IF LEN(ALLTRIM(STR(l)))=1
         wl='0'+ALLTRIM(TRANSFORM(l,'99'))
      ELSE
         wl=TRANSFORM(l,'99')   
      ENDIF   
  texto=texto+'i'+wl+SUBSTR(wDIR_CLI1,1,50)+ Chr(13)+ Chr(10) 
  ENDIF 
  *--------------------

  IF !EMPTY(wciu_CLI) OR !EMPTY(west_CLI)
      l=l+1
      IF LEN(ALLTRIM(STR(l)))=1
         wl='0'+ALLTRIM(TRANSFORM(l,'99'))
      ELSE
         wl=TRANSFORM(l,'99')   
      ENDIF  
      tex1=ALLTRIM(wciu_cli)+ space(3)+ALLTRIM(west_cli)
      texto=texto+'i'+wl+SUBSTR(tex1,1,50) + Chr(13)+ Chr(10) 
  ENDIF   
*------------------

  tex1='' 
  IF !EMPTY(WRIF_CLI) 
      *WRIF=SUBSTR(wRIF_CLI,1,1)+'-'+SUBSTR(wRIF_CLI,2,8)+'-'+SUBSTR(wRIF_CLI,10,1)
      tex1='Rif/CI:'+ALLTRIM(WRIF_CLI)  
*!*	      *tex1='Rif. :'+ALLTRIM(RIF_CLI)
*!*	  ELSE
*!*	      tex1= 'Cedula :'+ALLTRIM(wCEI_CLI)
  ENDIF 
  IF !EMPTY(tex1)
      tex1=SUBSTR(tex1+SPACE(22),1,22)
      *l=l+1
      *IF LEN(ALLTRIM(STR(l)))=1
      *   wl='0'+ALLTRIM(TRANSFORM(l,'99'))
      *ELSE
      *   wl=TRANSFORM(l,'99')   
      *ENDIF 
  *texto=texto+'i'+wl+tex1+ Chr(13)+ Chr(10)      
  ENDIF
  *----------------
  tex2=''    
  IF !EMPTY(wTEL_CLI)
      tex2= 'Tlf.:'+ ALLTRIM(wTEL_CLI)
  ENDIF
      tex2=SUBSTR(tex2+SPACE(20),1,20)
      
      l=l+1
      IF LEN(ALLTRIM(STR(l)))=1
         wl='0'+ALLTRIM(TRANSFORM(l,'99'))
      ELSE
         wl=TRANSFORM(l,'99')   
      ENDIF       
  *----------------
  texto=texto+'i'+wl+tex1+tex2+ Chr(13) + Chr(10)
  *--------------------
  
  l=l+1
  IF LEN(ALLTRIM(STR(l)))=1
     wl='0'+ALLTRIM(TRANSFORM(l,'99'))
  ELSE
     wl=TRANSFORM(l,'99')   
  ENDIF 
  texto=texto+'i'+wl+'------------------------------------------------------------------------------' +Chr(13) + Chr(10)
  
  *--------temino encabezado---
*!*	  l=l+1
*!*	  IF LEN(ALLTRIM(STR(l)))=1
*!*	     wl='0'+ALLTRIM(TRANSFORM(l,'99'))
*!*	  ELSE
*!*	     wl=TRANSFORM(l,'99')   
*!*	  ENDIF 

*!*	  texto=texto+'i'+wl+'Cantidad    Precio        /      Codigo    Descripcion' + Chr(13)+ Chr(10)
  *----------------
  *l=l+1
  *  IF LEN(ALLTRIM(STR(l)))=1
  *   wl='0'+ALLTRIM(TRANSFORM(l,'99'))
  *ELSE
  *   wl=TRANSFORM(l,'99')   
  *ENDIF  
  *texto=texto+'i'+wl+'------------------------------------------------------------------------------' +Chr(13) + Chr(10)
  
  *-------------------
  SCAN
  
	**//Pase de Variables
		STORE FPRECIO 			TO PVP_PRO
		STORE FCANTIDAD			TO CAN_PRO
		STORE FALICUOTA			TO POR_IMP
		STORE ALLTRIM(FDESCRIP)	TO DES_PRO
		STORE ALLTRIM(FCODIGO)	TO NRO_PRO
	  
     pvp=TRANSFORM(PVP_PRO,'99999999.99')
     pvp=SUBSTR(pvp,1,8)+SUBSTR(pvp,10,2)
     le=LEN(ALLTRIM(pvp))
     pvp_f=SUBSTR('0000000000',1,10-le)+ALLTRIM(pvp)
       
     can=TRANSFORM(can_PRO,'99999.999')
     can=SUBSTR(can,1,5)+SUBSTR(can,7,3)
     le=LEN(ALLTRIM(can))
     can_f=SUBSTR('00000000',1,8-le)+ALLTRIM(can)
    
     *texto=texto+'@'+'Cod :'+nro_pro+Chr(13) + Chr(10)
*!*	     IF can_pro=1
*!*	        can2=ALLTRIM(TRANSFORM(can_PRO,'9999.99'))
*!*	        pvp2=ALLTRIM(TRANSFORM(pvp_PRO,'9999999.99'))
*!*	        texto=texto+'@'+can2 +' x ' + 'Bs '+pvp2+Chr(13) + Chr(10)
*!*	     ENDIF    
     
	*Impuesto '' Ex '!' Imp1	
     IF por_imp=0
        *texto=texto+' '+pvp_f+can_f+'   '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10)
         texto=texto+' '+pvp_f+can_f+nro_pro+'   '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10)
     ELSE 
        *texto=texto+'!'+pvp_f+can_f+'   '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10)
        texto=texto+'!'+pvp_f+can_f+nro_pro+'   '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10)
     ENDIF 
     
     *texto=texto+'#'+pvp_f+can_f+nro_pro+'   '+SUBSTR(des_pro,1,40)+Chr(13) + Chr(10) &totales x impuesto
     *IF !EMPTY(keyfecha)
     *    texto=texto+'@'+keyfecha+Chr(13) + Chr(10)
     *ENDIF    
  ENDSCAN
   texto=texto+'@'+'                     '+Chr(13) + Chr(10)
 
   *-------orden de compra
    
    tex3=' '  
  IF wpla_fac>0

      wpla_fac=ALLTRIM(TRANSFORM(wpla_fac,'999'))
      tex3= 'Plazo : '+ wpla_fac +' dias'
      texto=texto+'@'+tex3+Chr(13) + Chr(10)
  ENDIF
  
      tex3=' '    
  IF !EMPTY(word_com)
      tex3= 'Nota de Entrega : '+ ALLTRIM(word_com) 
      texto=texto+'@'+tex3+Chr(13) + Chr(10)
  ENDIF
  
  texto=texto+'P'+'H'+'91'+'TELEFONOS:'+Chr(13) + Chr(10)
  texto=texto+'P'+'H'+'92'+'0414-271.4156 / 0414-90344.45'+Chr(13) + Chr(10)
  texto=texto+'P'+'H'+'93'+'0424-120.95.00'+Chr(13) + Chr(10)
  texto=texto+'P'+'H'+'94'+'e-mail: carnegomez@gmail.com'+Chr(13) + Chr(10)
  *------escribo datos--------
     texto=texto+'101'+Chr(13) + Chr(10)
     gniobytes=FWRITE(gntestfile,texto)    
     glcloseok=Fclose(gntestfile) 
   
**** RETURN 
    
     com1_open= OpenFpctrl('COM1')
     
      IF com1_open#1
         MESSAGEBOX('error, AL ABRIR PUERTO...')
         RETURN
      ENDIF

*------envio datos a impresora  
  
  SendFileCmd(@lstatus,@lerror,warchivo) 
  com1_close=closefpctrl() 

RETURN

*!*	*--capturo datos fiscal ------------------------
*!*	wnro_arch=0
*!*	FOR wnro_arch=0 TO 10000
*!*	    wnro=ALLTRIM(TRANSFORM(wnro_arch,'999999'))
*!*	    warchivo='d:\fac_fis\output'+wnro+'.dat'
*!*	    IF FILE(warchivo)=.f.
*!*	       gntestfile1=Fcreate(warchivo) 
*!*	       EXIT  
*!*	     ENDIF
*!*	ENDFOR 
*!*	*-------------------------------
*!*	   texto1='' + Chr(13) + Chr(10)
*!*	   gniobytes=FWRITE(gntestfile1,texto1)   
*!*	   glcloseok1=Fclose(gntestfile1) 
*!*	   com1_open= OpenFpctrl('COM1')
*!*	   
*!*	   IF com1_open#1
*!*	     MESSAGEBOX('error')
*!*	     RETURN
*!*	   ENDIF
*!*	   
*!*	   cmd='S1' 
*!*	   uploadstatuscmd(@lstatus,@lerror,@cmd,warchivo) 
*!*	   com1_close=closefpctrl() 
*!*	*------------------------------ 
*!*	  *gntestfile1=FOPEN('c:\input1.dat',2)
*!*	   gntestfile1=FOPEN(warchivo,2)
*!*	   gniobytes=fgets(gntestfile1,texto1) 
*!*	*------variables para guardar----
*!*	 
*!*	   wfac_fis=SUBSTR(gniobytes,22,8)
*!*	   whor_fis=SUBSTR(gniobytes,77,6)
*!*	   wfec=SUBSTR(gniobytes,83,6)
*!*	   wfec_fis=CTOD(SUBSTR(wfec,1,2) +'/' + SUBSTR(wfec,3,2) +'/'+ SUBSTR(wfec,5,2)) 
*!*	   wmaq_fis=SUBSTR(gniobytes,67,10) 
*!*	   whor_fis=SUBSTR(whor_fis,1,2) + ':' + SUBSTR(whor_fis,3,2) + ':' + SUBSTR(whor_fis,5,2)   
*!*	   
*--------cierro archivo   
*!*	  glcloseok1=Fclose(gntestfile1) 

*-------------------------
*!*	RETURN 
