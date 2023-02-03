Global TooltipConsole := new Console("Tooltip")

class OnHoverTooltip {
	__New(text, control, delay, followMouse := false, offsetPos := 0, offsetSize := 0) {
		this.text := text
		this.control := control
		this.delay := delay
		this.followMouse := followMouse
		this.offsetPos := (Array.isArray(offsetPos)) ? offsetPos : [offsetPos, 0]
		this.offsetSize := (Array.isArray(offsetSize)) ? offsetSize : [offsetSize, 0]

		this.guiElement := new GuiElementData(this.control)
		this.index := 0

		; Runtime data
		this.state := false
		this.tooltipState := false
		this.startTime := 0
		this.activeTime := 0
		this.position := [0, 0]
	}

	Activate() {
		this.state := true
		this.startTime := A_TickCount
		; TooltipConsole.log(this)
	}
	Update() {
		this.activeTime := A_TickCount - this.startTime
		if (!this.tooltipState && this.activeTime >= this.delay) {
			this.tooltipState := true
			this.ShowTooltip()
		}

		if (this.tooltipState && this.followMouse) {
			this.UpdateTooltip()
		}
	}

	ShowTooltip() {
		this._getPosition()
		Tooltip, % this.text, % this.position[1], % this.position[2], % this.index
	}
	UpdateTooltip() {
		this._getPosition()
		Tooltip, % this.text, % this.position[1], % this.position[2], % this.index
	}

	Disable() {
		this.state := false
		this.tooltipState := false
		ToolTip,,,, this.index
	}

	_getPosition() {
		; local oldPos := [this.position[1], this.position[2]]
		if (this.followMouse) {
			CoordMode, Mouse, Relative
			MouseGetPos, X, Y
			this.position[1] := (X + 12) + this.offsetPos[1]
			this.position[2] := (Y + 12) + this.offsetPos[2]
		}
		else {
			CoordMode, ToolTip, Screen
			this.position[1] := (WinPosX + this.guiElement.x) + this.offsetPos[1]
			this.position[2] := (WinPosY + this.guiElement.y) + this.offsetPos[2]
		}
		; TooltipConsole.log({"new": this.position, "old": oldPos}, "Positions")
		; TooltipConsole.log(this.position, "Position")
		; TooltipConsole.log(this.guiElement, "GuiElement")
	}
}

Global OnHoverTooltipList := []
Global ActiveTooltipList := []

SetTimer, OnHoverTooltipUpdate, 100

RegisterTooltipOnHover(text, control, delay, followMouse := false, offsetPos := 0, offsetSize := 0) {
	newInstance := new OnHoverTooltip(text, control, delay, followMouse, offsetPos, offsetSize := 0)
	OnHoverTooltipList.Push(newInstance)
	; TooltipConsole.log(newInstance, "Registered" )
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
		if (takeAction && Array.contains(ActiveTooltipList, tipInstance) == false && ActiveTooltipList.length() < 19) {
			ActiveTooltipList.Push(tipInstance)
			tipInstance.index := ActiveTooltipList.length() + 1
			tipInstance.Activate()
		}
		else if (!takeAction && Array.contains(ActiveTooltipList, tipInstance)) {
			tipInstance.Disable()
			Array.remove(ActiveTooltipList, tipInstance)
			TooltipConsole.log("Deactivating: " Array.split(tipInstance.text, " ")[1], false)
		}
	}

	; Update all active tooltips
	for i, tipInstance in ActiveTooltipList {
		tipInstance.Update()
	}
}