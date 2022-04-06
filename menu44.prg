SET SYSMENU TO

SET SYSMENU AUTOMATIC

DO MenuHorizontal

READ EVENTS

SET SYSMENU TO DEFAULT

*---

PROCEDURE MenuHorizontal

  DEFINE PAD PadArchivo OF _MSYSMENU ;

    PROMPT "\<Archivo" KEY ALT+A

  DEFINE PAD PadEdicion OF _MSYSMENU ;

    PROMPT "\<Edicion" KEY ALT+E

  ON PAD PadArchivo OF _MSYSMENU ;

    ACTIVATE POPUP PopArchivo

  ON PAD PadEdicion OF _MSYSMENU ;

    ACTIVATE POPUP PopEdicion

  *---

  DEFINE POPUP PopArchivo MARGIN RELATIVE SHADOW

  DEFINE BAR 1 OF PopArchivo ;

    PROMPT "\<Nuevo" PICTRES _MFI_NEW

  DEFINE BAR 2 OF PopArchivo ;

    PROMPT "\<Abrir" PICTRES _MFI_OPEN

  DEFINE BAR 3 OF PopArchivo ;

    PROMPT "\<Salir" PICTRES _MFI_QUIT

  DEFINE BAR 4 OF PopArchivo ;

    PROMPT "\|\<Guardar" PICTRES _MFI_SAVE

  DEFINE BAR 5 OF PopArchivo ;

    PROMPT "Guardar \<como" PICTRES _MFI_SAVAS

  DEFINE BAR 6 OF PopArchivo ;

    PROMPT "Guardar como \<HTML" PICTRES _mfi_saveashtml

  DEFINE BAR 7 OF PopArchivo ;

    PROMPT "\|\<Vista preliminar" PICTRES _MFI_PREVU

  DEFINE BAR 8 OF PopArchivo ;

    PROMPT "\<Imprimir" PICTRES _mfi_sysprint

  DEFINE BAR 9 OF PopArchivo ;

    PROMPT "\<Enviar" PICTRES _MFI_SEND

  ON SELECTION BAR 3 OF PopArchivo CLEAR EVENTS

  *---

  DEFINE POPUP PopEdicion MARGIN RELATIVE SHADOW

  DEFINE BAR 1 OF PopEdicion ;

    PROMPT "\|\<Copiar" PICTRES _MED_COPY

  DEFINE BAR 2 OF PopEdicion ;

    PROMPT "\|Cor\<tar" PICTRES _MED_CUT

  DEFINE BAR 3 OF PopEdicion ;

    PROMPT "\|\<Pegar" PICTRES _MED_PASTE

  DEFINE BAR 4 OF PopEdicion ;

    PROMPT "\|\<Deshacer" PICTRES _MED_UNDO

  DEFINE BAR 5 OF PopEdicion ;

    PROMPT "\|\<Rehacer" PICTRES _MED_REDO

ENDPROC
