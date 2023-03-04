#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, C:\Users\CTN\Documents\CTN\Programming\ahk\Projects\TextToReplace\

Global Session := Session || "guiPrototype"

; Exit if the main script is not running.
if (!Session || Session != "Main") {
	; #Include, C:\Users\CTN\Documents\CTN\Programming\ahk\Projects\TextToReplace\utils\debugUtilities.ahk
	#Include, C:\Users\CTN\Documents\CTN\Programming\ahk\Projects\TextToReplace\gui\guiManager.ahk
	#Include, C:\Users\CTN\Documents\CTN\Programming\ahk\Projects\TextToReplace\utils\generalUtilities.ahk
	
	Global WinPosX := 1922
	Global WinPosY := 655
	; IniRead, WinPosX, data\generalDataStorage.ini, WindowData, posX
	; IniRead, WinPosY, data\generalDataStorage.ini, WindowData, posY
	Global WinWidth := 600
	Global WinHeight := 350
	Global Console := new Console("", "  ")

	ConstructPrototypeWindow()
	ConstructPrototypeElements()
}

ConstructPrototypeWindow() {
	WinGetTitle, postAWin, A
	Gui, Main:Color, 121212
	Gui, Main:Show, % " x" WinPosX " y" WinPosY " w" WinWidth " h" WinHeight
	WinActivate, %postAWin%
}
ConstructPrototypeElements() {
	element := new GuiElementBase()
	element.window := "Main"
	element.text := "Hello World!"
	element.rect := new Rect(200, 50, 100, 100)
	element.brush.rect := element.rect

	element.style.font.name := "Impact"
	element.style.font.size := 20
	element.style.font.weight := 100
	element.style.align.horizontal := "center"
	element.style.align.vertical := "center"

	element.style.main.color.default := "FFFFFF"

	element.ConstructElement()
	console.log(element.brush, {object: {nullValues: true}})
}