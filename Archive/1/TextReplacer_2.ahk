#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%


Run, Executed\TextReplacerExecute.ahk,,, ExecutedScript

;================GUI================

    IniRead, LineNumber, Ini\Main.ini, LineNumber, LineNumber

    Gui, Main:Add, Pic, BackgroundTrans x0 y0 w600 h-1, Images\BG.png

    Gui, Main:Font, cBlack s16, Impact
    Gui, Main:Add, Edit, vInput x20 y100 w150

    Gui, Main:Font, cWhite s12, Arial
    Gui, Main:Add, Text, BackgroundTrans vTxt x+8 y108, <Gets replaced with>

    Gui, Main:Font, cBlack s16, Impact
    Gui, Main:Add, Edit, vOutput r4 x+12 y60 w240


    Gui, Main:Font, cWhite s16, Impact
    ;Gui, Main:Add, Button, gTestIt x20 y280 w100 h40, Test it
    Gui, Main:Add, Button, gEditSubits x220 y280 w140 h40, Edit Submited
    Gui, Main:Add, Button, gSubmit x480 y280 w100 h40, Submit

    Gui, Main:Color, Black
    Gui, Edit:+Border
    Gui, Main:Show, w600 h340, Text Replacer / Main
Return


Submit:
    Gui, Submit, NoHide
    
    If (Input == "") {
        MsgBox, Nothing was in the Input field
        return
    }

    If (Output == "") {
        MsgBox, Nothing was in the Output field
        return
    }

    NewString := StrReplace(Output,"`r`n", "<_newline_>")
    NewString := StrReplace(NewString,"`n", "<_newline_>")
    NewOutput := StrReplace(NewString,"<_newline_>", "``n")
    Output := StrReplace(NewString,"<_newline_>", "{Enter}")

    IniWrite, true, Ini\Main.ini, %LineNumber%, Active
    IniWrite, %Input%, Ini\Main.ini, %LineNumber%, Input
    IniWrite, %Output%, Ini\Main.ini, %LineNumber%, Output

    
    InputCount = % StrLen(Input)

    FileAppend,
    (
    :*:%Input%::
    LineNumber = %LineNumber%
    LoopTimes = %InputCount%

    Send, %Input%

    ToolTip, Press Midle Mous button to replace with "%NewOutput%", PressToReplace
    SetTimer, PressToReplace, -2000

    IniRead, Output, Ini\Main.ini, %LineNumber%, Output
    return


    ), Executed\TextReplacerExecute.ahk

    ; FileAppend,
    ; (
    ; Gui, Edit:Add, Text, x20 y20, %Input%
    ; Gui, Edit:Add, Text, x100 y20, %Output%
    ; ), Gui\EditSubmited.ahk

    GuiControl,, Input,
    GuiControl,, Output,

    LineNumber++
    IniWrite, %LineNumber%, Ini\Main.ini, LineNumber, LineNumber
return

; TestIt:
;     Gui, TestIt:New
;     Gui, Font, cGreen s16, Impact
;     Gui, TestIt:Add, Edit, R4 x20 y20 w360
;     Gui, TestIt:Show, w400 h160, Test it!
; return

EditSubits:
#Include, GUI\EditSubmited_2.ahk
return


MainGuiClose:
    IniWrite, %LineNumber%, Ini\Main.ini, LineNumber, LineNumber
    Process, Close, % ExecutedScript
    ExitApp
return
