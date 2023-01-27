

	;autohotkey 32bit unicode

	;Modifications from Original code:

	; - "UpdateScrollBars(A_Gui, Gui%A_Gui%Width, Gui%A_Gui%Height, 2, ...)" instead "UpdateScrollBars(A_Gui, A_GuiWidth, A_GuiHeight, 2, ...)"
		;prevents blank spaces while adding new controls horizontally (see more info at "GuiSize:" label at script's end)
		;necessary because "A_GuiWidth" and "A_GuiHeight" only return the correct gui windows size if "GuiSize" label is launched by resizing gui windows, otherwise, incorrect 0 and 32768 values will be returned!
		;see more information at "GuiSize:" label in this script file

	;New parameters added to "UpdateScrollBars()" Function! ("UpdateOption" and "Left\Top\Right\Bottom Margins")
		;see more information at "UpdateScrollBars()" Function in the script's end!

	;4 Global variables added, The "MostLeft\Top\Right\BottomControls" Variables (to be used with "UpdateScrollBars()" function, parameter "UpdateOption = 2")

	;"ScrollUpLeft" & "ScrollDownRight" Labels	;used previously to avoid blank\empty spaces while adding new controls (but not in use anymore)
					;Controls X Y W H used instead as references to prevent  blank\empty spaces!

Column = 2	;gui starts with 2 Columns

Line = 3		;gui starts with 3 Lines


OnMessage(0x115, "OnScroll") ; WM_VSCROLL	;necessary for scrollable gui windows (must be added before gui lines)
OnMessage(0x114, "OnScroll") ; WM_HSCROLL	;necessary for scrollable gui windows (must be added before gui lines)

;___________Main Gui Windows = Gui "1"______________

gui, +HwndMainGuiHwnd	;stores Gui 1 windows "Hwnd" id in "MainGuiHwnd" variable

Gui,  +Resize +0x300000  ; WS_VSCROLL | WS_HSCROLL	;necessary for scrollable gui windows 
						;+Resize (allows resize of windows)


gui, add, button, x-99 y-99 vAddLine gAddLine, Add Line (F11)		;negative x and y, so the button won't be visible (prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an invisible gui area, avoiding so graphic bugs\glitches)
						;after the first 6 edit controls are added, the button will be moved to a visible and correct position

gui, add, button, x-99 y-99 vAddColumn gAddColumn, Add Column (F12)	;negative x and y, so the button won't be visible (prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an invisible gui area, avoiding so graphic bugs\glitches)
							;after the first 6 edit controls are added, the button will be moved to a visible and correct position

gui, add, edit, xm ym w50 vC1L1 gRealTimeOutput, C1L1
gui, add, edit, w50 vC1L2 gRealTimeOutput, C1L2
gui, add, edit, w50 vC1L3 gRealTimeOutput, C1L3

gui, add, edit, x+5 ym w50 vC2L1 gRealTimeOutput, C2L1
gui, add, edit, w50 vC2L2 gRealTimeOutput, C2L2
gui, add, edit, w50 vC2L3 gRealTimeOutput, C2L3

GuiControlGet, Temp, Pos, C%Column%L%Line% 	;get x, y , width and height position from the last added edit control "C%Column%L%Line%" and store values in "TempY" "TempX" "TempW" "TempH" variables
 
GuiControl, Move, AddLine, % "X" TempX - 30 "Y" TempY + TempH + 5
GuiControl, Move, AddColumn, % "X" TempX + TempW + 5 "y" TempY

gui, show, w500 h300, Main Gui Windows

Gui,  +LastFound				;necessary for scrollable gui windows (allow scrolling with mouse wheel - must be added after gui lines)
GroupAdd, MyGui, % "ahk_id " . WinExist()		;necessary for scrollable gui windows (allow scrolling with mouse wheel - must be added after gui lines)


gui, Test:default	;_______Gui Test (just for test)__________ 

gui, +HwndTestGuiHwnd	;stores Gui 1 windows "Hwnd" id in "TestGuiHwnd" variable

gui, +LabelGui	;uses default Gui labels (example: instead using "TestGuiSize:", "GuiSize" will be used while resizing "Test Gui" Windows)

Gui,  +Resize +0x300000  ; WS_VSCROLL | WS_HSCROLL	;necessary for scrollable gui windows 
						;+Resize (allows resize of windows)

gui, add, text, , Just for Test (Adding controls little bugged)
gui, add, button, , ok 
gui, add, button, , ok 
gui, add, edit, w50 vtesteditcount,
gui, add, edit, x+5 w50 vtesteditcount2,
gui, add, button, xm w200 vTestAddVertical gTestAddVertical, Add Vertical (F11) 
gui, add, button, w200 gTestAddHorizontal, Add Horizontal (F12)
x := A_ScreenWidth/2 - 28
gui, show, x%x% w260 h220, Gui Test (Just for Test)

Gui,  +LastFound				;necessary for scrollable gui windows (allow scrolling with mouse wheel - must be added after gui lines)
GroupAdd, MyGui, % "ahk_id " . WinExist()		;necessary for scrollable gui windows (allow scrolling with mouse wheel - must be added after gui lines)

return

TestAddVertical:		;______"Gui Test" Test Button Add Vertical______

guicontrolget, Temp, pos,  % %A_DefaultGui%MostBottomControl
TempY := TempY + TempH + 5

testn++
gui, add, edit , xs  y%TempY% w50 r1 vTestEdit%testn%, Edit%testn%
testn++
gui, add, edit , x+5 w50 r1 vTestEdit%testn%, Edit%testn%
testn++
gui, add, edit , x+5 w50 r1 vTestEdit%testn%, Edit%testn%

%A_DefaultGui%MostBottomControl = TestEdit%testn%		;in this case, after adding new controls, the "MostBottomControl" is the last added "edit control"
						;must be re-specified, otherwise, incorrect scroll area will be calculated by the "UpdateScrollBars()" function

UpdateScrollBars(A_DefaultGui, Gui%A_DefaultGui%Width, Gui%A_DefaultGui%Height, 2, 20, 20, 20, 20)

testcount++
guicontrol,  , testeditcount, % testcount
return

TestAddHorizontal:	;______"Gui Test" Test Button Add Horizontal_______

guicontrolget, Temp, pos,  % %A_DefaultGui%MostRightControl
TempX := TempX + TempW + 5  

testn++
gui, add, edit , x%TempX% ym  w50 r1 vTestEdit%testn%, Edit%testn%
testn++
gui, add, edit ,  w50 r1 vTestEdit%testn%, Edit%testn%
testn++
gui, add, edit , w50 r1 vTestEdit%testn%, Edit%testn%

%A_DefaultGui%MostRightControl = TestEdit%testn%		;in this case, after adding new controls, the "MostRightControl" is the last added "edit control"
						;must be re-specified, otherwise, incorrect scroll area will be calculated by the "UpdateScrollBars()" function


UpdateScrollBars(A_DefaultGui, Gui%A_DefaultGui%Width, Gui%A_DefaultGui%Height, 2, 20, 20, 20, 20)

testcount++
guicontrol,  , testeditcount, % testcount
return

AddLine:	;______________________________Button Add Line__________________________________

guicontrol, Move, AddLine, y-100	;negative x and y, so the button won't be visible (prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an invisible gui area, avoiding so graphic bugs\glitches)


	;gosub, ScrollUpLeft		;to prevent gui windows blank\empty spaces if "scrollbars != 0" !
				;not necessary anymore, "YTemp" and "XTemp" below in use instead

GuiControlGet, Temp, Pos, C%Column%L%Line%	;correct Y position for the new added controls to prevent gui windows blank\empty spaces  if "scrollbars != 0" !
YTemp := TempY + TempH + 5			;get x, y , width and height position from the last added edit control "C%Column%L%Line%" and store values in "TempY" "TempX" "TempW" "TempH" variables

GuiControlGet, Temp, Pos, C1L1		;for correct X position necessary to prevent blank\empty spaces  if "scrollbars != 0" !
XTemp := TempX

Line++

loop, %Column%
{	
if a_index = 1
gui, add, edit, x%XTemp%  y%YTemp% w50 vC%a_index%L%Line% gRealTimeOutput, C%a_index%L%Line%
else
gui, add, edit, x+5  w50  vC%a_index%L%Line% gRealTimeOutput, C%a_index%L%Line%
}

gosub, ButtonsReposition

	;MostLeftControl = Specify here the new control (remove initial ";")		;in this case, after adding new controls, The Most Left\Top\Right\Bottom controls are the same controls detected while using "UpdateOption = 1" at script execution! 
	;MostTopControl = Specify here the new control (remove initial ";")		; - if The Most Left\Top\Right\Bottom are about to change while adding\moving controls, so they must be specified!
	;MostRightControl = Specify here the new control (remove initial ";")		;in this case, "C1L1" is always the "MostLeft" and the "MostTop" Control (at script execution and after adding new controls)
	;MostBottomControl = Specify here the new control (remove initial ";")		; - in fact, in this case, all the controls from "column 1" are "MostLeft" controls and all controls from "Line 1" are "MostTop" controls!
								;in this case "AddColumn" Button is always the "MostRightControl" (at script execution and after adding new controls)	
								;in this case "AddLine" Button is always the "MostBottomControl" (at script execution and after adding new controls)
							
							

UpdateScrollBars(A_DefaultGui, Gui%A_DefaultGui%Width, Gui%A_DefaultGui%Height, 2, 20, 20, 20, 20)	;must use "Gui%A_Gui%Width" and "Gui%A_Gui%Height" instead just "A_GuiWidth" and "A_GuiHeight" (see more information at "GuiSize:" label in this script file)
										;"UpdateOption = 2" (Fast), to be used if The Most Left\Top\Right\Bottom controls are already known\detected\defined! 
										; - for "UpdateOption = 1", The more controls added, More slow will be "UpdateScrollBars()" function (because of  "Loop, Parse, ..." in use)
										; - "UpdateOption = 2" prevents slowness from "UpdateOption = 1" because "Loop, Parse, ..." is not used! 	
										; - see more notes below at "UpdateScrollBars()" function
										;"20"  Left\Top\Right\Bottom Margins (must be the same value for any "UpdateScrollBars()" in use)

	;goto, ScrollDownRight		;Optional

return

AddColumn:	;______________________________Button Add Column_________________________________

guicontrol, Move, AddColumn, y-100	;negative x and y, so the button won't be visible (prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an invisible gui area, avoiding so graphic bugs\glitches)

	;gosub, ScrollUpLeft		;to prevent gui windows blank\empty spaces  if "scrollbars != 0" !
				;not necessary anymore, "XTemp" and "YTemp" below in use instead

GuiControlGet, Temp, Pos, C%Column%L%Line%	;correct X position for the new added controls to prevent gui windows blank\empty spaces  if "scrollbars != 0" !
XTemp := TempX + TempW + 5			 ;get x, y , width and height position from the last added edit control "C%Column%L%Line%" and store values in "TempY" "TempX" "TempW" "TempH" variables

GuiControlGet, Temp, Pos, C1L1		;for correct Y position necessary to prevent blank\empty spaces  if "scrollbars != 0" !
YTemp := TempY

Column++

loop, %Line%
{	
if a_index = 1
gui, add, edit, x%XTemp% y%YTemp% w50 vC%Column%L%a_index% gRealTimeOutput, C%Column%L%a_index%	;ys, ym, y(0 to 7) cause adding columns bugs (y10 no bug found) 
else
gui, add, edit, y+5 w50 vC%Column%L%a_index% gRealTimeOutput, C%Column%L%a_index%	;"Y+5", "5" is the "y" spacement between add controls (necessasy to prevents spacement problem)  
}

gosub, ButtonsReposition

	;MostLeftControl = Specify here the new control (remove initial ";")		;in this case, after adding new controls, The Most Left\Top\Right\Bottom controls are the same controls detected while using "UpdateOption = 1" at script execution! 
	;MostTopControl = Specify here the new control (remove initial ";")		; - if The Most Left\Top\Right\Bottom are about to change while adding\moving controls, so they must be specified!
	;MostRightControl = Specify here the new control (remove initial ";")		;in this case, "C1L1" is always the "MostLeft" and the "MostTop" Control (at script execution and after adding new controls)
	;MostBottomControl = Specify here the new control (remove initial ";")		; - in fact, in this case, all the controls from "column 1" are "MostLeft" controls and all controls from "Line 1" are "MostTop" controls!
								;in this case "AddColumn" Button is always the "MostRightControl" (at script execution and after adding new controls)	
								;in this case "AddLine" Button is always the "MostBottomControl" (at script execution and after adding new controls)

UpdateScrollBars(A_DefaultGui, Gui%A_DefaultGui%Width, Gui%A_DefaultGui%Height, 2, 20, 20, 20, 20)	;must use "Gui%A_Gui%Width" and "Gui%A_Gui%Height" instead just "A_GuiWidth" and "A_GuiHeight" (see more information at "GuiSize:" label in this script file)
										;"UpdateOption = 2" (Fast), to be used if The Most Left\Top\Right\Bottom controls are already known\detected\defined! 
										; - for "UpdateOption = 1", The more controls added, More slow will be "UpdateScrollBars()" function (because of  "Loop, Parse, ..." in use)
										; - "UpdateOption = 2" prevents slowness from "UpdateOption = 1" because "Loop, Parse, ..." is not used! 	
										; - see more notes below at "UpdateScrollBars()" function
										;"20"  Left\Top\Right\Bottom Margins (must be the same value for any "UpdateScrollBars()" in use)

	;goto, ScrollDownRight		;Optional

return

ButtonsReposition:	;______________________________Buttons Reposition____________________________

GuiControlGet, Temp, Pos, C%Column%L%Line% 	;get x, y , width and height position from the last added edit control "C%Column%L%Line%" and store values in "TempY" "TempX" "TempW" "TempH" variables

GuiControl, Move, AddLine, % "X" TempX - 30 "Y" TempY + TempH + 5
GuiControl, Move, AddColumn, % "X" TempX + TempW + 5 "y" TempY

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
guicontrol, -g, C%a_index%L%LineDetected%		;remove gLabel

loop, %Column%
{
if a_index != %ColumnDetected%
guicontrol, , C%a_index%L%LineDetected%, % %a_guicontrol%
}

loop, %Column%
guicontrol, +gRealTimeOutput, C%a_index%L%LineDetected%		;add gLabel

return

guiclose:	;__________________________________gui close___________________________
exitapp

f11::	;_______________F11 (Add Line \ Test Add vertical)_____________

TempHwnd := Winactive("A")	;stores "Hwnd" id of the current active windows in "TempHwnd" variable
			;"A" Active Windows

if (TempHwnd = MainGuiHwnd)
{
Gui, 1:Default	;Gui 1 is the  Main Gui
goto, AddLine
}

if (TempHwnd = TestGuiHwnd)
{
Gui, Test:Default
goto, TestAddVertical
}

return

f12::	;_______________F12 (Add Column \ Test Add Horizontal)____________

TempHwnd := Winactive("A")	;stores "Hwnd" id of the current active windows in "TempHwnd" variable
			;"A" Active Windows

if (TempHwnd = MainGuiHwnd)
{
Gui, 1:Default	;Gui 1 is the  Main Gui
goto, AddColumn
}

if (TempHwnd = TestGuiHwnd)
{
Gui, Test:Default
goto, TestAddHorizontal
}

return
;____________________________________________Scrollable Gui_____________________________________________



GuiSize:	;_____Gui Size______

Gui%A_Gui%Width = %A_GuiWidth%	;necessary because "A_GuiWidth" and "A_GuiHeight" only return the correct gui windows size if "GuiSize" label is launched by resizing gui windows, otherwise, incorrect 0 and 32768 values will be returned!
Gui%A_Gui%Height = %A_GuiHeight%

%A_Gui%MostLeftControl := %A_Gui%MostLeftControl		;tunrs The "MostLeft\Top\Right\BottomControls" variables into Dynamic variables (preserving their original values) 
%A_Gui%MostTopControl := %A_Gui%MostTopControl		;so, "MostLeft\Top\Right\BottomControls" values from "Main Script" are visible to "UpdateScrollBars()" function and vice-versa! 
%A_Gui%MostRightControl := %A_Gui%MostRightControl
%A_Gui%MostBottomControl := %A_Gui%MostBottomControl

if %A_Gui%GuiScrollableAtExecution != 0
{
UpdateScrollBars(A_Gui, A_GuiWidth, A_GuiHeight, 1, 20, 20, 20, 20)	;"UpdateOption = 1" (Slow), The Most Left\Top\Right\Bottom controls will be detected\defined at script execution 
							;see notes below at "UpdateScrollBars()" function
							;"20"  Left\Top\Right\Bottom Margins (must be the same value for any "UpdateScrollBars()" in use)
							;in this case, "C1L1" is always the "MostLeft" and the "MostTop" Control (at script execution and after adding new controls)
							; - in fact, in this case, all the controls from "column 1" are "MostLeft" controls and all controls from "Line 1" are "MostTop" controls!
							;in this case "AddColumn" Button is always the "MostRightControl" (at script execution and after adding new controls)
							;in this case "AddLine" Button is always the "MostBottomControl" (at script execution and after adding new controls)
%A_Gui%GuiScrollableAtExecution = 0				
}
else
UpdateScrollBars(A_Gui, A_GuiWidth, A_GuiHeight, 2, 20, 20, 20, 20)	;"UpdateOption = 2" (Fast), to be used if The Most Left\Top\Right\Bottom controls are already known\detected\defined!
							; - for "UpdateOption = 1", The more controls added, More slow will be "UpdateScrollBars()" function (because of  "Loop, Parse, ..." in use)
							; - "UpdateOption = 2" prevents slowness from "UpdateOption = 1" because "Loop, Parse, ..." is not used! 	
							; - see more notes below at "UpdateScrollBars()" function
							;"20"  Left\Top\Right\Bottom Margins (must be the same value for any "UpdateScrollBars()" in use)

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

GuiControlGet, TempControl, Pos, C1L1
guicontrol, ,C1L3, %TempControlX% \ %TempControlY%
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

GuiControlGet, TempControl, Pos, C1L1
guicontrol, ,C1L3, %TempControlX% \ %TempControlY%
}

