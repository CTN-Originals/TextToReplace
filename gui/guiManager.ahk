Global currentElementId := 0

; Exit if the main script is not running.
if (!Session || Session != "Main") {
	; ExitApp
	Global WinPosX
	Global WinPosY
	IniRead, WinPosX, C:\Users\CTN\Documents\CTN\Programming\ahk\Projects\TextToReplace\data\generalDataStorage.ini, WindowData, posX
	IniRead, WinPosY, C:\Users\CTN\Documents\CTN\Programming\ahk\Projects\TextToReplace\data\generalDataStorage.ini, WindowData, posY
	Global WinWidth := 880
	Global WinHeight := 510

	Gui, Main:Color, 121212
	Gui, Main:Show, % " x" WinPosX " y" WinPosY " w" WinWidth " h" WinHeight
	#Include, C:\Users\CTN\Documents\CTN\Programming\ahk\Projects\TextToReplace\utils\debugUtilities.ahk
	Global Console := new Console(false)
	ConstructGUIElement()
}


;================Classes================
	class GuiElementBase {
		__New(hwnd := "") {
			this.id := "_" (currentElementId + 1)
			this.control := hwnd
			this.textControl := ""
			this.backgroundControl := ""
			this.borderControl := ""

			this.rect := new Rect(0, 0, 0, 0)
			this.style := new this.ElementStyle()
			this._interaction := new this.GuiElementInteraction()

			this.window := "Main"
			this.type := "Text"
			this.text := ""
			this.options := ""
			this.fontOptions := ""
			this.group := ""
			this.zIndex := 0
			; this.element := new GuiTextElement()

			this.state := "false"
			this.Validate() ; initial validation
		}
	
		Validate() {
			if (this.control) {
				ControlGetPos, x, y, w, h,, % "ahk_id" this.control
				if (this.rect.x != x) || (this.rect.y != y) || (this.rect.width > 0 && this.rect.width != w) || (this.rect.height > 0 && this.rect.height != h) {
					this.rect.x := x
					this.rect.y := y
					this.rect.width := (this.rect.width > 0) ? w : 0
					this.rect.height := (this.rect.height > 0) ? h : 0
				}
			}
		}

		ConstructElement() {
			this._constructElementOptions()
			
			Console.log("Gui, Font, " this.style.font.OptionFlags().full ", " this.style.font.name)
			Console.log(this.type ","  this.options ", " this.text "`n")
			Gui, % (this.window) ? this.window ":Font" : "Font" , % this.fontOptions, % this.style.font.name
			Gui, % (this.window) ? this.window ":Add" : "Add" , % this.type, % this.options " hwndhwnd", % this.text

			this.control := hwnd
		}

		_constructElementOptions() {
			this.options := this.rect.OptionFlags().full " " this.style.OptionFlags().full
			this.fontOptions := this.style.font.OptionFlags().full
			console.log(this.options, {prefix: "Options"})
		}

		SetType(type) {
			switch type {
				case "button":
					this.type := "Button"
				case "background":
					this.type := "Progress"
				default:
					this.type := "Text"
			}
		}
	
		Redraw() {
			this.Validate()
			this._constructElementOptions()
			GuiControl, % (this.window) ? this.window ":MoveDraw" : "MoveDraw", % this.control, % this.options
		}

		;================Nested Classes================
			class GuiElementInteraction {
				__New() {
					this.onClick := ""
					this.onMouseEnter := ""
					this.onMouseDown := ""
					this.onMouseExit := ""
				}
			}
			
			class ElementStyle {
				__New() {
					this.enabled := true
					this.backgroundTrans := true

					this.main := new this.StyleDefinition()
					this.text := new this.StyleDefinition()
					this.background := new this.StyleDefinition()
					this.border := new this.StyleDefinition()

					this.font := new this.FontStyle()
					this.align := new this.Alignment()

					this.state := "normal"
				}

				OptionFlags {
					get {
						flagsObject := {}
						flagsObject.enabled := (this.enabled) ? "" : " Disabled"
						flagsObject.backgroundTrans := (this.backgroundTrans) ? " BackgroundTrans" : ""

						flagsObject.main := this.main.OptionFlags().full
						flagsObject.text := this.text.OptionFlags().full
						flagsObject.background := this.background.OptionFlags().full
						flagsObject.border := this.border.OptionFlags().full

						flagsObject.font := this.font.OptionFlags().full
						flagsObject.align := this.align.OptionFlags().full

						flagsObject.full := "border " flagsObject.enabled flagsObject.backgroundTrans flagsObject.main flagsObject.align

						return flagsObject
					}
				}
				
				class StyleDefinition {
					__New() {
						this.enabled := true
						this.color := new this.ColorObject()
						this.state := "normal"
						this._opicity := "" ; not functional yet (can be done with Gdip)
					}

					OptionFlags {
						get {
							flagsObject := {}
							flagsObject.color := (this.enabled && this.getColor()) ? " c" this.getColor() : ""
							flagsObject.full := flagsObject.color
							return flagsObject
						}
					}

					class ColorObject {
						__New() {
							this.normal := ""
							this.hover := ""
							this.active := ""
						}
					}

					getColor {
						get {
							if (this.enabled) {
								return this.color[this.state]
							} 
							else {
								return "000000"
							}
						}
					}
				}
				class FontStyle {
					__New() {
						this.name := "Segoe UI"
						this.size := 12
						
						this.weight := 400
						this.bold := false
						this.italic := false
						this.underline := false
						this.strike := false
					}
	
					OptionFlags {
						get {
							flagsObject := {}
							flagsObject.font := this.name
							flagsObject.size := (this.size > 0) ? " s" this.size : ""
							flagsObject.weight := (this.weight > 0 && this.weight != 400) ? " w" this.weight : ""
							flagsObject.style := (this.bold) ? " bold" : ""
							flagsObject.style .= (this.italic) ? " italic" : ""
							flagsObject.style .= (this.underline) ? " underline" : ""
							flagsObject.style .= (this.strike) ? " strike" : ""
							flagsObject.full := "normal" flagsObject.weight flagsObject.size flagsObject.style
	
							return flagsObject
						}
					}
				}
				class Alignment {
					__New() {
						this.horizontal := "left"
						this.vertical := "center"
					}

					OptionFlags {
						get {
							flagsObject := {}
							flagsObject.full := (this.vertical == "center") ? " " this.horizontal " 0x200" : " " this.horizontal
							return flagsObject
						}
					}
				}
			}
		;=-=-=-=-=-=-=-=-Nested Classes=-=-=-=-=-=-=-=-
	}

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


