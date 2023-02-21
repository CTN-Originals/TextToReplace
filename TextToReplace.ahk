#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force ; Ensures a single running instance.
; SendMode, Play
SetWorkingDir, %A_ScriptDir% ; Ensures a consistent starting directory.
SetBatchLines, -1

Global Session := Session || "Main"

ActiveColorTheme := 2

;================Include================
	#Include, gui/interactables/colorTheme.ahk

	#Include, gui/interactables/SimpleButton.ahk
	#Include, gui/interactables/Close_Button.ahk
	#Include, gui/interactables/Minimize_Button.ahk
	#Include, gui/interactables/Plus_Button.ahk
	#Include, gui/interactables/Settings_Button.ahk
	#Include, gui/interactables/Panel.ahk
	#Include, gui/interactables/Switch.ahk

	#Include, data/generalData.ahk
	
	; #Include, class/generalClasses.ahk
	#Include, utils/generalUtilities.ahk
	#Include, gui/manager/guiManager.ahk
	#Include, gui/sections/overview.ahk
	#Include, gui/sections/addInstance.ahk
	
	#Include, test/generalTests.ahk
	#Include, triggers/triggerManager.ahk

;=-=-=-=-=-=-=-=-Include=-=-=-=-=-=-=-=-

;================VARIABLES================

	Global Console := new Console("")

	;================GUI VARS================
		Global WinPosX
		Global WinPosY
		IniRead, WinPosX, data\generalDataStorage.ini, WindowData, posX
		IniRead, WinPosY, data\generalDataStorage.ini, WindowData, posY

		Global WinWidth := 880
		Global WinHeight := 610

		;================BOARDS================

			; CurrentBoars := 0

			; CurrentX := 80
			; CurrentY := 45
			; IncreaseX := 265
			; IncreaseY := 165

		;=-=-=-=-=-=-=-=-BOARDS=-=-=-=-=-=-=-=-

	;=-=-=-=-=-=-=-=-GUI VARS=-=-=-=-=-=-=-=-

	;================Data================
		Global ReplaceHotkey := "Tab"
		Global ProgramStartTime := A_TickCount
	;=-=-=-=-=-=-=-=-Data=-=-=-=-=-=-=-=-

;=-=-=-=-=-=-=-=-VARIABLES=-=-=-=-=-=-=-=-

Start()
;================GUI================
	WinGetTitle, postAWin, A
    ;================WINDOW================
		
		Gui, Main:+LastFound
		Gui, Main:Color, %BackgroundColor%
		Gui, Main:Margin, 0, 0

		Gui, Main:Add, Progress, % "x-1 y" (WinHeight-65) " w" (WinWidth+2) " h65 Background" FooterColor " Disabled"
		
		Gui, Main:Add, Progress, % "x-1 y-1 w66 h" (WinHeight+2) " Background" SideBarColor " Disabled"
		Gui, Main:Add, Progress, % "x-1 y-1 w" (WinWidth+2) " h40 Background" HeaderColor " Disabled"

		Create_Close_Button("x:=" (WinWidth-35), "y:=" (WinHeight/14-(WinHeight/14)), "w:=30", "h:=30", "Window:=Main")
		Create_Minimize_Button("x:=" (WinWidth-70), "y:=" (WinHeight/14-(WinHeight/14)), "w:=30", "h:=30", "Window:=Main")
		Gui, Main:Font, cWhite s18, Impact
		Gui, Main:Add, Text, % "x" (WinWidth-105) " y" (WinHeight/14-(WinHeight/14) + 5) " w30 h30 cWhite Center 0x200 gReloadWindow", R

		Gui, Main:Font, s14 c%FontColor%, Impact
		Gui, Main:Add, Text, % "x0 y0 w" WinWidth " h" (WinHeight/14) " BackgroundTrans Center 0x200 gGuiMove", Text To Replace

	;=-=-=-=-=-=-=-=-WINDOW=-=-=-=-=-=-=-=-

	;================SIDEBAR================

		Create_Plus_Button("x:=8", "y:=50", "w:=50", "h:=50", PlusButtonColors, "Radius:=5")
		; Gui, Main:Font, cWhite s30, Impact
		; Gui, Main:Add, Text, % "x8 y120 w50 h50 Center 0x200 gEditButton", E 

		Create_Settings_Button("x:=8", "y:=" (WinHeight-58), "w:=50", "h:=50", SettingsButtonColors, "ToolTip:=Settings", "OnTopColor:=" SideBarColor)

	;=-=-=-=-=-=-=-=-SIDEBAR=-=-=-=-=-=-=-=-

	;================SECTION================
		;WinWidth: 814
		;WinHeight: 510
		;================ADD NEW================
			; AddNewInstanceUI()
		;=-=-=-=-=-=-=-=-ADD NEW=-=-=-=-=-=-=-=-

		;================BOARDS================
			; Create_Panel("x:=80", "y:=45", "w:=250", "h:=150", "OnTopColor:=" BackgroundColor, PanelColors)

			; Create_Panel("x:=345", "y:=45", "w:=250", "h:=150", "OnTopColor:=" BackgroundColor, PanelColors)
			; Create_Panel("x:=610", "y:=45", "w:=250", "h:=150", "OnTopColor:=" BackgroundColor, PanelColors)

			; Create_Panel("x:=80", "y:=210", "w:=250", "h:=150", "OnTopColor:=" BackgroundColor, PanelColors)
			; Create_Panel("x:=345", "y:=210", "w:=250", "h:=150", "OnTopColor:=" BackgroundColor, PanelColors)
			; Create_Panel("x:=610", "y:=210", "w:=250", "h:=150", "OnTopColor:=" BackgroundColor, PanelColors)


			; Create_Panel("x:=80", "y:=375", "w:=250", "h:=150", "OnTopColor:=" BackgroundColor, PanelColors)
			; Create_Panel("x:=345", "y:=375", "w:=250", "h:=150", "OnTopColor:=" BackgroundColor, PanelColors)
			; Create_Panel("x:=610", "y:=375", "w:=250", "h:=150", "OnTopColor:=" BackgroundColor, PanelColors)

			CreateOverviewUI()
		;=-=-=-=-=-=-=-=-BOARDS=-=-=-=-=-=-=-=-
	;=-=-=-=-=-=-=-=-SECTION=-=-=-=-=-=-=-=-

	;================Grid================
		; Gui, Main:Add, Progress, x472 y40 w1 h505 BackgroundTrans Background000040 Disabled
		; Gui, Main:Add, Progress, x66 y294 w900 h1 BackgroundTrans Background000040 Disabled
	
		; Gui, Main:Add, Progress, x439 y0 w1 h800 BackgroundTrans Background004040 Disabled
		; Gui, Main:Add, Progress, x0 y274 w900 h1 BackgroundTrans Background004040 Disabled
	;=-=-=-=-=-=-=-=-Grid=-=-=-=-=-=-=-=-

	Gui, Main: -Caption
	Gui, Main:Show, x%WinPosX% y%WinPosY%  w%WinWidth% h%WinHeight%, Text To Replace
	WinSet, Region, 0-0 w%WinWidth% h%WinHeight% r10-10, Text To Replace

	WinActivate, %postAWin%

	; #IncludeAgain, triggers/includeTriggers.ahk
	Ready()
	#Include, triggers/triggers.ahk
	Return
	;=-=-=-=-=-=-=-=-GUI=-=-=-=-=-=-=-=-
	
