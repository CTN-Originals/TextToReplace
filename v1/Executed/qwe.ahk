#SingleInstance, Force
trigger := "qwe"
IniRead, ThisActive, ini	riggers.ini, qwe, Active
if (!ThisActive) {
	return
}
	
:*:qwe::
	LoopTimes := 3
	Send, qwe
	WaitForKeyPress := 1
	GoSub, InitiateTrigger
	IniRead, Output, ini/triggers.ini, qwe, Output
return