#SingleInstance, Force
#Include, Included\Gdip.ahk
;#Include, Gdip.ahk
; SendMode Input
; SetWorkingDir, %A_ScriptDir%

Gdip_Startup()

global CTN_Plus_Button:=[]

; Create_Plus_Button("x:=20", "y:=20", "w:=25", "h:=25", "PlusBackgroundColor:=007000")
; Create_Plus_Button("x:=70", "y:=20", "w:=50", "h:=50", "PlusBackgroundColor:=007000")
; Create_Plus_Button("x:=150", "y:=20", "w:=100", "h:=100", "PlusBackgroundColor:=007000")
; Create_Plus_Button("x:=300", "y:=20", "w:=200", "h:=200", "PlusBackgroundColor:=007000")
; Create_Plus_Button("x:=550", "y:=20", "w:=400", "h:=400", "PlusBackgroundColor:=007000")


; Gui, 1:Color, 007000
; Gui, 1:Show, w1000 h450
SetTimer, CTN_Hover_Function_Plus_Button, 20
;return

Create_Plus_Button(params*) {
    ;================DEFAULTS================
        x:=10,
        y:=10,
        w:=100,
        h:=100,

    ;================Colors================
        ;================Normal Colors================
            Color:="FFFFFF",
            Shadow_Color:="000000"
        ;================Hover Colors================
            Hover:="00FF00",
            Hover_Shadow:="000000",
        ;================Pressed Colors================
            Pressed:="0000FF",
            Pressed_Shadow:="000000"
    ;================Style================
        Thickness:=15,
        Radius:=5,
    ;================Options================
        Window:=1,
        Label:="PlusButton",
        PlusBackgroundColor:=""

    for index, param in params {
        for index2, param2 in StrSplit(param, ",") {
            ParamObj := StrSplit(param2, ":=")
            Var := ParamObj[1]
            %Var% := ParamObj[2]
        }
    }

    CTN_Plus_Button.Push(New Plus_Button(x, y, w, h, Color, Shadow_Color, Hover, Hover_Shadow, Pressed, Pressed_Shadow, Thickness, Radius, Window, Label, PlusBackgroundColor))
}

CTN_Hover_Function_Plus_Button(){
	static Hover_On, Index
	MouseGetPos,,,,ctrl, 2
	if ( ! Hover_On && ctrl) {
		loop, % CTN_Plus_Button.Length() {
			if (ctrl=CTN_Plus_Button[A_Index].Hwnd) {
				CTN_Plus_Button[A_Index].Draw_Hover()
				Hover_On:=1
				Index:=A_Index
				break
			}
		}	
	}
	else if (Hover_On)
		if ( ctrl != CTN_Plus_Button[Index].Hwnd) {
			CTN_Plus_Button[Index].Draw_Default()
			Hover_On:=0
		}
}


