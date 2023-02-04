#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

Global n1 = 4
Global n2 = 8
Msgbox,,Include.ahk, % func(n1, n2)

func(x := 2, y := 5) {
	return x + y
}