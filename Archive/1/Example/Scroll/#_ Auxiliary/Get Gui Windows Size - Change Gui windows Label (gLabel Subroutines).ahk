
;________________gui _____________________

gui, +Resize
gui, add, button, gShowSize, Show Gui Size (Works)
gui, add, button, gShowSize1, Show Gui Size (does not Work)
gui, add, text, x5 , `nBy Resizing the Windows, a messagebox `nwill show up displaying their sizes `n 
gui, add, text, x5, F11 (Keyboard): `n`n - "Gui 2" Windows uses "3Gui" Lables `n`n - "Gui 3" Windows uses "2Gui" Lables
gui, add, text, ,  ` - causes incorrect gui2/gui3 size output
gui, add, text, , ` - Gui2/Gui3 resize will not work `n
gui, add, text, x5, F12 (Keyboard): `n`n - "Gui 2" Windows uses "2Gui" Lables `n`n - "Gui 3" Windows uses "3Gui" Lables 
gui, add, text, ,  ` - causes incorrect gui2/gui3 size output
gui, add, text, , ` - Gui2/Gui3 resize will not work
gui, show, w200 , Gui 1

;_________________gui 2_____________________

gui, 2: +LabelGui	;"gui 2" Windows will use the same "SubRoutine Lables" used by the Default "Gui" windows
		;example: "gui 2" windows close button will use "guiclose" subroutine lable instead "2guiclose" 
		;example: "gui 2" windows when resized will use "GuiSize" subroutine lable instead "2GuiSize" 
		;the "gui 2" id will still be "2" even if "SubRoutine Lables" is changed

gui, 2: +Resize
gui2x := a_ScreenWidth/2+110
gui, 2: add, button, gShowSize, Show Gui Size (Works)
gui, 2: add, button, gShowSize1, Show Gui Size `n (does not Work)
gui, 2: show, w150 h150 x%gui2x%, Gui 2

;_________________gui 3_____________________

gui, 3: +LabelGui	;"gui 3" Windows will use the same "SubRoutine Lables" used by the Default "Gui" windows
		;example: "gui 3" windows close button will use "guiclose" subroutine lable instead "3guiclose" 
		;example: "gui 3" windows when resized will use "GuiSize" subroutine lable instead "3GuiSize" 
		;the "gui 3" id will still be "3" even if "SubRoutine Lables" is changed

gui, 3: +Resize
gui3x := a_ScreenWidth/2-265
gui, 3: add, button, gShowSize, Show Gui Size (Works)
gui, 3: add, button, gShowSize1, Show Gui Size `n (does not Work)
gui, 3: show, w150  x%gui3x%, Gui 3

gui, show, w200 , Gui 1	;makes gui 1 the active windows at script execution

sleep, 1000		;prevents message boxes showing up displaying gui windows size output at script execution
GuiSize = 1		

return

	;__________________"Show" buttons____________________________

ShowSize:		;_______works__

Gui, +OwnDialogs		;(gui own dialog message box "must press ok button to continue using main the gui windows")
			;pauses current "loop" thread too (must press message box ok button in order to loop continues again)

msgbox, % " Gui Windows Size = " A_Gui "`n`n Width = " Gui%A_Gui%Width "`n`n Height = " Gui%A_Gui%Height

	;"Gui%A_Gui%Width" and "Gui%A_Gui%Height" used instead "A_GuiWidth" and "A_GuiHeight"
	;see the notes below why

return

ShowSize1:		;_____does not work__

Gui, +OwnDialogs		;(gui own dialog message box "must press ok button to continue using main the gui windows")
			;pauses current "loop" thread too (must press message box ok button in order to loop continues again)

	;"A_GuiWidth" and "A_GuiHeight" will only show the right gui windows width\height values when "GuiSize" subroutine is called by resizing a gui windows
	;if "GuiSize" subroutine is called by a gui control (like buttons) instead by resizing a gui windows, "A_GuiWidth" outputs "0" and "A_GuiHeight" outputs "32768" (wrong values)
	;for others subroutines called by general gui controls (like "buttons" for example), "A_GuiWidth" outputs "0" and "A_GuiHeight" outputs "32768" (wrong values)

