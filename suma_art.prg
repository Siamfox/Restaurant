***************************************************************
**FUNCTION SUMAITEM() && Contador de Item Solo Pto. de Ventas
***************************************************************
nArt=0
SELECT 10
GO top
DO WHILE !EOF()
	nArt=nArt+cantidad
	SKIP 1
ENDDO
RETURN



