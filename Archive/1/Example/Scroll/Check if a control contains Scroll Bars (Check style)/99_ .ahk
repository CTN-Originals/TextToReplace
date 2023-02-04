


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
gui, add, listview, x+5 w100 BackgroundWhite Grid 100, 111111|222222|333333
gui, add, listview, x+5 w100 BackgroundWhite Grid 100, 1|2|3  
loop, 10
LV_Add("", a_index)

gui, show
return

guiclose:	;_______________ Close Button ________________________
exitapp


ControlScrollBarsCheck(wParam, lParam, msg, hwnd)	;_________ Control Scroll Bars Check (Function) _________
{
ControlGet, ControlStyle, style, , , ahk_id %hwnd%

if (ControlStyle & 0x100000)
HBar = Yes

if (ControlStyle & 0x200000)
VBar = Yes

ToolTip, Hwnd: %hwnd% `n`n VBar: %VBar% `n`n HBar: %HBar% 

return

Static RunAtScriptExecution := OnMessage(0x200, "ControlScrollBarsCheck")
}


