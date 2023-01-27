

	;https://autohotkey.com/boards/viewtopic.php?p=100117#p100117

gui, add, button, gAdd, Add (F11)
gui, add, text, x+5, Total Added =  
gui, add, edit, x+5 w50 vEdit +readonly,

gui, 2: add, button, gAdd,  Add (F12)
gui, 2: add, text, x+5, Total Added =  
gui, 2: add, edit, x+5 w50 vEdit +readonly,

x := A_ScreenWidth / 2 - 305
gui, show, x%x% w300 h300, Gui 1
x += 310
gui, 2: show, x%x% w300 h300, Gui 2
return

Add:	;__________Add Buttons _____________________

AddFunction(A_DefaultGui)	;"A_DefaultGui" instead "A_Gui", works with "gui threads" and "hotkeys threads", in this case "F11" and "F12"
			;for hotkeys threads, default gui must be specified using this line "gui, x: Default", where "x" is the gui number\id\name desired by user
return

	;_____________ Hotkeys ________________

F11::
gui, 1: Default	;"1" will be assigned to "A_DefaultGui" built-in variable, and since "AddFunction()" parameter from "Add" label is "A_DefaultGui", the new controls will be added in "Gui 1 windows"
goto, Add
return

F12::
gui, 2: Default	;"2" will be assigned to "A_DefaultGui" built-in variable, and since "AddFunction()" parameter from "Add" label is "A_DefaultGui", the new controls will be added in "Gui 2 windows"
goto, Add
return

guiclose:	;________________Gui Close __________________
2guiclose:
exitapp

AddFunction(x)	;______________Add Controls Function _________________
{
Global	;this function will remember the previous variables assigned values, allowing "%x%TotalAdded++" correct count

gui, Add, edit, w50, 
%x%TotalAdded++
guicontrol, , Edit,  % %x%TotalAdded
}











