; #NoEnv
#SingleInstance Force
#Warn All, stdOut
#ErrorStdOut "UTF-8"
#Requires AutoHotkey v2.0
SendMode "Play"
SetWorkingDir A_ScriptDir


mainGui := Gui(, "Main",)
mainGui.Add('Button', 'x10 y10 w100 h30 cff0000 Background0000FF ++Border', 'Button')
mainGui.Show("w250 h100 NA")