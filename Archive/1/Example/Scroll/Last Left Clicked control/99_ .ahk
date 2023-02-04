

gui, add, combobox,   w100 r5, 1|2|3|4|5|6|7|8|9|10
loop, 3
gui, add, edit, x+5  w100,

gui, add, edit, xm  w100 r3 -VScroll, Press "F12" to show The Last Left Clicked Control!
gui, add, edit, x+5  w100 r3, Press "F11" to blank The Last Left Clicked Control!
gui, add, edit, x+5  w100 r3 +HScroll -VScroll, 
gui, add, edit, x+5  w100 r3 +HScroll +VScroll, 

gui, add, listview, xm w100 BackgroundWhite Grid , 1|2|3  		;0x8000   NoSortHdr
gui, add, listview, x+5 w100 BackgroundWhite Grid, 1
loop, 10
LV_Add("", a_index)
LV_ModifyCol(1, 25)
gui, add, listview, x+5 w100 BackgroundWhite Grid, 111111|222222|333333|222222|333333|222222|333333|222222|333333
gui, add, listview, x+5 w100 BackgroundWhite Grid, 1|2|3  
loop, 10
LV_Add("", a_index)

gui, add, listbox, xm w100 h75,  1|2|
gui, add, listbox, x+5 w100 h75,  0|1|2|3|4|5|6|7|8|9
gui, add, listbox, x+5 w100 h75 +hscroll,  0000000000000000000000|1|2
gui, add, listbox, x+5 w100 h75 +hscroll,  0000000000000000000000|1|2|3|4|5|6|7|8|9

Gui, Add, TreeView, xm w100 h75
P1 := TV_Add("Test")
P1C1 .= TV_Add("Parent 1's first child", P1)  ; Specify P1 to be this item's 
Gui, Add, TreeView, x+5 w100 h75
P1 := TV_Add("Test", , "Expand")
loop, 10
P1C1 .= TV_Add(a_index, P1)  ; Specify P1 to be this item's 
Gui, Add, TreeView, x+5 w100 h75
P1 := TV_Add("Test", , "Expand")
P1C1 .= TV_Add("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTt", P1)  ; Specify P1 to be this item's 
Gui, Add, TreeView, x+5 w100 h75
P1 := TV_Add("Test", , "Expand")
loop, 10
P1C1 .= TV_Add(a_index " - TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTt", P1)  ; Specify P1 to be this item's 

;It seems that "+hscroll" does not work with "DropDownList"
gui, add, ddl, xm w100 +hscroll, Click||1|2
gui, add, ddl, x+5 w100 +hscroll, Click||1|2|2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |2 |22222222222222222222222222222222222222222222222222222222222222222|End

gui, show

return

F12::	;______________ F12 ___________________	

tooltip, % "Last Left Clicked Control: `n`n ClassNN: " LastLeftClickedControl("ClassNN") "`n`n Hwnd: " LastLeftClickedControl("Hwnd")

return

f11::	;___________ F11 ___________________

LastLeftClickedControl("blank")	;blank "LastLeftClickedControl()" function static var values

return

guiclose:	;___________ Gui close _______________
exitapp


LastLeftClickedControl(Option)	;________________ Last Left Clicked Control (Function) ____________________
{
Static ControlClassNN, ControlHwnd	;"Static" variables are always implicitly "local", but differ from "locals" variables because their values are remembered between calls.

if Option = ClassNN
return, ControlClassNN

if Option = Hwnd
return, ControlHwnd

	if Option = Blank
	{
	ControlClassNN := ControlHwnd := ""	;blank function static var values
	return
	}

MouseGetPos, , , , ControlClassNN, 1	;"ControlClassNN" is the name of the variable in which to store the name (ClassNN) of the control under the mouse cursor. If the control cannot be determined, this variable will be made blank.
				;"0" or "blank", "1" - Stores the control's ClassNN (in this case "1" is recommended)

MouseGetPos, , , , ControlHwnd, 3	;"2" or "3",  Stores the control's HWND id number, instead the control's ClassNN (in this case "3" is recommended)

	;ToolTip, ClassNN: %ControlClassNN% `n`n Hwnd: %ControlHwnd%

return

Static RunAtScriptExecution1 := OnMessage(0xA1, "LastLeftClickedControl")	;for "Left" mouse button press while the cursor is within the nonclient area of a window
Static RunAtScriptExecution2 := OnMessage(0x201, "LastLeftClickedControl")	;for "Left" mouse button press while the cursor is in the client area of a window
}
