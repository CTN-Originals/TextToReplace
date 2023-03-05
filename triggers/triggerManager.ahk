Global triggerConsole := new Console("Trigger Manager", "  ")
Global TriggerDataStoragePath := "triggers/triggerStorage.ini"
Global TriggerScriptPath := "triggers/triggers.ahk"

SendMode, Event


class TriggerData {
	__New(trigger) {
		this.trigger := this._formatTrigger(trigger)
		this.output := ""
		this.state := true
		this.status := ""

		; Input options
		this.caseSensitive := false
		this.keepInput := false

		this.confirmation := true
		this.confirmationTime := 5000 ; 5 seconds
		this.confirmKey := "Tab"

		; Output options
		this.outputType := "text"
		this.outputDelay := 0
		this.outputSpeed := 0
		this.fromClipboard := false

		this._cancelTrigger := ObjBindMethod(this, "_cancelTriggerExecution")
		this._execTrigger := ObjBindMethod(this, "_executeTrigger")

		this._validate()
	}

	Initiate() {
		this.status := "initiated"
		if (this.confirmation == "true") {
			cancelTrigger := this._cancelTrigger ; Get the cancel trigger function
			execTrigger := this._execTrigger ; Get the Execution trigger function

			Tooltip, % "Press " this.confirmKey " to replace with " Array.join(Array.split(this.output, " "), " ", 10) "...", % (A_CaretX + 20), % (A_CaretY + 20), 1
			SetTimer, % cancelTrigger, % "-"this.confirmationTime
			Hotkey, % this.confirmKey, % execTrigger, On
		}
		else {
			this._executeTrigger()
		}
	}
	_executeTrigger() {
		if (this.confirmation == "true") {
			cancelTrigger := this._cancelTrigger ; Get the cancel trigger function
			Hotkey, % this.confirmKey, Off ; turn off the hotkey
			SetTimer, % cancelTrigger, Off ; turn off the cancel timer
		}
		Tooltip,,,, 1 ; Hide the tooltip
		
		trigLen := StrLen(this.trigger) ; Get the length of the trigger
		SendInput, {BackSpace %trigLen%} ; Delete the trigger from the input
		Send, % this._formatToOutput(this.output) ; Send the output
	
		this.status := "executed"
		triggerConsole.log("Executed: " this.trigger, false)
	}
	_cancelTriggerExecution() {
		Hotkey, % this.confirmKey, Off
		Tooltip,,,, 1
		this.status := "cancelled"
		triggerConsole.log("Cancelled: " this.trigger, false)
	}

	storeTriggerData() {
		keys := Object.keys(this)
		for i in keys {
			key := keys[i]
			value := this._toSafeString(this[key])
			IniWrite, % value, %TriggerDataStoragePath%, % this.trigger, % key
		}
	}
	
	_validate() {
		keys := Object.keys(this)
		for i in keys {
			key := keys[i]
			if (key == "trigger") {
				continue
			}

			IniRead, storageValue, %TriggerDataStoragePath%, % this.trigger, %key%
			if (storageValue && storageValue != "ERROR" && storageValue != "") {
				this[key] := storageValue
			}
		}
	}

	_formatTrigger(trigger) {
		output := StrReplace(trigger, "\n", "\\n")
		return output
	}
	_formatToOutput(string) {
		output := StrReplace(string, "\\n", "{Enter}")
		return output
	}
	_toSafeString(string) {
		if (InStr(string, "`n")) {
			string := StrReplace(string, "`n", "\\n")
		}
		if (string == "0") {
			string = false
		}
		if (string == "1") {
			string = true
		}
		return string
	}
	_formatString(string) {
		if (InStr(string, "\\n")) {
			string := StrReplace(string, "\\n", "`n")
		}
		return string
	}
}
Global TriggerDataCollection := {}

InitiateTrigger(trigger) {
	Console.log("Initiating: " trigger)
	TriggerDataCollection[trigger].Initiate()
}


ValidateTriggerData() {
	triggerConsole.log("Validating trigger data...")

	IniRead, RawTriggers, %TriggerDataStoragePath%, TriggerData, triggers
	if (RawTriggers == "ERROR") {
		IniWrite, placeholder, %TriggerDataStoragePath%, TriggerData, triggers
		RawTriggers := 
	}
	Global triggers := Array.split(RawTriggers, ",")

	for i in triggers {
		trigger := triggers[i]
		if (trigger == "" || trigger == "placeholder") {
			continue
		}
		triggerData := new TriggerData(trigger)
		TriggerDataCollection[trigger] := triggerData
	}

	Console.log("Triggers: " RawTriggers)
	; triggerConsole.log(TriggerDataCollection, "TriggerDataCollection")
	ConstructTriggerScript()
	
}

