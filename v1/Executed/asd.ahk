#SingleInstance, Force

	trigger := "asd"
	IniRead, ThisActive, ini\main.ini, asd, Active
	if (!ThisActive) {
		return
	}

	:*:asd::
		LoopTimes := 3
		Send, asd

		ToolTip, {replaceHotkey} replace with "qwer", PressToReplace
		WaitForKeyPress := 1
		SetTimer, PressToReplace, -2000

		IniRead, Output, ini\main.ini, asd, Output
	return