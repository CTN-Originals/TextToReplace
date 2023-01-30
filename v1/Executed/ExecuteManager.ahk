#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

WaitForKeyPress := 0

#if WaitForKeyPress
InitiateTrigger:
Tab::
Loop, %LoopTimes% {
	Send, {BackSpace}
}
Send, %Output%

Output := 
LoopTimes := 0
return
#if

PressToReplace:
	ToolTip
	WaitForKeyPress := 0
return

