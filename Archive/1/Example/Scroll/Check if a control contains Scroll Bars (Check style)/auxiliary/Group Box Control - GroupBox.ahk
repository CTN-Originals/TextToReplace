

gui, add, edit,  y50, 1
gui, add, groupbox, x50, haa
gui, add, edit,  xp+10 yp+20, 2
gui, add, edit,  x+5, 3


gui, show
return

guiclose:
exitapp


~LButton::	;___________ Mouse Left Click Hotkey ____________________

	;"~", keeps "left mouse click" and "mouse wheeldown" original functions

MouseGetPos, , , WinId, TempControlId, 2	;"TempControlId" is the name of the variable in which to store the name (ClassNN) of the control under the mouse cursor. If the control cannot be determined, this variable will be made blank.
				;"2",  Stores the control's HWND id number, instead the control's ClassNN

tooltip, % "WinId: " WinId "`n`nControlId: " TempControlId 
return


~WheelDown::	;______________________________

	;"~", keeps "left mouse click" and "mouse wheeldown" original functions

MouseGetPos, , , WinId, TempControlId, 3	;"TempControlId" is the name of the variable in which to store the name (ClassNN) of the control under the mouse cursor. If the control cannot be determined, this variable will be made blank.
				;"2",  Stores the control's HWND id number, instead the control's ClassNN

tooltip, % "WinId: " WinId "`n`nControlId: " TempControlId 
return







