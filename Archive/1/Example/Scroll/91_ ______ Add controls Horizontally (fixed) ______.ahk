
	;autohotkey 32bit unicode

	;Modifications from Original code:

	; - "UpdateScrollBars(A_Gui, Gui%A_Gui%Width, Gui%A_Gui%Height)" instead "UpdateScrollBars(A_Gui, A_GuiWidth, A_GuiHeight)"
		;prevents blank spaces while adding new controls horizontally (see more info at "GuiSize:" lable at script's end)


Column = 2	;gui starts with 2 Columns

Line = 3		;gui starts with 3 Lines


OnMessage(0x115, "OnScroll") ; WM_VSCROLL	;necessary for scrollable gui windows (must be added before gui lines)
OnMessage(0x114, "OnScroll") ; WM_HSCROLL	;necessary for scrollable gui windows (must be added before gui lines)

Gui,  +Resize +0x300000  ; WS_VSCROLL | WS_HSCROLL	;necessary for scrollable gui windows 
						;+Resize (allows resize of windows)


gui, add, button, vAddLine, Add Line		;x65 y85
GuiControl, 1: Move, AddLine, x65 y85		;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)

gui, add, button, vAddColumn, Add Column		;x65 y85
GuiControl, 1: Move, AddColumn, x120 y60		;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)

gui, add, edit, xm y10 w50 vC1L1 gRealTimeOutput, C1L1	;ys, ym, y(0 to 7) cause adding columns bugs (y10 no bug found) 
gui, add, edit, w50 vC1L2 gRealTimeOutput, C1L2
gui, add, edit, w50 vC1L3 gRealTimeOutput, C1L3

gui, add, edit, x+5 y10 w50 vC2L1 gRealTimeOutput, C2L1	;ys, ym, y(0 to 7) cause adding columns bugs (y10 no bug found) 
gui, add, edit, w50 vC2L2 gRealTimeOutput, C2L2
gui, add, edit, w50 vC2L3 gRealTimeOutput, C2L3

gui, show, w500 h300, gui

Gui,  +LastFound				;necessary for scrollable gui windows (allow scrolling with mouse wheel - must be added after gui lines)
GroupAdd, MyGui, % "ahk_id " . WinExist()		;necessary for scrollable gui windows (allow scrolling with mouse wheel - must be added after gui lines)

return

ButtonAddLine:	;______________________________Button Add Line__________________________________

ButtonsReposition = Line		;prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an empty gui area, avoiding so graphic bugs\glitches 
gosub, ButtonsReposition

Line++

gosub, ScrollUpLeft

loop, %Column%
{	
if a_index = 1
gui, add, edit, xm w50 vC%a_index%L%Line% gRealTimeOutput, C%a_index%L%Line%
else
gui, add, edit, x+5 w50  vC%a_index%L%Line% gRealTimeOutput, C%a_index%L%Line%
}

UpdateScrollBars(A_Gui, Gui%A_Gui%Width, Gui%A_Gui%Height)	;update new added lines (or any other added controls) inside gui windows

goto, ScrollDownRight

return

ButtonAddColumn:	;______________________________Button Add Column_________________________________

ButtonsReposition = Column		;prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an empty gui area, avoiding so graphic bugs\glitches 
gosub, ButtonsReposition

Column++

gosub, ScrollUpLeft

loop, %Line%
{	
if a_index = 1
gui, add, edit, x+5 y10 w50 vC%Column%L%a_index% gRealTimeOutput, C%Column%L%a_index%	;ys, ym, y(0 to 7) cause adding columns bugs (y10 no bug found) 
else
gui, add, edit, w50  vC%Column%L%a_index% gRealTimeOutput, C%Column%L%a_index%
}

UpdateScrollBars(A_Gui, Gui%A_Gui%Width, Gui%A_Gui%Height)	;update new added lines (or any other added controls) inside gui windows

goto, ScrollDownRight

return

ButtonsReposition:	;______________________________Buttons Reposition____________________________

MoveEditRef = C%Column%L%Line%	;"Edit control" from last column and last line

GuiControlGet, %MoveEditRef%, 1: Pos	;get x, y , width and height position from "%MoveEditRef%" Button and store values in "%MoveEditRef%y" "%MoveEditRef%x" "%MoveEditRef%w" "%MoveEditRef%h" variables
				;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)

if ButtonsReposition = Line	;prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an empty gui area, avoiding so graphic bugs\glitches 
{
GuiControl, 1: Move, AddLine, % "x" %MoveEditRef%x "y" %MoveEditRef%y+55		;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)
GuiControl, 1: Move, AddColumn, % "x" %MoveEditRef%x+55 "y" %MoveEditRef%y+26		;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)
}

