#SingleInstance, Force

	trigger := "qwe"
	IniRead, ThisActive, ini\main.ini, qwe, Active
	if (!ThisActive) {
		return
	}

	:*:qwe::
		LoopTimes := 3
		Send, qwe

		ToolTip, {replaceHotkey} replace with "asd", PressToReplace
		WaitForKeyPress := 1
		SetTimer, PressToReplace, -2000

		IniRead, Output, ini\main.ini, qwe, Output
	return