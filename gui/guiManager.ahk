
;================Classes================
	;================Base================
		class GuiElementBase {
			__New(hwnd := "") {
				this.hwnd := hwnd
		
				this.rect := new Rect(0, 0, 0, 0)
				this.style := new GuiElementStyle()
				this.interaction := new GuiElementInteraction()
		
				this.window := ""
				this.type := "Text"
				this.element := new GuiTextElement()
				this.options := ""
				this.text := ""
	
				this.state := false
		
				this.Validate() ; initial validation
			}
		
			Validate() {
				if (this.hwnd) {
					ControlGetPos, x, y, w, h,, % "ahk_id" this.hwnd
					if (this.rect.x != x) || (this.rect.y != y) || (this.rect.width != w) || (this.rect.height != h) {
						this.rect.x := x
						this.rect.y := y
						this.rect.width := w
						this.rect.height := h
						this.OnResize()
					}
				}
			}
	
			ConstructElement() {
				this._constructElementOptions()
				
				window := (this.window) ? this.window ":Add" : "Add"
				Console.log(window ", "  this.type ","  this.options ", " this.text "`n")
				Gui, % window , % this.type, % this.options, % this.text
			}
	
			_constructElementOptions() {
				this.options := this.rect.OptionFlags().full
				console.log(this.options)
			}
		
			OnResize() {
				
			}
		}
	
		class GuiElementInteraction {
			__New() {
				this.onClick := ""
				this.onMouseEnter := ""
				this.onMouseDown := ""
				this.onMouseExit := ""
			}
		}
		
		;================Style================
			class GuiElementStyle {
				__New() {
					this.backgroundColor := "FFFFFF"
					this.backgroundOpacity := "FF"
					this.backgroundTrans := true
					this.font := new Font()
				}

				OptionFlags {
					get {
						
					}
				}
			}
			class GuiFont {
				__New() {
					this.size := 12
					this.name := "Segoe UI"
					this.color := "FFFFFF"
					this.align := new Vector2("Center", "Center")
					
					this.weight
					this.bold := false
					this.italic := false
					this.underline := false
					this.strikeout := false
				}
			}
		;=-=-=-=-=-=-=-=-Style=-=-=-=-=-=-=-=-
	;=-=-=-=-=-=-=-=-Base=-=-=-=-=-=-=-=-

	;================Elements================
		;================Basic================
			class GuiTextElement {
				__New() {
					this.content := ""
				}
			}
			class GuiButtonElement extends GuiElementBase {
				__New() {
					
				}
			}
			class GuiLinkElement extends GuiElementBase {
				__New() {
					
				}
			}
		;=-=-=-=-=-=-=-=-Basic=-=-=-=-=-=-=-=-

		;================Input================
			class GuiEditElement extends GuiElementBase {
				__New() {
					
				}
			}
			class GuiCheckboxElement extends GuiElementBase {
				__New() {
					
				}
			}
			class GuiRadioElement extends GuiElementBase {
				__New() {
					
				}
			}
			class GuiSliderElement extends GuiElementBase {
				__New() {
					
				}
			}
			class GuiDropDownListElement extends GuiElementBase {
				__New() {
					
				}
			}
			class GuiComboBoxElement extends GuiElementBase {
				__New() {
					
				}
			}
			class GuiHotkeyElement extends GuiElementBase {
				__New() {
					
				}
			}
			class GuiDateTimeElement extends GuiElementBase {
				__New() {
					
				}
			}
			class GuiMonthCalElement extends GuiElementBase {
				__New() {
					
				}
			}
		;=-=-=-=-=-=-=-=-Input=-=-=-=-=-=-=-=-

		;================Display================
			class GuiTabElement extends GuiElementBase {
				__New() {
					
				}
			}
			class GuiGroupBoxElement extends GuiElementBase {
				__New() {
					
				}
			}
			class GuiListBoxElement extends GuiElementBase {
				__New() {
					
				}
			}
			class GuiListViewElement extends GuiElementBase {
				__New() {
					
				}
			}
			class GuiTreeViewElement extends GuiElementBase {
				__New() {
					
				}
			}
	
			class GuiPictureElement extends GuiElementBase {
				__New() {
					
				}
			}
			class GuiProgressElement extends GuiElementBase {
				__New() {
					
				}
			}
			class GuiStatusBarElement extends GuiElementBase {
				__New() {
					
				}
			}
		;=-=-=-=-=-=-=-=-Display=-=-=-=-=-=-=-=-
	;=-=-=-=-=-=-=-=-Elements=-=-=-=-=-=-=-=-

	;================General================
		class Vector2 {
			__New(x, y) {
				this.x := x
				this.y := y
			}
		}
		class Rect {
			__New(x, y, width, height) {
				this.x := x
				this.y := y
				this.width := width
				this.height := height
			}

			OptionFlags {
				get {
					flagsObject := {}
					flagsObject.x := (this.x) ? " x" this.x : ""
					flagsObject.y := (this.y) ? " y" this.y : ""
					flagsObject.width := (this.width) ? " w" this.width : ""
					flagsObject.height := (this.height) ? " h" this.height : ""
					flagsObject.full := flagsObject.x flagsObject.y flagsObject.width flagsObject.height
					; flagsObject.full := " x" this.x " y" this.y " w" this.width " h" this.height
					; for key, value in this {
					; 	if (value) {
					; 		flagsObject.full .= flagsObject[key]
					; 	}
					; }
					return flagsObject
				}
			}
		}
	;=-=-=-=-=-=-=-=-General=-=-=-=-=-=-=-=-
;=-=-=-=-=-=-=-=-Classes=-=-=-=-=-=-=-=-


ConstructGUIElement() {
	element := new GuiElementBase()
	element.window := "Main"
	element.text := "Hello World!"
	element.rect := new Rect(200, 50, 0, 0)

	element.ConstructElement()

	Console.log(element)
	Console.log(text)
}

; Exit if the main script is not running.
if (!Console) {
	ExitApp
}