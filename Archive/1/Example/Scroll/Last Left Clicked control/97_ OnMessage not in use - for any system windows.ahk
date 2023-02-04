


	;tested in Autohotkey 32 bit unicode

	;Scroll Gui Windows with Mouse Wheels:
	; - press "F11" or click "Mouse Middle Button" \ - Left Click on Gui windows scroll bars \ - Left Click on any Gui windows blank areas or non-client areas

	;Shift + WheelDown = Scroll Gui Windows to the Right \ Shift + WheelUp = Scroll Gui Windows to the Left 

	;Scroll Controls with Mouse Wheels:
	; - Left click a control to scroll it!


gui, +resize

gui, add, combobox,   w100 r5, 1|2|3|4|5|6|7|8|9|10
loop, 3
gui, add, edit, x+5  w100,

gui, add, edit, xm  w100 r3 -VScroll, Press "F12" to show The Last Left Clicked Control!
gui, add, edit, x+5  w100 r3, Press "F11" to blank The Last Left Clicked Control!
gui, add, edit, x+5  w100 r3 +HScroll -VScroll, Mouse "Middle" `nButton do the same `nas "F11"
gui, add, edit, x+5  w100 r3 +HScroll +VScroll, 

gui, add, listview, xm w100 BackgroundWhite Grid , 1|2|3  		;0x8000   NoSortHdr
gui, add, listview, x+5 w100 BackgroundWhite Grid, 1
loop, 10
LV_Add("", a_index)
LV_ModifyCol(1, 25)
gui, add, listview, x+5 w100 BackgroundWhite Grid, 111111|222222|333333|222222|333333|222222|333333|222222|333333
gui, add, listview, x+5 w100 BackgroundWhite Grid, 1|2|3  
loop, 10
LV_Add("", a_index)

gui, add, listbox, xm w100 h75,  1|2|
gui, add, listbox, x+5 w100 h75,  0|1|2|3|4|5|6|7|8|9
gui, add, listbox, x+5 w100 h75 +hscroll,  0000000000000000000000|1|2
gui, add, listbox, x+5 w100 h75 +hscroll,  0000000000000000000000|1|2|3|4|5|6|7|8|9

Gui, Add, TreeView, xm w100 h75
P1 := TV_Add("Test")
P1C1 .= TV_Add("Parent 1's first child", P1)  ; Specify P1 to be this item's 
Gui, Add, TreeView, x+5 w100 h75
P1 := TV_Add("Test", , "Expand")
loop, 10
P1C1 .= TV_Add(a_index, P1)  ; Specify P1 to be this item's 
Gui, Add, TreeView, x+5 w100 h75
P1 := TV_Add("Test", , "Expand")
P1C1 .= TV_Add("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTt", P1)  ; Specify P1 to be this item's 
Gui, Add, TreeView, x+5 w100 h75
P1 := TV_Add("Test", , "Expand")
loop, 10
P1C1 .= TV_Add(a_index " - TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTt", P1)  ; Specify P1 to be this item's 

;It seems that "+hscroll" does not work with "DropDownList"
gui, add, ddl, xm w100 +hscroll, Click||1|2
gui, add, ddl, x+5 w100 +hscroll, Click||1|2|2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |22222222222222222222222222222222222222222222222222222222222222222|End

gui, show, w390 h350

return

F12::	;______________ F12 ___________________	

tooltip, % "Last Left Clicked Control: `n`n ClassNN: " LastLeftClickedControl("ClassNN") "`n`n Hwnd: " LastLeftClickedControl("Hwnd")

return

f11::	;___________ F11 ___________________

LastLeftClickedControl("blank")	;blank "LastLeftClickedControl()" function static var values

return

guiclose:	;___________ Gui close _______________
exitapp


~LButton::	;____________ Mouse "Left" Button ____________

	;"~" keeps LButton Original function

LastLeftClickedControl( )	;keeps track of the system last left clicked control

return


LastLeftClickedControl(Option := "")	;________________ Last Left Clicked Control (Function) ____________________
{
	;Option: "ClassNN" returns Control ClassNN \ "Hwnd" returns Control Hwnd \ "Blank" blanks ClassNN and Hwnd of the last clicked control

Static ControlClassNN, ControlHwnd	;"Static" variables are always implicitly "local", but differ from "locals" variables because their values are remembered between calls.

if Option = ClassNN
return, ControlClassNN

if Option = Hwnd
return, ControlHwnd

	if Option = Blank
	{
	ControlClassNN := ControlHwnd := ""	;blank function static var values
	return
	}

MouseGetPos, , , , ControlClassNN, 1	;"ControlClassNN" is the name of the variable in which to store the name (ClassNN) of the control under the mouse cursor. If the control cannot be determined, this variable will be made blank.
				;"0" or "blank", "1" - Stores the control's ClassNN (in this case "1" is recommended)

MouseGetPos, , , , ControlHwnd, 3	;"2" or "3",  Stores the control's HWND id number, instead the control's ClassNN (in this case "3" is recommended)

	;ToolTip, ClassNN: %ControlClassNN% `n`n Hwnd: %ControlHwnd%
}


