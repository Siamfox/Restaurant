***clear
*!*	//realizar calculo para una nueva clave de 10 min de duracion
*!*	// valor del minutero+fecha del dia
*!*	// se toman los 6 primeros digitos del proceso y luego se a¤aden 2 ltras
*!*	// segun el salto en la cadenas letras

*!*	// dias   1,  2,  3,  4,  5,  6,  7
*!*	//      dom,lun,mar,mie,jue,vie,sab
*!*	//      Sun,Mon,Tue,Wed,Thu,Fri,Sat

letras='abcdeNOPQRSRUVfghij012345klmnowxyz6789ABCDEFGHpqrstuvIJKLMWXYZabcdeNOPQRSRUVfghij012345klmnowxyz6789ABCDEFGHpqrstuvIJKLMWXYZ'
letras2='GabriellaArianaSamiRaFerNANdoSaraypEDROVIviranporsiemprefelicesasilodecretohoyDios'
valor=substr(time(),1,2)+substr(time(),4,1)+dtos(date())+str(dow(date()))  &&//valor cambia cada 10 min
store 0 to sumafin,suma,con,suma2,salto1,salto2,suma3
cadena=''
for g=1 to dow(date())
    for i=1 to len(valor)
        suma=val(substr(valor,i,1)) + val(substr(valor,i+1,1))
        cadena=cadena+alltrim(str(suma))
    next i
    store cadena to valor, sumafin
    cadena=''
next g

for  j=1 to len(sumafin)
     suma2=val(substr(sumafin,j,1)) + val(substr(sumafin,j+1,1))
     salto1=salto1+suma2
next j

for  J=len(sumafin) to 1 step -2
     suma3=val(substr(sumafin,j,1)) + val(substr(sumafin,j-1,1))
     salto2=salto2+suma3
next j

salto1=salto1-salto2
salto2=salto2-salto1

retorno=substr(letras,salto1,1)+substr(sumafin,4,3)+substr(letras,salto2,1)+substr(sumafin,1,3)+;
	   '-'+substr(letras2,salto2,1)+substr(sumafin,4,3)+substr(letras2,salto1,1)+substr(sumafin,1,3)

RETURN 
