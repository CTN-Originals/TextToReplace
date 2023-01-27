

gui, add, edit, w200 r3, Press "F12" or "F11" to focus listview control

gui, add, listview, BackgroundWhite Grid +HwndMyTableControlId, 1|2|3	;"HwndMyTableControlId" stores the control Hwnd Id number in "MyTableControlId" variable

loop, 3
LV_Add("", "Test", "Test", "Test")

gui, show
return

F12::	;___ F12 ___
DllCall("SetFocus", "Ptr", MyTableControlId)
return

F11::	;___ F11 ___
ControlFocus, , ahk_id %MyTableControlId%		;"ahk_id" allows to focus controls by Hwnd Id number
return

guiclose:	;________ Gui Close _______________
exitapp