#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

WaitForKeyPress := 0

#if WaitForKeyPress
MButton::
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

    #Include, Executed\test.ahk
    #Include, Executed\btw.ahk
    #Include, Executed\some.ahk