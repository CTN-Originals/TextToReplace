#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
; SetWorkingDir, %A_ScriptDir%

if (ActiveColorTheme == 1) {
	Global BackgroundColor := "000080"
	Global HeaderColor := "000040"
	Global SideBarColor := "0010FF"
	Global FooterColor := "0000FF"
	Global FontColor := "FFFFFF"


	;================Button================
		Global ButtonColor := "FFFFFF"
		Global ButtonBackgroundColor := "0000E6"
		Global ButtonBorderColor := "FFFFFF"
	
		Global HButtonColor := "0000E6"
		Global HButtonBackgroundColor := "00FFFF"
		Global HButtonBorderColor := "00FF00"
	
		Global PButtonColor := "00E699"
		Global PButtonBackgroundColor := "00004D"
		Global PButtonBorderColor := "000040"
	
	
		Global BarButtonColor := "FFFFFF"
		Global BarButtonBackgroundColor := "0000A8"
		Global BarButtonBorderColor := "FFFFFF"
	
		Global HBarButtonColor := "00FFFF"
		Global HBarButtonBackgroundColor := "00004D"
		Global HBarButtonBorderColor := "00FF00"
	
		Global PBarButtonColor := "0000FF"
		Global PBarButtonBackgroundColor := "00FFFF"
		Global PBarButtonBorderColor := "000040"
	;=-=-=-=-=-=-=-=-Button=-=-=-=-=-=-=-=-


	;================Icon================
		Global IconButtonColor := "FFFFFF"
		Global IconButtonSecondColor := "FF000040"
		Global IconButtonShadowColor := "000000"
		Global IconButtonBorderColor := "FFFFFF"
	
		Global HIconButtonColor := "00FF00"
		Global HIconButtonSecondColor := "FF000040"
		Global HIconButtonShadowColor := "000000"
		Global HIconButtonBorderColor := "FFFFFF"
	
		Global PIconButtonColor := "00FFFF"
		Global PIconButtonSecondColor := "FF000040"
		Global PIconButtonShadowColor := "000000"
		Global PIconButtonBorderColor := "FFFFFF"
	;=-=-=-=-=-=-=-=-Icon=-=-=-=-=-=-=-=-

	;================Panel================
		Global PanelBackgroundColor := "0000A0"
		Global SecondPanelBackgroundColor := "000080"
		Global PanelHeaderColor := "050068"
		Global PanelFooterColor := "0000FF"
	
		Global PanelFontColor := "FFFFFF"
	;=-=-=-=-=-=-=-=-Panel=-=-=-=-=-=-=-=-

	;================SWITCH COLORS================
		Global Switch_Off_Color := "000020"
		Global Switch_Off_Border_Color := "000000"
		Global Switch_Off_Slide_Color := "000040"
		Global Switch_Off_Slide_Border_Color := "0080FF"

		Global Switch_On_Color := "00FF00"
		Global Switch_On_Border_Color := "000000"
		Global Switch_On_Slide_Color := "0000FF"
		Global Switch_On_Slide_Border_Color := "000000"


		Global Switch_Off_Hover := "000040"
		Global Switch_Off_Hover_Border := "000000"
		Global Switch_Off_HSlide_Color := "000080"
		Global Switch_Off_HSlide_Border_Color := "00FFFF"

		Global Switch_On_Hover := "00FF00"
		Global Switch_On_Hover_Border := "FFFFFF"
		Global Switch_On_HSlide_Color := "000080"
		Global Switch_On_HSlide_Border_Color := "FFFFFF"


		Global Switch_Off_Pressed := "000080"
		Global Switch_Off_Pressed_Border := "FFFFFF"
		Global Switch_Off_PSlide_Color := "000080"
		Global Switch_Off_PSlide_Border_Color := "FFFFFF"

		Global Switch_On_Pressed := "00FF00"
		Global Switch_On_Pressed_Border := "000000"
		Global Switch_On_PSlide_Color := "0000FF"
		Global Switch_On_PSlide_Border_Color := "000000"

		; Switch_Off_Color
			; Switch_Off_Border_Color
			; Switch_Off_Slide_Color
			; Switch_Off_Slide_Border_Color
			; Switch_On_Color
			; Switch_On_Border_Color
			; Switch_On_Slide_Color
			; Switch_On_Slide_Border_Color
			; Switch_Off_Hover
			; Switch_Off_Hover_Border
			; Switch_Off_HSlide_Color
			; Switch_Off_HSlide_Border_Color
			; Switch_On_Hover
			; Switch_On_Hover_Border
			; Switch_On_HSlide_Color
			; Switch_On_HSlide_Border_Color
			; Switch_Off_Pressed
			; Switch_Off_Pressed_Border
			; Switch_Off_PSlide_Color
			; Switch_Off_PSlide_Border_Color
			; Switch_On_Pressed
			; Switch_On_Pressed_Border
			; Switch_On_PSlide_Color
		; Switch_On_PSlide_Border_Color
	;=-=-=-=-=-=-=-=-SWITCH COLORS=-=-=-=-=-=-=-=-
}

