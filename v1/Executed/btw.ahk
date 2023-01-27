#SingleInstance, Force

    ThisLineNumber := 2
    IniRead, ThisActive, ini\Main.ini, 2, Active
    if (ThisActive == "false") {
        return
    }

    :*:btw::
    LoopTimes := 3

    Send, btw

    ToolTip, Press Midle Mous button to replace with "by the way", PressToReplace
    WaitForKeyPress := 1
    SetTimer, PressToReplace, -2000

    IniRead, Output, ini\Main.ini, 2, Output
    return

