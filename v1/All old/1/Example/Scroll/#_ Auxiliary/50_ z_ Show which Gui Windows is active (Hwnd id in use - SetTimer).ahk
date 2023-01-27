
SetTimer, UpdateInfo, 1000

gui, +HwndGui1	;stores Gui 1 windows "Hwnd" id in "Gui1" variable
x := A_ScreenWidth / 2 - 200 
gui, show, x%x% w200 h200, Gui Windows 1

gui, 2: +HwndGui2		;stores Gui 2 windows "Hwnd" id in "Gui2" variable
x := A_ScreenWidth / 2 +10
gui, 2: show, x%x% w200 h200, Gui Windows 2

gui, info: -Sysmenu
gui, Info: +HwndGuiInfo	;stores Gui Info windows "Hwnd" id in "GuiInfo" variable
gui, Info: add, text, w300 center vText, 
y := A_ScreenHeight / 2 + 110
gui, Info: show, y%y%, Info

gui, 1: show

UpdateInfo:	;_____________________Update Info________________________

TempHwnd := Winactive("A")	;stores "Hwnd" id of the current active windows in "TempHwnd" variable
			;"A" Active Windows

if TempHwnd = %Gui1%
{
guicontrol, info: , Text, Gui 1 Active (Hwnd = %Gui1%)
return
}

if TempHwnd = %Gui2%
{
guicontrol, info: , Text, Gui 2 Active (Hwnd = %Gui2%)
return
}

if TempHwnd = %GuiInfo%
{
guicontrol, info: , Text, Gui Info Active (Hwnd = %GuiInfo%)
return
}

guicontrol, info: , Text, No Gui Windows Active (Hwnd = %TempHwnd%)

return

guiclose:	;______________ gui close_____________
2guiclose:
exitapp