else if (ActiveColorTheme == 2) {
	Global BackgroundColor := "121212"
	Global HeaderColor := "000000"
	Global SideBarColor := "181818"
	Global FooterColor := "2B2B2B"
	Global FontColor := "A8A8A8"

	;================Button================
		Global ButtonColor := "FFFFFF"
		Global ButtonBackgroundColor := "000028"
		Global ButtonBorderColor := "A8A8A8"
	
		Global HButtonColor := "009199"
		Global HButtonBackgroundColor := "000000"
		Global HButtonBorderColor := "FFFFFF"
	
		Global PButtonColor := "00E699"
		Global PButtonBackgroundColor := "00004D"
		Global PButtonBorderColor := "000040"
	
	
		Global BarButtonColor := "FFFFFF"
		Global BarButtonBackgroundColor := "00232E"
		Global BarButtonBorderColor := "A8A8A8"
	
		Global HBarButtonColor := "009199"
		Global HBarButtonBackgroundColor := "000000"
		Global HBarButtonBorderColor := "000080"
	
		Global PBarButtonColor := "000000"
		Global PBarButtonBackgroundColor := "009199"
		Global PBarButtonBorderColor := "A8A8A8"
	;=-=-=-=-=-=-=-=-Button=-=-=-=-=-=-=-=-

	;================Icon================
		Global IconButtonColor := "FFFFFF"
		Global IconButtonSecondColor := "00232E"
		Global IconButtonShadowColor := "000000"
		Global IconButtonBorderColor := "FFFFFF"
	
		Global HIconButtonColor := "00232E"
		Global HIconButtonSecondColor := "009199"
		Global HIconButtonShadowColor := "FFFFFF"
		Global HIconButtonBorderColor := "FFFFFF"
	
		Global PIconButtonColor := "009199"
		Global PIconButtonSecondColor := "00232E"
		Global PIconButtonShadowColor := "000000"
		Global PIconButtonBorderColor := "FFFFFF"
	;=-=-=-=-=-=-=-=-Icon=-=-=-=-=-=-=-=-

	;================Panel Colors================
		Global PanelBackgroundColor := "181818"
		Global SecondPanelBackgroundColor := "121212"
		Global PanelHeaderColor := "0D0D0D"
		Global PanelFooterColor := "0D0D0D"

		Global PanelBorderColor := "FF0000"
	
		Global PanelFontColor := "A8A8A8"
	;=-=-=-=-=-=-=-=-Panel Colors=-=-=-=-=-=-=-=-


	;================SWITCH COLORS================
		Global Switch_Off_Color := "000028"
		Global Switch_Off_Border_Color := "121212"
		Global Switch_Off_Slide_Color := "000040"
		Global Switch_Off_Slide_Border_Color := "0080FF"

		Global Switch_On_Color := "00CCCC"
		Global Switch_On_Border_Color := "000000"
		Global Switch_On_Slide_Color := "0000FF"
		Global Switch_On_Slide_Border_Color := "000000"


		Global Switch_Off_Hover := "000040"
		Global Switch_Off_Hover_Border := "000000"
		Global Switch_Off_HSlide_Color := "000080"
		Global Switch_Off_HSlide_Border_Color := "00FFFF"

		Global Switch_On_Hover := "00CCCC"
		Global Switch_On_Hover_Border := "FFFFFF"
		Global Switch_On_HSlide_Color := "000080"
		Global Switch_On_HSlide_Border_Color := "FFFFFF"


		Global Switch_Off_Pressed := "000080"
		Global Switch_Off_Pressed_Border := "FFFFFF"
		Global Switch_Off_PSlide_Color := "000080"
		Global Switch_Off_PSlide_Border_Color := "FFFFFF"

		Global Switch_On_Pressed := "00CCCC"
		Global Switch_On_Pressed_Border := "000000"
		Global Switch_On_PSlide_Color := "0000FF"
		Global Switch_On_PSlide_Border_Color := "000000"

		; Switch_Off_Color
			; Switch_Off_Border_Color
			; Switch_Off_Slide_Color
			; Switch_Off_Slide_Border_Color
			; Switch_On_Color
			; Switch_On_Border_Color
			; Switch_On_Slide_Color
			; Switch_On_Slide_Border_Color
			; Switch_Off_Hover
			; Switch_Off_Hover_Border
			; Switch_Off_HSlide_Color
			; Switch_Off_HSlide_Border_Color
			; Switch_On_Hover
			; Switch_On_Hover_Border
			; Switch_On_HSlide_Color
			; Switch_On_HSlide_Border_Color
			; Switch_Off_Pressed
			; Switch_Off_Pressed_Border
			; Switch_Off_PSlide_Color
			; Switch_Off_PSlide_Border_Color
			; Switch_On_Pressed
			; Switch_On_Pressed_Border
			; Switch_On_PSlide_Color
		; Switch_On_PSlide_Border_Color
	;=-=-=-=-=-=-=-=-SWITCH COLORS=-=-=-=-=-=-=-=-
}

