


Column = 2	;gui starts with 2 Columns

Line = 3		;gui starts with 3 Lines

TotalControls = 6

y = 150

gui, +resize

gui, add, text, , - "Add Column" button can't add more than 331 controls (Why?) `n- "F11" keyboard button can add more than 331 controls! (Why?)
gui, add, text, x+20 ym, - "Add Line" button can't add more than 496 controls (Why?) `n- "F12" keyboard button can add more than 496 controls! (Why?)

gui, add, text, xm y+10, - After 331 columns or 496 lines added, "Add columns" or "Add line" buttons threads won't even be executed anymore! (Why?) `n- After 331 columns or 496 lines added, "F12" or "F11" Keyboard buttons threads will still be executed! (Why?)

gui, add, text, , - Each GUI window may have up to 11,000 controls! From 5000+ controls, system instability may occur for certain control types! `n- But this script can only reach 9,973 controls!

gui, add, button, y+10 vAddLine gF12, Add Line (F12)		;x65 y85
	;GuiControl, 1: Move, AddLine, x65 y85		;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)

gui, add, button, x+5 vAddColumn gF11, Add Column (F11)		;x65 y85
	;GuiControl, 1: Move, AddColumn, x120 y60		;"1:" means gui 1  (for gui 1, only "Pos" would be enough too)

gui, add, edit, xm y%y% w50 r1 vC1L1 +readonly, 0
gui, add, edit, w50 vC1L2 +readonly, Loop = 
gui, add, edit, w50 vC1L3 +readonly, Total = 

gui, add, edit, x+5 y%y% w50 vC2L1 +readonly, 0
gui, add, edit, w50 vC2L2, 331
gui, add, edit, w50 vC2L3 +readonly, %TotalControls%

gui, show, w500 h300 maximize, 
return
	
F12::	;______________________________Button Add Line__________________________________

	;gosub, ButtonsReposition

guicontrolget, C2L2

loop, %C2L2%
{
Line++


loop, %Column%
{	
if a_index = 1
gui, add, edit, xm w50 r1 vC%a_index%L%Line%, C%a_index%L%Line%
else
gui, add, edit, x+5 w50 r1  vC%a_index%L%Line%, C%a_index%L%Line%

TotalControls++
guicontrol, , C2L3, %TotalControls%
}

count2++
guicontrol, , C1L1, %Count2%
}
	;gosub, ButtonsReposition
return


f11::	;______________________________Button Add Column_________________________________

	;gosub, ButtonsReposition

guicontrolget, C2L2

loop, %C2L2%
{
Column++

loop, %Line%
{	
if a_index = 1
gui, add, edit, x+5 y%y% w50 r1 vC%Column%L%a_index%, C%Column%L%a_index%
else
gui, add, edit, w50  r1 vC%Column%L%a_index%, C%Column%L%a_index%

TotalControls++
guicontrol, , C2L3, %TotalControls%
}

	;gosub, ButtonsReposition

Count++
guicontrol, , C2L1, %Count%
}
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


























