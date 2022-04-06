clear

? RedondearMas(123.123,-2) 
? RedondearMenos(123.123,-2)

? RedondearMas(123.123,0) 
? RedondearMenos(123.123,0)
 
? RedondearMas(123.123,1) 
? RedondearMenos(123.123,1)


FUNCTION RedondearMas(tnNro, tnPos) 
  RETURN CEILING(tnNro/10^tnPos)*10^tnPos 
ENDFUNC 

FUNCTION RedondearMenos(tnNro, tnPos) 
  RETURN FLOOR(tnNro/10^tnPos)*10^tnPos 
ENDFUNC 