;____________________________________________Scrollable Gui_____________________________________________


GuiSize:	;_____Gui Size______

Gui%A_Gui%Width = %A_GuiWidth%	;necessary because "A_GuiWidth" and "A_GuiHeight" only return the correct gui windows size if "GuiSize" label is launched by resizing gui windows, otherwise, incorrect 0 and 32768 values will be returned!
Gui%A_Gui%Height = %A_GuiHeight%

%A_Gui%MostLeftControl := %A_Gui%MostLeftControl		;tunrs The "MostLeft\Top\Right\BottomControls" variables into Global Dynamic variables (preserving their original values) 
%A_Gui%MostTopControl := %A_Gui%MostTopControl		;so, "MostLeft\Top\Right\BottomControls" values from "Main Script" are visible to "UpdateScrollBars()" function and vice-versa! 
%A_Gui%MostRightControl := %A_Gui%MostRightControl
%A_Gui%MostBottomControl := %A_Gui%MostBottomControl

if %A_Gui%GuiScrollableAtExecution != 0
{
UpdateScrollBars(A_Gui, A_GuiWidth, A_GuiHeight, 1, 20, 20, 20, 20)	;"UpdateOption = 1" (Slow), The Most Left\Top\Right\Bottom controls will be detected\defined at script execution 
							;see notes below at "UpdateScrollBars()" function
							;"20"  Left\Top\Right\Bottom Margins (must be the same value for any "UpdateScrollBars()" in use)

%A_Gui%GuiScrollableAtExecution = 0				
}
else
UpdateScrollBars(A_Gui, A_GuiWidth, A_GuiHeight, 2, 20, 20, 20, 20)	;"UpdateOption = 2" (Fast), to be used if The Most Left\Top\Right\Bottom controls are already known\detected\defined!
							; - for "UpdateOption = 1", The more controls added, More slow will be "UpdateScrollBars()" function (because of  "Loop, Parse, ..." in use)
							; - "UpdateOption = 2" prevents slowness from "UpdateOption = 1" because "Loop, Parse, ..." is not used! 	
							; - see more notes below at "UpdateScrollBars()" function
							;"20"  Left\Top\Right\Bottom Margins (must be the same value for any "UpdateScrollBars()" in use)

return


ScrollUpLeft:	;________Scroll Up / Left Edge (prevents blank spaces while adding new controls - Not in use anymore, X Y W H ref positions used instead)_______

SendMessage, 0x115, 6, 0, ,A 		;moves vertical scroll to windows top (to prevent "blank" areas in gui windows)
				;"1" means move down ("3" moves down higher)
				;"0" means move up ("2" moves up higher)
				;"6" moves top
				;"7" moves to bottom
				; "A" may mean for any active windows (yet to be confirmed)

SendMessage, 0x114, 6, 0, , A		;moves horizontal scroll to windows left edge (to prevent "blank" areas in gui windows)
				;"1" means move right ("3" moves right higher)
				;"0" means move left ("2" moves left higher)
				;"6" moves left edge
				;"7" moves to right edge
				; "A" may mean for any active windows (yet to be confirmed)
sleep 50
return

ScrollDownRight:	;________Scroll Down / Right Edge (prevents blank spaces while adding new controls - Not in use anymore, X Y W H ref positions used instead)_______
sleep 50

SendMessage, 0x115, 7, 0, ,A 		;moves vertical scroll to windows bottom 
				;"1" means move down ("3" moves down higher)
				;"0" means move up ("2" moves up higher)
				;"6" moves top
				;"7" moves to bottom
				; "A" may mean for any active windows (yet to be confirmed)

SendMessage, 0x114, 7, 0, , A		;moves horizontal scroll to windows left edge (to prevent "blank" areas in gui windows)
				;"1" means move right ("3" moves right higher)
				;"0" means move left ("2" moves left higher)
				;"6" moves left edge
				;"7" moves to right edge
				; "A" may mean for any active windows (yet to be confirmed)

return

