#SingleInstance, Force
trigger := "asd"
IniRead, ThisActive, ini	riggers.ini, asd, Active
if (!ThisActive) {
	return
}
	
:*:asd::
	LoopTimes := 3
	Send, asd
	GoSub, InitiateTrigger
	IniRead, Output, ini/triggers.ini, asd, Output
return