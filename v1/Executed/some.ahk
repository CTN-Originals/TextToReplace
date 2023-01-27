#SingleInstance, Force

    ThisLineNumber := 3
    IniRead, ThisActive, ini\Main.ini, 3, Active
    if (ThisActive == "false") {
        return
    }

    :*:some::
    LoopTimes := 4

    Send, some

    ToolTip, Press Midle Mous button to replace with "thing", PressToReplace
    WaitForKeyPress := 1
    SetTimer, PressToReplace, -2000

    IniRead, Output, ini\Main.ini, 3, Output
    return

