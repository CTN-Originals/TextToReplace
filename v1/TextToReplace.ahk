#SingleInstance, Force
SendMode, Play
SetWorkingDir, %A_ScriptDir%
SetBatchLines, -1


;================INI READ================

	; IniRead, Linenumber, ini\triggers.ini, LineNumber, LineNumber
	; IniRead, TotalLines, ini\triggers.ini, TotalLines, TotalLines

	ActiveColorTheme := 2

;=-=-=-=-=-=-=-=-INI READ=-=-=-=-=-=-=-=-

;================Include================
	#Include, Included/gui/SimpleButton.ahk
	#Include, Included/gui/Close_Button.ahk
	#Include, Included/gui/Minimize_Button.ahk
	#Include, Included/gui/Plus_Button.ahk
	#Include, Included/gui/Settings_Button.ahk
	#Include, Included/gui/Panel.ahk
	#Include, Included/gui/Switch.ahk
	#IncludeAgain, Included/gui/colorTheme.ahk

	#Include, utils/generalUtilities.ahk
;=-=-=-=-=-=-=-=-Include=-=-=-=-=-=-=-=-

;================VARIABLES================

	;================GUI VARS================

		winPosX := 1924
		winPosY := 426
		winWidth := 880
		winHeight := 610

		;================BOARDS================

			CurrentBoars := 0

			CurrentX := 80
			CurrentY := 45
			IncreaseX := 265
			IncreaseY := 165

		;=-=-=-=-=-=-=-=-BOARDS=-=-=-=-=-=-=-=-

	;=-=-=-=-=-=-=-=-GUI VARS=-=-=-=-=-=-=-=-

	;================Data================
		IniRead, rawTriggers, ini/triggers.ini, TriggerData, triggers
		if (rawTriggers == "ERROR") {
			IniWrite, placeholder, ini/triggers.ini, TriggerData, triggers
			rawTriggers := 
		}
		Global triggers := StringToArray(rawTriggers, [], ",")
		OutputDebug, % "Triggers: " rawTriggers "`n"

		Global replaceHotkey := "Tab"
	;=-=-=-=-=-=-=-=-Data=-=-=-=-=-=-=-=-

;=-=-=-=-=-=-=-=-VARIABLES=-=-=-=-=-=-=-=-

