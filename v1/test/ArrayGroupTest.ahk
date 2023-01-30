#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

ProgNumber := 1

Global ProgGroup1 := []

Gui, Add, Progress, x10 y20 w40 h40 BackgroundFF0000  Disabled Border vProg1
Gui, Add, Progress, x+10 y20 w40 h40 BackgroundFF0000 Disabled Border vProg2
Gui, Add, Progress, x+10 y20 w40 h40 BackgroundFF0000 Disabled Border vProg3
Gui, Add, Progress, x+10 y20 w40 h40 BackgroundFF0000 Disabled Border vProg4
Gui, Add, Progress, x+10 y20 w40 h40 BackgroundFF0000 Disabled Border vProg5
Gui, Add, Progress, x+10 y20 w40 h40 BackgroundFF0000 Disabled Border vProg6
Gui, Add, Progress, x+10 y20 w40 h40 BackgroundFF0000 Disabled Border vProg7
Gui, Add, Progress, x+10 y20 w40 h40 BackgroundFF0000 Disabled Border vProg8

ProgGroup%ProgNumber%.Push("Prog1","Prog2","Prog3","Prog4","Prog5","Prog6","Prog7","Prog8")

Gui, Add, Button, x200 y200 w100 h40 gHide, Hide

CurrentList := % element "|"
for index, element in ProgGroup1
{
    ArrayList := StrReplace(CurrentList, "|", "Index " index ": " element "`n|")
    CurrentList := ArrayList
}

ArrayList := StrReplace(CurrentList, "|", BackSpace)
msgbox, % ArrayList
;msgbox, % ProgGroup1.Length()

Gui, Color, 000040
Gui, Show, w400 h300, Array Group Test
return


Hide:
    For index, ObjectVar in ProgGroup1 {
        GuiControl, Hide, % ObjectVar
        Sleep, 50
    }

return