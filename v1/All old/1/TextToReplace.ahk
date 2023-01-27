#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;================GUI================

    IniRead, LineNumber, Ini\Main.ini, LineNumber, LineNumber

    Gui, Main:Add, Pic, BackgroundTrans x0 y0 w-1 h400, Images\BG.png

    Gui, Main:Font, cBlack s16, Impact
    Gui, Main:Add, Edit, vInput x20 y100 w150

    Gui, Main:Font, cWhite s12, Arial
    Gui, Main:Add, Text, BackgroundTrans vTxt x+8 y108, <Gets replaced with>

    Gui, Main:Font, cBlack s16, Impact
    Gui, Main:Add, Edit, vOutput r4 x+12 y60 w240

    Gui, Main:Font, cWhite s12, Impact
    Gui, Main:Add, Button, +Center gMainGuiClose x576 y0 w24 h20, X

    Gui, Main:Font, cWhite s16, Impact
    Gui, Main:Add, Button, gTestIt x20 y280 w100 h40, Test it
    Gui, Main:Add, Button, x220 y280 w140 h40, Edit Submited
    Gui, Main:Add, Button, 0x1000  gSubmit x480 y280 w100 h40, Submit

    Gui, Main:Default
    Gui, Main:Color, Black
    Gui, Main:-Border
    Gui, Main:Show, w600 h340, Text To Replace / Main
return


Submit:

return

TestIt:
    Gui, TestIt:New
    Gui, Font, cGreen s16, Impact
    Gui, TestIt:Add, Edit, R4 x20 y20 w360
    ;Gui, TestIt:-Border
    Gui, TestIt:Show, w400 h160, Test it!
return






MainGuiClose:
    IniWrite, %LineNumber%, Ini\Main.ini, LineNumber, LineNumber
    Process, Close, % ExecutedScript
    ExitApp
return