Global DefaultButtonColors := "Window:=Main," "Color:=" ButtonColor ",BackgroundColor:=" ButtonBackgroundColor ",BorderColor:=" ButtonBorderColor ",HColor:=" HButtonColor ",HBackgroundColor:=" HButtonBackgroundColor ",HBorderColor:=" HButtonBorderColor ",PColor:=" PButtonColor ",PBackgroundColor:=" PButtonBackgroundColor ",PBorderColor:=" PButtonBorderColor,
Global DefaultBarButtonColors := "Window:=Main," "Color:=" BarButtonColor ",BackgroundColor:=" BarButtonBackgroundColor ",BorderColor:=" BarButtonBorderColor ",HColor:=" HBarButtonColor ",HBackgroundColor:=" HBarButtonBackgroundColor ",HBorderColor:=" HBarButtonBorderColor ",PColor:=" PBarButtonColor ",PBackgroundColor:=" PBarButtonBackgroundColor ",PBorderColor:=" PBarButtonBorderColor,

Global PlusButtonColors := "Window:=Main," "Color:=" IconButtonColor ",Shadow_Color:=" IconButtonShadowColor ",Hover:=" HIconButtonColor ",Hover_Shadow:=" HIconButtonShadowColor ",Pressed:=" PIconButtonColor ",Pressed_Shadow:=" PIconButtonShadowColor,
Global SettingsButtonColors := "Window:=Main," "Color:=" IconButtonColor ",Shadow_Color:=" IconButtonShadowColor ",Slide_Color:=" IconButtonSecondColor ",Slide_Border_Color:=" IconButtonBorderColor ",Hover:=" HIconButtonColor ",Hover_Shadow:=" IconButtonShadowColor ",HSlide_Color:=" HIconButtonSecondColor ",HSlide_Border_Color:=" HIconButtonBorderColor ",Pressed:=" PIconButtonColor ",Pressed_Shadow:=" PIconButtonShadowColor ",PSlide_Color:=" PIconButtonSecondColor ",PSlide_Border_Color:=" PIconButtonBorderColor

Global PanelColors := "Window:=Main," "HeaderHeight:=25," "FooterHeight:=25" ",Color1:=" PanelBackgroundColor ",HeaderColor:=" PanelHeaderColor ",PanelFooterColor:=" PanelFooterColor ",FontColor:=" PanelFontColor ",BorderColor:=" PanelBorderColor
Global SwitchColors := "Window:=Main," "Off_Color:=" Switch_Off_Color ",Off_Border_Color:=" Switch_Off_Border_Color ",Off_Slide_Color:=" Switch_Off_Slide_Color ",Off_Slide_Border_Color:=" Switch_Off_Slide_Border_Color ",On_Color:=" Switch_On_Color ",On_Border_Color:=" Switch_On_Border_Color ",On_Slide_Color:=" Switch_On_Slide_Color ",On_Slide_Border_Color:=" Switch_On_Slide_Border_Color ",Off_Hover:=" Switch_Off_Hover ",Off_Hover_Border:=" Switch_Off_Hover_Border ",Off_HSlide_Color:=" Switch_Off_HSlide_Color ",Off_HSlide_Border_Color:=" Switch_Off_HSlide_Border_Color ",On_Hover:=" Switch_On_Hover ",On_Hover_Border:=" Switch_On_Hover_Border ",On_HSlide_Color:=" Switch_On_HSlide_Color ",On_HSlide_Border_Color:=" Switch_On_HSlide_Border_Color ",Off_Pressed:=" Switch_Off_Pressed ",Off_Pressed_Border:=" Switch_Off_Pressed_Border ",Off_PSlide_Color:=" Switch_Off_PSlide_Color ",Off_PSlide_Border_Color:=" Switch_Off_PSlide_Border_Color ",On_Pressed:=" Switch_On_Pressed ",On_Pressed_Border:=" Switch_On_Pressed_Border ",On_PSlide_Color:=" Switch_On_PSlide_Color ",On_PSlide_Border_Color:=" Switch_On_PSlide_Border_Color 