Start()
;================GUI================
	WinGetTitle, postAWin, A
    ;================WINDOW================
		
		Gui, Main:+LastFound
		Gui, Main:Color, %BackgroundColor%
		Gui, Main:Margin, 0, 0

		Gui, Main:Add, Progress, % "x-1 y" (winHeight-65) " w" (winWidth+2) " h65 Background" FooterColor " Disabled"
		
		Gui, Main:Add, Progress, % "x-1 y-1 w66 h" (winHeight+2) " Background" SideBarColor " Disabled"
		Gui, Main:Add, Progress, % "x-1 y-1 w" (winWidth+2) " h40 Background" HeaderColor " Disabled"

		Create_Close_Button("x:=" (winWidth-35), "y:=" (winHeight/14-(winHeight/14)), "w:=30", "h:=30", "Window:=Main")
		Create_Minimize_Button("x:=" (winWidth-70), "y:=" (winHeight/14-(winHeight/14)), "w:=30", "h:=30", "Window:=Main")
		Gui, Main:Font, cWhite s18, Impact
		Gui, Main:Add, Text, % "x" (winWidth-105) " y" (winHeight/14-(winHeight/14) + 5) " w30 h30 cWhite Center 0x200 gReloadWindow", R

		Gui, Main:Font, s14 c%FontColor%, Impact
		Gui, Main:Add, Text, % "x0 y0 w" winWidth " h" (winHeight/14) " BackgroundTrans Center 0x200 gGuiMove", Text To Replace

	;=-=-=-=-=-=-=-=-WINDOW=-=-=-=-=-=-=-=-

	;================SIDEBAR================

		Create_Plus_Button("x:=8", "y:=50", "w:=50", "h:=50", PlusButtonColors, "Radius:=5")
		Gui, Main:Font, cWhite s30, Impact
		Gui, Main:Add, Text, % "x8 y120 w50 h50 Center 0x200 gEditButton", E 

		Create_Settings_Button("x:=8", "y:=" (winHeight-58), "w:=50", "h:=50", SettingsButtonColors, "ToolTip:=Settings", "OnTopColor:=" SideBarColor)

	;=-=-=-=-=-=-=-=-SIDEBAR=-=-=-=-=-=-=-=-

	;================SECTION================
		;winWidth: 814
		;winHeight: 510
		;================ADD NEW================
		
			
			GuiAddNew() {
				
				Global IOConfirmTimeValue
				;================Input================
					Create_Panel("x:=85", "y:=50", "w:=370", "h:=220", "Footer:=False", "Title:=Input", "OnTopColor:=" BackgroundColor, PanelColors)
					Gui, Main:Font, s12 cBlack, Impact
					Gui, Main:Add, Edit, x120 y110 w300 r1 Center Border Limit30 vinputTrigger

					Create_Panel("x:=105", "y:=150", "w:=330", "h:=100", "Footer:=False", "Title:=Input Options", "OnTopColor:=" PanelBackgroundColor, PanelColors, "Color1:=" SecondPanelBackgroundColor, "HeaderHeight:=16")

					Global IOConfirmSwitchState := Create_Switch("x:=120", "y:=185", "w:=30", "switchState:=1", "Label:=Void", "Tooltip:=Ask for confirmation before replacing the text", SwitchColors, "OnTopColor:=" SecondPanelBackgroundColor)
					Gui, Main:Font, s10 cWhite Bold, Helvetica
					Gui, Main:Add, Text, % "x+15 y+-18 w200 h20 0x200", Confirmation

					Gui, Main:Font, s8 cBlack Normal, Helvetica
					Gui, Main:Add, Edit, % "x120 y+10 w40 h19 Center 0x200 vIOConfirmTimeValue", 5000
					Gui, Main:Font, s10 cWhite Bold, Helvetica
					Gui, Main:Add, Text, % "x165 y+-20 w200 h20 0x200", Confirm Time
					
					; Global IORegexSwitchState := Create_Switch("x:=120", "y:=185", "w:=30", "switchState:=0", "Label:=Void", "Tooltip:=Comming soon...", SwitchColors, "OnTopColor:=" SecondPanelBackgroundColor)
				;=-=-=-=-=-=-=-=-Input=-=-=-=-=-=-=-=-

				;================Options================
					Create_Panel("x:=480", "y:=50", "w:=380", "h:=220", "Footer:=False", "Title:=Options", "OnTopColor:=" BackgroundColor, PanelColors)
	
					Create_Switch("x:=520", "y:=100", "w:=25", "Label:=Void", SwitchColors, "OnTopColor:=" PanelBackgroundColor)
					Create_Switch("x:=520", "y:=+20", "w:=50", "Label:=Void", "Thickness:=2", SwitchColors, "OnTopColor:=" PanelBackgroundColor)
					Create_Switch("x:=520", "y:=+20", "w:=100", "Label:=Void", "Thickness:=4", SwitchColors, "OnTopColor:=" PanelBackgroundColor)
				;=-=-=-=-=-=-=-=-Options=-=-=-=-=-=-=-=-

				;================Output================
					Create_Panel("x:=85", "y:=294", "w:=775", "h:=240", "Footer:=False", "Title:=Output", "Radius:=1", "OnTopColor:=" BackgroundColor, PanelColors)
					Gui, Main:Font, s10 cBlack, Helvetica
					Gui, Main:Add, Edit, x105 y349 w735 h170 Border vOutput
				;=-=-=-=-=-=-=-=-Output=-=-=-=-=-=-=-=-
				
				;================Footer Buttons================
					CreateButton("x:=760", "y:=557", "w:=100", "h:=40", "Text:=Save", "FontSize:=16", "Variable:=Save", "Label:=Save", "Radius:=0", DefaultBarButtonColors, "Color:=00FF00", "OnTopColor:=" FooterColor)
					global Save
	
					CreateButton("x:=206", "y:=557", "w:=100", "h:=40", "Text:=Clear", "FontSize:=15", "Variable:=Clear", "Label:=Clear", "Radius:=0", DefaultBarButtonColors, "Color:=FF0000", "OnTopColor:=" FooterColor)
					global Clear
					CreateButton("x:=86", "y:=557", "w:=100", "h:=40", "Text:=Cancel", "FontSize:=15", "Variable:=Cancel", "Label:=Cancel", "Radius:=0", DefaultBarButtonColors, "Color:=FF0000", "OnTopColor:=" FooterColor)
					global Cancel
				;=-=-=-=-=-=-=-=-Footer Buttons=-=-=-=-=-=-=-=-
			}
			GuiAddNew()
			
			
		;=-=-=-=-=-=-=-=-ADD NEW=-=-=-=-=-=-=-=-
		;================BOARDS================
			; Create_Panel("x:=80", "y:=45", "w:=250", "h:=150", "OnTopColor:=000080", PanelColors)

			; Create_Panel("x:=345", "y:=45", "w:=250", "h:=150", "OnTopColor:=000080", PanelColors)
			; Create_Panel("x:=610", "y:=45", "w:=250", "h:=150", "OnTopColor:=000080", PanelColors)

			; Create_Panel("x:=80", "y:=210", "w:=250", "h:=150", "OnTopColor:=000080", PanelColors)
			; Create_Panel("x:=345", "y:=210", "w:=250", "h:=150", "OnTopColor:=000080", PanelColors)
			; Create_Panel("x:=610", "y:=210", "w:=250", "h:=150", "OnTopColor:=000080", PanelColors)


			; Create_Panel("x:=80", "y:=375", "w:=250", "h:=150", "OnTopColor:=000080", PanelColors)
			; Create_Panel("x:=345", "y:=375", "w:=250", "h:=150", "OnTopColor:=000080", PanelColors)
			; Create_Panel("x:=610", "y:=375", "w:=250", "h:=150", "OnTopColor:=000080", PanelColors)
		;=-=-=-=-=-=-=-=-BOARDS=-=-=-=-=-=-=-=-
	;=-=-=-=-=-=-=-=-SECTION=-=-=-=-=-=-=-=-


	;================Grid================
		; Gui, Main:Add, Progress, x472 y40 w1 h505 BackgroundTrans Background000040 Disabled
		; Gui, Main:Add, Progress, x66 y294 w900 h1 BackgroundTrans Background000040 Disabled
	
		; Gui, Main:Add, Progress, x439 y0 w1 h800 BackgroundTrans Background004040 Disabled
		; Gui, Main:Add, Progress, x0 y274 w900 h1 BackgroundTrans Background004040 Disabled
	;=-=-=-=-=-=-=-=-Grid=-=-=-=-=-=-=-=-

	Gui, Main: -Caption
	Gui, Main:Show, x%winPosX% y%winPosY%  w%winWidth% h%winHeight%, Text To Replace
	WinSet, Region, 0-0 w%winWidth% h%winHeight% r10-10, Text To Replace

	WinActivate, %postAWin%

	Ready()

	#IncludeAgain, Executed/ExecuteManager.ahk
	#IncludeAgain, Executed/includeTriggers.ahk

	Return
