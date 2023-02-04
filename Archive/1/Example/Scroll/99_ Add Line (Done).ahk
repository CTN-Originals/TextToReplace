

Col = 2		;gui starts with 2 Columns

Col1EditTotal = 3

Col2EditTotal = 3


gui, +resize

gui, add, button, vAddLine, Add Line	;x65 y85
GuiControl, 1: Move, AddLine, x65 y85	;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)

gui, add, edit, xm ym w50 vCol1Edit1, C1E1
gui, add, edit, w50 vCol1Edit2, C1E2
gui, add, edit, w50 vCol1Edit3, C1E3

gui, add, edit, x+5 ym w50 vCol2Edit1, C2E1
gui, add, edit, w50 vCol2Edit2, C2E2
gui, add, edit, w50 vCol2Edit3, C2E3

gui, show, w200 h200, gui
return

ButtonAddLine:	;______________________________ButtonAdd Line__________________________________

gosub, ButtonsReposition

loop, %Col%
{
Col%a_index%EditTotal++
	
ColEditTotalTemp := Col%a_index%EditTotal

	if a_index = 1
	gui, add, edit, xm w50 vCol%a_index%Edit%ColEditTotalTemp%, C%a_index%E%ColEditTotalTemp%
	else
	gui, add, edit, x+5 w50  vCol%a_index%Edit%ColEditTotalTemp%, C%a_index%E%ColEditTotalTemp%
}

return

ButtonsReposition:	;______________________________Buttons Reposition____________________________

MoveEditRef = Col%Col%Edit%Col1EditTotal%	;Edit control from last column and last line

GuiControlGet, %MoveEditRef%, 1: Pos			;get x, y , width and height position from "%MoveEditRef%" Button and store values in "%MoveEditRef%y" "%MoveEditRef%x" "%MoveEditRef%w" "%MoveEditRef%h" variables
						;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)

GuiControl, 1: Move, AddLine, % "x" %MoveEditRef%x "y" %MoveEditRef%y+55		;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)

return

guiclose:
exitapp


























