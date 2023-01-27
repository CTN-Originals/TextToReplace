


gui, +HwndGui1	;stores Gui 1 windows "Hwnd" id in "Gui1" variable
gui, add, button, g1ButtonActive, Show Active Gui Windows `n(or press "F11" keyboard button)
x := A_ScreenWidth / 2 - 200 
gui, show, x%x% w200 h200, Gui Windows 1

gui, 2: +HwndGui2		;stores Gui 2 windows "Hwnd" id in "Gui2" variable
gui, 2: add, button, g2ButtonActive, Show Active Gui Windows `n(or press "F11" keyboard button)
x := A_ScreenWidth / 2 +10
gui, 2: show, x%x% w200 h200, Gui Windows 2

gui, info: -Sysmenu
gui, Info: +HwndGuiInfo	;stores Gui Info windows "Hwnd" id in "GuiInfo" variable
gui, Info: add, text, w300 center vText, Press keyboard "F11" Button or Gui "Show Active" Buttons
y := A_ScreenHeight / 2 + 110
gui, Info: show, y%y%, Info

gui, 1: show

return

F11::		;__________________ Update Info _______________________
1ButtonActive:
2ButtonActive:

w_Gui =	;"w_Gui = blank" (should be always blank when "hotkeys" or "gui buttons threads" are executed )

TempHwnd := Winactive("A")	;stores "Hwnd" id of the current active windows in "TempHwnd" variable
			;"A" Active Windows

if TempHwnd = %Gui1%
w_Gui = 1

if TempHwnd = %Gui2%
w_Gui = 2

if TempHwnd = %GuiInfo%
w_Gui = Info

ActiveGui(W_Gui, TempHwnd)	;"ActiveGui()" simple example function below

return
 
guiclose:	;______________ gui close_____________
2guiclose:
exitapp


ActiveGui(GuiId, NotFound)	;_______________ ActiveGui (Function)________________
{
if GuiId !=	;if "GuiId" is not blank
guicontrol, info: , Text, % "Gui " GuiId " Active (Hwnd = " Gui%GuiId% ")"
else
guicontrol, info: , Text, No Gui Windows Active (Hwnd = %NotFound%)
}










