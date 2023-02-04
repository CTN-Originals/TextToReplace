

gui, add, edit,   w100,
loop, 3
gui, add, edit, x+5  w100,

gui, add, edit, xm  w100 r3 -VScroll,
gui, add, edit, x+5  w100 r3,
gui, add, edit, x+5  w100 r3 +HScroll -VScroll,
gui, add, edit, x+5  w100 r3 +HScroll +VScroll,

gui, add, listview, xm w100 BackgroundWhite Grid , 1|2|3  		;0x8000   NoSortHdr
gui, add, listview, x+5 w100 BackgroundWhite Grid, 1
loop, 10
LV_Add("", a_index)
LV_ModifyCol(1, 25)
gui, add, listview, x+5 w100 BackgroundWhite Grid, 111111|222222|333333
gui, add, listview, x+5 w100 BackgroundWhite Grid, 1|2|3  
loop, 10
LV_Add("", a_index)

gui, add, listbox, xm w100 h75,  1|2|
gui, add, listbox, x+5 w100 h75,  0|1|2|3|4|5|6|7|8|9
gui, add, listbox, x+5 w100 h75 +hscroll,  0000000000000000000000|1|2
gui, add, listbox, x+5 w100 h75 +hscroll,  0000000000000000000000|1|2|3|4|5|6|7|8|9

;It seems that "+hscroll" does not work with "DropDownList"
gui, add, ddl, xm w100 +hscroll, Click||1|2
gui, add, ddl, x+5 w100 +hscroll, Click||1|2|2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |22222222222222222222222222222222222222222222222222222222222222222|End

gui, show
return

guiclose:	;_______________ Close Button ________________________
exitapp


ControlScrollBarsCheck(wParam, lParam, msg, hwnd)	;_________ Control Scroll Bars Check (Function) _________
{
ControlGet, ControlStyle, style, , , ahk_id %hwnd%	;stores the control style in "ControlStyle" variable

if (ControlStyle & 0x100000)	;check for "horizontal" scroll bar.
HBar = Yes			;if control contains "horizontal" scroll bar, "HBar = Yes"

if (ControlStyle & 0x200000)	;check for "vertical" scroll bar.
VBar = Yes			;if control contains "vertical" scroll bar, "VBar = Yes"

ToolTip, Hwnd: %hwnd% `n`n VBar: %VBar% `n`n HBar: %HBar% 

return

Static RunAtScriptExecution := OnMessage(0x200, "ControlScrollBarsCheck")	;"0x200", execute "ControlScrollBarsCheck" function at mouse movement
}


