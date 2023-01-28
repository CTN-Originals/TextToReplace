#SingleInstance, Force

		trigger := "test"
		IniRead, ThisActive, ini\main.ini, test, Active
		if (!ThisActive) {
			return
		}

		:*:test::
			LoopTimes := 4
			Send, test

			ToolTip, {replaceHotkey} replace with "by the way by the wayby the wayby the wayby the wayby the wayby the wayby the wayby the wayby the way", PressToReplace
			WaitForKeyPress := 1
			SetTimer, PressToReplace, -2000

			IniRead, Output, ini\main.ini, test, Output
		return