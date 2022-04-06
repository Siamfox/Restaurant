*****************************************************************
**FUNCTION DETALLE() && MOSTRAR DETALLE ARTICULO 
*****************************************************************

**//No Funciona con Seven
*!*	DEFINE WINDOW wGrande ;
*!*	FROM 0, 40 TO 39, 100 ;
*!*	TITLE "Detalle del Articulo..."         && Principal window
*!*	ACTIVATE WINDOW wGrande 


PUBLIC ofrmListExamples
ofrmListExamples=NEWOBJECT("frmListExamples")
ofrmListExamples.Show
RETURN


DEFINE CLASS frmListExamples AS form

 DataSession = 2
 Top = 0
 Left = 0
 Height = 400
 Width = 400
 Caption = "Detalle del Articulo"
 Name = "frmDetalle"

 ADD OBJECT shape1 AS shape WITH ;
  Top = 3, ;
  Left = 2, ;
  Height = 76, ;
  Width = 360, ;
  SpecialEffect = 0, ;
  Name = "Shape1"


ADD OBJECT lbl1 as label WITH ;
top=4,;
left= 3,;
Caption="Codigo"

ADD OBJECT lbl4 as label WITH ;
top=4,;
left= 80,;
Caption="121..1.1.1."

ADD OBJECT lbl2 as label WITH ;
top=20,;
left= 3,;
Caption="Descripcion"

ADD OBJECT lbl3 as label WITH ;
top=40,;
left= 3,;
Caption="Detalle"




*!*	@ 0,1 say '<BASICOS................................................> ' COLOR W/B+
*!*	@ 1,1 say '<CODIGO............> '+ALLTRIM(B->CODIGO)
*!*	@ 2,1 say '<DESCRIPCION.......> '+ALLTRIM(B->DESCRIP)
*!*	@ 3,1 say '<DESCRIP-DETALLADA.> '+ALLTRIM(B->DESCRIP2)

*!*	@ 7,1 say '<DETALLES...............................................> ' COLOR W/B+
*!*	@ 8,1 say '<MARCA.............> '+ALLTRIM(B->MARCA)
*!*	@ 9,1 say '<MODELO............> '+ALLTRIM(B->MODELO)
*!*	@10,1 say '<TIPO..............> '+ALLTRIM(B->TIPO) 
*!*	@11,1 say '<MEDIDA............> '+ALLTRIM(B->Medida)
*!*	@12,1 say '<COLOR.............> '+ALLTRIM(B->Color)
*!*	@13,1 say '<GARANTIA..........> '+ALLTRIM(B->Garantia)
*!*	@14,1 say '<UNIDAD/UNIDAD_DET.> '+ALLTRIM(B->Unidad)+'/'+ALLTRIM(B->Uni_Det)
*!*	@15,1 say '<CANTIDAD UNIDADES.> '+TRANSFORM(B->Can_Uni,'999,999,999.99')
*!*	@16,1 say '<PRECIO X UNIDAD...> '+TRANSFORM(B->Pre_Uni,'999,999,999.99')
*!*	@17,1 say '<STOCK (MIN/MAX)...> '+TRANSFORM(B->Stockmin,'999,999,999.99')+'/'+ALLTRIM(TRANSFORM(B->Stockmax,'999,999,999.99'))

*!*	@19,1 say '<PRECIOS................................................> ' COLOR W/B+
*!*	@20,1 say '<PRECIO EMPAQUE....> '+TRANSFORM(B->Pvpbul,'999,999,999.99')
*!*	@21,1 say '<PRECIO MAYOR......> '+TRANSFORM(B->Pre1,'999,999,999.99')
*!*	@22,1 say '<PRECIO TECNICO....> '+TRANSFORM(B->Pre2,'999,999,999.99')
*!*	@23,1 say '<PRECIO PVP........> '+TRANSFORM(B->Pre3,'999,999,999.99') 

*!*	@25,1 say '<EXISTENCIAS............................................> ' COLOR W/B+
*!*	@26,10 say '<DP_01>'
*!*	@26,20 say '<DP_02>'
*!*	@26,30 say '<DP_03>'
*!*	@26,40 say '<DP_04>' 
*!*	@27,10 say TRANSFORM(B->Dep_01,'999999.999')
*!*	@27,20 say TRANSFORM(B->Dep_02,'999999.999')
*!*	@27,30 say TRANSFORM(B->Dep_03,'999999.999')
*!*	@27,40 say TRANSFORM(B->Dep_04,'999999.999')
*!*	@28,1 say '<TOTAL> '+TRANSFORM(B->Dep_01+B->Dep_02+B->Dep_03+B->Dep_04,'999,999,999.99')

*!*	@30,1 say '<OTROS..................................................> ' COLOR W/B+
*!*	@31,1 say '<ULT/ACTUALIZACION.> '+DTOC(B->fch_actua)
*!*	@32,1 say '<UBICACION.........> '+ALLTRIM(B->Ubica)
*!*	@33,1 say '<SUSTITUTOS........> '+ALLTRIM(B->Alterno)


*!*	@37,2 say '<Pulse Cualquier Tecla para continuar...................> '
*!*	thisform.nCosto_pro.Refresh
*!*	*!*	thisform.nDscto1.Refresh
*!*	*!*	thisform.nDscto2.Refresh
*!*	thisform.nDscto3.Refresh
*!*	INKEY(0)

*!*	RELEASE WINDOW wGrande
*!*	CLEAR
*RETURN
