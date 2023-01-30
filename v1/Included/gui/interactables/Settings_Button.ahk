#SingleInstance, Force
#Include, Included/gui/interactables/Gdip.ahk
; #Include, Gdip.ahk
; SendMode Input
; SetWorkingDir, %A_ScriptDir%

Gdip_Startup()

global CTN_Settings_Button:=[]

; Create_Settings_Button("x:=20", "y:=20", "w:=25", "h:=25", "OnTopColor:=007000")
; Create_Settings_Button("x:=70", "y:=20", "w:=50", "h:=50", "OnTopColor:=007000")
; Create_Settings_Button("x:=150", "y:=20", "w:=100", "h:=100", "OnTopColor:=007000")
; Create_Settings_Button("x:=300", "y:=20", "w:=200", "h:=200", "OnTopColor:=007000")
; Create_Settings_Button("x:=550", "y:=20", "w:=400", "h:=400", "OnTopColor:=007000")


; Gui, 1:Color, 007000
; Gui, 1:Show, w1000 h450
SetTimer, CTN_Hover_Function_Settings_Button, 20
; return

Create_Settings_Button(params*) {
    ;================DEFAULTS================
        x:=10,
        y:=10,
        w:=100,
        h:=100,

    ;================Colors================
        ;================Normal Colors================
            Color:="FFFFFF",
            Shadow_Color:="000000",
            Slide_Color:="000040",
            Slide_Border_Color:="FFFFFF",
        ;================Hover Colors================
            Hover:="00FF00",
            Hover_Shadow:="000000",
            HSlide_Color:="000040",
            HSlide_Border_Color:="FFFFFF",
        ;================Pressed Colors================
            Pressed:="0000FF",
            Pressed_Shadow:="000000",
            PSlide_Color:="000040",
            PSlide_Border_Color:="FFFFFF",
    ;================Style================
        Thickness:=15,
        Radius:=2,
        Slide_Radius:=3,
        BorderWidth:=2,
    ;================Options================
        Window:=1,
        Label:="SettingsButton",
        Tooltip := ""
        OnTopColor:=""

    for index, param in params {
        for index2, param2 in StrSplit(param, ",") {
            ParamObj := StrSplit(param2, ":=")
            Var := ParamObj[1]
            ;MsgBox, %Var%
            %Var% := ParamObj[2]
        }
    }
    
    CTN_Settings_Button.Push(New Settings_Button(x, y, w, h, Color, Shadow_Color, Slide_Color, Slide_Border_Color, Hover, Hover_Shadow, HSlide_Color, HSlide_Border_Color, Pressed, Pressed_Shadow, PSlide_Color, PSlide_Border_Color, Thickness, Radius, Slide_Radius, BorderWidth, Window, Label, ToolTip, OnTopColor))
}

CTN_Hover_Function_Settings_Button(){
	static Hover_On, Index
	MouseGetPos,,,,ctrl, 2
	if ( ! Hover_On && ctrl) {
		loop, % CTN_Settings_Button.Length() {
			if (ctrl=CTN_Settings_Button[A_Index].Hwnd) {
				CTN_Settings_Button[A_Index].Draw_Hover()
				Hover_On:=1
				Index:=A_Index
				break
			}
		}	
	}
	else if (Hover_On)
		if ( ctrl != CTN_Settings_Button[Index].Hwnd) {
			CTN_Settings_Button[Index].Draw_Default()
			Hover_On:=0
		}
}


