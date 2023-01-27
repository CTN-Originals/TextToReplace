


	;DllCall("SetFocus", "Ptr", VarOfAnyControlHwndIdNumber)	;replace "VarOfAnyControlHwndIdNumber" with "0" or leave the parameter blank to unfocus current focused control
							;if a correct Control Hwnd id number is specified, the specified control will be focused
							;only works with the script gui windows

Gui, +HwndGuiId

gui, add, text, , Press "F12" to show focused control
gui, add, text, , Press "F11" to remove focus from the focused control

loop, 5
gui, add, edit, w200, 

gui, add, edit, w200 +HwndControlId, 

gui, 2: add, edit, w200, 
gui, 2: add, edit, w200, 

gui, 2: show
gui, show

return

guiclose:	;_______________ Gui Close _________________________
exitapp


F11::	;____ F11 _____

DllCall("SetFocus", "Int", 0)

	;tooltip, hah

return

F12::	;_____ F12 _____

tooltip, % "Focus Found: `n`n" GetFocusedControlHwnd( )

return


GetFocusedControlHwnd( )	;___________Get Focused Control Hwnd Id Number (Function) ________________________
{
GuiWindowHwnd := WinExist("A")		;stores the current Active Window Hwnd id number in "GuiWindowHwnd" variable
				;"A" for Active Window

ControlGetFocus, FocusedControl, ahk_id %GuiWindowHwnd%	;stores the  classname "ClassNN" of the current focused control from the window above in "FocusedControl" variable
						;"ahk_id" searches windows by Hwnd Id number

return, FocusedControl

ControlGet, FocusedControlId, Hwnd,, %FocusedControl%, ahk_id %GuiWindowHwnd%	;stores the Hwnd Id number of the focused control found above in "FocusedControlId" variable

return, FocusedControlId
}


