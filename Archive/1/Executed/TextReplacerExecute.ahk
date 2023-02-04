#SingleInstance, force

MButton::
Loop, %LoopTimes% {
    Send, {BackSpace}
}
Send, %Output%
Output = 
LoopTimes = 0
return

PressToReplace:
    ToolTip
return

;================SUBMITED================

:*:`{::
    LineNumber = 1
    LoopTimes = 1

    Send, ""{""

    ToolTip, Press Midle Mous button to replace with "{ ", PressToReplace
    SetTimer, PressToReplace, -2000

    IniRead, Output, Ini\Main.ini, 1, Output
    return