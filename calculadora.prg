*:******************************************************************************
*:   CALCULATOR
*:******************************************************************************


Public oCal

oCal = Createobject("Calculator")
oCal.Show


#Define CRLF            Chr(13)+Chr(10)
#Define BUTTONBACKCOLOR Rgb(236,233,216)

**************************************************
*-- Class:        calc (d:\all_zapl\lib\mc_win95.vcx)
*-- ParentClass:  form
*-- BaseClass:    form
*:******************************************************************************
*:
*: Class:CALCULATOR  BaseClass: Form
*:
*:******************************************************************************
Define Class CALCULATOR As Form


	Top                    = 0
	Left                   = 0
	Height                 = 340
	Width                  = 189
	DoCreate               = .T.
	ShowTips               = .T.
	BorderStyle            = 3
	Caption                = "Calculadora"
	ControlBox             = .F.
	Closable               = .F.
	FontSize               = 8
	MaxButton              = .F.
	MinButton              = .F.
	MaxWidth               = 189
	MinHeight              = 340
	MinWidth               = 189
	KeyPreview             = .T.
	*BackColor              = Rgb(116,116,116)
	BackColor              = Rgb(236,233,216)
	memoval                = 0
	result                 = 0
	znak                   = []
	br_rows                = 0
	nbracketsopened        = 0
	AddEnterValueToHistory = .T.
	frmActiveControl       = Null
	ActiveFormDatasession  = ""
	Name                   = "calc"
	blockade               = .F.
	fl_znak                = .F.
	memoclick              = .F.
	old_num                = .F.

	Add Object b7 As CommandButton With ;
		Top = 231, ;
		Left = 40, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "7", ;
		TabIndex = 10, ;
		ToolTipText = ['Tecla de Acceso Rapido - "7"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(0,0,255), ;
		Name = "B7"


	Add Object b8 As CommandButton With ;
		Top = 231, ;
		Left = 68, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "8", ;
		TabIndex = 11, ;
		ToolTipText = ['Tecla de Acceso Rapido - "8"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(0,0,255), ;
		Name = "B8"


	Add Object b9 As CommandButton With ;
		Top = 231, ;
		Left = 96, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "9", ;
		TabIndex = 12, ;
		ToolTipText = ['Tecla de Acceso Rapido - "9"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(0,0,255), ;
		Name = "B9"


	Add Object b4 As CommandButton With ;
		Top = 257, ;
		Left = 40, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "4", ;
		TabIndex = 7, ;
		ToolTipText = ['Tecla de Acceso Rapido - "4"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(0,0,255), ;
		Name = "B4"


	Add Object b5 As CommandButton With ;
		Top = 257, ;
		Left = 68, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "5", ;
		TabIndex = 8, ;
		ToolTipText = ['Tecla de Acceso Rapido - "5"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(0,0,255), ;
		Name = "B5"


	Add Object b6 As CommandButton With ;
		Top = 257, ;
		Left = 96, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "6", ;
		TabIndex = 9, ;
		ToolTipText = ['Tecla de Acceso Rapido - "6"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(0,0,255), ;
		Name = "B6"


	Add Object b1 As CommandButton With ;
		Top = 283, ;
		Left = 40, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "1", ;
		TabIndex = 4, ;
		ToolTipText = ['Tecla de Acceso Rapido - "1"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(0,0,255), ;
		Name = "B1"


	Add Object b2 As CommandButton With ;
		Top = 283, ;
		Left = 68, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "2", ;
		TabIndex = 5, ;
		ToolTipText = ['Tecla de Acceso Rapido - "2"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(0,0,255), ;
		Name = "B2"


	Add Object b3 As CommandButton With ;
		Top = 283, ;
		Left = 96, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "3", ;
		TabIndex = 6, ;
		ToolTipText = ['Tecla de Acceso Rapido - "3"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(0,0,255), ;
		Name = "B3"


	Add Object b0 As CommandButton With ;
		Top = 309, ;
		Left = 40, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "0", ;
		TabIndex = 1, ;
		ToolTipText = ['Tecla de Acceso Rapido - "0"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(0,0,255), ;
		Name = "B0"


	Add Object b00 As CommandButton With ;
		Top = 309, ;
		Left = 68, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "00", ;
		TabIndex = 2, ;
		ToolTipText = ['Tecla de Acceso Rapido - Shift+"0"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(0,0,255), ;
		Name = "B00"


	Add Object plus As CommandButton With ;
		Top = 283, ;
		Left = 129, ;
		Height = 51, ;
		Width = 25, ;
		Caption = "+", ;
		TabIndex = 13, ;
		ToolTipText = ['Tecla de Acceso Rapido - "+"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,255), ;
		Name = "PLUS"


	Add Object Minus As CommandButton With ;
		Top = 257, ;
		Left = 129, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "-", ;
		TabIndex = 15, ;
		ToolTipText = ['Tecla de Acceso Rapido - "-"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,255), ;
		Name = "MINUS"


	Add Object Multi As CommandButton With ;
		Top = 231, ;
		Left = 129, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "*", ;
		TabIndex = 17, ;
		ToolTipText = ['Tecla de Acceso Rapido - "*"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,255), ;
		Name = "MULTI"


	Add Object divide As CommandButton With ;
		Top = 257, ;
		Left = 157, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "/", ;
		TabIndex = 16, ;
		ToolTipText = ['Tecla de Acceso Rapido - "/"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,255), ;
		Name = "DIVIDE"


	Add Object memorecall As CommandButton With ;
		Top = 205, ;
		Left = 40, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "MR", ;
		TabIndex = 23, ;
		ToolTipText = ['Tecla de Acceso Rapido - "R"'], ;
		SpecialEffect = 1, ;
		Name = "MEMORECALL"


	Add Object memominus As CommandButton With ;
		Top = 205, ;
		Left = 68, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "M-", ;
		TabIndex = 21, ;
		ToolTipText = ['Tecla de Acceso Rapido - "M"'], ;
		SpecialEffect = 1, ;
		Name = "MEMOMINUS"


	Add Object memoplus As CommandButton With ;
		Top = 205, ;
		Left = 96, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "M+", ;
		TabIndex = 22, ;
		ToolTipText = ['Tecla de Acceso Rapido - "P"'], ;
		SpecialEffect = 1, ;
		Name = "MEMOPLUS"


	Add Object percent As CommandButton With ;
		Top = 205, ;
		Left = 157, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "%", ;
		TabIndex = 19, ;
		ToolTipText = ['Tecla de Acceso Rapido - "%"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,255), ;
		Name = "PERCENT"


	Add Object bpoint As CommandButton With ;
		Top = 309, ;
		Left = 96, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = ".", ;
		TabIndex = 3, ;
		ToolTipText = ['Tecla de Acceso Rapido - "." or ","'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(0,0,255), ;
		Name = "BPOINT"


	Add Object ac As CommandButton With ;
		Top = 205, ;
		Left = 6, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "AC", ;
		TabIndex = 27, ;
		ToolTipText = ['Tecla de Acceso Rapido - "A"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,0), ;
		Name = "AC"


	Add Object Off As CommandButton With ;
		Top = 231, ;
		Left = 6, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "OFF", ;
		TabIndex = 26, ;
		ToolTipText = ['Tecla de Acceso Rapido - "O"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,0), ;
		Name = "OFF"


	Add Object Back As CommandButton With ;
		Top = 257, ;
		Left = 6, ;
		Height = 25, ;
		Width = 25, ;
		FontName = "Symbol", ;
		FontSize = 8, ;
		Caption = (Chr(172)), ;
		TabIndex = 25, ;
		ToolTipText = "Tecla de Acceso Rapido - BackSpace", ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,0), ;
		Name = "BACK"


	Add Object bc As CommandButton With ;
		Top = 283, ;
		Left = 6, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "C", ;
		TabIndex = 24, ;
		ToolTipText = ['Tecla de Acceso Rapido - "C"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,0), ;
		Name = "BC"


	Add Object equal As CommandButton With ;
		Top = 283, ;
		Left = 157, ;
		Height = 51, ;
		Width = 25, ;
		Caption = (Alltrim("=")), ;
		TabIndex = 14, ;
		ToolTipText = ['Tecla de Acceso Rapido - "=" or Enter'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,255), ;
		Name = "EQUAL"


	Add Object plusminus As CommandButton With ;
		Top = 205, ;
		Left = 129, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "+/-", ;
		TabIndex = 20, ;
		ToolTipText = ['Tecla de Acceso Rapido - "S"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,255), ;
		Name = "PLUSMINUS"


	Add Object Sqrt As CommandButton With ;
		Top = 231, ;
		Left = 157, ;
		Height = 25, ;
		Width = 25, ;
		FontName = "Symbol", ;
		FontSize = 8, ;
		Caption = "�", ;
		TabIndex = 18, ;
		ToolTipText = ['Tecla de Acceso Rapido - "\"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,255), ;
		Name = "SQRT"


	Add Object Enter As TextBox With ;
		Alignment = 1, ;
		Enabled = .F., ;
		Height = 22, ;
		Left = 40, ;
		TabIndex = 29, ;
		Top = 154, ;
		Width = 142, ;
		DisabledBackColor = Rgb(170,170,255), ;
		DisabledForeColor = Rgb(0,0,0), ;
		Name = "Enter"


	Add Object text1 As TextBox With ;
		FontSize = 8, ;
		Alignment = 2, ;
		Enabled = .F., ;
		Height = 22, ;
		Left = 6, ;
		TabIndex = 30, ;
		Top = 154, ;
		Width = 27, ;
		DisabledBackColor = Rgb(192,192,192), ;
		DisabledForeColor = Rgb(0,0,0), ;
		Name = "Text1"


	Add Object lenta As EditBox With ;
		Alignment = 1, ;
		Height = 136, ;
		Left = 6, ;
		ReadOnly = .T., ;
		ScrollBars = 0, ;
		TabStop = .F., ;
		Top = 11, ;
		Width = 177, ;
		DisabledBackColor = Rgb(170,170,255), ;
		DisabledForeColor = Rgb(0,0,0), ;
		Name = "Lenta"


	Add Object fillbutt As CommandButton With ;
		Top = 309, ;
		Left = 6, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "F", ;
		TabIndex = 24, ;
		ToolTipText = "", ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,0), ;
		Name = "FILLBUTT"


	Add Object rightbracket As CommandButton With ;
		Top = 179, ;
		Left = 96, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = ")", ;
		TabIndex = 19, ;
		ToolTipText = ['Tecla de Acceso Rapido - ")"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,255), ;
		Name = "RightBracket"


	Add Object leftbracket As CommandButton With ;
		Top = 179, ;
		Left = 68, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "(", ;
		TabIndex = 20, ;
		ToolTipText = ['Tecla de Acceso Rapido - "("'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,255), ;
		Name = "LeftBracket"


	Add Object text2 As TextBox With ;
		FontSize = 8, ;
		Alignment = 2, ;
		Enabled = .F., ;
		Height = 25, ;
		Left = 6, ;
		TabIndex = 30, ;
		Top = 179, ;
		Width = 59, ;
		DisabledBackColor = Rgb(192,192,192), ;
		DisabledForeColor = Rgb(0,0,0), ;
		Name = "Text2"


	Add Object Command3 As CommandButton With ;
		Top = 179, ;
		Left = 157, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "x^y", ;
		TabIndex = 19, ;
		ToolTipText = ['Tecla de Acceso Rapido - "^"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,255), ;
		Name = "Command3"


	Add Object power2 As CommandButton With ;
		Top = 179, ;
		Left = 129, ;
		Height = 25, ;
		Width = 25, ;
		FontSize = 8, ;
		Caption = "x^2", ;
		TabIndex = 20, ;
		ToolTipText = ['Tecla de Acceso Rapido - "X"'], ;
		SpecialEffect = 1, ;
		ForeColor = Rgb(255,0,255), ;
		Name = "Power2"


	Procedure Calculate
		Do Case
		Case Thisform.znak == "*"
			Thisform.result = Thisform.result * Val(Thisform.Enter.Value)
		Case Thisform.znak == "^"
			Thisform.result = Thisform.result ^ Val(Thisform.Enter.Value)
		Case Thisform.znak == "+"
			Thisform.result = Thisform.result + Val(Thisform.Enter.Value)
		Case Thisform.znak == "-"
			Thisform.result = Thisform.result - Val(Thisform.Enter.Value)
		Case Thisform.znak == "/"
			Thisform.result = Thisform.result / Val(Thisform.Enter.Value)
		Case Thisform.znak == "*%"
			Thisform.result = Thisform.result * Val(Thisform.Enter.Value) / 100
		Case Thisform.znak == "+%"
			Thisform.result = Thisform.result + (Thisform.result*Val(Thisform.Enter.Value) / 100)
		Case Thisform.znak == "-%"
			Thisform.result = Thisform.result - (Thisform.result*Val(Thisform.Enter.Value) / 100)
		Case Thisform.znak == "/%"
			Thisform.result = Thisform.result / Val(Thisform.Enter.Value) / 100
		Endcase
		Thisform.Enter.Value = Transform(Thisform.result)
		Thisform.fl_znak     = .F.
	Endproc


	Procedure makelenta
		Lparameters lcZnak

		If This.br_rows = 0
			This.lenta.Value = Alltrim(This.Enter.Value) + " " + m.lcZnak
		Else
			If Thisform.AddEnterValueToHistory
				This.lenta.Value = This.lenta.Value + CRLF + Alltrim(This.Enter.Value) + " " + m.lcZnak
			Else
				This.lenta.Value = This.lenta.Value + " " + m.lcZnak
			Endif
		Endif
		Thisform.AddEnterValueToHistory = .T.
		This.br_rows                    = This.br_rows + 1
		This.ControlScroll(This.lenta)
	Endproc


	Procedure pressdidit
		Lparameters lcDigit
		Thisform.memoclick = .F.
		If .Not. Thisform.blockade
			If .Not. Thisform.fl_znak
				Thisform.Enter.Value = lcDigit
				Thisform.fl_znak     = .T.
			Else
				If (Len(Thisform.Enter.Value) < 16 And Thisform.nbracketsopened == 0) Or;
						thisform.nbracketsopened # 0
					Thisform.Enter.Value = Thisform.Enter.Value + m.lcDigit
				Endif
			Endif
		Endif
	Endproc


	Procedure signpress
		Lparameters lcSign
		If .Not. Thisform.blockade
			If Thisform.nbracketsopened # 0
				If Not Thisform.Checkentervalue()
					Thisform.Enter.Value = Thisform.Enter.Value + m.lcSign
				Endif
			Else
				Thisform.memoclick = .F.
				Thisform.makelenta(m.lcSign)
				If Empty(Thisform.znak)
					Thisform.result = Val(Thisform.Enter.Value)
				Else
					Thisform.Calculate()
				Endif
				Thisform.znak    = m.lcSign
				Thisform.fl_znak = .F.
			Endif
		Endif
	Endproc


	Procedure ControlScroll
		Lparameters oControl
		Local lnLen, lnSels
		If Int(oControl.Height/17) < This.br_rows
			oControl.ScrollBars = 2
			m.lnLen  = Len(oControl.Value)
			m.lnSels = Rat(Chr(10),oControl.Value)
		Else
			oControl.ScrollBars = 0
			m.lnLen             = 0
			m.lnSels            = 0
		Endif
		oControl.SelStart  = m.lnSels + 1
		oControl.SelLength = m.lnLen  - m.lnSels
	Endproc


	Procedure nbracketsopened_assign
		Lparameters vNewVal
		Local lnEval
		*To do: Modify this routine for the Assign method
		This.nbracketsopened = m.vNewVal
		If m.vNewVal == 0
			If Not Empty(Thisform.Enter.Value)
				*		      TRY
				m.lnEval = Thisform.Enter.Value
				m.lnEval = Evaluate(m.lnEval)
				Thisform.Enter.Value = Thisform.Enter.Value + " = " +Transform(m.lnEval)
				If Not Empty(Thisform.znak)
					Thisform.makelenta("=")
					Thisform.Enter.Value = Transform(m.lnEval)
					Thisform.Calculate()
				Else
					Thisform.result      = Thisform.result      + m.lnEval
					Thisform.znak        = "x"
				Endif
				*		      CATCH
				Thisform.Enter.Value = "ERROR"
				*		      ENDTRY
				Thisform.makelenta("")
				Thisform.AddEnterValueToHistory = .F.
			Endif
			Thisform.text2.Value = ""
		Else
			Thisform.text2.Value = "(="+Transform(m.vNewVal)
		Endif
	Endproc


	Procedure Checkentervalue
		Return (Right(Thisform.Enter.Value,1) $ "+-*/^" Or Right(Thisform.Enter.Value,5) == "SQRT(")
	Endproc


	Procedure fillresulttocontrol
		Lparameters lnWhatClassToFill, lbonlyEditBox

		If Type("this.frmActiveControl") = [O] And;
				NOT Isnull(This.frmActiveControl)
			m.lnDataSession = Set("Datasession")
			Set DataSession To This.ActiveFormDatasession
			Do Case
			Case Not This.frmActiveControl.Enabled  Or;
					this.frmActiveControl.ReadOnly
				*** Control is ReadOnly or Disabled (I doubt the ActiveControl can be disabled, but just for insurance)
				*** So we don't suppose change the value

			Case Vartype(This.frmActiveControl.Value) == "N" And Not m.lbonlyEditBox
				Do Case
				Case PEMSTATUS(This.frmActiveControl,"InputMask",5) And;
						NOT Empty(This.frmActiveControl.InputMask)     And;
						"*" $ Transform(m.lnWhatClassToFill,This.frmActiveControl.InputMask)
					*** Do Nothing, Result overflow inputmask

				Case Not Empty(This.frmActiveControl.ControlSource) And;
						LEN(Transform(Evaluate(This.frmActiveControl.ControlSource))) < Len(m.lnWhatClassToFill)
					*** Again do nothing, Result oveflow the length of the field assosiated with the textbox
				Otherwise
					This.frmActiveControl.Value = Val(m.lnWhatClassToFill)
				Endcase
			Case Vartype(This.frmActiveControl.Value) == "C"

				m.lnSelStart  = This.frmActiveControl.SelStart
				m.lnSelLength = This.frmActiveControl.SelLength
				Store "" To m.lcBeginControlSourceValue, m.lcEndControlSourceValue
				If Not Empty(This.frmActiveControl.ControlSource)
					m.lcBeginControlSourceValue = Evaluate(This.frmActiveControl.ControlSource)
					m.lcEndControlSourceValue   = Substr(m.lcBeginControlSourceValue,m.lnSelStart + m.lnSelLength + 1)
					m.lcBeginControlSourceValue = Left(m.lcBeginControlSourceValue,m.lnSelStart)
				Endif

				Do Case
				Case PEMSTATUS(This.frmActiveControl,"InputMask",5) And;
						NOT Empty(This.frmActiveControl.InputMask)     And;
						"*" $ Transform(Val(m.lnWhatClassToFill),This.frmActiveControl.InputMask)
					*** Do Nothing, Result overflow inputmask

				Case Not Empty(This.frmActiveControl.ControlSource)                                 And;
						LEN(lcBeginControlSourceValue+lcEndControlSourceValue+m.lnWhatClassToFill) > Len(Evaluate(This.frmActiveControl.ControlSource)) And;
						TYPE(This.frmActiveControl.ControlSource) == "C" && Otherwise is Memo and we can store the result there
					*** Again do nothing, Result oveflow the length of the field assosiated with the textbox

				Case This.frmActiveControl.MaxLength # 0            And;
						this.frmActiveControl.MaxLength  < Len(m.lnWhatClassToFill)
					*** Again do nothing, Result oveflow the MaxLength of the control
				Otherwise
					If PEMSTATUS(This.frmActiveControl,"InputMask",5) And;
							NOT Empty(This.frmActiveControl.InputMask)
						m.lcInputMask = This.frmActiveControl.InputMask
						If Not Empty(This.frmActiveControl.Format)
							m.lcInputMask = [@]+This.frmActiveControl.Format+[ ]+This.frmActiveControl.InputMask
						Endif
						m.lcValueOfresult = Transform(Val(m.lnWhatClassToFill),m.lcInputMask)
					Else
						m.lcValueOfresult = m.lnWhatClassToFill
					Endif
					If Not m.lbonlyEditBox Or (m.lbonlyEditBox And Upper(This.frmActiveControl.BaseClass)=="EDITBOX")
						This.frmActiveControl.Value    = m.lcBeginControlSourceValue + m.lcValueOfresult + m.lcEndControlSourceValue
						This.frmActiveControl.Refresh()
						This.frmActiveControl.SelStart = m.lnSelStart
						If Not Empty(m.lnSelLength)
							This.frmActiveControl.SelLength = Len(m.lcValueOfresult)
						Endif
					Endif
				Endcase
			Endcase
			This.frmActiveControl = Null
			Set DataSession To lnDataSession
		Endif
	Endproc


	Procedure Show
		Lparameters nStyle
		If Type("_SCREEN.ActiveForm")                =="O"  And;
				NOT Isnull(_Screen.ActiveForm)                   And;
				TYPE("_SCREEN.ActiveForm.ActiveControl") == "O"  And;
				NOT Isnull(_Screen.ActiveForm.ActiveControl)     And;
				UPPER(_Screen.ActiveForm.ActiveControl.BaseClass) $ "TEXTBOX EDITBOX"
			This.ActiveFormDatasession = _Screen.ActiveForm.DataSessionId
			This.frmActiveControl      = _Screen.ActiveForm.ActiveControl
		Endif
	Endproc


	Procedure Init
		Lparameters m_top,m_left
		Local oControl, lnControl
		This.Top                        = Iif(Type("m_top") # "N" ,0,m_top)
		This.Left                       = Iif(Type("m_left") # "N",0,m_left)
		*	thisform.SetAll("BackColor", BUTTONBACKCOLOR, "CommandButton")
		For Each oControl In This.Controls
			If Not Upper(oControl.Name) == "LENTA"
				oControl.Tag = Transform(oControl.Top)
			Else
				oControl.Tag = Transform(oControl.Height)
			Endif
		Next
		Thisform.fillbutt.ToolTipText = "Copiar y Pegar" + CRLF +;
			["F"       or Click Izq- copiar resultado a Memoria] + CRLF + ;
			[Shift+"F" or Click Der- copiar historial a Memoria]
	Endproc


	Procedure KeyPress
		Lparameters nKeyCode, nShift
		Local oButton, llisRigthclick
		m.oButton = ""
		Do Case
		Case nKeyCode < 0
		Case (nKeyCode = 27 .Or. Upper(Chr(nKeyCode)) == "O") .And. nShift = 0  &&  Esc or O (off)
			m.oButton = "this.OFF"
		Case nKeyCode == 40                             && press "("
			m.oButton = "this.LeftBracket"
		Case nKeyCode == 41                             && press ")"
			m.oButton = "this.RightBracket"
		Case nKeyCode == 48            .And. nShift = 2 && Ctrl+0    press "00"
			m.oButton = "this.B00"
		Case Between(nKeyCode, 48, 57) .And. nShift = 0 && press some digit
			m.oButton = "this.B"+Chr(nKeyCode)
		Case Inlist(nKeyCode, 44, 46) .And. nShift = 0 && Decimal point (no matter if it is point or comma
			m.oButton = "this.BPOINT"
		Case nKeyCode = 127  .And. nShift = 0 && BackSpace
			m.oButton = "this.BACK"
		Case nKeyCode = 42  .And. Inlist(nShift,0,1) &&  *
			m.oButton = "this.Multi"
		Case nKeyCode = 47  .And. nShift = 0 &&  /
			m.oButton = "this.DIVIDE"
		Case nKeyCode = 45  .And. nShift = 0 &&  -
			m.oButton = "this.Minus"
		Case nKeyCode = 43  .And. Inlist(nShift,0,1)       &&  +
			m.oButton = "this.PLUS"
		Case Inlist(nKeyCode, 13, 61)  .And. nShift = 0    &&  Enter or =
			Nodefault
			m.oButton = "this.EQUAL"
		Case Upper(Chr(nKeyCode)) == "C"  .And. nShift = 0 &&  C (Clear)
			m.oButton = "this.BC"
		Case Upper(Chr(nKeyCode)) == "A" .And. nShift = 0  &&  A (ll Clear)
			m.oButton = "this.AC"
		Case Upper(Chr(nKeyCode)) == "F" .And. nShift = 0  &&  F (Copy to Clipboard only result7)
			m.oButton = "this.FILLBUTT"
		Case Upper(Chr(nKeyCode)) == "F" .And. nShift = 1  &&  Shift+F (Copy to Clipboard whole History)
			m.llisRigthclick = .T.
			m.oButton        = "this.FILLBUTT"
		Case nKeyCode = 37                                 &&  % (Percent pressed)
			m.oButton = "this.Percent"
		Case nKeyCode = 92  .And. nShift = 0               &&  \ (SQRT)
			m.oButton = "this.SQRT"
		Case Upper(Chr(nKeyCode)) = "S"  .And. nShift = 0  &&  S (Sign change)
			m.oButton = "this.PLUSMINUS"
		Case Upper(Chr(nKeyCode)) = "R"  .And. nShift = 0  &&  R (Memory recall)
			m.oButton = "this.MEMORECALL"
		Case Upper(Chr(nKeyCode)) = "M"  .And. nShift = 0  &&  M (Memory minus)
			m.oButton = "this.MEMOMINUS"
		Case Upper(Chr(nKeyCode)) = "P"  .And. nShift = 0  &&  P (Memory plus)
			m.oButton = "this.MEMOPLUS"
		Endcase
		If Not Empty(m.oButton)
			Evaluate(m.oButton+[.SetFocus()])
			Evaluate(m.oButton+[.] + Iif(m.llisRigthclick,[Right],[]) + [Click()])
		Endif
	Endproc


	Procedure Resize
		Local lnTag
		This.LockScreen = .T.
		For Each oControl In This.Controls
			lnTag = Val(oControl.Tag)
			If Not Upper(oControl.Name) == "LENTA"
				If This.Height == This.MinHeight
					oControl.Top = m.lnTag
				Else
					oControl.Top = m.lnTag + (This.Height - This.MinHeight)
				Endif
			Else
				If This.Height == This.MinHeight
					oControl.Height = m.lnTag
				Else
					oControl.Height = m.lnTag + (This.Height - This.MinHeight)
				Endif
				This.ControlScroll(oControl)
			Endif
		Endfor
		This.LockScreen = .F.
	Endproc


	Procedure Hide
		This.frmActiveControl = Null
	Endproc


	Procedure b7.Click
		Thisform.pressdidit("7")
	Endproc


	Procedure b8.Click
		Thisform.pressdidit("8")
	Endproc


	Procedure b9.Click
		Thisform.pressdidit("9")
	Endproc


	Procedure b4.Click
		Thisform.pressdidit("4")
	Endproc


	Procedure b5.Click
		Thisform.pressdidit("5")
	Endproc


	Procedure b6.Click
		Thisform.pressdidit("6")
	Endproc


	Procedure b1.Click
		Thisform.pressdidit("1")
	Endproc


	Procedure b2.Click
		Thisform.pressdidit("2")
	Endproc


	Procedure b3.Click
		Thisform.pressdidit("3")
	Endproc


	Procedure b0.Click
		Thisform.pressdidit("0")
	Endproc


	Procedure b00.Click
		Thisform.pressdidit("00")
	Endproc


	Procedure plus.Click
		Thisform.signpress("+")
	Endproc


	Procedure Minus.Click
		Thisform.signpress("-")
	Endproc


	Procedure Multi.Click
		Thisform.signpress("*")
	Endproc


	Procedure divide.Click
		Thisform.signpress("/")
	Endproc


	Procedure memorecall.Click
		Local asd, m_point
		If .Not. Thisform.blockade
			If Thisform.memoclick
				Thisform.text1.Value =""
				Thisform.memoval = 0
				Thisform.memoclick = .F.
			Else
				If Round(Thisform.memoval,14) = Int(Thisform.memoval)
					m_point = 0
				Else
					asd     = Alltrim(Strtran(Str(Thisform.memoval,16,7),"0"," "))
					m_point = At(".",asd)
					m_point = Iif(m_point=Len(asd),0,Len(asd)-m_point)
				Endif
				Thisform.Enter.Value =  Alltrim(Str(Thisform.memoval,16,m_point))
				Thisform.memoclick = .T.
			Endif
			Thisform.fl_znak = .F.
		Endif
	Endproc


	Procedure memominus.Click
		If .Not. Thisform.blockade
			If .Not. Empty(Thisform.znak)
				Thisform.Calculate()
				Thisform.memoval = Thisform.memoval - Thisform.result
			Else
				Thisform.memoval = Thisform.memoval - Thisform.result
			Endif
			Thisform.text1.Value = "M"
			Thisform.memoclick = .F.
			Thisform.fl_znak = .F.
		Endif
	Endproc


	Procedure memoplus.Click
		If .Not. Thisform.blockade
			If .Not. Empty(Thisform.znak)
				Thisform.Calculate()
				Thisform.memoval = Thisform.memoval + Thisform.result
			Else
				Thisform.memoval = Thisform.memoval + Thisform.result
			Endif
			Thisform.text1.Value = "M"
			Thisform.memoclick = .F.
			Thisform.fl_znak = .F.
		Endif
	Endproc


	Procedure percent.Click
		If .Not. Thisform.blockade
			Thisform.memoclick = .F.
			Thisform.makelenta("%")
			If .Not. Empty(Thisform.znak)
				Thisform.znak = Thisform.znak + "%"
				Thisform.Calculate()
			Endif
			Thisform.makelenta("=")
			Thisform.znak = ""
			Thisform.fl_znak = .F.
		Endif
	Endproc


	Procedure bpoint.Click
		Thisform.memoclick = .F.
		If Empty(At(".",Thisform.Enter.Value)) .Or.;
				.Not. Thisform.fl_znak
			If Empty(Thisform.Enter.Value) .Or.;
					.Not. Thisform.fl_znak
				Thisform.Enter.Value = "0."
				Thisform.fl_znak     = .T.
			Else
				Thisform.Enter.Value  = Thisform.Enter.Value + "."
			Endif
		Endif
	Endproc


	Procedure ac.Click
		Thisform.Enter.Value             = ""
		Thisform.result                  = 0
		Thisform.blockade                = .F.
		Thisform.fl_znak                 = .F.
		Thisform.znak                    = .F.
		Thisform.text1.DisabledForeColor = Rgb(0,0,0)
		Thisform.text1.Value             = ""
		Thisform.lenta.Value             = ""
		Thisform.br_rows                 = 0
		Thisform.memoval                 = 0
		Thisform.nbracketsopened         = 0
		Thisform.lenta.ScrollBars        = 0
		Thisform.memoclick               = .F.
	Endproc


	Procedure Off.Click
		Thisform.Hide()
	Endproc


	Procedure Back.Click
		Local m_len
		Local lcRightChar, lnLen
		lnLen = Len(Thisform.Enter.Value)
		Thisform.memoclick = .F.
		Do Case
		Case lnLen == 0
		Case lnLen = 1
			Thisform.Enter.Value     = ""
			Thisform.nbracketsopened = 0
		Otherwise
			lcRightChar = Right(Thisform.Enter.Value,1)
			Do Case
			Case Right(Thisform.Enter.Value,5) == "SQRT("
				Thisform.nbracketsopened = Thisform.nbracketsopened - 1
				Thisform.Enter.Value = Left(Thisform.Enter.Value,Len(Thisform.Enter.Value)-4) && ;o)
			Case lcRightChar == ")"
				Thisform.nbracketsopened = Thisform.nbracketsopened + 1
			Case lcRightChar == "("
				Thisform.nbracketsopened = Thisform.nbracketsopened - 1
			Endcase
			Thisform.Enter.Value = Left(Thisform.Enter.Value,Len(Thisform.Enter.Value)-1)
		Endcase
	Endproc


	Procedure bc.Click
		Thisform.Enter.Value     = ""
		Thisform.blockade        = .F.
		Thisform.fl_znak         = .F.
		Thisform.memoclick       = .F.
		Thisform.nbracketsopened = 0
		If Thisform.text1.Value = "E"
			Thisform.text1.DisabledForeColor = Rgb(0,0,0)
			Thisform.text1.Value = Iif(Empty(Thisform.memoval),"","M")
		Endif
	Endproc


	Procedure equal.Click
		If .Not. Empty(Thisform.znak) .And. .Not. Thisform.blockade
			Thisform.memoclick = .F.
			Thisform.makelenta("=")
			If Thisform.fl_znak .Or. .Not. Empty(Thisform.znak)
				Thisform.Calculate()
			Endif
			Thisform.makelenta("T"+CRLF)
			Thisform.znak = ""
		Endif
	Endproc


	Procedure plusminus.Click
		Local lnPointPosition,lnLen
		m.lnLen            = Len(Thisform.Enter.Value)
		m.lnPointPosition  = At(".",Thisform.Enter.Value)
		m.lnPointPosition  = Iif(m.lnPointPosition#0,m.lnLen - m.lnPointPosition + Iif(Val(Thisform.Enter.Value)<0,0,1),0)
		Thisform.memoclick = .F.
		If .Not. Empty(Val(Thisform.Enter.Value))
			Thisform.Enter.Value = Alltrim(Str(Val(Thisform.Enter.Value) * (-1),m.lnLen + 1,m.lnPointPosition))
		Endif
	Endproc


	Procedure Sqrt.Click
		If Thisform.nbracketsopened # 0
			If Thisform.Checkentervalue()
				Thisform.nbracketsopened = Thisform.nbracketsopened + 1
				Thisform.Enter.Value     = Thisform.Enter.Value + "SQRT("
			Endif
		Else
			Thisform.memoclick = .F.
			Thisform.makelenta("SQRT")
			Thisform.result = Sqrt(Val(Thisform.Enter.Value))
			Thisform.Enter.Value = Alltrim(Str(Thisform.result,19,2))
			Thisform.fl_znak = .F.
			Thisform.makelenta("T")
		Endif
	Endproc


	Procedure fillbutt.Click
		Local lnPointPosition,lcResult
		If .Not. Thisform.blockade
			Thisform.memoclick = .F.
			If Empty(Thisform.znak)
				Thisform.result = Val(Thisform.Enter.Value)
			Else
				Thisform.Calculate()
			Endif
			Thisform.znak     = ""
			Thisform.fl_znak  = .F.
			m.lcResult        = Alltrim(Strtran(Str(Thisform.result,16,7),"0"," "))
			m.lnPointPosition = At(".",m.lcResult)
			m.lnPointPosition = Iif(m.lnPointPosition=Len(m.lcResult),0,Len(m.lcResult)-m.lnPointPosition)

			_Cliptext = Alltrim(Str(Thisform.result,16,m.lnPointPosition))
			This.Parent.fillresulttocontrol(_Cliptext)
		Endif
		Thisform.Off.Click()
	Endproc


	Procedure fillbutt.RightClick
		If .Not. Thisform.blockade
			Thisform.memoclick = .F.
			Thisform.equal.Click()
			Thisform.znak      = ""
			Thisform.fl_znak   = .F.
			_Cliptext          = Thisform.lenta.Value
			This.Parent.fillresulttocontrol(_Cliptext, .T.)
		Endif
		Thisform.Off.Click()
	Endproc


	Procedure rightbracket.Click
		If Thisform.nbracketsopened > 0 And Not Thisform.Checkentervalue()
			Thisform.Enter.Value     = Thisform.Enter.Value + ")"
			Thisform.nbracketsopened = Thisform.nbracketsopened - 1
		Endif
	Endproc


	Procedure leftbracket.Click
		If Not Empty(Thisform.Enter.Value) And Empty(Thisform.znak) And Thisform.nbracketsopened == 0
			Return
		Endif

		If Thisform.nbracketsopened == 0
			Thisform.nbracketsopened = Thisform.nbracketsopened + 1
			Thisform.Enter.Value     = "("
		Else
			If Thisform.Checkentervalue()
				Thisform.nbracketsopened = Thisform.nbracketsopened + 1
				Thisform.Enter.Value     = Thisform.Enter.Value + "("
			Endif
		Endif
		Thisform.fl_znak         = .T.
	Endproc


	Procedure Command3.Click
		Thisform.signpress("^")
	Endproc


	Procedure power2.Click
		Thisform.memoclick = .F.
		If Thisform.nbracketsopened # 0
			If Not Thisform.Checkentervalue()
				Thisform.Enter.Value = Thisform.Enter.Value + "^2"
			Endif
		Else
			Thisform.makelenta("^2")
			Thisform.result      = (Val(Thisform.Enter.Value)^2)
			Thisform.Enter.Value = Alltrim(Str(Thisform.result,19,2))
			Thisform.fl_znak     = .F.
			Thisform.makelenta("T")
		Endif
	Endproc

Enddefine
*-- EndDefine: calc
**************************************************
