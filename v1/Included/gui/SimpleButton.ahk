#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

Global CTNSimpleButton := []

SetTimer, CTN_Hover_Function_SimpleButton, 20

;================GUI================
    ; #Include, Gdip.ahk

    ; Gdip_Startup()
    ; SetTitleMatchMode, 2

    ; Width := 500
    ; Height := 300

    ; Gui, +LastFound
    ; WinSet, Transparent, 240
    ; Gui, Color, 040080
    ; Gui, Margin, 0, 0

    ; Gui, Add, Progress, % "x-1 y-1 w" (Width+2) " h31 Background020040 Disabled hwndHPROG"


    ; CreateButton("x:=15", "y:=40", "BorderWidth:=8")
    ; CreateButton("x:=145", "y:=40", "w:=200", "h:=80")
    ; CreateButton("x:=15", "y:=130", "w:=400", "h:=160")


    ; Gui, Font, s12 cWhite, Impact
    ; Gui, Add, Text, % "x0 y0 w" Width " h30 BackgroundTrans Center 0x200 gGuiMove vCaption", Custom Window Layout


    ; Gui, -Caption
    ; WinSet, Region, 0-0 w%Width% h%Height% r10-10
    ; Gui, Show, w%Width% h%Height%, Mouse Recorder

    ; return
;-=-=-=-=-=-=-=-=GUI-=-=-=-=-=-=-=-=

CreateButton(params*) {

    x := 10
    y := 10
    w := 100
    h := 40

    Text := "Button"
    Font := "Impact"
    FontSize := "14"

    Window := "1"
    Label := ""
    Variable := ""
    Radius := 0
    ShowBorder := 0
    BorderWidth := 4
    ToolTip := ""

    Color := "FFFFFF"
    BackgroundColor := "0000FF"
    BorderColor := "FFFFFF"

    HColor := "0000FF"
    HBackgroundColor := "00FFFF"
    HBorderColor := "00FF08"

    PColor := "00FF80"
    PBackgroundColor := "050068"
    PBorderColor := "050068"

    TextOpicity := "0xFF"
    BackgroundOpicity := "0xFF"

    OnTopColor := "040080"


    for index, param in params {
        for index2, param2 in StrSplit(param, ",") {
            ParamObj := StrSplit(param2, ":=")
            Var := ParamObj[1]
            %Var% := ParamObj[2]
        }
    }

    CTNSimpleButton.Push(New Button(x, y, w, h, Text, Font, FontSize, Window, Label, Variable, Radius, ShowBorder, BorderWidth, ToolTip, Color, BackgroundColor, BorderColor, HColor, HBackgroundColor, HBorderColor, PColor, PBackgroundColor, PBorderColor, TextOpicity, BackgroundOpicity, OnTopColor))
}


CTN_Hover_Function_SimpleButton(){
	static Hover_On, Index
	MouseGetPos,,,,ctrl, 2
	if ( ! Hover_On && ctrl) {
		loop, % CTNSimpleButton.Length() {
			if (ctrl=CTNSimpleButton[A_Index].Hwnd) {
				CTNSimpleButton[A_Index].Draw_Hover()
				Hover_On:=1
				Index:=A_Index
				break
			}
		}	
	}
	else if (Hover_On)
		if ( ctrl != CTNSimpleButton[Index].Hwnd) {
			CTNSimpleButton[Index].Draw_Default()
			Hover_On:=0
		}
}



