** Creo un Cursor con los datos del Menu,
** puede ser una tabla ya predefinida

CREATE CURSOR cMiMenu (Nivel C(20),Nombre C(50), DoWhat C(90))

** nivel = ####_ (separo con "_" cada 4 digitos
**         para identificar a que nivel pertenece

** nombre = el nombre que quiero asignar a ese nodo en el menu

** dowhath = que comando quiero ejecutar con el dobleclick, lo ideal
**           es que solo los hijos finales tengan algo, pero ...

** se pueden agregar mas campos, como por ej: imagen, parametros, usuarios, etc
INSERT INTO  cMiMenu (Nivel, Nombre, DoWhat) ;
 VALUES ('0001_', 'Padre 1', ' ')
INSERT INTO  cMiMenu (Nivel, Nombre, DoWhat) ;
 VALUES ('0002_', 'Padre 2', ' ')
INSERT INTO  cMiMenu (Nivel, Nombre, DoWhat) ;
 VALUES ('0001_0001_', 'Hijo 1', 'DO FORM \FRM\Hijo1.scx')
INSERT INTO  cMiMenu (Nivel, Nombre, DoWhat) ;
 VALUES ('0002_0001_','Hijo 2',' ')
INSERT INTO  cMiMenu (Nivel, Nombre, DoWhat) ;
 VALUES ('0002_0001_0001_', 'Hijo de Hijo 2', 'DO \PRG\hijo_de_hijo2.prg')


PUBLIC oForm
oForm = NEWOBJECT("Form1")
oForm.SHOW

DEFINE CLASS Form1 AS FORM

 TOP = 10
 LEFT = 100
 HEIGHT = 360
 WIDTH = 360
 DOCREATE = .T.
 CAPTION = "Menu con TreeView y DobleClick"
 NAME = "Form1"
 MINWIDTH = 100
 MINHEIGHT = 100

 ADD OBJECT Olecontrol1 AS OLECONTROL WITH ;
   TOP = 10, LEFT = 10, HEIGHT = 340, WIDTH = 340, ;
   NAME = "Olecontrol1", OLECLASS = "MSComctlLib.TreeCtrl.2"

 PROCEDURE Olecontrol1.DBLCLICK
   SELECT cMiMenu
   LOCATE FOR cMiMenu.Nivel = THIS.SELECTEDITEM.KEY
   IF FOUND()
     IF LEN(ALLTRIM(cMiMenu.DoWhat)) > 1
       WAIT WINDOW + cMiMenu.DoWhat
     ENDIF
   ENDIF
 ENDPROC

 PROCEDURE RESIZE
   THIS.Olecontrol1.WIDTH = THIS.WIDTH - 20
   THIS.Olecontrol1.HEIGHT = THIS.HEIGHT - 20
 ENDPROC

 PROCEDURE Olecontrol1.INIT
   LOCAL lcNivel,lcTexto,lnTipo,lnResta
   THISFORM.Olecontrol1.LineStyle = 1
   THISFORM.Olecontrol1.LabelEdit = 1
   THISFORM.Olecontrol1.FullRowSelect = .T.
   THISFORM.Olecontrol1.HotTracking = .T.
   SELECT cMiMenu
   GO TOP
   DO WHILE !EOF()
     lcNivel = ALLTRIM(cMiMenu.Nivel)
     lcTexto = ALLTRIM(cMiMenu.Nombre)
     IF LEN(ALLTRIM(lcNivel)) = 5
       ** Cuando el valor del LEN() = 5 asumo que es un nodo raiz
       lnTipo = 0
       THISFORM.Olecontrol1.Nodes.ADD(, lnTipo, lcNivel, lcTexto,,)
     ELSE
       ** si LEN() > 5 es un hijo, siempre multiplos de 5
       lnTipo=4
       lnResta = LEN(ALLTRIM(Nivel)) - 5
       lcKey = SUBSTR(ALLTRIM(lcNivel), 1, lnResta)
       THISFORM.Olecontrol1.Nodes.ADD(lcKey, lnTipo, lcNivel, lcTexto,,)
     ENDIF
     SKIP
   ENDDO
 ENDPROC

ENDDEFINE