;=-=-=-=-=-=-=-=-GUI=-=-=-=-=-=-=-=-

Start() {
	if (FileExist("Executed/includeTriggers.ahk")) {
		FileDelete, Executed/includeTriggers.ahk
	}
	FormatIncludedTriggers()
}

Ready() {
	GuiControl, Main:, inputTrigger, readytest
	GuiControl, Main:, Output, Testing...
}

;================Sidebar Buttons================
	PlusButton:
	
	return

	EditButton:

	return
	
	SettingsButton:
	
	return
;=-=-=-=-=-=-=-=-Sidebar Buttons=-=-=-=-=-=-=-=-

;================Footer Buttons================
	Save:
	    Gui, Submit, NoHide
	    
	    If (inputTrigger == "") {
	        MsgBox, Nothing was in the Input field
	        return
	    }
	
	    If (Output == "") {
	        MsgBox, Nothing was in the Output field
	        return
	    }
	
	    NewString := StrReplace(Output,"`r`n", "<_newline_>")
	    NewString := StrReplace(NewString,"`n", "<_newline_>")
	    NewOutput := StrReplace(NewString,"<_newline_>", "``n")
	    output := StrReplace(NewString,"<_newline_>", "{Enter}")
	
	    IniWrite, true, ini\triggers.ini, %inputTrigger%, Active
	    IniWrite, %inputTrigger%, ini\triggers.ini, %inputTrigger%, Input
	    IniWrite, %output%, ini\triggers.ini, %inputTrigger%, output
	
	    InputCount := % StrLen(inputTrigger)
		targetFilePath := "Executed\" inputTrigger ".ahk"
	
		OutputDebug, % "Input Trigger: " inputTrigger "`n"
		OutputDebug, % "Target File Path: " targetFilePath "`n"
	
		if (FileExist(targetFilePath)) {
			FileDelete, %targetFilePath%
		}
		if (triggers.HasKey(inputTrigger) != 1) {
			triggers.Push(inputTrigger)
			rawtriggers := ArrayToString(triggers, ",")
			IniWrite, %rawTriggers%, ini/triggers.ini, TriggerData, triggers
		}

		OutputDebug, % IOConfirmSwitchState.SwitchState " " IOConfirmTimeValue "`n"
		AppendTriggerFile(targetFilePath, inputTrigger, output, NewOutput, IOConfirmSwitchState.SwitchState, IOConfirmTimeValue)
		; Gosub, ReloadWindow
	return
	
	Clear:
		For i in triggers {
			if (FileExist("Executed/" triggers[i] ".ahk")) {
				FileDelete, % "Executed/" triggers[i] ".ahk"
			}
		}
		if (FileExist("ini/triggers.ini")) {
			FileDelete, ini/triggers.ini
		}
		FileDelete, Executed/includeTriggers.ahk
		triggers := 
		FormatIncludedTriggers()
		Gosub, ReloadWindow
	return
	
	Cancel:
	
	return