if ButtonsReposition = Column
{
GuiControl, 1: Move, AddLine, % "x" %MoveEditRef%x+53 "y" %MoveEditRef%y+25		;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)
GuiControl, 1: Move, AddColumn, % "x" %MoveEditRef%x+110 "y" %MoveEditRef%y		;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)
}

return

RealTimeOutput:	;___________________________RealTime Output________________________

	;%A_GuiControl% - The name of the variable associated with the GUI control that launched the current thread. If that control lacks an associated variable, A_GuiControl instead contains the first 63 characters of the control's text/caption (this is most often used to avoid giving each button a variable name). A_GuiControl is blank whenever: 1) A_Gui is blank; 2) a GUI menu bar item or event such as GuiClose/GuiEscape launched the current thread; 3) the control lacks an associated variable and has no caption; or 4) The control that originally launched the current thread no longer exists (perhaps due to Gui Destroy).

guicontrolget, %a_guicontrol%	;stores text typed by user in the gui edit box control variable that called\launched "RealTimeOutput" subroutine	


ColumnDetected := RegExReplace(a_guicontrol, "C(.*)L(.*)", "$1")	;detects which "Colum" belongs the  gui edit box control that called\launched "RealTimeOutput" subroutine				
						;"C(.*)L(.*)" - match "C" then match any "string", then match "L" then match any "string" 
						;(.*) match any string 
						;"$1" is a backreference to the (.*) at right of "C" that will be stored in "ColumnDetected" variable
						;"$2" is a backreference to the (.*) at right of "L"

LineDetected := RegExReplace(a_guicontrol, "C(.*)L(.*)", "$2")	;detects which "Line" belongs the  gui edit box control that called\launched "RealTimeOutput" subroutine				
						;"C(.*)L(.*)" - match "C" then match any "string", then match "L" then match any "string" 
						;(.*) match any string 
						;"$1" is a backreference to the (.*) at right of "C"
						;"$2" is a backreference to the (.*) at right of "L" that will be stored in "LineDetected" variable

	;msgbox, coluna - %ColumnDetected% `n`n linha - %LineDetected%

loop, %Column%
guicontrol, -g, C%a_index%L%LineDetected%		;remove gLable

loop, %Column%
{
if a_index != %ColumnDetected%
guicontrol, , C%a_index%L%LineDetected%, % %a_guicontrol%
}

loop, %Column%
guicontrol, +gRealTimeOutput, C%a_index%L%LineDetected%		;add gLable

return

guiclose:	;__________________________________gui close___________________________
exitapp


;______________________________________________Scrollable Gui_____________________________________________



GuiSize:	;_____Gui Size______

Gui%A_Gui%Width = %A_GuiWidth%	;necessary because "A_GuiWidth" and "A_GuiHeight" only gives the correct gui windows size if "GuiSize" lable is launched by resizing gui windows
Gui%A_Gui%Height = %A_GuiHeight%

    UpdateScrollBars(A_Gui, A_GuiWidth, A_GuiHeight)

return


ScrollUpLeft:	;________Scroll Up / Left Edge (prevents blank spaces while adding new controls)_______

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

ScrollDownRight:	;________Scroll Down / Right Edge (prevents blank spaces while adding new controls)_______
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

#IfWinActive ahk_group MyGui
WheelUp::
WheelDown::
+WheelUp::
+WheelDown::
    ; SB_LINEDOWN=1, SB_LINEUP=0, WM_HSCROLL=0x114, WM_VSCROLL=0x115
    OnScroll(InStr(A_ThisHotkey,"Down") ? 1 : 0, 0, GetKeyState("Shift") ? 0x114 : 0x115, WinExist())
return
#IfWinActive

UpdateScrollBars(GuiNum, GuiWidth, GuiHeight)
{
    static SIF_RANGE=0x1, SIF_PAGE=0x2, SIF_DISABLENOSCROLL=0x8, SB_HORZ=0, SB_VERT=1
    
    Gui, %GuiNum%:Default
    Gui, +LastFound
    
    ; Calculate scrolling area.
    Left := Top := 9999
    Right := Bottom := 0
    WinGet, ControlList, ControlList
    Loop, Parse, ControlList, `n
    {
        GuiControlGet, c, Pos, %A_LoopField%
        if (cX < Left)
            Left := cX
        if (cY < Top)
            Top := cY
        if (cX + cW > Right)
            Right := cX + cW
        if (cY + cH > Bottom)
            Bottom := cY + cH
    }
    Left -= 8
    Top -= 8
    Right += 8
    Bottom += 8
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
}

OnScroll(wParam, lParam, msg, hwnd)
{
    static SIF_ALL=0x17, SCROLL_STEP=10
    
    bar := msg=0x115 ; SB_HORZ=0, SB_VERT=1
    
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
}

