#SingleInstance, Force

class GuiElementData {
	__New(hwnd) {
		this.hwnd := hwnd

		this.x
		this.y
		this.w
		this.h

		this.Validate() ; initial validation
	}

	Validate() {
		ControlGetPos, x, y, w, h,, % "ahk_id" this.hwnd
		if (this.x != x) || (this.y != y) || (this.w != w) || (this.h != h) {
			this.x := x
			this.y := y
			this.w := w
			this.h := h
		}
	}
}
