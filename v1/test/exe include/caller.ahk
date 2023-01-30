#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

Gui, Add, Button, x10 y10 w100 h30 gInitiate, Portal Include 
Gui, Show, w250 h100,
return


Initiate:
	FileAppend, 
	(
		#Include, include.ahk

	), portal.ahk 
	sleep, 1000
	#IncludeAgain, portal.ahk
	; Reload
return

^r::
	Reload
return

^j::
	FileDelete, portal.ahk
	FileAppend, `n, portal.ahk
	Reload
return
GuiClose:
	FileDelete, portal.ahk
	FileAppend, `n, portal.ahk
	ExitApp
return

; #Include, portal.ahk