msgbox, ` Gui Windows Size = %A_Gui% `n`n Width = %A_GuiWidth% `n`n Height = %A_GuiHeight%		;for others subroutines called by general gui controls (like "buttons" for example), "A_GuiWidth" outputs "0" and "A_GuiHeight" outputs "32768" (wrong values)

ShowSize1 = 0	;prevents "Gui%A_Gui%Width" = 0 and "Gui%A_Gui%Height" = 32768
			
gosub, GuiSize	;if "GuiSize" subroutine is called by a gui control (like buttons) instead by resizing a gui windows, "A_GuiWidth" outputs "0" and "A_GuiHeight" outputs "32768" (wrong values)	

ShowSize1 = 1

return

;_____________________________F keyboard buttons__________________ 

f11:: ;_____

gui, 2: +Label3Gui	;"gui 2" windows will use the same "SubRoutine Lables" used by "gui 3" windows instead using the "Gui" Windows default ones as defined at script execution
		;example: "gui 2" windows close button will use "3guiclose" subroutine lable instead "guiclose" as defined at script execution
		;example: "gui 2" windows when reized will use "3GuiSize" subroutine lable instead "GuiSize" as defined at script execution 
		;the "gui 2" id will still be "2" even if "SubRoutine Lables" is changed

gui, 3: +Label2Gui	;"gui 3" windows will use the same "SubRoutine Lables" used by "gui 2" windows instead using the "Gui" Windows default ones as defined at script execution
		;example: "gui 3" windows close button will use "2guiclose" subroutine lable instead "guiclose" as defined at script execution
		;example: "gui 3" windows when reized will use "2GuiSize" subroutine lable instead "GuiSize" as defined at script execution 
		;the "gui 3" id will still be "3" even if "SubRoutine Lables" is changed

return

f12:: ;_____

gui, 2: +Label2Gui	;"gui 2" windows will use its own "SubRoutine Lables" instead using the "Gui" Windows default ones as defined at script execution
		;example: "gui 2" windows close button will use "2guiclose" subroutine lable instead "guiclose" as defined at script execution
		;example: "gui 2" windows when reized will use "2GuiSize" subroutine lable instead "GuiSize" as defined at script execution 
		;the "gui 2" id will still be "2" even if "SubRoutine Lables" is changed

gui, 3: +Label3Gui	;"gui 3" windows will use its own "SubRoutine Lables" instead using the "Gui" Windows default ones as defined at script execution
		;example: "gui 3" windows close button will use "3guiclose" subroutine lable instead "guiclose" as defined at script execution
		;example: "gui 3" windows when reized will use "3GuiSize" subroutine lable instead "GuiSize" as defined at script execution 
		;the "gui 3" id will still be "3" even if "SubRoutine Lables" is changed

return


GuiSize:	;________________________Gui Size__________________________	

if GuiSize = 1	;prevents message boxes showing up displaying gui windows size output at script execution
{
Gui, +OwnDialogs		;(gui own dialog message box "must press ok button to continue using main the gui windows")
			;pauses current "loop" thread too (must press message box ok button in order to loop continues again)

msgbox, ` Gui Windows Resized = %A_Gui% `n`n Width = %A_GuiWidth% `n`n Height = %A_GuiHeight%
}

if ShowSize1 != 0	;prevents "Gui%A_Gui%Width" = 0 and "Gui%A_Gui%Height" = 32768
{
Gui%A_Gui%Width = %A_GuiWidth%	;"Gui%A_Gui%Width" allows any subroutine called by any gui control (buttons, etc), keyboard button, etc, to detect a gui windows width
Gui%A_Gui%Height =  %A_GuiHeight%	;"Gui%A_Gui%Height" allows any subroutine called by any gui control (buttons, etc), keyboard button, etc, to detect a gui windows Height
}

return


	;________________________Gui Close__________________________

guiclose:
exitapp
return

2guiclose:
Gui, +OwnDialogs		;(gui own dialog message box "must press ok button to continue using main the gui windows")
			;pauses current "loop" thread too (must press message box ok button in order to loop continues again)

msgbox, "2guiclose" SubRoutine Launched by "Gui %A_Gui%" close button!
return

3guiclose:
Gui, +OwnDialogs		;(gui own dialog message box "must press ok button to continue using main the gui windows")
			;pauses current "loop" thread too (must press message box ok button in order to loop continues again)

msgbox, "3guiclose" SubRoutine Launched by "Gui %A_Gui%" close button!
return










