*!*	p.ej:
*!*	gDatosGrid(thisform.pageframe.page1.grid1)  && desde cualquier lugar del form

*!*	gDatosGrid(this.grid1)       && desde el activate de pageframe.page1

*!*	*----------------------------------------
*!*	procedure gDatosGrid(oGrid)
*!*	* ----------------------------------------
PARAMETERS oGrid
IF VARTYPE(oGrid)#"O"
	RETURN
ENDIF
LOCAL ni,lcFile,lcResp

lcFile=oGrid.RecordSource
IF EMPTY(lcFile)
	RETURN
ENDIF
IF RECCOUNT(lcFile)=0
	RETURN
ENDIF

ni=0
FOR EACH ocolumn IN oGrid.Columns
	ni=ni+1
	lcCurrent=oColumn.CurrentControl
	lndVal=ogrid.Columns[ni].&lcCurrent..Value
	lcVartype=VARTYPE(lndVal)
	DO case
		CASE EMPTY(lndVal)
			lcResp="empty"
		CASE lcVartype="C"
			lcResp=lndVal
		CASE lcVArtype$'IN'
			lcResp=TRANSFORM(lndVal)
		CASE lcVartype="D"
			lcResp=DTOC(lndVal)
		CASE lcVartype="T"
			lcResp=TTOC(lndVal)
		CASE lcVartype="L"
			lcResp=TRANSFORM(lndVal,"Y")
		ENDCASE
*!*		MESSAGEBOX("Cursor="+lcFile+CHR(13);
*!*			+oColumn.name+"="+lcResp)
ENDFOR