Start() {
	if (FileExist("triggers/triggers.ahk")) {
		FileDelete, triggers/triggers.ahk
	}
	ValidateTriggerData()
	; FileAppend, , triggers/triggers.ahk
	; FormatIncludedTriggers()
}

Ready() {
	console.log("`n-------- Ready! --------`n")
	StartTest()
	; ConstructGUIElement()
	; AddNewInstanceUI()
}

#IncludeAgain, triggers/triggers.ahk


;================Sidebar Buttons================
	PlusButton:
		AddNewInstanceUI()
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
	    If (OutputText == "") {
	        MsgBox, Nothing was in the Output field
	        return
	    }

		confirmation := IOConfirmSwitch.SwitchState
		confirmationTime := IOConfirmTimeValue
		keepInput := IOKeepInputSwitch.SwitchState
		caseSensitive := IOCaseSensitiveSwitch.SwitchState
	
	    NewString := StrReplace(OutputText,"`r`n", "<_newline_>")
	    NewString := StrReplace(NewString,"`n", "<_newline_>")
	    NewOutput := StrReplace(NewString,"<_newline_>", "``n")
	    output := StrReplace(NewString,"<_newline_>", "{Enter}")

		; triggerData := new TriggerData(inputTrigger)
		RegisterTrigger(inputTrigger, OutputText) ;, OutputText, confirmation, confirmationTime, caseSensitive, keepInput, outputType, outputDelay)
	
	    ; IniWrite, %inputTrigger%, triggers/triggerStorage.ini, %inputTrigger%, trigger
	    ; IniWrite, %output%, triggers/triggerStorage.ini, %inputTrigger%, output
	    ; IniWrite, true, triggers/triggerStorage.ini, %inputTrigger%, state

		; IniWrite, % (confirmation) ? "true" : "false", triggers/triggerStorage.ini, %inputTrigger%, confirmation
		; IniWrite, % (confirmationTime) ? confirmationTime : "", triggers/triggerStorage.ini, %inputTrigger%, confirmationTime
		; IniWrite, % (caseSensitive) ? "true" : "false", triggers/triggerStorage.ini, %inputTrigger%, caseSensitive
		; IniWrite, % (keepInput) ? "true" : "false", triggers/triggerStorage.ini, %inputTrigger%, keepInput
		; IniWrite, % (outputType) ? outputType : "", triggers/triggerStorage.ini, %inputTrigger%, outputType
		; IniWrite, % (outputDelay) ? outputDelay : "", triggers/triggerStorage.ini, %inputTrigger%, outputDelay
		; IniWrite, % (outputSpeed) ? outputSpeed : "", triggers/triggerStorage.ini, %inputTrigger%, outputSpeed
		; IniWrite, % (fromClipboard) ? "true" : "false", triggers/triggerStorage.ini, %inputTrigger%, fromClipboard
	
		; targetFilePath := "triggers/" inputTrigger ".ahk"
	
		; OutputDebug, % "Input Trigger: " inputTrigger "`n"
		; OutputDebug, % "Target File Path: " targetFilePath "`n"
	
		; if (FileExist(targetFilePath)) {
		; 	FileDelete, %targetFilePath%
		; }
		; if (!Array.contains(triggers, inputTrigger)) {
		; 	triggers.Push(inputTrigger)
		; 	rawtriggers := Array.join(triggers, ",")
		; 	; rawtriggers := triggers.toString(",")
		; 	IniWrite, %rawTriggers%, triggers/triggerStorage.ini, TriggerData, triggers
		; }

		; OutputDebug, % IOConfirmSwitch.SwitchState " " IOConfirmTimeValue "`n"
		; AppendTriggerFile(targetFilePath, inputTrigger, output, NewOutput, IOConfirmSwitch.SwitchState, IOConfirmTimeValue)
		; Gosub, ReloadWindow
	return
	
	Clear:
		; For i in triggers {
		; 	if (FileExist("triggers/" triggers[i] ".ahk")) {
		; 		FileDelete, % "triggers/" triggers[i] ".ahk"
		; 	}
		; }
		if (FileExist(TriggerDataStoragePath)) {
			FileDelete, %TriggerDataStoragePath%
		}
		if (FileExist("triggers/triggers.ahk")) {
			FileDelete, triggers/triggers.ahk
		}
		FileAppend, , triggers/triggers.ahk
		; FileDelete, triggers/includeTriggers.ahk
		triggers := 
		; FormatIncludedTriggers()
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
			IniRead, ThisActive, triggers/triggerStorage.ini, %trigger%, Active
			if (!ThisActive) {
				\treturn
			}
			\t
		)

		scriptStart := StrReplace(scriptStart, "`t", "")
		scriptArray := Array.cleanup(Array.split(scriptStart, "`n"))



		scriptArray.Push(": * B0 " ((caseSensitive) ? "C" : "C0") " :" trigger ":" ":")
		scriptArray.Push("LoopTimes := " strLength)
		; scriptArray.Push("Send, " trigger)

		scriptArray.Push("WaitForKeyPress := 1")
		if (confirmation) {
			scriptArray.Push("ToolTip, Press """ ReplaceHotkey """ replace with """ rawOutput """, % A_CaretX, % A_CaretY + 20, PressToReplace")
			scriptArray.Push("SetTimer, PressToReplace, -" confirmationTime)
		}
		else {
			scriptArray.Push("GoSub, InitiateTrigger")
		}


		scriptArray.Push("IniRead, Output, triggers/triggerStorage.ini, " trigger ", Output")
		scriptArray.Push("return")

		scriptOutput := Array.toScript(scriptArray)
		
		; OutputDebug, % "`n" scriptOutput "`n"
		FileAppend, % scriptOutput, % file
		; GuiControl, Main:Text, Output, % scriptOutput
	}

	; FormatIncludedTriggers() {
	; 	FileAppend,, triggers/includeTriggers.ahk
	; 	; Console.log(triggers)
	; 	For i in triggers {
	; 		if (triggers[i] == "placeholder") {
	; 			continue
	; 		}
	; 		FileAppend, % "#Include, triggers/" triggers[i] ".ahk`n", triggers/includeTriggers.ahk
	; 	}
	; }
;=-=-=-=-=-=-=-=-Methods=-=-=-=-=-=-=-=-




Void:
	
return

GuiMove:
    PostMessage, 0xA1, 2
	KeyWait, LButton
	SaveWindowData()
	; Gui, Main:+LastFound
	; WinGetPos, WinPosX, WinPosY
	; Console.log([WinPosX, WinPosY])
return

ReloadWindow:
	OnExit()
	if (!A_IsCompiled) {
		Run, "C:\Users\CTN\Documents\CTN\Programming\ahk\Projects\TextToReplace\.editor\reload.ahk"
	}
	Sleep, 120
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
	; Gui, Main:Minimize
	OnExit()
	sleep, 100
	ExitApp
return

OnExit() {
	; FormatIncludedTriggers()
	SaveWindowData()
}

SaveWindowData() {
	Gui, Main:+LastFound
	WinGetPos, WinPosX, WinPosY,,, Text To Replace
	IniWrite, %WinPosX%, data/generalDataStorage.ini, WindowData, posX
	IniWrite, %WinPosY%, data/generalDataStorage.ini, WindowData, posY
}