;=-=-=-=-=-=-=-=-Footer Buttons=-=-=-=-=-=-=-=-

;================Methods================
	AppendTriggerFile(file, trigger, output, rawOutput, confirmation := true, confirmationTime := 5000) {
		strLength := StrLen(trigger)
		scriptArray := []

		scriptStart = 
		(
			#SingleInstance, Force
			trigger := "%trigger%"
			IniRead, ThisActive, ini\triggers.ini, %trigger%, Active
			if (!ThisActive) {
				\treturn
			}
			\t
		)

		scriptStart := StrReplace(scriptStart, "`t", "")
		scriptArray := CleanupArray(StrSplit(scriptStart, "`n"))

		scriptArray.Push(":*:" trigger ":" ":")
		scriptArray.Push("LoopTimes := " strLength)
		scriptArray.Push("Send, " trigger)

		if (confirmation) {
			scriptArray.Push("ToolTip, Press """ replaceHotkey """ replace with """ rawOutput """, PressToReplace")
			scriptArray.Push("WaitForKeyPress := 1")
			scriptArray.Push("SetTimer, PressToReplace, -" confirmationTime)
		}
		else {
			scriptArray.Push("GoSub, InitiateTrigger")
		}

		scriptArray.Push("IniRead, Output, ini/triggers.ini, " trigger ", Output")
		scriptArray.Push("return")

		scriptOutput := ArrayToScript(scriptArray)
		
		OutputDebug, % "`n" scriptOutput "`n"
		FileAppend, % scriptOutput, % file
		GuiControl, Main:Text, Output, % scriptOutput
	}

	FormatIncludedTriggers() {
		FileAppend,, Executed/includeTriggers.ahk
		For i in triggers {
			if (triggers[i] == "placeholder") {
				continue
			}
			FileAppend, % "#Include, Executed/" triggers[i] ".ahk`n", Executed/includeTriggers.ahk
		}
	}
;=-=-=-=-=-=-=-=-Methods=-=-=-=-=-=-=-=-




Void:
	
return

GuiMove:
    PostMessage, 0xA1, 2
return

ReloadWindow:
	OnExit()
	Run, "C:\Users\CTN\Documents\CTN\Programming\ahk\Projects\TextToReplace\v1\Editor\reload.ahk"
	Sleep, 100
	ExitApp
return

MinimizeButton:
	WindowTransparency := 250
	Loop, 25 {
		WinSet, Transparent, %WindowTransparency%
		WindowTransparency -= 10.2
		sleep, 8
	}
	
	Gui Minimize
	WinSet, Transparent, 255
return

Pause::
Break::
MainGuiEscape:
MainGuiClose:
CloseButton:
	Gui, Main:Minimize
	OnExit()
	ExitApp
return

OnExit() {
	FormatIncludedTriggers()
}