Global TooltipConsole := new Console("Tooltip")

class OnHoverTooltip {
	__New(text, control, delay, followMouse := false, offsetPos := 0, offsetSize := 0) {
		this.text := text
		this.control := control
		this.delay := delay
		this.followMouse := followMouse
		this.offsetPos := offsetPos
		this.offsetSize := offsetSize

		this.guiElement := new GuiElementData(this.control)
		this.index := 0

		; Runtime data
		this.state := false
		this.tooltipState := false
		this.startTime := 0
		this.activeTime := 0
		this.currentDelay := delay
	}

	Activate() {
		this.state := true
		this.startTime := A_TickCount
		TooltipConsole.log(this)
	}
	Update() {
		this.activeTime := A_TickCount - this.startTime
	}

	Enable() {
		
	}
	Disable() {
		this.state := false
	}
}

Global OnHoverTooltipList := []
Global ActiveTooltipList := []

SetTimer, OnHoverTooltipUpdate, 1000

RegisterTooltipOnHover(text, control, delay, followMouse := false, offsetPos := 0, offsetSize := 0) {
	newInstance := new OnHoverTooltip(text, control, delay, followMouse, offsetPos, offsetSize := 0)
	OnHoverTooltipList.Push(newInstance)
}


OnHoverTooltipUpdate() {
	MouseGetPos,,,, mouseControl, 2
	for i, tipInstance in OnHoverTooltipList {
		takeAction := false
		if (Array.isArray(tipInstance.control)) {
			for k, hwnd in tipInstance.control {
				if (hwnd == mouseControl) {
					takeAction := true
				}
			}
		}
		else if (tipInstance.control == mouseControl) {
			takeAction := true
		}

		; shoeld enable and tooltip list is not full (WhichToolTip needs to range between 2/20)
		; Console.log(ActiveTooltipList.HasKey(tipInstance))
		if (takeAction && ActiveTooltipList.HasKey(tipInstance) == false && ActiveTooltipList.length() < 19) {
			ActiveTooltipList.Push(tipInstance)
			tipInstance.index := ActiveTooltipList.length() + 1
			tipInstance.Activate()
		}
		else if (!takeAction && ActiveTooltipList.HasKey(tipInstance)) {
			tipInstance.Disable()
			ActiveTooltipList.Remove(tipInstance)
		}
	}

	; Update all active tooltips
	for i, tipInstance in ActiveTooltipList {
		tipInstance.Update()
	}
}