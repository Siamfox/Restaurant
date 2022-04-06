************************
*
Procedure RefreshMe
LPARAMETERS oContainer
*++
*>>Recursive method to refresh bound controls in the specified container.
*--
LOCAL ix, oThis, oFrm, nControlCount, cType, nCol

nControlCount = 0
IF TYPE("m.oContainer.CONTROLCOUNT") = "N"
	nControlCount = m.oContainer.CONTROLCOUNT
	cType = "C"
ELSE
	IF TYPE("m.oContainer.PageCount") = "N"
		nControlCount = m.oContainer.PAGECOUNT
		cType = "P"
	ENDIF
ENDIF
FOR ix = 1 TO nControlCount
	IF cType = "C"
		m.oThis = m.oContainer.CONTROLS[m.ix]
	ELSE
		IF cType = "P"
			m.oThis = m.oContainer.PAGES[m.ix]
		ENDIF
	ENDIF
	DO CASE
		CASE m.oThis.BASECLASS == 'Container'
			m.oThis.REFRESH()
			RefreshMe(m.oThis)
		CASE m.oThis.BASECLASS == 'Pageframe'
			* Refresh only the active page in a pageframe. Other page
			* contents will refresh when their page is activated.
			LOCAL nPage
			FOR nPage = 1 TO m.oThis.PAGECOUNT
				IF m.oThis.PAGES[m.nPage].PAGEORDER = m.oThis.ACTIVEPAGE
					RefreshMe(m.oThis.PAGES[m.nPage])
					EXIT
				ENDIF
			ENDFOR

		CASE m.oThis.BASECLASS == 'Grid'
			FOR nCol = 1 TO m.oThis.COLUMNCOUNT
				RefreshMe(m.oThis.COLUMNS[m.nCol])
			ENDFOR
			
		OTHERWISE			
			IF PEMSTATUS(m.oThis, 'Refresh', 5) 
				m.oThis.REFRESH()
			ENDIF 
	ENDCASE
ENDFOR