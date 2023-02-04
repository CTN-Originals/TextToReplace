; #SingleInstance, Force
; SendMode Input
; SetWorkingDir, %A_ScriptDir%

#Include, utils/debugUtilities.ahk
#Include, triggers/triggerClass.ahk
; #Include, triggers/includeTriggers.ahk

Global triggerConsole := new Console("Trigger Manager", "  ")
WaitForKeyPress := 0

global RawTriggers

ValidateTriggerData() {
	triggerConsole.log("Validating trigger data...")
	IniRead, RawTriggers, triggers/triggerStorage.ini, TriggerData, triggers
	if (RawTriggers == "ERROR") {
		IniWrite, placeholder, triggers/triggerStorage.ini, TriggerData, triggers
		RawTriggers := 
	}
	Global triggers := Array.split(RawTriggers, ",")
	Console.log("Triggers: " RawTriggers)
}

InitiateTrigger(trigger) {
	
}

; #If WaitForKeyPress
; 	InitiateTrigger:
; 	Tab::
; 		Loop, %LoopTimes% {
; 			Send, {BackSpace}
; 		}
; 		Send, {Raw}%Output%

; 		lines := StrSplit(Output, "{Enter}")
; 		for i in lines {
; 			line := lines[i]
; 		}

; 		Output := 
; 		LoopTimes := 0

; 		GoSub, PressToReplace
; 	return
; #If





; PressToReplace:
; 	ToolTip
; 	WaitForKeyPress := 0
; return
