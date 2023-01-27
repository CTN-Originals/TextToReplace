

gui, add, button, vActive gShow1, Active
gui, add, radio, vRadio1 checked gChangeLable, Change "Active" button g lable to "Show1"
gui, add, radio, vRadio2 gChangeLable, Change "Active" button g lable to "Show2"
gui, add, radio, vRadio3 gChangeLable, Remove "Active" button g lable
gui, show
return

Show1:
msgbox, 1
return

Show2:
msgbox, 2
return

ChangeLable:

loop, 3
{
guicontrolget, radio%a_index%

	if radio%a_index% = 1		;"1" means if radio%a_index% box is checked
	{
	if a_index != 3
	guicontrol, +gShow%a_index%, Active
	else
	guicontrol, -g, Active	;remove g lable from "Active button"
	}

}

return

guiclose:
exitapp













