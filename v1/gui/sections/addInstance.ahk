/*
	IO = Input Options
*/

Global IOConfirmSwitch
Global IOConfirmText
Global IOConfirmTimeValue

AddNewInstanceUI() {
	GetInputPanel()
	GetOptionsPanel()
	GetOutputPanel()
	GetFooterButtons()
}

GetInputPanel() {
	Create_Panel("x:=85", "y:=50", "w:=370", "h:=220", "Footer:=False", "Title:=Input", "OnTopColor:=" BackgroundColor, PanelColors)
	Gui, Main:Font, s12 cBlack, Impact
	Gui, Main:Add, Edit, x120 y110 w300 r1 Center Border Limit30 vinputTrigger

	Create_Panel("x:=105", "y:=150", "w:=330", "h:=100", "Footer:=False", "Title:=Input Options", "OnTopColor:=" PanelBackgroundColor, PanelColors, "Color1:=" SecondPanelBackgroundColor, "HeaderHeight:=16")

	IOConfirmSwitch := Create_Switch("x:=120", "y:=185", "w:=30", "switchState:=1", "Label:=Void", SwitchColors, "OnTopColor:=" SecondPanelBackgroundColor)
	Gui, Main:Font, s10 cWhite Bold, Helvetica
	Gui, Main:Add, Text, % "x+15 y+-18 h20 0x200 vIOConfirmText hwndIOConfirmText", Confirmation

	Gui, Main:Font, s8 cBlack Normal, Helvetica
	Gui, Main:Add, Edit, % "x+20 y+-20 w40 h20 Center 0x200 vIOConfirmTimeValue", 5000
	Gui, Main:Font, s10 cWhite Bold, Helvetica
	Gui, Main:Add, Text, % "x+10 y+-20 h20 0x200", Confirm Time

	IOKeepInputSwitch := Create_Switch("x:=120", "y:=+10", "w:=30", "switchState:=1", "Label:=Void", "Tooltip:=Ask for confirmation before replacing the text", SwitchColors, "OnTopColor:=" SecondPanelBackgroundColor)
	Gui, Main:Font, s10 cWhite Bold, Helvetica
	Gui, Main:Add, Text, % "x+15 y+-18 h20 0x200", Keep Input
	
	RegisterTooltipOnHover("Ask for confirmation before replacing the text", IOConfirmSwitch.hwnd, 1000)
	RegisterTooltipOnHover("Ask for confirmation before replacing the text", IOConfirmText, 1000)
	; Global IORegexSwitchState := Create_Switch("x:=120", "y:=185", "w:=30", "switchState:=0", "Label:=Void", "Tooltip:=Comming soon...", SwitchColors, "OnTopColor:=" SecondPanelBackgroundColor)
}
GetOptionsPanel() {
	Create_Panel("x:=480", "y:=50", "w:=380", "h:=220", "Footer:=False", "Title:=Options", "OnTopColor:=" BackgroundColor, PanelColors)

	Gui, Main:Font, s11 cWhite Bold, Helvetica
	Gui, Main:Add, Text, % "x500 y100 w200 h20 0x200 BackgroundTrans", Output Speed
	Gui, Main:Add, Text, % "x500 y+10 w200 h20 0x200 BackgroundTrans", From Clipboard
	Gui, Main:Add, Text, % "x500 y+10 w200 h20 0x200 BackgroundTrans", Keep Input
	Global someV

	;================Switch preview================
		; Create_Switch("x:=520", "y:=100", "w:=25", "Label:=Void", SwitchColors, "OnTopColor:=" PanelBackgroundColor)
		; Create_Switch("x:=520", "y:=+20", "w:=50", "Label:=Void", "Thickness:=2", SwitchColors, "OnTopColor:=" PanelBackgroundColor)
		; Create_Switch("x:=520", "y:=+20", "w:=100", "Label:=Void", "Thickness:=4", SwitchColors, "OnTopColor:=" PanelBackgroundColor)
	;=-=-=-=-=-=-=-=-Switch preview=-=-=-=-=-=-=-=-
}
GetOutputPanel() {
	Create_Panel("x:=85", "y:=294", "w:=775", "h:=240", "Footer:=False", "Title:=Output", "Radius:=1", "OnTopColor:=" BackgroundColor, PanelColors)
	Gui, Main:Font, s10 cBlack, Helvetica
	Gui, Main:Add, Edit, x105 y349 w735 h170 Border vOutput
}
GetFooterButtons() {
	CreateButton("x:=760", "y:=557", "w:=100", "h:=40", "Text:=Save", "FontSize:=16", "Variable:=Save", "Label:=Save", "Radius:=0", DefaultBarButtonColors, "Color:=00FF00", "OnTopColor:=" FooterColor)
	global Save

	CreateButton("x:=206", "y:=557", "w:=100", "h:=40", "Text:=Clear", "FontSize:=15", "Variable:=Clear", "Label:=Clear", "Radius:=0", DefaultBarButtonColors, "Color:=FF0000", "OnTopColor:=" FooterColor)
	global Clear
	CreateButton("x:=86", "y:=557", "w:=100", "h:=40", "Text:=Cancel", "FontSize:=15", "Variable:=Cancel", "Label:=Cancel", "Radius:=0", DefaultBarButtonColors, "Color:=FF0000", "OnTopColor:=" FooterColor)
	global Cancel
}