Class Settings_Button {

    __New(x,y,w,h,Color:="",Shadow_Color:="",Slide_Color:="",Slide_Border_Color:="",Hover:="",Hover_Shadow:="",HSlide_Color:="",HSlide_Border_Color:="",Pressed:="",Pressed_Shadow:="",PSlide_Color:="",PSlide_Border_Color:="",Thickness:="",Radius:="",Slide_Radius:="",BorderWidth:="",Window:="",Label:="",ToolTip:="",OnTopColor:=""){
		
        This.X:=x
		This.Y:=y
		This.W:=w
		This.H:=h

		;========Color========
            This.Color:= "0xFF" Color
            This.Shadow_Color:= "0xFF" Shadow_Color
            This.Slide_Color:= "0xFF" Slide_Color
            This.Slide_Border_Color:= "0xFF" Slide_Border_Color
		;========Hover Color========
            This.Hover:= "0xFF" Hover
            This.Hover_Shadow:= "0xFF" Hover_Shadow
            This.HSlide_Color:= "0xFF" HSlide_Color
            This.HSlide_Border_Color:= "0xFF" HSlide_Border_Color
		;========Pressed Color========
            This.Pressed:= "0xFF" Pressed
            This.Pressed_Shadow:= "0xFF" Pressed_Shadow
            This.PSlide_Color:= "0xFF" PSlide_Color
            This.PSlide_Border_Color:= "0xFF" PSlide_Border_Color

		;========Style========
            This.Thickness:=Thickness
            This.Radius:=Radius
            This.Slide_Radius:=Slide_Radius
            This.BorderWidth:=BorderWidth
		;========Options========
			This.Window:=Window
			This.Label:=Label
            This.OnTopColor:= "0xFF" OnTopColor
            This.Tooltip := ToolTip
            This.ShowToolTip := ObjBindMethod(This, "ShowToolTipFunc") 

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
	    pBitmap:=Gdip_CreateBitmap( This.W , This.H-(This.H/10) ) 
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        ;================Background================
        Brush := Gdip_BrushCreateSolid( This.OnTopColor )
        Gdip_FillRectangle( G , Brush , -2 , -2 , This.W+8 , This.H+8 )
        Gdip_DeleteBrush( Brush )
        
        ;================Top Shadow================
        Brush := Gdip_BrushCreateSolid( This.Shadow_Color )
        Gdip_FillRoundedRectangle( G , Brush , This.W/25 , (This.W/10)+(This.W/25) , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;4 , 14 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Top================
        Brush := Gdip_BrushCreateSolid( This.Color )
        Gdip_FillRoundedRectangle( G , Brush , 0 , This.W/10 , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;0 , 10 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Midle Shadow================
        Brush := Gdip_BrushCreateSolid( This.Shadow_Color )
        Gdip_FillRoundedRectangle( G , Brush , This.W/25 , (This.W/2.5)+(This.W/25) , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;4 , 44 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Midle================
        Brush := Gdip_BrushCreateSolid( This.Color )
        Gdip_FillRoundedRectangle( G , Brush , 0 , This.W/2.5 , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;0 , 40 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Bottum Shadow================
        Brush := Gdip_BrushCreateSolid( This.Shadow_Color )
        Gdip_FillRoundedRectangle( G , Brush , This.W/25 , This.W-((This.W/10)+(This.W/5))+(This.W/25) , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;4 , 74 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Bottum================
        Brush := Gdip_BrushCreateSolid( This.Color )
        Gdip_FillRoundedRectangle( G , Brush , 0 , This.W-((This.W/10)+(This.W/5)) , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;0 , 70 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Top Slide================
        Brush := Gdip_BrushCreateSolid( This.Slide_Color )
        Gdip_FillRoundedRectangle( G , Brush , This.W/20 , This.W/20 , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;5 , 5 , 20 , 20 , 3 
        Gdip_DeleteBrush( Brush )

        ;================Top Slide Border================
        Pen := Gdip_CreatePen( This.Slide_Border_Color , (This.W/100)+(This.BorderWidth/2) )
        Gdip_DrawRoundedRectangle( G , Pen , This.W/20 , This.W/20 , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;5 , 5 , 20 , 20 , 5 
        Gdip_DeletePen( Pen )
        
        ;================Midle Slide================
        Brush := Gdip_BrushCreateSolid( This.Slide_Color )
        Gdip_FillRoundedRectangle( G , Brush , ((This.W/10)+(This.W/5))+(This.W/20)+(This.W/50) , ((This.W/10)+(This.W/5))+(This.W/20) , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;37 , 35 , 20 , 20 , 3 
        Gdip_DeleteBrush( Brush )

        ;================Midle Slide Border================
        Pen := Gdip_CreatePen( This.Slide_Border_Color , (This.W/100)+(This.BorderWidth/2) )
        Gdip_DrawRoundedRectangle( G , Pen , ((This.W/10)+(This.W/5))+(This.W/20)+(This.W/50) , ((This.W/10)+(This.W/5))+(This.W/20) , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;37 , 35 , 20 , 20 , 5 
        Gdip_DeletePen( Pen )
        
        ;================Bottum Slide================
        Brush := Gdip_BrushCreateSolid( This.Slide_Color )
        Gdip_FillRoundedRectangle( G , Brush , This.W-((This.W/10)+(This.W/5)) , (This.W/2)+(This.W/10)+(This.W/20) , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;70 , 65 , 20 , 20 , 3 
        Gdip_DeleteBrush( Brush )

        ;================Bottum Slide Border================
        Pen := Gdip_CreatePen( This.Slide_Border_Color , (This.W/100)+(This.BorderWidth/2) )
        Gdip_DrawRoundedRectangle( G , Pen , This.W-((This.W/10)+(This.W/5)) , (This.W/2)+(This.W/10)+(This.W/20) , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;70 , 65 , 20 , 20 , 5 
        Gdip_DeletePen( Pen )

        This.Default_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
    }

    Create_Hover_Bitmap() {
	    pBitmap:=Gdip_CreateBitmap( This.W , This.H-(This.H/10) ) 
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        ;================Background================
        Brush := Gdip_BrushCreateSolid( This.OnTopColor )
        Gdip_FillRectangle( G , Brush , -2 , -2 , This.W+8 , This.H+8 )
        Gdip_DeleteBrush( Brush )
        
        ;================Top Shadow================
        Brush := Gdip_BrushCreateSolid( This.Hover_Shadow )
        Gdip_FillRoundedRectangle( G , Brush , This.W/25 , (This.W/10)+(This.W/25) , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;4 , 14 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Top================
        Brush := Gdip_BrushCreateSolid( This.Hover )
        Gdip_FillRoundedRectangle( G , Brush , 0 , This.W/10 , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;0 , 10 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Midle Shadow================
        Brush := Gdip_BrushCreateSolid( This.Hover_Shadow )
        Gdip_FillRoundedRectangle( G , Brush , This.W/25 , (This.W/2.5)+(This.W/25) , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;4 , 44 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Midle================
        Brush := Gdip_BrushCreateSolid( This.Hover )
        Gdip_FillRoundedRectangle( G , Brush , 0 , This.W/2.5 , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;0 , 40 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Bottum Shadow================
        Brush := Gdip_BrushCreateSolid( This.Hover_Shadow )
        Gdip_FillRoundedRectangle( G , Brush , This.W/25 , This.W-((This.W/10)+(This.W/5))+(This.W/25) , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;4 , 74 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Bottum================
        Brush := Gdip_BrushCreateSolid( This.Hover )
        Gdip_FillRoundedRectangle( G , Brush , 0 , This.W-((This.W/10)+(This.W/5)) , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;0 , 70 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Top Slide================
        Brush := Gdip_BrushCreateSolid( This.HSlide_Color )
        Gdip_FillRoundedRectangle( G , Brush , This.W-((This.W/10)+(This.W/5)) , This.W/20 , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;5 , 5 , 20 , 20 , 3 
        Gdip_DeleteBrush( Brush )

        ;================Top Slide Border================
        Pen := Gdip_CreatePen( This.HSlide_Border_Color , (This.W/100)+(This.BorderWidth/2) )
        Gdip_DrawRoundedRectangle( G , Pen , This.W-((This.W/10)+(This.W/5)) , This.W/20 , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;5 , 5 , 20 , 20 , 5 
        Gdip_DeletePen( Pen )
        
        ;================Midle Slide================
        Brush := Gdip_BrushCreateSolid( This.HSlide_Color )
        Gdip_FillRoundedRectangle( G , Brush , ((This.W/10)+(This.W/5))+(This.W/20)+(This.W/50) , ((This.W/10)+(This.W/5))+(This.W/20) , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;37 , 35 , 20 , 20 , 3 
        Gdip_DeleteBrush( Brush )

        ;================Midle Slide Border================
        Pen := Gdip_CreatePen( This.HSlide_Border_Color , (This.W/100)+(This.BorderWidth/2) )
        Gdip_DrawRoundedRectangle( G , Pen , ((This.W/10)+(This.W/5))+(This.W/20)+(This.W/50) , ((This.W/10)+(This.W/5))+(This.W/20) , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;37 , 35 , 20 , 20 , 5 
        Gdip_DeletePen( Pen )
        
        ;================Bottum Slide================
        Brush := Gdip_BrushCreateSolid( This.HSlide_Color )
        Gdip_FillRoundedRectangle( G , Brush , This.W/20 , (This.W/2)+(This.W/10)+(This.W/20) , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;70 , 65 , 20 , 20 , 3 
        Gdip_DeleteBrush( Brush )

        ;================Bottum Slide Border================
        Pen := Gdip_CreatePen( This.HSlide_Border_Color , (This.W/100)+(This.BorderWidth/2) )
        Gdip_DrawRoundedRectangle( G , Pen , This.W/20 , (This.W/2)+(This.W/10)+(This.W/20) , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;70 , 65 , 20 , 20 , 5 
        Gdip_DeletePen( Pen )

        This.Hover_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
    }

    Create_Pressed_Bitmap() {
	    pBitmap:=Gdip_CreateBitmap( This.W , This.H-(This.H/10) ) 
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        ;================Background================
        Brush := Gdip_BrushCreateSolid( This.OnTopColor )
        Gdip_FillRectangle( G , Brush , -2 , -2 , This.W+8 , This.H+8 )
        Gdip_DeleteBrush( Brush )
        
        ;================Top Shadow================
        Brush := Gdip_BrushCreateSolid( This.Pressed_Shadow )
        Gdip_FillRoundedRectangle( G , Brush , This.W/25 , (This.W/10)+(This.W/25) , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;4 , 14 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Top================
        Brush := Gdip_BrushCreateSolid( This.Pressed )
        Gdip_FillRoundedRectangle( G , Brush , 0 , This.W/10 , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;0 , 10 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Midle Shadow================
        Brush := Gdip_BrushCreateSolid( This.Pressed_Shadow )
        Gdip_FillRoundedRectangle( G , Brush , This.W/25 , (This.W/2.5)+(This.W/25) , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;4 , 44 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Midle================
        Brush := Gdip_BrushCreateSolid( This.Pressed )
        Gdip_FillRoundedRectangle( G , Brush , 0 , This.W/2.5 , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;0 , 40 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Bottum Shadow================
        Brush := Gdip_BrushCreateSolid( This.Pressed_Shadow )
        Gdip_FillRoundedRectangle( G , Brush , This.W/25 , This.W-((This.W/10)+(This.W/5))+(This.W/25) , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;4 , 74 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Bottum================
        Brush := Gdip_BrushCreateSolid( This.Pressed )
        Gdip_FillRoundedRectangle( G , Brush , 0 , This.W-((This.W/10)+(This.W/5)) , (This.W-(This.W/10)+(This.W/25+2)) , This.W/10 , (This.W/100)+(This.Radius/2) ) ;0 , 70 , 96 , 10 , 2
        Gdip_DeleteBrush( Brush )
        
        ;================Top Slide================
        Brush := Gdip_BrushCreateSolid( This.PSlide_Color )
        Gdip_FillRoundedRectangle( G , Brush , ((This.W/10)+(This.W/5))+(This.W/20)+(This.W/50) , This.W/20 , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;5 , 5 , 20 , 20 , 3 
        Gdip_DeleteBrush( Brush )

        ;================Top Slide Border================
        Pen := Gdip_CreatePen( This.PSlide_Border_Color , (This.W/100)+(This.BorderWidth/2) )
        Gdip_DrawRoundedRectangle( G , Pen , ((This.W/10)+(This.W/5))+(This.W/20)+(This.W/50) , This.W/20 , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;5 , 5 , 20 , 20 , 5 
        Gdip_DeletePen( Pen )
        
        ;================Midle Slide================
        Brush := Gdip_BrushCreateSolid( This.PSlide_Color )
        Gdip_FillRoundedRectangle( G , Brush , ((This.W/10)+(This.W/5))+(This.W/20)+(This.W/50) , ((This.W/10)+(This.W/5))+(This.W/20) , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;37 , 35 , 20 , 20 , 3 
        Gdip_DeleteBrush( Brush )

        ;================Midle Slide Border================
        Pen := Gdip_CreatePen( This.PSlide_Border_Color , (This.W/100)+(This.BorderWidth/2) )
        Gdip_DrawRoundedRectangle( G , Pen , ((This.W/10)+(This.W/5))+(This.W/20)+(This.W/50) , ((This.W/10)+(This.W/5))+(This.W/20) , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;37 , 35 , 20 , 20 , 5 
        Gdip_DeletePen( Pen )
        
        ;================Bottum Slide================
        Brush := Gdip_BrushCreateSolid( This.PSlide_Color )
        Gdip_FillRoundedRectangle( G , Brush , ((This.W/10)+(This.W/5))+(This.W/20)+(This.W/50) , (This.W/2)+(This.W/10)+(This.W/20) , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;70 , 65 , 20 , 20 , 3 
        Gdip_DeleteBrush( Brush )

        ;================Bottum Slide Border================
        Pen := Gdip_CreatePen( This.PSlide_Border_Color , (This.W/100)+(This.BorderWidth/2) )
        Gdip_DrawRoundedRectangle( G , Pen , ((This.W/10)+(This.W/5))+(This.W/20)+(This.W/50) , (This.W/2)+(This.W/10)+(This.W/20) , This.W/5 , This.W/5 , (This.W/10)*(This.Slide_Radius/10) ) ;70 , 65 , 20 , 20 , 5 
        Gdip_DeletePen( Pen )

        This.Pressed_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
    }

    Draw_Pressed(){
		SetTimer,CTN_Hover_Function_Settings_Button,Off
		SetImage(This.hwnd, This.Pressed_Bitmap)
		While(GetKeyState("LButton"))
			Sleep,10

		SetTimer,CTN_Hover_Function_Settings_Button,On
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



; st_printArr(array, depth=5, indentLevel=""){
    ;     for k, v in Array
    ;     {
    ;         list.= indentLevel "[" k "]" ;first start building up each the key names
    ;         if (IsObject(v) && depth>1) ;is this "end" level? are there more levels?
    ;             list.="n" st_printArr(v, depth-1, indentLevel . "    ") ;yep the value is another object so we are not at the end level, start all over one level down this branch
    ;         Else
    ;             list.=" -> " v ;we reached the end of one branch! (or the final branch)
    ;     ; list.="n"
    ;         list:=rtrim(list, "rn t") "n" ;add a tab for the next indent level
    ;     }
    ;     return rtrim(list)
; }