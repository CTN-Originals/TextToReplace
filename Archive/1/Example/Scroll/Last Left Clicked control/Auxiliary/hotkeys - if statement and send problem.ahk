Gui, +HwndGuiId
gui, add, text, , Close to Exit script
Gui, show, w300 h200
return

guiclose:	;________ Gui Close __________
exitapp


WheelUp::		;_________ Hotkeys ___________
WheelDown::
MButton::
F12::
+WheelUp::	;"+" Shift + WheelUp
+WheelDown::	;"+" Shift + WheelDown
+MButton::
+F12::

IfWinactive, ahk_id %GuiId%
{
if (A_ThisHotkey = "WheelDown" or "WheelUp")	;only  "WheelDown" or "WheelUp" Hotkeys should trigger the tooltip, but it's not behaving as expected
					;Correct syntax ==> if (A_ThisHotkey = "WheelDown" or A_ThisHotkey = "WheelUp")

tooltip, %A_ThisHotkey%			;All the hotkeys above trigger the tooltip (but they shouldn't)

return
}

send {%A_ThisHotkey%}	;for WheelUp, WheelDown, MButton and F12 works great
			;for +WheelUp, +WheelDown, +MButton and +F12 does not work
			;for example,  in "FireFox" +wheelup\+wheeldown = previous\next page, but, "send {+WheelDown}\ send {+WheelUp}" don't work

return
