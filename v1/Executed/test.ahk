#SingleInstance, Force

ThisLineNumber := 1

:*:test::
IniRead, ThisActive, ini\Main.ini, 1, Active
if (ThisActive = "false") {
    return
}
LoopTimes := 4

Send, test

ToolTip, Press Midle Mous button to replace with "Test 1`n2`n3`n4", PressToReplace
WaitForKeyPress := 1
SetTimer, PressToReplace, -2000

IniRead, Output, ini\Main.ini, 1, Output
return

