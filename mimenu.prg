PUBLIC goMiForm
goMiForm=CREATEOBJECT("MiForm")
goMiForm.SHOW(1)
RETURN
*---
*--- Definición de MiForm
*---
DEFINE CLASS MiForm AS FORM
SHOWWINDOW = 2
DOCREATE = .T.
AUTOCENTER = .T.
CAPTION = "Ejemplo de menú en un formulario SDI"
NAME = "MiForm"

PROCEDURE INIT
*DO MiMenu.mpr WITH Thisform, .T.
DO MiMenuEjemplo WITH THISFORM, .T.
ENDPROC

PROCEDURE DESTROY
RELEASE MENU (THIS.NAME) EXTENDED
ENDPROC
ENDDEFINE
*---
*--- MiMenuEjemplo.spr
*---
PROCEDURE MiMenuEjemplo
LPARAMETERS oFormRef, getMenuName, lUniquePopups
LOCAL cMenuName, nTotPops, a_menupops, cTypeParm2, cSaveFormName
IF TYPE("m.oFormRef") # "O" OR ;
LOWER(m.oFormRef.BASECLASS) # 'form' OR ;
m.oFormRef.SHOWWINDOW # 2
MESSAGEBOX([Este menú solo puede ser llamado en un formulario de nivel superior])
RETURN
ENDIF
m.cTypeParm2 = TYPE("m.getMenuName")
m.cMenuName = SYS(2015)
m.cSaveFormName = m.oFormRef.NAME
IF m.cTypeParm2 = "C" OR (m.cTypeParm2 = "L" AND m.getMenuName)
m.oFormRef.NAME = m.cMenuName
ENDIF
IF m.cTypeParm2 = "C" AND !EMPTY(m.getMenuName)
m.cMenuName = m.getMenuName
ENDIF
DIMENSION a_menupops[3]
IF TYPE("m.lUniquePopups")="L" AND m.lUniquePopups
FOR nTotPops = 1 TO ALEN(a_menupops)
a_menupops[m.nTotPops]= SYS(2015)
ENDFOR
ELSE
a_menupops[1]="archivo"
a_menupops[2]="edición"
a_menupops[3]="ayuda"
ENDIF
*---
*--- Definición del menú
*---
DEFINE MENU (m.cMenuName) IN (m.oFormRef.NAME) BAR
DEFINE PAD _1mv0kg6re OF (m.cMenuName) PROMPT "\ DEFINE PAD _1mv0kg6rf OF (m.cMenuName) PROMPT "\ DEFINE PAD _1mv0kg6rg OF (m.cMenuName) PROMPT "A\ ON PAD _1mv0kg6re OF (m.cMenuName) ACTIVATE POPUP (a_menupops[1])
ON PAD _1mv0kg6rf OF (m.cMenuName) ACTIVATE POPUP (a_menupops[2])
ON PAD _1mv0kg6rg OF (m.cMenuName) ACTIVATE POPUP (a_menupops[3])

DEFINE POPUP (a_menupops[1]) MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF (a_menupops[1]) PROMPT "\ DEFINE BAR 2 OF (a_menupops[1]) PROMPT "\ DEFINE BAR 3 OF (a_menupops[1]) PROMPT "\-"
DEFINE BAR 4 OF (a_menupops[1]) PROMPT "\ DEFINE BAR 5 OF (a_menupops[1]) PROMPT "\ DEFINE BAR 6 OF (a_menupops[1]) PROMPT "\ DEFINE BAR 7 OF (a_menupops[1]) PROMPT "\-"
DEFINE BAR 8 OF (a_menupops[1]) PROMPT "\ ON SELECTION BAR 8 OF (a_menupops[1]) DO _Salir

DEFINE POPUP (a_menupops[2]) MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF (a_menupops[2]) PROMPT "\ DEFINE BAR 2 OF (a_menupops[2]) PROMPT "\-"
DEFINE BAR 3 OF (a_menupops[2]) PROMPT "Cor\ DEFINE BAR 4 OF (a_menupops[2]) PROMPT "\ DEFINE BAR 5 OF (a_menupops[2]) PROMPT "\
DEFINE POPUP (a_menupops[3]) MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF (a_menupops[3]) PROMPT "\ DEFINE BAR 2 OF (a_menupops[3]) PROMPT "\-"
DEFINE BAR 3 OF (a_menupops[3]) PROMPT "Acerca \
ACTIVATE MENU (m.cMenuName) NOWAIT

IF m.cTypeParm2 = "C"
m.getMenuName = m.cMenuName
m.oFormRef.NAME = m.cSaveFormName
ENDIF
ENDPROC

PROCEDURE _Salir
_SCREEN.ACTIVEFORM.RELEASE
ENDPROC