#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

if (ActiveColorTheme == 1) {
	BackgroundColor := "000080"
	HeaderColor := "000040"
	SideBarColor := "0010FF"
	FooterColor := "0000FF"
	FontColor := "FFFFFF"


	ButtonColor := "FFFFFF"
	ButtonBackgroundColor := "0000E6"
	ButtonBorderColor := "FFFFFF"

	HButtonColor := "0000E6"
	HButtonBackgroundColor := "00FFFF"
	HButtonBorderColor := "00FF00"

	PButtonColor := "00E699"
	PButtonBackgroundColor := "00004D"
	PButtonBorderColor := "000040"


	BarButtonColor := "FFFFFF"
	BarButtonBackgroundColor := "0000A8"
	BarButtonBorderColor := "FFFFFF"

	HBarButtonColor := "00FFFF"
	HBarButtonBackgroundColor := "00004D"
	HBarButtonBorderColor := "00FF00"

	PBarButtonColor := "0000FF"
	PBarButtonBackgroundColor := "00FFFF"
	PBarButtonBorderColor := "000040"


	IconButtonColor := "FFFFFF"
	IconButtonSecondColor := "FF000040"
	IconButtonShadowColor := "000000"
	IconButtonBorderColor := "FFFFFF"

	HIconButtonColor := "00FF00"
	HIconButtonSecondColor := "FF000040"
	HIconButtonShadowColor := "000000"
	HIconButtonBorderColor := "FFFFFF"

	PIconButtonColor := "00FFFF"
	PIconButtonSecondColor := "FF000040"
	PIconButtonShadowColor := "000000"
	PIconButtonBorderColor := "FFFFFF"


	PlaneBackgroundColor := "0000A0"
	SecondPlaneBackgroundColor := "000080"
	PlaneHeaderColor := "050068"
	PlaneFooterColor := "0000FF"

	PlaneFontColor := "FFFFFF"

	;================SWITCH COLORS================
		Switch_Off_Color:="000020"
		Switch_Off_Border_Color:="000000"
		Switch_Off_Slide_Color:="000040"
		Switch_Off_Slide_Border_Color:="0080FF"

		Switch_On_Color:="00FF00"
		Switch_On_Border_Color:="000000"
		Switch_On_Slide_Color:="0000FF"
		Switch_On_Slide_Border_Color:="000000"


		Switch_Off_Hover:="000040"
		Switch_Off_Hover_Border:="000000"
		Switch_Off_HSlide_Color:="000080"
		Switch_Off_HSlide_Border_Color:="00FFFF"

		Switch_On_Hover:="00FF00"
		Switch_On_Hover_Border:="FFFFFF"
		Switch_On_HSlide_Color:="000080"
		Switch_On_HSlide_Border_Color:="FFFFFF"


		Switch_Off_Pressed:="000080"
		Switch_Off_Pressed_Border:="FFFFFF"
		Switch_Off_PSlide_Color:="000080"
		Switch_Off_PSlide_Border_Color:="FFFFFF"

		Switch_On_Pressed:="00FF00"
		Switch_On_Pressed_Border:="000000"
		Switch_On_PSlide_Color:="0000FF"
		Switch_On_PSlide_Border_Color:="000000"

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
	BackgroundColor := "121212"
	HeaderColor := "000000"
	SideBarColor := "181818"
	FooterColor := "2B2B2B"
	FontColor := "A8A8A8"


	ButtonColor := "FFFFFF"
	ButtonBackgroundColor := "000028"
	ButtonBorderColor := "A8A8A8"

	HButtonColor := "009199"
	HButtonBackgroundColor := "000000"
	HButtonBorderColor := "FFFFFF"

	PButtonColor := "00E699"
	PButtonBackgroundColor := "00004D"
	PButtonBorderColor := "000040"


	BarButtonColor := "FFFFFF"
	BarButtonBackgroundColor := "00232E"
	BarButtonBorderColor := "A8A8A8"

	HBarButtonColor := "009199"
	HBarButtonBackgroundColor := "000000"
	HBarButtonBorderColor := "000080"

	PBarButtonColor := "000000"
	PBarButtonBackgroundColor := "009199"
	PBarButtonBorderColor := "A8A8A8"


	IconButtonColor := "FFFFFF"
	IconButtonSecondColor := "00232E"
	IconButtonShadowColor := "000000"
	IconButtonBorderColor := "FFFFFF"

	HIconButtonColor := "00232E"
	HIconButtonSecondColor := "009199"
	HIconButtonShadowColor := "FFFFFF"
	HIconButtonBorderColor := "FFFFFF"

	PIconButtonColor := "009199"
	PIconButtonSecondColor := "00232E"
	PIconButtonShadowColor := "000000"
	PIconButtonBorderColor := "FFFFFF"


	PlaneBackgroundColor := "181818"
	SecondPlaneBackgroundColor := "121212"
	PlaneHeaderColor := "0D0D0D"
	PlaneFooterColor := "0D0D0D"

	PlaneFontColor := "A8A8A8"


	;================SWITCH COLORS================
		Switch_Off_Color:="000028"
		Switch_Off_Border_Color:="121212"
		Switch_Off_Slide_Color:="000040"
		Switch_Off_Slide_Border_Color:="0080FF"

		Switch_On_Color:="00CCCC"
		Switch_On_Border_Color:="000000"
		Switch_On_Slide_Color:="0000FF"
		Switch_On_Slide_Border_Color:="000000"


		Switch_Off_Hover:="000040"
		Switch_Off_Hover_Border:="000000"
		Switch_Off_HSlide_Color:="000080"
		Switch_Off_HSlide_Border_Color:="00FFFF"

		Switch_On_Hover:="00CCCC"
		Switch_On_Hover_Border:="FFFFFF"
		Switch_On_HSlide_Color:="000080"
		Switch_On_HSlide_Border_Color:="FFFFFF"


		Switch_Off_Pressed:="000080"
		Switch_Off_Pressed_Border:="FFFFFF"
		Switch_Off_PSlide_Color:="000080"
		Switch_Off_PSlide_Border_Color:="FFFFFF"

		Switch_On_Pressed:="00CCCC"
		Switch_On_Pressed_Border:="000000"
		Switch_On_PSlide_Color:="0000FF"
		Switch_On_PSlide_Border_Color:="000000"

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

DefaultButtonColors := "Window:=Main," "Color:=" ButtonColor ",BackgroundColor:=" ButtonBackgroundColor ",BorderColor:=" ButtonBorderColor ",HColor:=" HButtonColor ",HBackgroundColor:=" HButtonBackgroundColor ",HBorderColor:=" HButtonBorderColor ",PColor:=" PButtonColor ",PBackgroundColor:=" PButtonBackgroundColor ",PBorderColor:=" PButtonBorderColor,
DefaultBarButtonColors := "Window:=Main," "Color:=" BarButtonColor ",BackgroundColor:=" BarButtonBackgroundColor ",BorderColor:=" BarButtonBorderColor ",HColor:=" HBarButtonColor ",HBackgroundColor:=" HBarButtonBackgroundColor ",HBorderColor:=" HBarButtonBorderColor ",PColor:=" PBarButtonColor ",PBackgroundColor:=" PBarButtonBackgroundColor ",PBorderColor:=" PBarButtonBorderColor,

PlusButtonColors := "Window:=Main," "Color:=" IconButtonColor ",Shadow_Color:=" IconButtonShadowColor ",Hover:=" HIconButtonColor ",Hover_Shadow:=" HIconButtonShadowColor ",Pressed:=" PIconButtonColor ",Pressed_Shadow:=" PIconButtonShadowColor,
SettingsButtonColors := "Window:=Main," "Color:=" IconButtonColor ",Shadow_Color:=" IconButtonShadowColor ",Slide_Color:=" IconButtonSecondColor ",Slide_Border_Color:=" IconButtonBorderColor ",Hover:=" HIconButtonColor ",Hover_Shadow:=" IconButtonShadowColor ",HSlide_Color:=" HIconButtonSecondColor ",HSlide_Border_Color:=" HIconButtonBorderColor ",Pressed:=" PIconButtonColor ",Pressed_Shadow:=" PIconButtonShadowColor ",PSlide_Color:=" PIconButtonSecondColor ",PSlide_Border_Color:=" PIconButtonBorderColor
PlaneColors := "Window:=Main," "HeaderHeight:=25," "FooterHeight:=25" ",Color1:=" PlaneBackgroundColor ",HeaderColor:=" PlaneHeaderColor ",FooterColor:=" PlaneFooterColor ",FontColor:=" PlaneFontColor
SwitchColors := "Window:=Main," "Off_Color:=" Switch_Off_Color ",Off_Border_Color:=" Switch_Off_Border_Color ",Off_Slide_Color:=" Switch_Off_Slide_Color ",Off_Slide_Border_Color:=" Switch_Off_Slide_Border_Color ",On_Color:=" Switch_On_Color ",On_Border_Color:=" Switch_On_Border_Color ",On_Slide_Color:=" Switch_On_Slide_Color ",On_Slide_Border_Color:=" Switch_On_Slide_Border_Color ",Off_Hover:=" Switch_Off_Hover ",Off_Hover_Border:=" Switch_Off_Hover_Border ",Off_HSlide_Color:=" Switch_Off_HSlide_Color ",Off_HSlide_Border_Color:=" Switch_Off_HSlide_Border_Color ",On_Hover:=" Switch_On_Hover ",On_Hover_Border:=" Switch_On_Hover_Border ",On_HSlide_Color:=" Switch_On_HSlide_Color ",On_HSlide_Border_Color:=" Switch_On_HSlide_Border_Color ",Off_Pressed:=" Switch_Off_Pressed ",Off_Pressed_Border:=" Switch_Off_Pressed_Border ",Off_PSlide_Color:=" Switch_Off_PSlide_Color ",Off_PSlide_Border_Color:=" Switch_Off_PSlide_Border_Color ",On_Pressed:=" Switch_On_Pressed ",On_Pressed_Border:=" Switch_On_Pressed_Border ",On_PSlide_Color:=" Switch_On_PSlide_Color ",On_PSlide_Border_Color:=" Switch_On_PSlide_Border_Color 