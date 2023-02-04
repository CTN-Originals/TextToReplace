
	;https://autohotkey.com/boards/viewtopic.php?f=5&t=24048

gui, add, edit,   w100 +hscroll,
loop, 3
gui, add, edit, x+5  w100,

gui, add, edit, xm  w100 r3 -VScroll, Click Controls `nor `nScrolldown Controls
gui, add, edit, x+5  w100 r3, Click Controls `nor `nScrolldown Controls
gui, add, edit, x+5  w100 r3 +HScroll -VScroll, Click Controls `nor `nScrolldown Controls
gui, add, edit, x+5  w100 r3 +HScroll +VScroll, Click Controls `nor `nScrolldown Controls

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

guiclose:	;_______________ Close Button ________________________
exitapp


~LButton::	;___________ Mouse Left Click Hotkey ____________________
~WheelDown::

	;"~", keeps "left mouse click" and "mouse wheeldown" original functions

MouseGetPos, , , WinId, TempControlId, 3	;"WinId",  to store the Hwnd ID number of the window under the mouse cursor
				;"TempControlId" is the name of the variable in which to store the name (ClassNN) of the control under the mouse cursor. If the control cannot be determined, this variable will be made blank.
				;"3" or "2",  Stores the control's HWND id number, instead the control's ClassNN (in this case, option "3" is more appropriate)
				;"1", "0" or "blank" stores control ClassNN instead
				;https://autohotkey.com/docs/commands/MouseGetPos.htm

tooltip, % "WinId: " WinId "`n`nControlId: " TempControlId "`n`nScroll Bars: " ControlScrollBarsCheck("", "ahk_id" TempControlId)	;"ahk_id" search control by Hwnd id number
return


ControlScrollBarsCheck(Control := "", Window := "")	;_________ Control Scroll Bars Check (Function) _________
{

	;Function Return values: "VH" - Vertical and Horizontal Detected \ "V" - Ony Vertical Detected \ "H" - Only Horizontal Detected

	;"Window",  window's Title! Examples: ControlScrollBarsCheck(ControlClassNN, WinTitle)  \  ControlScrollBarsCheck("edit1", "Notepad")
	;"Window", To operate upon a Window HWND id number, specify "ahk_id"
		;Examples: ControlScrollBarsCheck("Edit8", "ahk_id" WinHwndVar)  \  ControlScrollBarsCheck(ControlClassNN, "ahk_id" WinHwndVar)
	;"Control", Can be either ClassNN (the classname and instance number of the control) or the control's text
	;"Control", To operate upon a control's HWND id number, leave the Control parameter blank and specify "ahk_id"
		;Examples: ControlScrollBarsCheck("", "ahk_id" ControlHwndVar)  \  ControlScrollBarsCheck( , "ahk_id" ControlHwndVar)

ControlGet, ControlStyle, style, , %Control%, %Window%	;stores the control style in "ControlStyle" variable

if (ControlStyle & 0x100000)	;check for "horizontal" scroll bar.
HBar = Yes			;if control contains "horizontal" scroll bar, "HBar = Yes"

if (ControlStyle & 0x200000)	;check for "vertical" scroll bar.
VBar = Yes			;if control contains "vertical" scroll bar, "VBar = Yes"

if (VBar and HBar = "yes")
return "VH"

if VBar = yes
return, "V"

if HBar = yes
return, "H"
}


