#SingleInstance, Force
#Include, RemomeLine\RemoveLine1.ahk

LineNumber = 0
LineNumberDisabled = 0

AddLineFirstY := 50

LineNumber++
Gui, Font, cWhite s16, Impact
Gui, Add, Text, vTxt1%LineNumber% x20 y20, %LineNumber%

Gui, Font, cBlack s16, Impact
Gui, Add, Edit, vInput%LineNumber% x50 y20 w150

Gui, Font, cWhite s10, Arial
Gui, Add, Text, vTxt2%LineNumber% x+10 y+-25, <Gets replaced with>

Gui, Font, cBlack s16, Impact
Gui, Add, Edit, vOutput%LineNumber% x+14 y+-25 w200


Gui, Add, Button, gAddLine vAddLine x150 y280 w130 h34, +
Gui, Add, Button, gRemoveLine vRemoveLine x300 y280 w130 h34, -
GuiControl, Disable, RemoveLine

Gui, Add, Edit, R4 x100 y320 w360
Gui, Add, Button, gSubmit x480 y400 w100 h40, Submit

Gui, Font, cWhite s16, Impact

Gui, Color, Black
Gui, Show, w600 h450, Text Replacer


return


Submit:
    Gui, Submit
    Gui, Show
    Sleep, 1000
    MsgBox, 
    (
    %Input1%
    %Output1%
    %Input2%
    %Output2%
    ) 
return

; IniWrite, hello, Ini\Main.ini, hello, Input
; IniWrite, Hi there, Ini\Main.ini, hello, Replace

AddLine:
    if (LineNumber == 1) {
        AddLineFirstY += 18
    }

    else if (LineNumber > 1) {
        AddLineFirstY += 50
    }

    GuiControl, Enable, RemoveLine

    LineNumber++
    Gui, Font, cWhite s16, Impact
    Gui, Add, Text, vTxt1%LineNumber% x20 y%AddLineFirstY%, %LineNumber%

    Gui, Font, cBlack s16, Impact
    Gui, Add, Edit, vInput%LineNumber% x50 y+-25 w150

    Gui, Font, cWhite s10, Arial
    Gui, Add, Text, vTxt2%LineNumber% x+10 y+-25, <Gets replaced with>

    Gui, Font, cBlack s16, Impact
    Gui, Add, Edit, vOutput%LineNumber% x+14 y+-25 w200
return

RemoveLine:
    if (LineNumber == 1) {
        GuiControl, Disable, RemoveLine
        return
    }
    GuiControl, Hide, Txt1%LineNumber%
    GuiControl, Disable, Input%LineNumber%
    GuiControl, Hide, Txt2%LineNumber%
    GuiControl, Disable, Output%LineNumber%
    LineNumber--
    return