#IfWinActive ahk_group AllScriptGuiWindows	;__________ Hotkeys below this line are only for this script gui windows _____________

	;see "GroupAllScriptGuiWindows( )" function below

WheelUp::
WheelDown::
+WheelUp::	;"+" Shift + WheelUp (Scroll Left)
+WheelDown::	;"+" Shift + WheelDown (Scroll Right)

if (LastLeftClickedControl("ClassNN") = "") 	;if "ClassNN" static variable from the fuction is blank
goto, ScrollGuiWindow

if (A_ThisHotkey = "WheelDown" or A_ThisHotkey = "WheelUp")	;wrong syntax => if (A_ThisHotkey = "WheelDown" or "WheelUp")
send {%A_ThisHotkey%}

if A_ThisHotkey = +WheelDown
send +{WheelDown}

if A_ThisHotkey = +WheelUp
send +{WheelUp}

return

~MButton::		;______ Mouse Middle Button ___________
	
	;"~" keeps MButton original function

LastLeftClickedControl("Blank")	;blank "LastLeftClickedControl()" function static variables
			;Scroll Gui Window instead gui controls

return

#IfWinActive	;_______________ Hotkeys below this line are for all system windows ___________________

ScrollGuiWindow:
    ; SB_LINEDOWN=1, SB_LINEUP=0, WM_HSCROLL=0x114, WM_VSCROLL=0x115
    OnScroll(InStr(A_ThisHotkey,"Down") ? 1 : 0, 0, GetKeyState("Shift") ? 0x114 : 0x115, WinExist())
return

GroupAllScriptGuiWindows( )   ;___________ Group All Gui Windows belonging to the script's process (Function) __________
{
Static RunAtScriptExecution := GroupAllScriptGuiWindows( )
GroupAdd, AllScriptGuiWindows, % "ahk_pid " DllCall("GetCurrentProcessId") . " ahk_class AutoHotkeyGUI"
}

;__________ Scroll Area Calculation Function _____________


