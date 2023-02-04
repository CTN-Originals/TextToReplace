
	;autohotkey 32bit unicode


Column = 2	;gui starts with 2 Columns

Line = 3		;gui starts with 3 Lines



gui, +resize

gui, add, button, vAddLine, Add Line		;x65 y85
GuiControl, 1: Move, AddLine, x65 y85		;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)

gui, add, button, vAddColumn, Add Column		;x65 y85
GuiControl, 1: Move, AddColumn, x120 y60		;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)

gui, add, edit, xm ym w50 vC1L1 gRealTimeOutput, C1L1
gui, add, edit, w50 vC1L2 gRealTimeOutput, C1L2
gui, add, edit, w50 vC1L3 gRealTimeOutput, C1L3

gui, add, edit, x+5 ym w50 vC2L1 gRealTimeOutput, C2L1
gui, add, edit, w50 vC2L2 gRealTimeOutput, C2L2
gui, add, edit, w50 vC2L3 gRealTimeOutput, C2L3

gui, show, w500 h300, gui
return

ButtonAddLine:	;______________________________Button Add Line__________________________________

ButtonsReposition = Line		;prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an empty gui area, avoiding so graphic bugs\glitches 
gosub, ButtonsReposition

Line++

loop, %Column%
{	
if a_index = 1
gui, add, edit, xm w50 vC%a_index%L%Line% gRealTimeOutput, C%a_index%L%Line%
else
gui, add, edit, x+5 w50  vC%a_index%L%Line% gRealTimeOutput, C%a_index%L%Line%
}

return

ButtonAddColumn:	;______________________________Button Add Column_________________________________

ButtonsReposition = Column		;prevents the last  added "Edit" control to overlap "Add Line" or "Add Column" buttons by moving them first  to an empty gui area, avoiding so graphic bugs\glitches 
gosub, ButtonsReposition

Column++

loop, %Line%
{	
if a_index = 1
gui, add, edit, x+5 ym w50 vC%Column%L%a_index% gRealTimeOutput, C%Column%L%a_index%
else
gui, add, edit, w50  vC%Column%L%a_index% gRealTimeOutput, C%Column%L%a_index%
}

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


f12::
guicontrol, , C1L1, X
return



















