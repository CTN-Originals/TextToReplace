#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

WaitForKeyPress := 0

#If WaitForKeyPress
	InitiateTrigger:
	Tab::
		Loop, %LoopTimes% {
			Send, {BackSpace}
		}
		Send, {Raw}%Output%

		lines := StrSplit(Output, "{Enter}")
		for i in lines {
			line := lines[i]
			
		}

		Output := 
		LoopTimes := 0

		GoSub, PressToReplace
	return
#If

PressToReplace:
	ToolTip
	WaitForKeyPress := 0
return
