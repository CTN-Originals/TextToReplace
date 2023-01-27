


Column = 2	;gui starts with 2 Columns

Line = 3		;gui starts with 3 Lines



gui, +resize

gui, add, button, vAddLine, Add Line		;x65 y85
GuiControl, 1: Move, AddLine, x65 y85		;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)

gui, add, button, vAddColumn, Add Column		;x65 y85
GuiControl, 1: Move, AddColumn, x120 y60		;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)

gui, add, edit, xm ym w50 vC1L1, C1L1
gui, add, edit, w50 vC1L2, C1L2
gui, add, edit, w50 vC1L3, C1L3

gui, add, edit, x+5 ym w50 vC2L1, C2L1
gui, add, edit, w50 vC2L2, C2L2
gui, add, edit, w50 vC2L3, C2L3

gui, show, w500 h300, gui
return

ButtonAddLine:	;______________________________Button Add Line__________________________________

gosub, ButtonsReposition

Line++

loop, %Column%
{	
if a_index = 1
gui, add, edit, xm w50 vC%a_index%L%Line%, C%a_index%L%Line%
else
gui, add, edit, x+5 w50  vC%a_index%L%Line%, C%a_index%L%Line%
}

return

ButtonAddColumn:	;______________________________Button Add Column_________________________________

gosub, ButtonsReposition

Column++

loop, %Line%
{	
if a_index = 1
gui, add, edit, x+5 ym w50 vC%Column%L%a_index%, C%Column%L%a_index%
else
gui, add, edit, w50  vC%Column%L%a_index%, C%Column%L%a_index%
}

gosub, ButtonsReposition

return

ButtonsReposition:	;______________________________Buttons Reposition____________________________

MoveEditRef = C%Column%L%Line%	;"Edit control" from last column and last line

GuiControlGet, %MoveEditRef%, 1: Pos	;get x, y , width and height position from "%MoveEditRef%" Button and store values in "%MoveEditRef%y" "%MoveEditRef%x" "%MoveEditRef%w" "%MoveEditRef%h" variables
				;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)

GuiControl, 1: Move, AddLine, % "x" %MoveEditRef%x "y" %MoveEditRef%y+55		;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)

GuiControl, 1: Move, AddColumn, % "x" %MoveEditRef%x+55 "y" %MoveEditRef%y+25		;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)

return

guiclose:
exitapp


























