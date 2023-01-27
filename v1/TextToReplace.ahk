#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
SetBatchLines, -1

#Include, Included\SimpleButton.ahk
#Include, Included\Close_Button.ahk
#Include, Included\Minimize_Button.ahk
#Include, Included\Plus_Button.ahk
#Include, Included\Settings_Button.ahk
#Include, Included\Plane.ahk
#Include, Included\Switch.ahk



;================INI READ================

    IniRead, Linenumber, ini\Main.ini, LineNumber, LineNumber
    IniRead, TotalLines, ini\Main.ini, TotalLines, TotalLines

    ActiveColorTheme := 2

;=-=-=-=-=-=-=-=-INI READ=-=-=-=-=-=-=-=-

;================VARIABLES================

    ;================GUI VARS================

        Width := 880
        Height := 610

        ;================BOARDS================

            CurrentBoars := 0

            CurrentX := 80
            CurrentY := 45
            IncreaseX := 265
            IncreaseY := 165

        ;=-=-=-=-=-=-=-=-BOARDS=-=-=-=-=-=-=-=-

    ;=-=-=-=-=-=-=-=-GUI VARS=-=-=-=-=-=-=-=-

    ;================COLOR THEME================
        if (ActiveColorTheme == 1) {
            BackgroundColor := "000080"
            HeaderColor := "000040"
            SideBarColor := "0010FF"
            FooterColor := "0000FF"
            FontColor := "FFFFFF"


            ButtonColor := "FFFFFF"
            ButtonBackgroundColor := "0000E6"
            ButtonBorderColor := "FFFFFF"

            HButtonColor := "0000E6"
            HButtonBackgroundColor := "00FFFF"
            HButtonBorderColor := "00FF00"

            PButtonColor := "00E699"
            PButtonBackgroundColor := "00004D"
            PButtonBorderColor := "000040"


            BarButtonColor := "FFFFFF"
            BarButtonBackgroundColor := "0000A8"
            BarButtonBorderColor := "FFFFFF"

            HBarButtonColor := "00FFFF"
            HBarButtonBackgroundColor := "00004D"
            HBarButtonBorderColor := "00FF00"

            PBarButtonColor := "0000FF"
            PBarButtonBackgroundColor := "00FFFF"
            PBarButtonBorderColor := "000040"


            IconButtonColor := "FFFFFF"
            IconButtonSecondColor := "FF000040"
            IconButtonShadowColor := "000000"
            IconButtonBorderColor := "FFFFFF"

            HIconButtonColor := "00FF00"
            HIconButtonSecondColor := "FF000040"
            HIconButtonShadowColor := "000000"
            HIconButtonBorderColor := "FFFFFF"

            PIconButtonColor := "00FFFF"
            PIconButtonSecondColor := "FF000040"
            PIconButtonShadowColor := "000000"
            PIconButtonBorderColor := "FFFFFF"


            PlaneBackgroundColor := "0000A0"
            SecondPlaneBackgroundColor := "000080"
            PlaneHeaderColor := "050068"
            PlaneFooterColor := "0000FF"

            PlaneFontColor := "FFFFFF"

            ;================SWITCH COLORS================
                Switch_Off_Color:="000020"
                Switch_Off_Border_Color:="000000"
                Switch_Off_Slide_Color:="000040"
                Switch_Off_Slide_Border_Color:="0080FF"

                Switch_On_Color:="00FF00"
                Switch_On_Border_Color:="000000"
                Switch_On_Slide_Color:="0000FF"
                Switch_On_Slide_Border_Color:="000000"


                Switch_Off_Hover:="000040"
                Switch_Off_Hover_Border:="000000"
                Switch_Off_HSlide_Color:="000080"
                Switch_Off_HSlide_Border_Color:="00FFFF"

                Switch_On_Hover:="00FF00"
                Switch_On_Hover_Border:="FFFFFF"
                Switch_On_HSlide_Color:="000080"
                Switch_On_HSlide_Border_Color:="FFFFFF"


                Switch_Off_Pressed:="000080"
                Switch_Off_Pressed_Border:="FFFFFF"
                Switch_Off_PSlide_Color:="000080"
                Switch_Off_PSlide_Border_Color:="FFFFFF"

                Switch_On_Pressed:="00FF00"
                Switch_On_Pressed_Border:="000000"
                Switch_On_PSlide_Color:="0000FF"
                Switch_On_PSlide_Border_Color:="000000"

                ; Switch_Off_Color
                    ; Switch_Off_Border_Color
                    ; Switch_Off_Slide_Color
                    ; Switch_Off_Slide_Border_Color
                    ; Switch_On_Color
                    ; Switch_On_Border_Color
                    ; Switch_On_Slide_Color
                    ; Switch_On_Slide_Border_Color
                    ; Switch_Off_Hover
                    ; Switch_Off_Hover_Border
                    ; Switch_Off_HSlide_Color
                    ; Switch_Off_HSlide_Border_Color
                    ; Switch_On_Hover
                    ; Switch_On_Hover_Border
                    ; Switch_On_HSlide_Color
                    ; Switch_On_HSlide_Border_Color
                    ; Switch_Off_Pressed
                    ; Switch_Off_Pressed_Border
                    ; Switch_Off_PSlide_Color
                    ; Switch_Off_PSlide_Border_Color
                    ; Switch_On_Pressed
                    ; Switch_On_Pressed_Border
                    ; Switch_On_PSlide_Color
                ; Switch_On_PSlide_Border_Color
            ;=-=-=-=-=-=-=-=-SWITCH COLORS=-=-=-=-=-=-=-=-
        }
        
        else if (ActiveColorTheme == 2) {
            BackgroundColor := "121212"
            HeaderColor := "000000"
            SideBarColor := "181818"
            FooterColor := "2B2B2B"
            FontColor := "A8A8A8"


            ButtonColor := "FFFFFF"
            ButtonBackgroundColor := "000028"
            ButtonBorderColor := "A8A8A8"

            HButtonColor := "009199"
            HButtonBackgroundColor := "000000"
            HButtonBorderColor := "FFFFFF"

            PButtonColor := "00E699"
            PButtonBackgroundColor := "00004D"
            PButtonBorderColor := "000040"


            BarButtonColor := "FFFFFF"
            BarButtonBackgroundColor := "00232E"
            BarButtonBorderColor := "A8A8A8"

            HBarButtonColor := "009199"
            HBarButtonBackgroundColor := "000000"
            HBarButtonBorderColor := "000080"

            PBarButtonColor := "000000"
            PBarButtonBackgroundColor := "009199"
            PBarButtonBorderColor := "A8A8A8"


            IconButtonColor := "FFFFFF"
            IconButtonSecondColor := "00232E"
            IconButtonShadowColor := "000000"
            IconButtonBorderColor := "FFFFFF"

            HIconButtonColor := "00232E"
            HIconButtonSecondColor := "009199"
            HIconButtonShadowColor := "FFFFFF"
            HIconButtonBorderColor := "FFFFFF"

            PIconButtonColor := "009199"
            PIconButtonSecondColor := "00232E"
            PIconButtonShadowColor := "000000"
            PIconButtonBorderColor := "FFFFFF"


            PlaneBackgroundColor := "181818"
            SecondPlaneBackgroundColor := "121212"
            PlaneHeaderColor := "0D0D0D"
            PlaneFooterColor := "0D0D0D"

            PlaneFontColor := "A8A8A8"


            ;================SWITCH COLORS================
                Switch_Off_Color:="000028"
                Switch_Off_Border_Color:="121212"
                Switch_Off_Slide_Color:="000040"
                Switch_Off_Slide_Border_Color:="0080FF"

                Switch_On_Color:="00CCCC"
                Switch_On_Border_Color:="000000"
                Switch_On_Slide_Color:="0000FF"
                Switch_On_Slide_Border_Color:="000000"


                Switch_Off_Hover:="000040"
                Switch_Off_Hover_Border:="000000"
                Switch_Off_HSlide_Color:="000080"
                Switch_Off_HSlide_Border_Color:="00FFFF"

                Switch_On_Hover:="00CCCC"
                Switch_On_Hover_Border:="FFFFFF"
                Switch_On_HSlide_Color:="000080"
                Switch_On_HSlide_Border_Color:="FFFFFF"


                Switch_Off_Pressed:="000080"
                Switch_Off_Pressed_Border:="FFFFFF"
                Switch_Off_PSlide_Color:="000080"
                Switch_Off_PSlide_Border_Color:="FFFFFF"

                Switch_On_Pressed:="00CCCC"
                Switch_On_Pressed_Border:="000000"
                Switch_On_PSlide_Color:="0000FF"
                Switch_On_PSlide_Border_Color:="000000"

                ; Switch_Off_Color
                    ; Switch_Off_Border_Color
                    ; Switch_Off_Slide_Color
                    ; Switch_Off_Slide_Border_Color
                    ; Switch_On_Color
                    ; Switch_On_Border_Color
                    ; Switch_On_Slide_Color
                    ; Switch_On_Slide_Border_Color
                    ; Switch_Off_Hover
                    ; Switch_Off_Hover_Border
                    ; Switch_Off_HSlide_Color
                    ; Switch_Off_HSlide_Border_Color
                    ; Switch_On_Hover
                    ; Switch_On_Hover_Border
                    ; Switch_On_HSlide_Color
                    ; Switch_On_HSlide_Border_Color
                    ; Switch_Off_Pressed
                    ; Switch_Off_Pressed_Border
                    ; Switch_Off_PSlide_Color
                    ; Switch_Off_PSlide_Border_Color
                    ; Switch_On_Pressed
                    ; Switch_On_Pressed_Border
                    ; Switch_On_PSlide_Color
                ; Switch_On_PSlide_Border_Color
            ;=-=-=-=-=-=-=-=-SWITCH COLORS=-=-=-=-=-=-=-=-
        }

        DefaultButtonColors := "Window:=Main," "Color:=" ButtonColor ",BackgroundColor:=" ButtonBackgroundColor ",BorderColor:=" ButtonBorderColor ",HColor:=" HButtonColor ",HBackgroundColor:=" HButtonBackgroundColor ",HBorderColor:=" HButtonBorderColor ",PColor:=" PButtonColor ",PBackgroundColor:=" PButtonBackgroundColor ",PBorderColor:=" PButtonBorderColor,
        DefaultBarButtonColors := "Window:=Main," "Color:=" BarButtonColor ",BackgroundColor:=" BarButtonBackgroundColor ",BorderColor:=" BarButtonBorderColor ",HColor:=" HBarButtonColor ",HBackgroundColor:=" HBarButtonBackgroundColor ",HBorderColor:=" HBarButtonBorderColor ",PColor:=" PBarButtonColor ",PBackgroundColor:=" PBarButtonBackgroundColor ",PBorderColor:=" PBarButtonBorderColor,

        PlusButtonColors := "Window:=Main," "Color:=" IconButtonColor ",Shadow_Color:=" IconButtonShadowColor ",Hover:=" HIconButtonColor ",Hover_Shadow:=" HIconButtonShadowColor ",Pressed:=" PIconButtonColor ",Pressed_Shadow:=" PIconButtonShadowColor,
        SettingsButtonColors := "Window:=Main," "Color:=" IconButtonColor ",Shadow_Color:=" IconButtonShadowColor ",Slide_Color:=" IconButtonSecondColor ",Slide_Border_Color:=" IconButtonBorderColor ",Hover:=" HIconButtonColor ",Hover_Shadow:=" IconButtonShadowColor ",HSlide_Color:=" HIconButtonSecondColor ",HSlide_Border_Color:=" HIconButtonBorderColor ",Pressed:=" PIconButtonColor ",Pressed_Shadow:=" PIconButtonShadowColor ",PSlide_Color:=" PIconButtonSecondColor ",PSlide_Border_Color:=" PIconButtonBorderColor
        PlaneColors := "Window:=Main," "HeaderHeight:=25," "FooterHeight:=25" ",Color1:=" PlaneBackgroundColor ",HeaderColor:=" PlaneHeaderColor ",FooterColor:=" PlaneFooterColor ",FontColor:=" PlaneFontColor
        SwitchColors := "Window:=Main," "Off_Color:=" Switch_Off_Color ",Off_Border_Color:=" Switch_Off_Border_Color ",Off_Slide_Color:=" Switch_Off_Slide_Color ",Off_Slide_Border_Color:=" Switch_Off_Slide_Border_Color ",On_Color:=" Switch_On_Color ",On_Border_Color:=" Switch_On_Border_Color ",On_Slide_Color:=" Switch_On_Slide_Color ",On_Slide_Border_Color:=" Switch_On_Slide_Border_Color ",Off_Hover:=" Switch_Off_Hover ",Off_Hover_Border:=" Switch_Off_Hover_Border ",Off_HSlide_Color:=" Switch_Off_HSlide_Color ",Off_HSlide_Border_Color:=" Switch_Off_HSlide_Border_Color ",On_Hover:=" Switch_On_Hover ",On_Hover_Border:=" Switch_On_Hover_Border ",On_HSlide_Color:=" Switch_On_HSlide_Color ",On_HSlide_Border_Color:=" Switch_On_HSlide_Border_Color ",Off_Pressed:=" Switch_Off_Pressed ",Off_Pressed_Border:=" Switch_Off_Pressed_Border ",Off_PSlide_Color:=" Switch_Off_PSlide_Color ",Off_PSlide_Border_Color:=" Switch_Off_PSlide_Border_Color ",On_Pressed:=" Switch_On_Pressed ",On_Pressed_Border:=" Switch_On_Pressed_Border ",On_PSlide_Color:=" Switch_On_PSlide_Color ",On_PSlide_Border_Color:=" Switch_On_PSlide_Border_Color 
    ;=-=-=-=-=-=-=-=-COLOR THEME=-=-=-=-=-=-=-=-


