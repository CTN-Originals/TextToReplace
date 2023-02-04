
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

gui, show, w500 h300, Scrollable Gui

Gui,  +LastFound				;necessary for scrollable gui windows (allow scrolling with mouse wheel - must be added after gui lines)
GroupAdd, MyGui, % "ahk_id " . WinExist()		;necessary for scrollable gui windows (allow scrolling with mouse wheel - must be added after gui lines)

return

ButtonAddLine:	;______________________________Button Add Line__________________________________

ButtonsReposition = Line		;prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an empty gui area, avoiding so graphic bugs\glitches 
gosub, ButtonsReposition

Line++

	;gosub, ScrollUpLeft		;to prevent gui windows blank\empty spaces if "scrollbars != 0" !
				;not necessary anymore, "TempY" and "TempControlX" below in use instead

TempY := %MoveEditRef%Y + 27		;correct Y position for the new added controls to prevent gui windows blank\empty spaces  if "scrollbars != 0" !
				;"%MoveEditRef%Y" defined from "Gosub, ButtonReposition" above

GuiControlGet, TempControl, Pos, C1L1	;for correct X position necessary to prevent blank\empty spaces  if "scrollbars != 0" !

loop, %Column%
{	
if a_index = 1
gui, add, edit, x%TempControlX%  y%TempY% w50 vC%a_index%L%Line% gRealTimeOutput, C%a_index%L%Line%
else
gui, add, edit, x+5  w50  vC%a_index%L%Line% gRealTimeOutput, C%a_index%L%Line%
}

UpdateScrollBars(A_Gui, Gui%A_Gui%Width, Gui%A_Gui%Height, , 20, 20)	;update new added lines (or any other added controls) inside gui windows

goto, ScrollDownRight

return

ButtonAddColumn:	;______________________________Button Add Column_________________________________

ButtonsReposition = Column		;prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an empty gui area, avoiding so graphic bugs\glitches 
gosub, ButtonsReposition

Column++

	;gosub, ScrollUpLeft		;to prevent gui windows blank\empty spaces  if "scrollbars != 0" !
				;not necessary anymore, "TempX" and "TempControlY" below in use instead

TempX := %MoveEditRef%X + 55	;correct X position for the new added controls to prevent gui windows blank\empty spaces  if "scrollbars != 0" !
				;"%MoveEditRef%X" defined from "Gosub, ButtonReposition" above

GuiControlGet, TempControl, Pos, C1L1	;for correct Y position necessary to prevent blank\empty spaces  if "scrollbars != 0"!

loop, %Line%
{	
if a_index = 1
gui, add, edit, x%TempX% y%TempControlY% w50 vC%Column%L%a_index% gRealTimeOutput, C%Column%L%a_index%	;ys, ym, y(0 to 7) cause adding columns bugs (y10 no bug found) 
else
gui, add, edit, w50  vC%Column%L%a_index% gRealTimeOutput, C%Column%L%a_index%
}

UpdateScrollBars(A_Gui, Gui%A_Gui%Width, Gui%A_Gui%Height, , 20, 20)	;update new added lines (or any other added controls) inside gui windows

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

f12::	;_______________F12_____________

return

f11::	;_______________F11____________

return
;____________________________________________Scrollable Gui_____________________________________________



GuiSize:	;_____Gui Size______

Gui%A_Gui%Width = %A_GuiWidth%	;necessary because "A_GuiWidth" and "A_GuiHeight" only gives the correct gui windows size if "GuiSize" lable is launched by resizing gui windows
Gui%A_Gui%Height = %A_GuiHeight%

Global LeftGuiScrollable
Global TopGuiScrollable
Global RightGuiScrollable
Global BottomGuiScrollable

Global GuiScrollableHorizontalPos
Global GuiScrollableVerticalPos

if GuiScrollableAtExecution != 0
{
UpdateScrollBars(A_Gui, A_GuiWidth, A_GuiHeight, , 20, 20)	;"20" "RightMargin" and "BottomMargin" = 20 (must be the same value for any "UpdateScrollBars()" in use)
GuiScrollableAtExecution = 0
}
else
UpdateScrollBars(A_Gui, A_GuiWidth, A_GuiHeight, 1, 20, 20)	;"20" "RightMargin" and "BottomMargin" = 20 (must be the same value for any "UpdateScrollBars()" in use)

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

