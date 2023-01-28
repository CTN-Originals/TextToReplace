#SingleInstance, Force

	trigger := "btw"
	IniRead, ThisActive, ini\main.ini, btw, Active
	if (!ThisActive) {
		return
	}

	:*:btw::
		LoopTimes := 3
		Send, btw

		ToolTip, {replaceHotkey} replace with "by the way", PressToReplace
		WaitForKeyPress := 1
		SetTimer, PressToReplace, -2000

		IniRead, Output, ini\main.ini, btw, Output
	return