;=-=-=-=-=-=-=-=-VARIABLES=-=-=-=-=-=-=-=-


;================GUI================

    ;================WINDOW================

        Gui, Main:+LastFound
        Gui, Main:Color, %BackgroundColor%
        Gui, Main:Margin, 0, 0

        
        

        Gui, Main:Add, Progress, % "x-1 y" (Height-65) " w" (Width+2) " h65 Background" FooterColor " Disabled"
        Gui, Main:Add, Progress, % "x-1 y-1 w66 h" (Height+2) " Background" SideBarColor " Disabled"
        Gui, Main:Add, Progress, % "x-1 y-1 w" (Width+2) " h40 Background" HeaderColor " Disabled"

        Create_Close_Button("x:=" (Width-35), "y:=" (Height/14-(Height/14)), "w:=30", "h:=30", "Window:=Main")
        Create_Minimize_Button("x:=" (Width-70), "y:=" (Height/14-(Height/14)), "w:=30", "h:=30", "Window:=Main")
        
        Gui, Main:Font, s14 c%FontColor%, Impact
        Gui, Main:Add, Text, % "x0 y0 w" Width " h" (Height/14) " BackgroundTrans Center 0x200 gGuiMove", Text To Replace

    ;=-=-=-=-=-=-=-=-WINDOW=-=-=-=-=-=-=-=-

    ;================SIDEBAR================

        Create_Plus_Button("x:=8", "y:=50", "w:=50", "h:=50", PlusButtonColors, "Radius:=5")
        
        Create_Settings_Button("x:=8", "y:=" (Height-58), "w:=50", "h:=50", SettingsButtonColors, "ToolTip:=Settings", "OnTopColor:=" SideBarColor)

    ;=-=-=-=-=-=-=-=-SIDEBAR=-=-=-=-=-=-=-=-
    
    ;================SECTION================
        ;Width: 814
        ;Height: 510
        ;================ADD NEW================

            Create_Plane("x:=85", "y:=50", "w:=370", "h:=220", "Footer:=False", "Title:=Input", "OnTopColor:=" BackgroundColor, PlaneColors)

            Gui, Main:Font, s12 cBlack, Impact
            Gui, Main:Add, Edit, x120 y110 w300 r1 Center Border Limit30 vInput

            Create_Plane("x:=105", "y:=150", "w:=330", "h:=100", "Footer:=False", "Title:=Input Options", "OnTopColor:=" PlaneBackgroundColor, PlaneColors, "Color1:=" SecondPlaneBackgroundColor, "HeaderHeight:=16")


            Create_Plane("x:=480", "y:=50", "w:=380", "h:=220", "Footer:=False", "Title:=Output", "OnTopColor:=" BackgroundColor, PlaneColors)

            Gui, Main:Font, s12 cBlack, Impact
            Gui, Main:Add, Edit, x520 y110 w300 r6 Center Border vOutput


            Create_Plane("x:=85", "y:=285", "w:=775", "h:=240", "Footer:=False", "Title:=Options", "Radius:=1", "OnTopColor:=" BackgroundColor, PlaneColors)

            Create_Switch("x:=120", "y:=340", "w:=40", "Label:=Void", SwitchColors, "OnTopColor:=" PlaneBackgroundColor)
            Create_Switch("x:=200", "y:=340", "w:=100", "Label:=Void", "Thickness:=4", SwitchColors, "OnTopColor:=" PlaneBackgroundColor)
            
            

            CreateButton("x:=760", "y:=555", "w:=100", "h:=40", "Text:=Save", "FontSize:=16", "Variable:=Save", "Label:=Save", "Radius:=0", DefaultBarButtonColors, "Color:=00FF00", "OnTopColor:=" FooterColor)
            global Save

            CreateButton("x:=86", "y:=555", "w:=100", "h:=40", "Text:=Cancel", "FontSize:=15", "Variable:=Cancel", "Label:=Cancel", "Radius:=0", DefaultBarButtonColors, "Color:=FF0000", "OnTopColor:=" FooterColor)
            global Cancel

        ;=-=-=-=-=-=-=-=-ADD NEW=-=-=-=-=-=-=-=-
        ;================BOARDS================
            ; Create_Plane("x:=80", "y:=45", "w:=250", "h:=150", "OnTopColor:=000080", PlaneColors)

            ; Create_Plane("x:=345", "y:=45", "w:=250", "h:=150", "OnTopColor:=000080", PlaneColors)
            ; Create_Plane("x:=610", "y:=45", "w:=250", "h:=150", "OnTopColor:=000080", PlaneColors)

            ; Create_Plane("x:=80", "y:=210", "w:=250", "h:=150", "OnTopColor:=000080", PlaneColors)
            ; Create_Plane("x:=345", "y:=210", "w:=250", "h:=150", "OnTopColor:=000080", PlaneColors)
            ; Create_Plane("x:=610", "y:=210", "w:=250", "h:=150", "OnTopColor:=000080", PlaneColors)


            ; Create_Plane("x:=80", "y:=375", "w:=250", "h:=150", "OnTopColor:=000080", PlaneColors)
            ; Create_Plane("x:=345", "y:=375", "w:=250", "h:=150", "OnTopColor:=000080", PlaneColors)
            ; Create_Plane("x:=610", "y:=375", "w:=250", "h:=150", "OnTopColor:=000080", PlaneColors)
        ;=-=-=-=-=-=-=-=-BOARDS=-=-=-=-=-=-=-=-
    ;=-=-=-=-=-=-=-=-SECTION=-=-=-=-=-=-=-=-


    ;Gui, Main:Add, Progress, x472 y40 w2 h800 Background000040 Disabled
    ;Gui, Main:Add, Progress, x66 y294 w900 h2 Background000040 Disabled

    ;Gui, Main:Add, Progress, x439 y0 w2 h800 Background00FFFF Disabled
    ;Gui, Main:Add, Progress, x0 y274 w900 h2 Background00FFFF Disabled

    Gui, Main: -Caption
    Gui, Main:Show, w%Width% h%Height%, Text To Replace

    WinSet, Region, 0-0 w%Width% h%Height% r10-10, Text To Replace

    if FileExist("Executed\ExecuteManager.ahk") {
        #Include, Executed\ExecuteManager.ahk
    }
    Return
