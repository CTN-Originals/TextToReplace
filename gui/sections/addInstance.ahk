/*
	IO = Input Options
*/

Global IOConfirmSwitch
Global IOConfirmTimeValue
Global IOKeepInputSwitch
Global IOCaseSensitiveSwitch

Global DefaultTextStyle := new GuiElementBase.ElementStyle()
DefaultTextStyle.main.color.normal := "FFFFFF"
DefaultTextStyle.font.name := "Helvetica"
DefaultTextStyle.font.size := 10
DefaultTextStyle.font.bold := true


AddNewInstanceUI() {
	GetInputPanel()
	GetOptionsPanel()
	GetOutputPanel()
	GetFooterButtons()
	; console.log(DefaultTextStyle, {prefix: "Default Style"})
	; console.log(GuiElement("Main"), {object: {nullValues: false}})
	RedrawGroup("InputOptions")
}

GetInputPanel() {
	Global IOConfirmTextElement := GuiElement("InputOptions")
	IOConfirmTextElement.style := DefaultTextStyle
	IOConfirmTextElement.text := "Confirmation"
	IOConfirmTextElement.rect.x := "+-30" ; doesn't work correctly after redrawing
	IOConfirmTextElement.rect.y := "+-18"
	IOConfirmTextElement.rect.height := 20
	IOConfirmTextElement.style.align.horizontal := "left"

	Create_Panel("x:=85", "y:=50", "w:=370", "h:=220", "Footer:=False", "Title:=Input", "OnTopColor:=" BackgroundColor, PanelColors)
	Gui, Main:Font, s12 cBlack, Impact
	Gui, Main:Add, Edit, x120 y110 w300 r1 Center Border Limit30 vinputTrigger

	Create_Panel("x:=105", "y:=150", "w:=330", "h:=100", "Footer:=False", "Title:=Input Options", "OnTopColor:=" PanelBackgroundColor, PanelColors, "Color1:=" SecondPanelBackgroundColor, "HeaderHeight:=16")

	IOConfirmSwitch := Create_Switch("x:=120", "y:=185", "w:=30", "switchState:=1", "Label:=Void", SwitchColors, "OnTopColor:=" SecondPanelBackgroundColor)
	; Gui, Main:Font, s10 cWhite Bold, Helvetica
	; Gui, Main:Add, Text, % "x+15 y+-18 h20 0x200 hwndIOConfirmText", Confirmation
	IOConfirmTextElement.ConstructElement()
	

	Gui, Main:Font, s8 cBlack Normal, Helvetica
	Gui, Main:Add, Edit, % "x120 y+13 w35 h20 Center 0x200 vIOConfirmTimeValue hwndIOConfirmTime", 5000
	Gui, Main:Font, s10 cWhite Bold, Helvetica
	Gui, Main:Add, Text, % "x+10 y+-20 h20 0x200 hwndIOConfirmTimeText", Confirm Time

	IOKeepInputSwitch := Create_Switch("x:=+25", "y:=185", "w:=30", "switchState:=0", "Label:=Void", SwitchColors, "OnTopColor:=" SecondPanelBackgroundColor)
	Gui, Main:Font, s10 cWhite Bold, Helvetica
	Gui, Main:Add, Text, % "x+15 y+-18 h20 0x200 hwndIOKeepInputText", Keep Input

	IOCaseSensitiveSwitch := Create_Switch("x:=277", "y:=+15", "w:=30", "switchState:=0", "Label:=Void", SwitchColors, "OnTopColor:=" SecondPanelBackgroundColor)
	Gui, Main:Font, s10 cWhite Bold, Helvetica
	Gui, Main:Add, Text, % "x+15 y+-18 h20 0x200 hwndIOCaseSensitiveText", Case Sensitive
	
	; RegisterTooltipOnHover("Ask for confirmation before replacing the text", [IOConfirmSwitch.hwnd, IOConfirmText], 500)
	RegisterTooltipOnHover("The time to wait for confirmation", [IOConfirmTime, IOConfirmTimeText], 500)
	RegisterTooltipOnHover("Keep the input text that you enter to trigger the replace", [IOKeepInputSwitch.hwnd, IOKeepInputText], 500)
	RegisterTooltipOnHover("Should the input be case senitive", [IOCaseSensitiveSwitch.hwnd, IOCaseSensitiveText], 500)
	; RegisterTooltipOnHover("Ask for confirmation before replacing the text", IOConfirmText, 100, true)
	; Global IORegexSwitchState := Create_Switch("x:=120", "y:=185", "w:=30", "switchState:=0", "Label:=Void", "Tooltip:=Comming soon...", SwitchColors, "OnTopColor:=" SecondPanelBackgroundColor)
	
	; IOConfirmTextElement.Redraw()
	; console.log(IOConfirmTextElement, {prefix: "IOConfirmTextElement", object: {nullValues: false}})
}
GetOptionsPanel() {
	Create_Panel("x:=480", "y:=50", "w:=380", "h:=220", "Footer:=False", "Title:=Options", "OnTopColor:=" BackgroundColor, PanelColors)

	Gui, Main:Font, s11 cWhite Bold, Helvetica
	Gui, Main:Add, Text, % "x500 y100 w200 h20 0x200 BackgroundTrans", Output Speed
	Gui, Main:Add, Text, % "x500 y+10 w200 h20 0x200 BackgroundTrans", From Clipboard
	Gui, Main:Add, Text, % "x500 y+10 w200 h20 0x200 BackgroundTrans", Keep Input
	Gui, Main:Add, Text, % "x500 y+10 w200 h20 0x200 BackgroundTrans", Send new line as

	;================Switch preview================
		; Create_Switch("x:=520", "y:=100", "w:=25", "Label:=Void", SwitchColors, "OnTopColor:=" PanelBackgroundColor)
		; Create_Switch("x:=520", "y:=+20", "w:=50", "Label:=Void", "Thickness:=2", SwitchColors, "OnTopColor:=" PanelBackgroundColor)
		; Create_Switch("x:=520", "y:=+20", "w:=100", "Label:=Void", "Thickness:=4", SwitchColors, "OnTopColor:=" PanelBackgroundColor)
	;=-=-=-=-=-=-=-=-Switch preview=-=-=-=-=-=-=-=-
}
GetOutputPanel() {
	Create_Panel("x:=85", "y:=294", "w:=775", "h:=240", "Footer:=False", "Title:=Output", "Radius:=1", "OnTopColor:=" BackgroundColor, PanelColors)
	Gui, Main:Font, s10 cBlack, Helvetica
	Gui, Main:Add, Edit, x105 y349 w735 h170 Border vOutputText
}
GetFooterButtons() {
	CreateButton("x:=760", "y:=557", "w:=100", "h:=40", "Text:=Save", "FontSize:=16", "Variable:=Save", "Label:=Save", "Radius:=0", DefaultBarButtonColors, "Color:=00FF00", "OnTopColor:=" FooterColor)
	global Save

	CreateButton("x:=206", "y:=557", "w:=100", "h:=40", "Text:=Clear", "FontSize:=15", "Variable:=Clear", "Label:=Clear", "Radius:=0", DefaultBarButtonColors, "Color:=FF0000", "OnTopColor:=" FooterColor)
	global Clear
	CreateButton("x:=86", "y:=557", "w:=100", "h:=40", "Text:=Cancel", "FontSize:=15", "Variable:=Cancel", "Label:=Cancel", "Radius:=0", DefaultBarButtonColors, "Color:=FF0000", "OnTopColor:=" FooterColor)
	global Cancel
}
