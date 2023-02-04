

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

	;for Adding controls, "A_DefaultGui" should be used instead "A_Gui" in order to allow Hotkeys, in this case "F12" and "F11" to target the correct gui windows! 
		;for Hotkeys, "Gui x:Default" should be used, where "x" is the name\numer\id of the desired Gui Windows

	;Hotkeys Threads, in this case "F12" and "F11", can add more gui controls than "Gui threads" themselves (a Limiation that even the current Lazy\Poor Developer (2 Agst 2016) of this program language doesn't know the cause!)
		;controls Limit 11000 ("Hotkeys threads" can reach the Limit but "Gui Threads" can't!)
		;"Gui Threads" are buggy while adding multiple new controls, while "Hotkeys threads" are not


Column = 2	;gui starts with 2 Columns

Line = 3		;gui starts with 3 Lines

MainGuiSaveFile = Main Gui Scrollable.ini	;File will be saved at script directory
TestGuiSaveFile = Test Gui Scrollable.ini	;File will be saved at script directory

OnMessage(0x115, "OnScroll") ; WM_VSCROLL	;necessary for scrollable gui windows (must be added before gui lines)
OnMessage(0x114, "OnScroll") ; WM_HSCROLL	;necessary for scrollable gui windows (must be added before gui lines)

;___________Main Gui Windows = Gui "1"______________

gui, +HwndMainGuiHwnd	;stores Gui 1 windows "Hwnd" id in "MainGuiHwnd" variable

Gui,  +Resize +0x300000  ; WS_VSCROLL | WS_HSCROLL	;necessary for scrollable gui windows 
						;+Resize (allows resize of windows)

gui, add, Button, x-99 y-99 vAdd gAdd Default, Add (F12)	;negative x and y, so the button won't be visible (prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an invisible gui area, avoiding so graphic bugs\glitches)
						;after the first 6 edit controls are added, the button will be moved to a visible and correct position

gui, add, Edit, x-99 y-99 w50 center vAddLine, 1	;negative x and y, so the button won't be visible (prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an invisible gui area, avoiding so graphic bugs\glitches)
					;after the first 6 edit controls are added, the button will be moved to a visible and correct position

guicontrolget, Temp, pos, Add

gui, add, Edit, x-99 y-99 w%TempW% center vAddColumn, 1	;negative x and y, so the button won't be visible (prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an invisible gui area, avoiding so graphic bugs\glitches)
						;after the first 6 edit controls are added, the button will be moved to a visible and correct position

gui, add, button, w50  x-99 y-99 vMainSave, Save	;negative x and y, so the button won't be visible (prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an invisible gui area, avoiding so graphic bugs\glitches)
					;after the first 6 edit controls are added, the button will be moved to a visible and correct position

gui, add, text, xm ym, Total Added = 
gui, add, text, x+5 w50 vTotalEditAdded, 
gui, add, text, xm, Limit = Up to 11,000 Controls
gui, add, text, xm, Save Location = Script Directory
gui, add, text, xm, "Add" Button can't reach Limit
gui, add, text, xm, "F12" can reach Limit

gui, add, edit, xm w50 vC1L1 gRealTimeOutput, C1L1
gui, add, edit, w50 vC1L2 gRealTimeOutput, C1L2
gui, add, edit, w50 vC1L3 gRealTimeOutput, C1L3

guicontrolget, Temp, pos, C1L1

gui, add, edit, x+5 y%TempY% w50 vC2L1 gRealTimeOutput, C2L1
gui, add, edit, w50 vC2L2 gRealTimeOutput, C2L2
gui, add, edit, w50 vC2L3 gRealTimeOutput, C2L3

IfExist, %MainGuiSaveFile%
gosub, MainLoad

MainLoad = 1	;for "guicontrolget, AddLine" and "guicontrolget, AddColumn"

gosub, ButtonsReposition

gui, show, w500 h300, Main Gui Windows

Gui,  +LastFound				;necessary for scrollable gui windows (allow scrolling with mouse wheel - must be added after gui lines)
GroupAdd, MyGui, % "ahk_id " . WinExist()		;necessary for scrollable gui windows (allow scrolling with mouse wheel - must be added after gui lines)


gui, Test:default	;_______Gui Test (just for test)__________ 

gui, +HwndTestGuiHwnd	;stores Gui 1 windows "Hwnd" id in "TestGuiHwnd" variable

gui, +LabelGui	;uses default Gui labels (example: instead using "TestGuiSize:", "GuiSize" will be used while resizing "Test Gui" Windows)

Gui,  +Resize +0x300000  ; WS_VSCROLL | WS_HSCROLL	;necessary for scrollable gui windows 
						;+Resize (allows resize of windows)

gui, add, text, xm, Limit = Up to 11,000 Controls
gui, add, text, xm, Save Location = Script Directory
gui, add, text, xm, "Add" Buttons can't reach Limit
gui, add, text, xm, "F12" and "F11" can reach Limit

gui, add, edit, w85 +readonly, Total Added =
gui, add, edit, x+5 w50 +readonly vTestTotalControl, 
gui, add, button, x+5 w70, Save
gui, add, button, xm w130 vTestAddVertical gTestAddVertical, Add Vertical (F11) 
gui, add, edit, x+5 w50 vTestVertAdd, 1
gui, add, button, xm w130 gTestAddHorizontal, Add Horizontal (F12)
gui, add, edit, x+5 w50 vTestHorAdd, 1
gui, add, edit,  xm w50 vTestRef,
loop, 3
gui, add, edit, x+5 w50,

IfExist, %TestGuiSaveFile%
gosub, TestLoad

TestLoad = 1	;for "guicontrolget, TestVertAdd" and "guicontrolget, TestHorAdd"

x := A_ScreenWidth/2 - 28
y:= A_ScreenHeight/2 - 160
gui, show, x%x% y%y% w260 h265, Gui Test (Just for Test)

Gui,  +LastFound				;necessary for scrollable gui windows (allow scrolling with mouse wheel - must be added after gui lines)
GroupAdd, MyGui, % "ahk_id " . WinExist()		;necessary for scrollable gui windows (allow scrolling with mouse wheel - must be added after gui lines)

return

TestAddVertical:		;______"Gui Test" Test Button Add Vertical______

	if TestAddVertical != 0
	{
	%A_DefaultGui%MostBottomControlAtExecution := %A_DefaultGui%MostBottomControl

	TestAddVertical = 0
	}

gosub, PleaseWait

guicontrolget, Temp, pos,  TestRef
XTemp := TempX

if TestLoad = 1
guicontrolget, TestVertAdd

VerticalsAdded += TestVertAdd	;stores\count the total vertical controls added (to be saved in ".ini" file)

loop, %TestVertAdd%
{

	guicontrolget, Temp, pos,  % %A_DefaultGui%MostBottomControl
	YTemp := TempY + TempH + 5

	loop, 3
	{
	testn++

	if A_index = 1 
	gui, add, edit , x%XTemp%  y%YTemp% w50 r1 vTestEdit%testn%, Edit%testn%
	else
	gui, add, edit , x+5 w50 r1 vTestEdit%testn%, Edit%testn%

	guicontrol,  Wait:, TotalEditAdded, % testn
	}

	%A_DefaultGui%MostBottomControl = TestEdit%testn%	;in this case, after adding new controls, the "MostBottomControl" is the last added "edit control"
						;must be re-specified, otherwise, incorrect scroll area will be calculated by the "UpdateScrollBars()" function
}

UpdateScrollBars(A_DefaultGui, Gui%A_DefaultGui%Width, Gui%A_DefaultGui%Height, 2, 20, 20, 20, 20)

gosub, PleaseWaitOver

guicontrol,  , TestTotalControl, % testn

return

TestAddHorizontal:	;______"Gui Test" Test Button Add Horizontal_______

	if TestAddHorizontal != 0
	{
	%A_DefaultGui%MostRightControlAtExecution := %A_DefaultGui%MostRightControl

	TestAddHorizontal = 0
	}

gosub, PleaseWait

guicontrolget, Temp, pos,  TestRef
YTemp := TempY

if TestLoad = 1
guicontrolget, TestHorAdd

HorizontalsAdded += TestHorAdd		;stores\count the total horizontal controls added (to be saved in ".ini" file)

loop, %TestHorAdd%
{
	guicontrolget, Temp, pos,  % %A_DefaultGui%MostRightControl
	XTemp := TempX + TempW + 5 

	loop, 3
	{
	testn++

	if A_index = 1
	gui, add, edit , x%XTemp% y%YTemp%  w50 r1 vTestEdit%testn%, Edit%testn%
	else
	gui, add, edit ,  w50 r1 vTestEdit%testn%, Edit%testn%

	guicontrol,  Wait:, TotalEditAdded, % testn
	}

	%A_DefaultGui%MostRightControl = TestEdit%testn%		;in this case, after adding new controls, the "MostRightControl" is the last added "edit control"
							;must be re-specified, otherwise, incorrect scroll area will be calculated by the "UpdateScrollBars()" function
}

UpdateScrollBars(A_DefaultGui, Gui%A_DefaultGui%Width, Gui%A_DefaultGui%Height, 2, 20, 20, 20, 20)

gosub, PleaseWaitOver

guicontrol,  , TestTotalControl, % testn

return

Add:	;______________________________Main Gui - Button Add__________________________________

gosub, PleaseWait

guicontrol, Move, Add, y-100		;negative x and y, so the button won't be visible (prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an invisible gui area, avoiding so graphic bugs\glitches)
guicontrol, Move, AddLine, y-100		;negative x and y, so the button won't be visible (prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an invisible gui area, avoiding so graphic bugs\glitches)
guicontrol, Move, AddColumn, y-100	;negative x and y, so the button won't be visible (prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an invisible gui area, avoiding so graphic bugs\glitches)
guicontrol, Move, MainSave, y-100	;negative x and y, so the button won't be visible (prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an invisible gui area, avoiding so graphic bugs\glitches)

	;gosub, ScrollUpLeft		;to prevent gui windows blank\empty spaces if "scrollbars != 0" !
				;not necessary anymore, "YTemp" and "XTemp" below in use instead

;___Main Gui - ADD Line____

GuiControlGet, Temp, Pos, C1L1		;for correct X position necessary to prevent blank\empty spaces  if "scrollbars != 0" !
XTemp := TempX

if MainLoad = 1
guicontrolget, AddLine

LinesAdded += AddLine	;stores\count the total lines added (to be saved in ".ini" file)

loop, %AddLine%
{

	GuiControlGet, Temp, Pos, C%Column%L%Line%	;correct Y position for the new added controls to prevent gui windows blank\empty spaces  if "scrollbars != 0" !
	YTemp := TempY + TempH + 5			;get x, y , width and height position from the last added edit control "C%Column%L%Line%" and store values in "TempY" "TempX" "TempW" "TempH" variables


	Line++

	loop, %Column%
	{	
	if a_index = 1
	gui, add, edit, x%XTemp%  y%YTemp% w50 r1 vC%a_index%L%Line% gRealTimeOutput, C%a_index%L%Line%
	else
	gui, add, edit, x+5  w50 r1 vC%a_index%L%Line% gRealTimeOutput, C%a_index%L%Line%

	TotalEditAdded++
	guicontrol, Wait:, TotalEditAdded, %TotalEditAdded%
	}
}

;___Main Gui - ADD Column____

GuiControlGet, Temp, Pos, C1L1		;for correct Y position necessary to prevent blank\empty spaces  if "scrollbars != 0" !
YTemp := TempY

if MainLoad = 1
guicontrolget, AddColumn

ColumnsAdded += AddColumn	;stores\count the total columns added (to be saved in ".ini" file)

loop, %AddColumn%
{

	GuiControlGet, Temp, Pos, C%Column%L%Line%	;correct X position for the new added controls to prevent gui windows blank\empty spaces  if "scrollbars != 0" !
	XTemp := TempX + TempW + 5			 ;get x, y , width and height position from the last added edit control "C%Column%L%Line%" and store values in "TempY" "TempX" "TempW" "TempH" variables

	Column++

	loop, %Line%
	{	
	if a_index = 1
	gui, add, edit, x%XTemp% y%YTemp% w50 r1 vC%Column%L%a_index% gRealTimeOutput, C%Column%L%a_index%	;ys, ym, y(0 to 7) cause adding columns bugs (y10 no bug found) 
	else
	gui, add, edit, y+5 w50 r1 vC%Column%L%a_index% gRealTimeOutput, C%Column%L%a_index%	;"Y+5", "5" is the "y" spacement between add controls (necessasy to prevents spacement problem)  

	TotalEditAdded++
	guicontrol, Wait:, TotalEditAdded, %TotalEditAdded%
	}
}

;_______Button Repsition \ UpdateScrollBars _________

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

gosub, PleaseWaitOver

guicontrol, 1:, TotalEditAdded, %TotalEditAdded%

return

ButtonsReposition:	;______________________________Buttons Reposition____________________________

GuiControlGet, Temp, Pos, C%Column%L%Line% 	;get x, y , width and height position from the last added edit control "C%Column%L%Line%" and store values in "TempY" "TempX" "TempW" "TempH" variables

GuiControl, Move, Add, % "X" TempX + TempW +5 "Y" TempY + TempH + 5

GuiControl, Move, AddLine, % "X" TempX  "Y" TempY + TempH + 5
GuiControl, Move, AddColumn, % "X" TempX + TempW + 5 "y" TempY

GuiControl, Move, MainSave, % "X" TempX - TempW - 4 "y" TempY + TempH +5	;"-4" instead "-5", otherwise, "Save" button would be wrongly defined as the "MostLeftControl"

return

ButtonSave:	;________________Main Gui Save________________

IniWrite, %LinesAdded%, %MainGuiSaveFile%, Section, LinesAdded
IniWrite, %ColumnsAdded%, %MainGuiSaveFile%, Section, ColumnsAdded

IniWrite, % %A_Gui%MostLeftControl, %MainGuiSaveFile%, Section, %A_Gui%MostLeftControl
IniWrite, % %A_Gui%MostTopControl, %MainGuiSaveFile%, Section, %A_Gui%MostTopControl
IniWrite, % %A_Gui%MostRightControl, %MainGuiSaveFile%, Section, %A_Gui%MostRightControl
IniWrite, % %A_Gui%MostBottomControl, %MainGuiSaveFile%, Section, %A_Gui%MostBottomControl

IniWrite, % %A_Gui%GuiScrollableAtExecution, %MainGuiSaveFile%, Section, %A_Gui%GuiScrollableAtExecution

	;IniWrite, %type%, %CharsListSavePath%\UserList.ini, Section, type	;"IniWrite" will write inside "settings.ini" file
							; %type% will replace the "type" variable value from ".ini" file (second "type") , with "type" variable value from the script
								;autotrim for iniread and iniwrite (preserve the leading and last spaces):
									;for iniWrite, use (""), example: "%type%", to save the leadings and last spaces from "type" var values inside ".ini" file, example type = "  haha  ", the leading and last spaces between "haha" will be saved in ".ini" file as " haha "!
									; then, iniRead will read "  haha  " and preserve the leading and last spaces! (without ("") from  iniWrite, the leading and last spaces will not be preserved from "type" var value!)
							;"settings.ini" location of the ".ini" file (using only "settings.ini", means that autohotkey will store, the ".ini" file at same location where the autohotkey or .exe file are located)
							;"Section" a section inside ".ini" file where to save a varaiable value
							; you can specify paths like:      %A_WorkingDir%\App Files\settings.ini        tested and worked
								; note  that, the specified folder must exist in order to autohotkey store / create the ".ini" file, otherwise, if the specified folder doesn't exist, autohotkey will not create the ".ini file"
							;The section name in the .ini file, which is the heading phrase that appears in square brackets (do not include the brackets in this parameter).


return

TestButtonSave:	;________Test Gui Save__________________

IniWrite, %VerticalsAdded%, %TestGuiSaveFile%, Section, VerticalsAdded
IniWrite, %HorizontalsAdded%, %TestGuiSaveFile%, Section, HorizontalsAdded

IniWrite, % %A_Gui%MostLeftControl, %TestGuiSaveFile%, Section, %A_Gui%MostLeftControl
IniWrite, % %A_Gui%MostTopControl, %TestGuiSaveFile%, Section, %A_Gui%MostTopControl

if %A_Gui%MostRightControlAtExecution !=		;if not blank
IniWrite, % %A_Gui%MostRightControlAtExecution, %TestGuiSaveFile%, Section, %A_Gui%MostRightControlAtExecution
else
IniWrite, % %A_Gui%MostRightControl, %TestGuiSaveFile%, Section, %A_Gui%MostRightControlAtExecution

if %A_Gui%MostBottomControlAtExecution !=	;if not blank
IniWrite, % %A_Gui%MostBottomControlAtExecution, %TestGuiSaveFile%, Section, %A_Gui%MostBottomControlAtExecution
else
IniWrite, % %A_Gui%MostBottomControl, %TestGuiSaveFile%, Section, %A_Gui%MostBottomControlAtExecution

IniWrite, % %A_Gui%GuiScrollableAtExecution, %TestGuiSaveFile%, Section, %A_Gui%GuiScrollableAtExecution

return

MainLoad:		;_________Main Gui Load__________________

IniRead, AddLine, %MainGuiSaveFile%, Section, LinesAdded
IniRead, AddColumn, %MainGuiSaveFile%, Section, ColumnsAdded

IniRead, %A_DefaultGui%MostLeftControl, %MainGuiSaveFile%, Section, %A_DefaultGui%MostLeftControl
IniRead, %A_DefaultGui%MostTopControl, %MainGuiSaveFile%, Section, %A_DefaultGui%MostTopControl
IniRead, %A_DefaultGui%MostRightControl, %MainGuiSaveFile%, Section, %A_DefaultGui%MostRightControl
IniRead, %A_DefaultGui%MostBottomControl, %MainGuiSaveFile%, Section, %A_DefaultGui%MostBottomControl

IniRead, %A_DefaultGui%GuiScrollableAtExecution, %MainGuiSaveFile%, Section, %A_DefaultGui%GuiScrollableAtExecution	;allows fast scroll area calculation at script execution while loading
											;"LinesAdded" and "ColumnsAdded" will not affect calculation speed

gosub, Add

	;Iniread, type, %a_workingdir%\ini load read.ini, section, type	;"Iniread" will read "settings.ini" file
							; first "type" will target any "type" variable value in the script and they will be replaced with the "type" variable value from ".ini" file (second "type")
								;autotrim for iniread and iniwrite (preserve the leading and last spaces):
									;for iniWrite, use (""), example: "%type%", to save the leadings and last spaces from "type" var values inside ".ini" file, example type = "  haha  ", the leading and last spaces between "haha" will be saved in ".ini" file as " haha "!
									; then, iniRead will read "  haha  " and preserve the leading and last spaces! (without ("") from  iniWrite, the leading and last spaces will not be preserved from "type" var value!)
							;"section", the section where to read the variables values inside the ".ini" file
							;"settings.ini" location of the ".ini" file (using only "settings.ini", means that autohotkey will read, if exist, the ".ini" file located at same location where the autohotkey or .exe file are located)
							; you can specify paths like:      %A_WorkingDir%\App Files\settings.ini        tested and worked
							;The section name in the .ini file, which is the heading phrase that appears in square brackets (do not include the brackets in this parameter).

return

TestLoad:		;__________________Test Gui Load_____________________

IniRead, TestVertAdd, %TestGuiSaveFile%, Section, VerticalsAdded
IniRead, TestHorAdd, %TestGuiSaveFile%, Section, HorizontalsAdded

IniRead, %A_DefaultGui%MostLeftControl, %TestGuiSaveFile%, Section, %A_DefaultGui%MostLeftControl
IniRead, %A_DefaultGui%MostTopControl, %TestGuiSaveFile%, Section, %A_DefaultGui%MostTopControl

IniRead, %A_DefaultGui%MostRightControl, %TestGuiSaveFile%, Section, %A_DefaultGui%MostRightControlAtExecution
IniRead, %A_DefaultGui%MostBottomControl, %TestGuiSaveFile%, Section, %A_DefaultGui%MostBottomControlAtExecution

IniRead, %A_DefaultGui%GuiScrollableAtExecution, %TestGuiSaveFile%, Section, %A_DefaultGui%GuiScrollableAtExecution	;allows fast scroll area calculation at script execution while loading
											;"LinesAdded" and "ColumnsAdded" will not affect calculation speed

gosub, TestAddVertical
gosub, TestAddHorizontal

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

PleaseWait:		;_____________Please Wait - Adding Controls_____________ 

Gui, %A_DefaultGui%: +Disabled		;To prevent the user from interacting with the owner while one of its owned window is visible, disable the owner via Gui +Disabled. Later (when the time comes to cancel or destroy the owned window), re-enable the owner via Gui -Disabled. Do this prior to cancel/destroy so that the owner will be reactivated automatically.
gui, Wait: +owner%A_DefaultGui%	;Make #2 window owned by #1 window.

gui, Wait: -Sysmenu
gui, Wait: add, Text, w200 y+30 center, Please Wait!!! `n
gui, Wait: add, Text, x50, Total Added = 
gui, Wait: add, Edit, x+5 w50 vTotalEditAdded +readonly center,
gui, Wait: show, , Adding Controls

return

PleaseWaitOver:	;_____________Please Wait Over - Adding Controls_____________ 

Gui, %A_DefaultGui%: -Disabled	; must use "Gui, 1: -Disabled" instead "Gui, -Disabled", otherwise, gui first windows will not be activated
			;To prevent the user from interacting with the owner while one of its owned window is visible, disable the owner via Gui +Disabled. Later (when the time comes to cancel or destroy the owned window), re-enable the owner via Gui -Disabled. Do this prior to cancel/destroy so that the owner will be reactivated automatically.
			;must use "Gui, 1: -Disabled" before  "Gui, 2: destroy", in order allow "gui 1" to be automatically selected after destroying "gui 2"

Gui, Wait: destroy		;must use "Gui, 1: -Disabled" before  "Gui, 2: destroy", in order allow "gui 1" to be automatically selected after destroying "gui 2"


return

guiclose:	;__________________________________gui close___________________________
exitapp

f11::	;_______________F11 (Add Line \ Test Add vertical)_____________

TempHwnd := Winactive("A")	;stores "Hwnd" id of the current active windows in "TempHwnd" variable
			;"A" Active Windows


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
goto, Add
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