;=-=-=-=-=-=-=-=-GUI=-=-=-=-=-=-=-=-


; Test:
    ;     CoordMode, Mouse, Reletive
    ;     while GetKeyState("LButton") {
    ;         MouseGetPos, PosX, PosY, , ,
    ;         GuiControl, MoveDraw, TestProg, % "x"(PosX-50) " y" (PosY-50)
    ;         GuiControl, MoveDraw, Test, % "x"(PosX-50) " y" (PosY-50)
    ;     }
; return


Save:
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

    InputCount := % StrLen(Input)

    FileAppend,
    (
    #SingleInstance, Force

    ThisLineNumber := %LineNumber%
    IniRead, ThisActive, ini\Main.ini, %LineNumber%, Active
    if (ThisActive == "false") {
        return
    }

    :*:%Input%::
    LoopTimes := %InputCount%

    Send, %Input%

    ToolTip, Press Midle Mous button to replace with "%NewOutput%", PressToReplace
    WaitForKeyPress := 1
    SetTimer, PressToReplace, -2000

    IniRead, Output, ini\Main.ini, %LineNumber%, Output
    return


    ), Executed\%Input%.ahk

    FileAppend, 
    (
    
    #Include, Executed\%Input%.ahk
    ), Executed\ExecuteManager.ahk


    Linenumber += 1
    TotalLines += 1
    IniWrite, %Linenumber%, ini\Main.ini, Linenumber, Linenumber
    IniWrite, %TotalLines%, ini\Main.ini, Linenumber, TotalLines

return

PlusButton:

return

SettingsButton:

return













Void:

return

GuiMove:
    PostMessage, 0xA1, 2
return

MinimizeButton:
    WindowTransparency := 250
    Loop, 25 {
        WinSet, Transparent, %WindowTransparency%
        WindowTransparency -= 10.2
        sleep, 8
    }
    
    Gui Minimize
    WinSet, Transparent, 255
return

MainGuiEscape:
MainGuiClose:
CloseButton:
    Gui, Main:Minimize
    ;Some conditions
    ExitApp
return