Global GuiElementStorage := {}

GuiElement(group) {
	element := new GuiElementBase()
	element.group := group
	if (!GuiElementStorage[group]) {
		GuiElementStorage[group] := {}
	}
	GuiElementStorage[group][element.id] := element
	return element
}
RedrawGroup(group) {
	console.log(GuiElementStorage[group])
	for id, element in GuiElementStorage[group] {
		element.Redraw()
		console.log(element, {prefix: id, object: {nullValues: false}})
	}
}

ConstructGUIElement() {
	element := new GuiElementBase()
	element.window := "Main"
	element.text := "Hello World!"
	element.rect := new Rect(200, 50, 0, 0)

	element.style.font.weight := 100
	element.style.font.name := "Impact"
	element.style.font.size := 20
	element.style.align.horizontal := "center"
	element.style.align.vertical := "center"

	element.style.color.background := 0x000000


	element.ConstructElement()

	; Console.log(element, {prefix: "Gui Element", object: {nullValues: false, brackets: true}})
}

; Gui, Main:Font, s12 cwhite
; Gui, Main:Add, Text, x100 y100 w100 h100 border BackgroundTrans 0x0, Allign 1
; Gui, Main:Add, Text, x+20 y100 w100 h100 border BackgroundTrans 0x1, Allign 2
; Gui, Main:Add, Text, x+20 y100 w100 h100 border BackgroundTrans 0x2, Allign 3
; Gui, Main:Add, Text, x+20 y100 w100 h100 border BackgroundTrans right 0x200, Allign 4