Class Plus_Button {

    __New(x,y,w,h,Color:="",Shadow_Color:="",Hover:="",Hover_Shadow:="",Pressed:="",Pressed_Shadow:="",Thickness:="",Radius:="",Window:="",Label:="",PlusBackgroundColor:=""){
		
        This.X:=x
		This.Y:=y
		This.W:=w
		This.H:=h

		;========Color========
            This.Color:= "0xFF" Color
            This.Shadow_Color:= "0xFF" Shadow_Color
		;========Hover Color========
            This.Hover:= "0xFF" Hover
            This.Hover_Shadow:= "0xFF" Hover_Shadow
		;========Pressed Color========
            This.Pressed:= "0xFF" Pressed
            This.Pressed_Shadow:= "0xFF" Pressed_Shadow

		;========Style========
            This.Thickness:=Thickness
            This.Radius:=Radius
		;========Options========
			This.Window:=Window
			This.Label:=Label
            This.PlusBackgroundColor:= "0x00" PlusBackgroundColor

		;========Functions========
			This.Create_Trigger()
			This.Create_Default_Bitmap()
			This.Create_Hover_Bitmap()
			This.Create_Pressed_Bitmap()

		sleep,20
		This.Draw_Default()
    }

    Create_Trigger(){
		Gui,% This.Window ": Add",Picture,  % "x" This.X " y" This.Y " w" This.W " h" This.H " hwndhwnd 0xE"
		This.Hwnd:=hwnd
		BPC:=This.Draw_Pressed.Bind(This)
		GuiControl,+G,% This.Hwnd,% BPC
        GuiControl, +BackgroundTrans, % This.Hwnd, % BPC
		if (This.Label){
			(IsFunc(This.Label))?(This.Function:=Func(This.Label),This.Type:="Function"):(This.Type:="Label")
		}
	}

    Create_Default_Bitmap() {
	    pBitmap:=Gdip_CreateBitmap( This.W*1.05 , This.H*1.05 ) 
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        ;================Background================
        Brush := Gdip_BrushCreateSolid( This.PlusBackgroundColor )
        Gdip_FillRectangle( G , Brush , 2 , 2 , This.W+2 , This.H+2 ) ;0 , 0 , 100 , 100
        Gdip_DeleteBrush( Brush )

        ;================Shadow V================
        Brush := Gdip_BrushCreateSolid( This.Shadow_Color )
        Gdip_FillRoundedRectangle( G , Brush , (This.W/2.4)+(This.W/25) , (This.W/25) , This.W/5 , This.W-((This.W/25)/2) , (This.W/100)*This.Radius ) ;44 , 14 , 20 , 80 , 1
        Gdip_DeleteBrush( Brush )

        ;================Shadow H================
        Brush := Gdip_BrushCreateSolid( This.Shadow_Color )
        Gdip_FillRoundedRectangle( G , Brush , (This.W/25) , (This.W/2.4)+(This.W/25) , This.W-((This.W/25)/2) , This.W/5 , (This.W/100)*This.Radius ) ;14 , 44 , 80 , 20 , 1
        Gdip_DeleteBrush( Brush )

        ;================Top V================
        Brush := Gdip_BrushCreateSolid( This.Color )
        Gdip_FillRoundedRectangle( G , Brush , This.W/2.5 , 0 , This.W/5 , This.W-((This.W/25)/2) , (This.W/100)*This.Radius ) ;40 , 10 , 20 , 80 , 1
        Gdip_DeleteBrush( Brush )

        ;================Top H================
        Brush := Gdip_BrushCreateSolid( This.Color )
        Gdip_FillRoundedRectangle( G , Brush , 0 , This.W/2.5 , This.W-((This.W/25)/2) , This.W/5 , (This.W/100)*This.Radius ) ;10 , 40 , 80 , 20 , 1
        Gdip_DeleteBrush( Brush )

        This.Default_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
    }

    Create_Hover_Bitmap() {
	    pBitmap:=Gdip_CreateBitmap( This.W*1.05 , This.H*1.05 ) 
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        ;================Background================
        Brush := Gdip_BrushCreateSolid( This.PlusBackgroundColor )
        Gdip_FillRectangle( G , Brush , 2 , 2 , This.W+2 , This.H+2 ) ;0 , 0 , 100 , 100
        Gdip_DeleteBrush( Brush )

        ;================Shadow V================
        Brush := Gdip_BrushCreateSolid( This.Hover_Shadow )
        Gdip_FillRoundedRectangle( G , Brush , (This.W/2.4)+(This.W/25) , (This.W/25) , This.W/5 , This.W-((This.W/25)/2) , (This.W/100)*This.Radius ) ;44 , 14 , 20 , 80 , 1
        Gdip_DeleteBrush( Brush )

        ;================Shadow H================
        Brush := Gdip_BrushCreateSolid( This.Hover_Shadow )
        Gdip_FillRoundedRectangle( G , Brush , (This.W/25) , (This.W/2.4)+(This.W/25) , This.W-((This.W/25)/2) , This.W/5 , (This.W/100)*This.Radius ) ;14 , 44 , 80 , 20 , 1
        Gdip_DeleteBrush( Brush )

        ;================Top V================
        Brush := Gdip_BrushCreateSolid( This.Hover )
        Gdip_FillRoundedRectangle( G , Brush , This.W/2.5 , 0 , This.W/5 , This.W-((This.W/25)/2) , (This.W/100)*This.Radius ) ;40 , 10 , 20 , 80 , 1
        Gdip_DeleteBrush( Brush )

        ;================Top H================
        Brush := Gdip_BrushCreateSolid( This.Hover )
        Gdip_FillRoundedRectangle( G , Brush , 0 , This.W/2.5 , This.W-((This.W/25)/2) , This.W/5 , (This.W/100)*This.Radius ) ;10 , 40 , 80 , 20 , 1
        Gdip_DeleteBrush( Brush )

        This.Hover_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
    }

    Create_Pressed_Bitmap() {
	    pBitmap:=Gdip_CreateBitmap( This.W*1.05 , This.H*1.05 ) 
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        ;================Background================
        Brush := Gdip_BrushCreateSolid( This.PlusBackgroundColor )
        Gdip_FillRectangle( G , Brush , 2 , 2 , This.W+2 , This.H+2 ) ;0 , 0 , 100 , 100
        Gdip_DeleteBrush( Brush )

        ;================Shadow V================
        Brush := Gdip_BrushCreateSolid( This.Pressed_Shadow )
        Gdip_FillRoundedRectangle( G , Brush , (This.W/2.4)+(This.W/25) , (This.W/25) , This.W/5 , This.W-((This.W/25)/2) , (This.W/100)*This.Radius ) ;44 , 14 , 20 , 80 , 1
        Gdip_DeleteBrush( Brush )

        ;================Shadow H================
        Brush := Gdip_BrushCreateSolid( This.Pressed_Shadow )
        Gdip_FillRoundedRectangle( G , Brush , (This.W/25) , (This.W/2.4)+(This.W/25) , This.W-((This.W/25)/2) , This.W/5 , (This.W/100)*This.Radius ) ;14 , 44 , 80 , 20 , 1
        Gdip_DeleteBrush( Brush )

        ;================Top V================
        Brush := Gdip_BrushCreateSolid( This.Pressed )
        Gdip_FillRoundedRectangle( G , Brush , This.W/2.5 , 0 , This.W/5 , This.W-((This.W/25)/2) , (This.W/100)*This.Radius ) ;40 , 10 , 20 , 80 , 1
        Gdip_DeleteBrush( Brush )

        ;================Top H================
        Brush := Gdip_BrushCreateSolid( This.Pressed )
        Gdip_FillRoundedRectangle( G , Brush , 0 , This.W/2.5 , This.W-((This.W/25)/2) , This.W/5 , (This.W/100)*This.Radius ) ;10 , 40 , 80 , 20 , 1
        Gdip_DeleteBrush( Brush )

        This.Pressed_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
    }

    Draw_Pressed(){
		SetTimer,CTN_Hover_Function_Plus_Button,Off
		SetImage(This.hwnd, This.Pressed_Bitmap)
		While(GetKeyState("LButton"))
			Sleep,10

		SetTimer,CTN_Hover_Function_Plus_Button,On
		MouseGetPos,,,,ctrl,2

		if (ctrl=This.Hwnd) {
			This.Draw_Hover()

			if (This.Type="Function") {
				This.Function.Call()
			}

			else if (This.Type:="Label") {
				gosub,% This.Label
			}	
		}

		else {
			This.Draw.Default()
		}
	}

    Draw_Hover(){
		SetImage(This.hwnd, This.Hover_Bitmap)
	}
    Draw_Default(){
		SetImage(This.hwnd, This.Default_Bitmap)
	}

}