#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; SplashTextOn, , , hello world?
; SplashImage, SHOW, cwBlue, Test, ,
; SplashImage, on
;Gui, Add, Progress, cwBlue Vertical vMyProgress w200



SplashTextOn, , , Displays only a title bar.
Sleep, 2000
SplashTextOn, 400, 300, Clipboard, The clipboard contains:`n%clipboard%
WinMove, Clipboard, , 0, 0  ; Move the splash window to the top left corner.
MsgBox, Press OK to dismiss the SplashText
SplashTextOff


;Gui, Color, Black
;Gui, Show, w800 h400, Splach example 1
return