UpdateScrollBars(GuiNum, GuiWidth, GuiHeight, UpdateOption := "", RightMargin := 8, BottomMargin := 8)
{
    static SIF_RANGE=0x1, SIF_PAGE=0x2, SIF_DISABLENOSCROLL=0x8, SB_HORZ=0, SB_VERT=1
    
    Gui, %GuiNum%:Default
    Gui, +LastFound 

if UpdateOption =	;if "UpdateOption" = blank (detects the "Most Right" and the "Most Bottom" gui control)
{   
    ; Calculate scrolling area.
    Left := Top := 0
    Right := Bottom := 0
    WinGet, ControlList, ControlList
    Loop, Parse, ControlList, `n
    {
        GuiControlGet, c, Pos, %A_LoopField%
	
	        ;if (cX < Left)
	            ;Left := cX
	        ;if (cY < Top)
	            ;Top := cY

        if (cX + cW > Right)
	{
	Right := cX + cW
	GuiScrollableMostRightControl = %A_LoopField%
	}

        if (cY + cH > Bottom)
	{
	Bottom := cY + cH
	GuiScrollableMostBottomControl = %A_LoopField%
	}

    }

    	;Left -= 8
   	;Top -= 8

    Right += RightMargin
    Bottom += BottomMargin

LeftGuiScrollable = %Left%
TopGuiScrollable = %Top%
RightGuiScrollable = %Right%
BottomGuiScrollable = %Bottom%

GuiScrollableHorizontalPos := 0
GuiScrollableVerticalPos := 0
}

if UpdateOption = 1
{

Gui, 1: +HwndGuiWindowsID	;stores "Gui 1" Hwnd windows id in "GuiWindowsID" variable
			;"Gui" instead "Gui, 1:" is for the default "Gui" windows 
GuiScrollableHorizontalPos := DllCall("GetScrollPos", "UInt", GuiWindowsID, "Int", 0)  ;  Last parameter is 1 for SB_VERT, 0 for SB_HORZ.
GuiScrollableVerticalPos := DllCall("GetScrollPos", "UInt", GuiWindowsID, "Int", 1)  ;  Last parameter is 1 for SB_VERT, 0 for SB_HORZ.


   ;Calculate Scrolling Area

;GuiControlGet, TempControl, Pos, %GuiScrollableMostRightControl%
;NewRight := TempControlX + TempControlW + RightMargin

;GuiControlGet, TempControl, Pos, %GuiScrollableMostBottomControl%
;NewBottom := TempControlY + TempControlH + BottomMargin

Left := 0 - GuiScrollableHorizontalPos
Top := 0 - GuiScrollableVerticalPos
Right := RightGuiScrollable - GuiScrollableHorizontalPos		;("+" because "Left" value is always <= 0, negative or 0, so, "Left" will be subtracted from "RightGuiScrollable")
Bottom := BottomGuiScrollable - GuiScrollableVerticalPos		;("+" because "Top" value is always <= 0, negative or 0, so, "Top" will be subtracted from "BottomGuiScrollable")

	;msgbox, %Left% - %Top% - %Right% - %Bottom%
}



;msgbox, left = %left% `n`n right = %right%

    ScrollWidth := Right - Left	;("-" because "Left" value is always <= 0, negative or 0, so, "Left" will be added to "Right")
    ScrollHeight := Bottom - Top	;("-" because "Top" value is always <= 0, negative or 0, so, "Top" will be added to "Bottom")
    
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
    
GuiControlGet, TempControl, Pos, C1L1
guicontrol, ,C1L3, %TempControlX% \ %TempControlY%
}

OnScroll(wParam, lParam, msg, hwnd)
{
;msgbox, %A_ThisLabel% - %A_ThisHotkey%
;msgbox, OnScroll(%wParam%, %lParam%, %msg%, %hwnd%)
 
   static SIF_ALL=0x17, SCROLL_STEP=10
    
    bar := msg=0x115 ; SB_HORZ=0, SB_VERT=1
    
    VarSetCapacity(si, 28, 0)
    NumPut(28, si) ; cbSize
    NumPut(SIF_ALL, si, 4) ; fMask
;msgbox, % DllCall("GetScrollInfo", "uint", hwnd, "int", bar, "uint", &si)
;msgbox, DllCall("GetScrollInfo", "uint", %hwnd%, "int", %bar%, "uint", &si)
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

	;if (msg = "0x115") or (msg = "277")
	;GuiScrollableVerticalPos =  %new_pos%

	;if (msg = "0x114") or (msg = "276")
	;GuiScrollableHorizontalPos =  %new_pos%

	;msgbox, OnScroll(%wParam%, %lParam%, %msg%, %hwnd% \ %GuiScrollableHorizontalPos%  - %GuiScrollableVerticalPos%)
	;msgbox, haha

GuiControlGet, TempControl, Pos, C1L1
guicontrol, ,C1L3, %TempControlX% \ %TempControlY%
}

