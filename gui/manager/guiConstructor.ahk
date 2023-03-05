#Include, C:\Users\CTN\Documents\CTN\Programming\ahk\Projects\TextToReplace\utils\generalUtilities.ahk
#Persistent
Global Console = new Console()

class GuiBase {
	__New() {
		; Create a new GuiBase
		this.name := "MainGui"
		this.elements := []
		this.elements.Push(new GuiElementBase(this.name))
	}
	
	; add element to gui function
	; CreateElement() {
	; 	; Create a new GuiElementBase
	; 	this.elements.Push(new GuiElementBase(this))
	; }
}
class GuiElementBase extends GuiBase {
	static window := "some window"
	__New(ByRef parentGui) {
		this.parentGui := parentGui
		console.log(base)
	}
}

Global GuiM := new GuiBase()
GuiM.name := "SomeGui"
; GuiM.CreateElement()
Console.log(GuiM)