Class Button {

    __New(x,y,w,h,Text:="",Font:="",FontSize:="",Window:="",Label:="",Variable:="",Radius:="",ShowBorder:="",BorderWidth:="",ToolTip:="",Color:="",BackgroundColor:="",BorderColor:="",HColor:="",HBackgroundColor:="",HBorderColor:="",PColor:="",PBackgroundColor:="",PBorderColor:="",TextOpicity:="",BackgroundOpicity:="",OnTopColor:="") {

        This.X:=x
        This.Y:=y
        This.W:=w
        This.H:=h

        This.Text:=Text
        This.Font:=Font
        This.FontSize:=FontSize

        This.Window := Window
        This.Label := Label
        This.Variable:= " v" Variable
        This.Radius := Radius
        This.ShowBorder := ShowBorder
        This.BorderWidth := BorderWidth
        This.Tooltip := ToolTip
        This.ShowToolTip := ObjBindMethod(This, "ShowToolTipFunc") 

        This.Color := Color
        This.BackgroundColor := BackgroundColor
        if (This.ShowBorder == 0) {
            This.BorderColor := This.BackgroundColor
        }
        else if (This.ShowBorder == 1) {
            This.BorderColor := BorderColor
        }
        
        This.HColor := HColor
        This.HBackgroundColor := HBackgroundColor
        if (This.ShowBorder == 0) {
            This.HBorderColor := This.HBackgroundColor
        }
        else if (This.ShowBorder == 1) {
            This.HBorderColor := HBorderColor
        }

        This.PColor := PColor
        This.PBackgroundColor := PBackgroundColor
        if (This.ShowBorder == 0) {
            This.PBorderColor := This.PBackgroundColor
        }
        else if (This.ShowBorder == 1) {
            This.PBorderColor := PBorderColor
        }

        this.TextOpicity := TextOpicity
        this.BackgroundOpicity := BackgroundOpicity

        This.OnTopColor := "0xFF" OnTopColor

        ;========Functions========
			This.Create_Trigger()
			This.Create_Default_Bitmap()
			This.Create_Hover_Bitmap()
			This.Create_Pressed_Bitmap()

		sleep,20
		This.Draw_Default()
    }

    Create_Trigger(){
		Gui, % This.Window ": Add", Picture,  % "x" This.X-2 " y" This.Y-2 " w" This.W " h" This.H " hwndhwnd 0xE " This.Variable
		This.Hwnd:=hwnd
		BPC:=This.Draw_Pressed.Bind(This)
		GuiControl, +G, % This.Hwnd, % BPC
        GuiControl, +BackgroundTrans, % This.Hwnd, % BPC
		if (This.Label){
			;(IsFunc(This.Label))?(This.Function:=Func(This.Label),This.Type:="Function"):(This.Type:="Label")
		}
	}

    Create_Default_Bitmap() {
        
        This.BorderWidth:= This.BorderWidth * ((This.W/100)+(This.H/100)) /4
        if (This.Radius != 0) {
            This.Radius:=(This.W/100)+(This.H/100) * 10 * (This.Radius+This.BorderWidth) /20
        }
		
        pBitmap:=Gdip_CreateBitmap( This.W+this.BorderWidth*2+2, This.H+this.BorderWidth*2+2 ) 
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        Brush := Gdip_BrushCreateSolid( This.OnTopColor )
        Gdip_FillRoundedRectangle( G , Brush , -2 , -2 , This.W+8 , This.H+8 , 0 )
        Gdip_DeleteBrush( Brush )

        ;========Background========
        Brush := Gdip_BrushCreateSolid( This.BackgroundOpicity This.BackgroundColor )
        Gdip_FillRoundedRectangle( G , Brush , 2 , 2 , This.W , This.H , This.Radius )
        Gdip_DeleteBrush( Brush )

        ;========Border========
        Pen := Gdip_CreatePen( This.BackgroundOpicity This.BorderColor , This.BorderWidth )
        Gdip_DrawRoundedRectangle( G , Pen , 2 , 2 , This.W , This.H , This.Radius )
        Gdip_DeletePen( Pen )

        ;========Text========
        Brush := Gdip_BrushCreateSolid( This.TextOpicity This.Color )
        Gdip_TextToGraphics( G , This.Text , "s" This.Get_Font_Size() " Center c" Brush " x2 y" This.TextY ,  This.Font , This.W , This.H )
        Gdip_DeleteBrush( Brush )
        Gdip_DeleteGraphics( G )

        This.Default_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)

	}

    Create_Hover_Bitmap() {

        pBitmap:=Gdip_CreateBitmap( This.W+this.BorderWidth*2+2, This.H+this.BorderWidth*2+2 ) 
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        Brush := Gdip_BrushCreateSolid( This.OnTopColor )
        Gdip_FillRoundedRectangle( G , Brush , -2 , -2 , This.W+8 , This.H+8 , 0 )
        Gdip_DeleteBrush( Brush )

        ;========Background========
        Brush := Gdip_BrushCreateSolid( This.BackgroundOpicity This.HBackgroundColor )
        Gdip_FillRoundedRectangle( G , Brush , 2 , 2 , This.W , This.H , This.Radius+(This.W/50) )
        Gdip_DeleteBrush( Brush )

        ;========Border========
        Pen := Gdip_CreatePen( This.BackgroundOpicity This.HBorderColor , This.BorderWidth )
        Gdip_DrawRoundedRectangle( G , Pen , 2 , 2 , This.W , This.H , This.Radius+(This.W/50) )
        Gdip_DeletePen( Pen )

        ;========Text========
        Brush := Gdip_BrushCreateSolid( This.TextOpicity This.HColor )
        Gdip_TextToGraphics( G , This.Text , "s" This.Get_Font_Size() " Center c" Brush " x2 y" This.TextY ,  This.Font , This.W , This.H )
        Gdip_DeleteBrush( Brush )
        Gdip_DeleteGraphics( G )

        This.Hover_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)

    }

    Create_Pressed_Bitmap() {

        pBitmap:=Gdip_CreateBitmap( This.W+this.BorderWidth*2+2, This.H+this.BorderWidth*2+2 ) 
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        Brush := Gdip_BrushCreateSolid( This.OnTopColor )
        Gdip_FillRoundedRectangle( G , Brush , -2 , -2 , This.W+8 , This.H+8 , 0 )
        Gdip_DeleteBrush( Brush )

        ;========Background========
        Brush := Gdip_BrushCreateSolid( This.BackgroundOpicity This.PBackgroundColor )
        Gdip_FillRoundedRectangle( G , Brush , 2 , 2 , This.W , This.H , 0 )
        Gdip_DeleteBrush( Brush )

        ;========Border========
        Pen := Gdip_CreatePen( This.BackgroundOpicity This.PBorderColor , This.BorderWidth )
        Gdip_DrawRoundedRectangle( G , Pen , 2 , 2 , This.W , This.H , 0 )
        Gdip_DeletePen( Pen )

        ;========Text========
        Brush := Gdip_BrushCreateSolid( This.TextOpicity This.PColor )
        Gdip_TextToGraphics( G , This.Text , "s" This.Get_Font_Size() " Center c" Brush " x2 y" This.TextY ,  This.Font , This.W , This.H )
        Gdip_DeleteBrush( Brush )
        Gdip_DeleteGraphics( G )

        This.Pressed_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)

    }

    Get_Font_Size() {
        Divided := This.W / 100
		
		if (StrLen(This.Text) >= 10) {
			NewSize := Divided * This.FontSize
			This.TextY := (this.H/2) - NewSize*.68 + 3
			;New_Size -= 2
		}

        else {
            NewSize := Divided * This.FontSize * 1.50
            This.TextY := (this.H/2) - NewSize*.68 + 3
        }

		return % NewSize
		return % This.TextY
    }


    Draw_Pressed(){
		SetTimer,CTN_Hover_Function_SimpleButton,Off
		SetImage(This.hwnd, This.Pressed_Bitmap)
		While(GetKeyState("LButton"))
			Sleep,10

		SetTimer,CTN_Hover_Function_SimpleButton,On
		MouseGetPos,,,,ctrl,2

		if (ctrl=This.Hwnd) {
			This.Draw_Hover()

			if (This.Type="Function") {
				This.Function.Call()
			}

			else if (This.Type:="Label") {
                if (This.Label == "") {
                    This.Draw.Default()
                }
                else
				    gosub,% This.Label
			}	
		}

		else {
			This.Draw.Default()
		}
	}

    Draw_Hover(){
		SetImage(This.hwnd, This.Hover_Bitmap)
        if (This.ToolTip != "") {
            ShowToolTip := This.ShowToolTip
            SetTimer, % ShowToolTip, 50
        }
	}

	Draw_Default(){
		SetImage(This.hwnd, This.Default_Bitmap)
        if (This.ToolTip != "") {
            ShowToolTip := This.ShowToolTip
            SetTimer, % ShowToolTip, Off
            This.ToolTipLooped := 0
            ToolTip
        }
	}

    ShowToolTipFunc() {
        This.ToolTipLooped += 1
        if (This.ToolTipLooped > 15) {
            ToolTip, % This.Tooltip
        }
    }

    
}



; GuiMove:
;     PostMessage, 0xA1, 2
; return

; CloseButton:
;     ExitApp
; return

; MinimizeButton:
;     Gui Minimize
; return