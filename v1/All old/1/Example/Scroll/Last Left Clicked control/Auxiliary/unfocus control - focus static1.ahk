

gui, add, text, , This is a "Text" control (Control ClassNN = Static1)

gui, add, edit, w200 r3, Press "F12" to focus "Static1" control (others controls will be unfocused)

gui, add, listview, BackgroundWhite Grid, 1|2|3

loop, 3
LV_Add("", "Test", "Test", "Test")

gui, show
return

F12::	;___ F12 ___
ControlFocus, Static1, A	;focus control "Static1" of the current active window
			;"A" for active window 
			;instead "Static1", "Button1", "Edit1", etc, etc, can be used
return

guiclose:	;________ Gui Close _______________
exitapp