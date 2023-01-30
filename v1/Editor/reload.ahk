#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

sleep, 500
; MsgBox, Reload?
WinGetTitle, targetTitle, ahk_exe Code.exe
ControlSend,, {CtrlDown}{NumpadAdd}{CtrlUp}, %targetTitle%
ExitApp