ConstructTriggerScript() {
	if (FileExist("triggers/triggers.ahk")) {
		FileDelete, triggers/triggers.ahk
	}
	FileAppend, `n, triggers/triggers.ahk
	; FileAppend, "#SingleInstance, Force`n#NoTrayIcon`n#Include, triggerManager.ahk", %TriggerScriptPath%
	; #Include, triggers/triggers.ahk
	for key, data in TriggerDataCollection {
		if (!data.state) {
			continue
		}

		line := ":*B0"
		line .= (data.caseSensitive) ? "C" : "C0"
		line .= ":" data.trigger "::`n`tInitiateTrigger(""" data.trigger """)`nreturn`n"

		FileAppend, %line%, %TriggerScriptPath%
	}
	
}

RegisterTrigger(trigger, output) {
	
	options := {}
	options["confirmation"] := IOConfirmSwitch.SwitchState
	options["confirmationTime"] := IOConfirmTimeValue
	options["caseSensitive"] := IOKeepInputSwitch.SwitchState
	options["keepInput"] := IOCaseSensitiveSwitch.SwitchState
	options["outputType"] := ""
	options["outputDelay"] := ""
	options["outputSpeed"] := ""
	options["fromClipboard"] := ""

	; Store trigger data

	triggerConsole.log(options, false)
	; triggerConsole.log(Object.keys(options), false)
	; triggerConsole.log(Object.values(options), false)


	triggerData := new TriggerData(trigger)
	trigger := triggerData.trigger

	triggerData.output := output
	keys := Object.keys(triggerData)
	for i in keys {
		key := keys[i]
		if (Array.contains(["trigger", "output", "state"], key)) {
			continue
		}
		if (Array.contains(Object.keys(options), key) && options[key] != "") {
			triggerData[key] := options[key]
		}
	}
	
	triggerData.storeTriggerData()
	TriggerDataCollection[trigger] := triggerData

	rawTriggers := Array.join(Object.keys(TriggerDataCollection), ",")
	IniWrite, %rawTriggers%, %TriggerDataStoragePath%, TriggerData, triggers
	ConstructTriggerScript()
	; Hotstring(":*:" trigger, InitiateTrigger.Call(trigger) " ")

		; triggerData.confirmation := (confirmation && confirmation != "") ? confirmation : triggerData.confirmation
		; triggerData.confirmationTime := (confirmationTime && confirmationTime != "") ? confirmationTime : triggerData.confirmationTime
		; triggerData.caseSensitive := (caseSensitive && caseSensitive != "") ? caseSensitive : triggerData.caseSensitive
		; triggerData.keepInput := (keepInput && keepInput != "") ? keepInput : triggerData.keepInput
		; triggerData.outputType := (outputType && outputType != "") ? outputType : triggerData.outputType
		; triggerData.outputDelay := (outputDelay && outputDelay != "") ? outputDelay : triggerData.outputDelay
		; triggerData.outputSpeed := (outputSpeed && outputSpeed != "") ? outputSpeed : triggerData.outputSpeed
		; triggerData.fromClipboard := (fromClipboard && fromClipboard != "") ? fromClipboard : triggerData.fromClipboard


		; IniWrite, %output%, %TriggerDataStoragePath%, %trigger%, output
		; IniWrite, true, %TriggerDataStoragePath%, %trigger%, state

		; IniWrite, % (confirmation) ? "true" : "false", %TriggerDataStoragePath%, %trigger%, confirmation
		; IniWrite, % (confirmationTime) ? confirmationTime : "", %TriggerDataStoragePath%, %trigger%, confirmationTime
		; IniWrite, % (caseSensitive) ? "true" : "false", %TriggerDataStoragePath%, %trigger%, caseSensitive
		; IniWrite, % (keepInput) ? "true" : "false", %TriggerDataStoragePath%, %trigger%, keepInput
		; IniWrite, % (outputType) ? outputType : "", %TriggerDataStoragePath%, %trigger%, outputType
		; IniWrite, % (outputDelay) ? outputDelay : "", %TriggerDataStoragePath%, %trigger%, outputDelay
		; IniWrite, % (outputSpeed) ? outputSpeed : "", %TriggerDataStoragePath%, %trigger%, outputSpeed
		; IniWrite, % (fromClipboard) ? "true" : "false", %TriggerDataStoragePath%, %trigger%, fromClipboard
	

}







; #Include, triggers/triggers.ahk
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