UpdateScrollBars(GuiNum, GuiWidth, GuiHeight, UpdateOption, LeftMargin := 8, TopMargin := 8, RightMargin := 8, BottomMargin := 8)
{
    static SIF_RANGE=0x1, SIF_PAGE=0x2, SIF_DISABLENOSCROLL=0x8, SB_HORZ=0, SB_VERT=1
    
    Gui, %GuiNum%:Default
    Gui, +LastFound

if UpdateOption = 1		;The Most Left\Top\Right\Bottom controls will be detected\defined at script execution
{    			;for "UpdateOption = 1", The more controls added, More slow will be "UpdateScrollBars()" function (because of  "Loop, Parse, ..." in use)
			;"UpdateOption = 2" prevents slowness from "UpdateOption = 1" because "Loop, Parse, ..." is not used! 		

    ; Calculate scrolling area.
    Left := Top := 9999
    Right := Bottom := 0
    WinGet, ControlList, ControlList
    Loop, Parse, ControlList, `n
    {
        GuiControlGet, c, Pos, %A_LoopField%
        if (cX < Left)
	{
	Left := cX
	%GuiNum%MostLeftControl := A_LoopField
	}
        if (cY < Top)
	{
	Top := cY
	%GuiNum%MostTopControl := A_LoopField
	}
        if (cX + cW > Right)
	{
	Right := cX + cW
	%GuiNum%MostRightControl := A_LoopField
	}
        if (cY + cH > Bottom)
	{
	Bottom := cY + cH
	%GuiNum%MostBottomControl := A_LoopField
	}
    }
}

if UpdateOption = 2			;to be used if The Most Left\Top\Right\Bottom controls are already known\detected\defined!
{				;"UpdateOption = 2" prevents slowness from "UpdateOption = 1" because "Loop, Parse, ..." is not used!
				;for "UpdateOption = 2", The numbers of Total controls will not affect  the speed of "UpdateScrollBars()" function

    ; Calculate scrolling area.

guicontrolget, Temp, pos, % %GuiNum%MostLeftControl
Left :=  TempX

guicontrolget, Temp, pos, % %GuiNum%MostTopControl
Top := TempY

guicontrolget, Temp, pos, % %GuiNum%MostRightControl
Right := TempX + TempW

guicontrolget, Temp, pos, % %GuiNum%MostBottomControl
Bottom := TempY + TempH

	;msgbox, % Left " - " Top " - " Right " - "  Bottom
}

    Left -= LeftMargin
    Top -= TopMargin
    Right += RightMargin
    Bottom += BottomMargin

    ScrollWidth := Right-Left
    ScrollHeight := Bottom-Top
    
    ; Initialize SCROLLINFO.
    VarSetCapacity(si, 28, 0)
    NumPut(28, si) ; cbSize
    NumPut(SIF_RANGE | SIF_PAGE, si, 4) ; fMask
    
    ; Update horizontal scroll bar.
    NumPut(ScrollWidth, si, 12) ; nMax
    NumPut(GuiWidth, si, 16) ; nPage
    DllCall("SetScrollInfo", "uint", WinExist(), "uint", SB_HORZ, "uint", &si, "int", 1)
    
    ; Update vertical scroll bar.
;     NumPut(SIF_RANGE | SIF_PAGE | SIF_DISABLENOSCROLL, si, 4) ; fMask
    NumPut(ScrollHeight, si, 12) ; nMax
    NumPut(GuiHeight, si, 16) ; nPage
    DllCall("SetScrollInfo", "uint", WinExist(), "uint", SB_VERT, "uint", &si, "int", 1)
    
    if (Left < 0 && Right < GuiWidth)
        x := Abs(Left) > GuiWidth-Right ? GuiWidth-Right : Abs(Left)
    if (Top < 0 && Bottom < GuiHeight)
        y := Abs(Top) > GuiHeight-Bottom ? GuiHeight-Bottom : Abs(Top)
    if (x || y)
        DllCall("ScrollWindow", "uint", WinExist(), "int", x, "int", y, "uint", 0, "uint", 0)

	;GuiControlGet, TempControl, Pos, C1L1
	;guicontrol, ,C1L3, %TempControlX% \ %TempControlY%
}


;___________Scroll Up\Down\Left\Right Function _____________


OnScroll(wParam, lParam, msg, hwnd)
{
    static SIF_ALL=0x17, SCROLL_STEP=10
    
    bar := msg=0x115	;SB_HORZ=0, SB_VERT=1 (if msg=0x115, bar = 1 else bar = 0)
    
    VarSetCapacity(si, 28, 0)
    NumPut(28, si) ; cbSize
    NumPut(SIF_ALL, si, 4) ; fMask
    if !DllCall("GetScrollInfo", "uint", hwnd, "int", bar, "uint", &si)
        return
    
    VarSetCapacity(rect, 16)
    DllCall("GetClientRect", "uint", hwnd, "uint", &rect)
    
    new_pos := NumGet(si, 20) ; nPos
    
    action := wParam & 0xFFFF
    if action = 0 ; SB_LINEUP
        new_pos -= SCROLL_STEP
    else if action = 1 ; SB_LINEDOWN
        new_pos += SCROLL_STEP
    else if action = 2 ; SB_PAGEUP
        new_pos -= NumGet(rect, 12, "int") - SCROLL_STEP
    else if action = 3 ; SB_PAGEDOWN
        new_pos += NumGet(rect, 12, "int") - SCROLL_STEP
    else if (action = 5 || action = 4) ; SB_THUMBTRACK || SB_THUMBPOSITION
        new_pos := wParam>>16
    else if action = 6 ; SB_TOP
        new_pos := NumGet(si, 8, "int") ; nMin
    else if action = 7 ; SB_BOTTOM
        new_pos := NumGet(si, 12, "int") ; nMax
    else
        return
    
    min := NumGet(si, 8, "int") ; nMin
    max := NumGet(si, 12, "int") - NumGet(si, 16) ; nMax-nPage
    new_pos := new_pos > max ? max : new_pos
    new_pos := new_pos < min ? min : new_pos
    
    old_pos := NumGet(si, 20, "int") ; nPos
    
    x := y := 0
    if bar = 0 ; SB_HORZ
        x := old_pos-new_pos
    else
        y := old_pos-new_pos
    ; Scroll contents of window and invalidate uncovered area.
    DllCall("ScrollWindow", "uint", hwnd, "int", x, "int", y, "uint", 0, "uint", 0)
    
    ; Update scroll bar.
    NumPut(new_pos, si, 20, "int") ; nPos
    DllCall("SetScrollInfo", "uint", hwnd, "int", bar, "uint", &si, "int", 1)

	;GuiControlGet, TempControl, Pos, C1L1
	;guicontrol, ,C1L3, %TempControlX% \ %TempControlY%

return

	;"OnMessage()" automatically sends 4 parameters to the specified function (wParam, lParam, msg, hwnd)

Static RunAtScriptExecution1 := OnMessage(0x115, "OnScroll") ; WM_VSCROLL
Static RunAtScriptExecution2 := OnMessage(0x114, "OnScroll") ; WM_HSCROLL

}