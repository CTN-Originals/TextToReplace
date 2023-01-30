#SingleInstance, Force
#Include, Included/gui/interactables/Gdip.ahk
SendMode Input
SetWorkingDir, %A_ScriptDir%

Gdip_Startup()

global CTN_Close_Button:=[]

; Create_Close_Button("x:=20", "y:=20", "w:=20", "h:=20")
; Create_Close_Button("x:=60", "y:=20", "w:=40", "h:=40")
; Create_Close_Button("x:=120", "y:=20", "w:=80", "h:=80")
; Create_Close_Button("x:=220", "y:=20", "w:=160", "h:=160")
; Create_Close_Button("x:=420", "y:=20", "w:=320", "h:=320")


; Gui, 1:Color, green
; Gui, 1:Show, w800 h400
SetTimer, CTN_Hover_Function_Close, 20
; return


Create_Close_Button(params*) {
    ;================DEFAULTS================
        x:=10,
        y:=10,
        w:=100,
        h:=40,

        ;================Colors================
            ;================Normal Colors================
                Color1:="FF0000",
                Color2:="050068",

                OutBorder_C1:="FFFFFF",
                OutBorder_C2:="6D6D6D",

                InBorder_C1:="6D6D6D",
                InBorder_C2:="FFFFFF",

                InShadow_C1:="0x00FFFFFF"
                InShadow_C2:="0x00000000"

                OutShadow_C1:="0x00000000"
                OutShadow_C2:="0x00FFFFFF"

                Cross_Shadow_Off:="0x00000000"

            ;================Hover Colors================
                Hover_C1:="FF3900",
                Hover_C2:="050068",

                Hover_OutBorder_C1:="6D6D6D",
                Hover_OutBorder_C2:="FFFFFF",

                Hover_InBorder_C1:="FFFFFF",
                Hover_InBorder_C2:="6D6D6D",

            ;================Pressed Colors================
                Pressed_C1:="FF8E00",
                Pressed_C2:="00FF08",

                Pressed_OutBorder_C1:="000000",
                Pressed_OutBorder_C2:="050068",

                Pressed_InBorder_C1:="000000",
                Pressed_InBorder_C2:="00FFFF",
        
        ;================Text================
            Text:="Button",
            Font:="Impact",
            Font_Size:="16",
            Font_Color_Top:="FFFFFF",
            Font_Color_Bottom:="000000",

        ;================Style================
            Border_Width:=20
            Radius:=10

        ;================Options================
            Window:=1,
            Label:="CloseButton",
            BakcgroundColor:="",

    for index, param in params {
        ParamObj := StrSplit(param, ":=")
        Var := ParamObj[1]
        %Var% := ParamObj[2]
    }

    CTN_Close_Button.Push(New Close_Button(x, y, w, h, Color1, Color2, OutBorder_C1, OutBorder_C2, InBorder_C1, InBorder_C2, InShadow_C1, InShadow_C2, OutShadow_C1, OutShadow_C2, Cross_Shadow_Off, Hover_C1, Hover_c2, Hover_OutBorder_C1, Hover_OutBorder_C2, Hover_InBorder_C1, Hover_InBorder_C2, Pressed_C1, Pressed_C2, Pressed_OutBorder_C1, Pressed_OutBorder_C2, Pressed_InBorder_C1, Pressed_InBorder_C2,  Text, Font, Font_Size, Font_Color_Top, Font_Color_Bottom,  Window, Label, Radius, Border_Width, BakcgroundColor))
}


CTN_Hover_Function_Close(){
	static Hover_On, Index
	MouseGetPos,,,,ctrl, 2
	if ( ! Hover_On && ctrl) {
		loop, % CTN_Close_Button.Length() {
			if (ctrl=CTN_Close_Button[A_Index].Hwnd) {
				CTN_Close_Button[A_Index].Draw_Hover()
				Hover_On:=1
				Index:=A_Index
				break
			}
		}	
	}
	else if (Hover_On)
		if ( ctrl != CTN_Close_Button[Index].Hwnd) {
			CTN_Close_Button[Index].Draw_Default()
			Hover_On:=0
		}
}


Class Close_Button {

    __New(x:=10, y:=10, w:=100, h:=40, Color1:="0000FF", Color2:="050068", OutBorder_C1:="050068", OutBorder_C2:="0000FF", InBorder_C1:="0080FF", InBorder_C2:="003060", InShadow_C1:="0x00FFFFFF", InShadow_C2:="0xFF000000", OutShadow_C1:="0xFF000000", OutShadow_C2:="0x00FFFFFF", Cross_Shadow_Off:="0x00000000", Hover_C1:="050068", Hover_C2:="0000FF", Hover_OutBorder_C1:="0000FF", Hover_OutBorder_C2:="050068", Hover_InBorder_C1:="003060", Hover_InBorder_C2:="0080FF", Pressed_C1:="006000", Pressed_C2:="00FF08", Pressed_OutBorder_C1:="0080FF", Pressed_OutBorder_C2:="050068", Pressed_InBorder_C1:="005050", Pressed_InBorder_C2:="00FFFF", Text:="Button", Font:="Impact", Font_Size:="16", Font_Color_Top:="FFFFFF", Font_Color_Bottom:="000000", Window:="1", Label:="CloseButton", Radius:=2, Border_Width:=4, BakcgroundColor:=""){
		
        This.X:=x
		This.Y:=y
		This.W:=w
		This.H:=h

		This.TextY:=TextY

		;========Color========
			This.Color1:= "0x00" Color1
			This.Color2:= "0x00" Color2
			This.OutBorder_C1:= "0x00" OutBorder_C1
			This.OutBorder_C2:= "0x00" OutBorder_C2
			This.InBorder_C1:= "0x00" InBorder_C1
			This.InBorder_C2:= "0x00" InBorder_C2

            This.InShadow_C1:=InShadow_C1
            This.InShadow_C2:=InShadow_C2
            This.OutShadow_C1:=OutShadow_C1
            This.OutShadow_C2:=OutShadow_C2

            Cross_Shadow_Off:=Cross_Shadow_Off

		;========Hover Color========
			This.Hover_C1:= "0x00" Hover_C1
			This.Hover_C2:= "0x00" Hover_C2
			This.Hover_OutBorder_C1:= "0x00" Hover_OutBorder_C1
			This.Hover_OutBorder_C2:= "0x00" Hover_OutBorder_C2
			This.Hover_InBorder_C1:= "0x00" Hover_InBorder_C1
			This.Hover_InBorder_C2:= "0x00" Hover_InBorder_C2

		;========Pressed Color========
			This.Pressed_C1:= "0x00" Pressed_C1
			This.Pressed_C2:= "0x00" Pressed_C2
			This.Pressed_OutBorder_C1:= "0x00" Pressed_OutBorder_C1
			This.Pressed_OutBorder_C2:= "0x00" Pressed_OutBorder_C2
			This.Pressed_InBorder_C1:= "0x00" Pressed_InBorder_C1
			This.Pressed_InBorder_C2:= "0x00" Pressed_InBorder_C2

        ;========Text========
			This.Text:=Text
			This.Font:=Font
			This.Font_Size:=Font_Size
			This.Font_Color_Top:= "0x00" Font_Color_Top
			This.Font_Color_Bottom:= "0x00" Font_Color_Bottom

		;========Options========
			This.Window:=Window
			This.Label:=Label
            This.BackgroundColor:=BackgroundColor

			This.Radius:=Radius
			This.Border_Width:=Border_Width

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
        WinSet, TransColor, "0xFF0000A0", This.Window
		if (This.Label){
			(IsFunc(This.Label))?(This.Function:=Func(This.Label),This.Type:="Function"):(This.Type:="Label")
		}
	}

    Create_Default_Bitmap() {
	    pBitmap:=Gdip_CreateBitmap( This.W*1.12 , This.H*1.12 )
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        Brush := Gdip_BrushCreateSolid( This.BackgroundColor )
		Gdip_FillRectangle( G , Brush , 2 , 2 , This.W+2, This.H+2)
		Gdip_DeleteBrush( Brush )

        ;================Bakcground================
        Brush := Gdip_BrushCreateSolid( This.Color1 )
        Gdip_FillRectangle( G , Brush , This.W/40 , This.W/40 , This.W*1.2 , This.H*1.2 )
        Gdip_DeleteBrush( Brush )

        ;================In Shadow================
        Pen := Gdip_CreatePen( This.InShadow_C1 , This.W/20 )
        Gdip_DrawLines( G , Pen , This.W+(This.W/20) " ,5|5,5|5," This.H+(This.H/20) " |" )
        Gdip_DeletePen( Pen )

        ;================Out Shadow================
        Pen := Gdip_CreatePen( This.OutShadow_C1 , This.W/20 )
        Gdip_DrawLines( G , Pen , This.W+(This.W/10) " ,2|" This.W+(This.W/10) " ," This.H+(This.H/10) " |2," This.H+(This.H/10) " |" )
        Gdip_DeletePen( Pen )

        ;================Top Border================
        Pen := Gdip_CreatePen( This.OutBorder_C1 , This.W/26.6 )
        Gdip_DrawLines( G , Pen , This.W+(This.W/13.33) " ,2|2,2|2," This.W+(This.H/13.33) " |" )
        Gdip_DeletePen( Pen )

        ;================Bottum Border================
        Pen := Gdip_CreatePen( This.InBorder_C1 , This.W/26.6 )
        Gdip_DrawLines( G , Pen , This.W+(This.W/13.33) " ,2|" This.W+(This.W/13.33) " ,"This.H+(This.H/13.33) " |2," This.H+(This.H/13.33) " |" )
        Gdip_DeletePen( Pen )

        ;================Cross Shadow 1================
        Pen := Gdip_CreatePen( "0xFF000000" , This.W/8 )
        Gdip_DrawLine( G , Pen , This.W/4 , This.W/4 , This.H-(This.H/13.33) , This.H-(This.H/13.33) )
        Gdip_DeletePen( Pen )

        ;================Cross Shadow 2================
        Pen := Gdip_CreatePen( "0xFF000000" , This.W/8 )
        Gdip_DrawLine( G , Pen , This.W-(This.W/13.33) , This.W/3.33 , This.H/3.33 , This.H-(This.H/13.33) )
        Gdip_DeletePen( Pen )

        ;================Cross 1================
        Pen := Gdip_CreatePen( "0xFFFFFFFF" , This.W/8 )
        Gdip_DrawLine( G , Pen , This.W/4 , This.W/4 , This.H-(This.H/8) , This.H-(This.H/8) )
        Gdip_DeletePen( Pen )

        ;================Cross 2================
        Pen := Gdip_CreatePen( "0xFFFFFFFF" , This.W/8 )
        Gdip_DrawLine( G , Pen , This.W-(This.W/8) , This.W/4 , This.H/4 , This.H-(This.H/8) )
        Gdip_DeletePen( Pen )
        Gdip_DeleteGraphics( G )

        This.Default_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
    }

    Create_Hover_Bitmap() {
	    pBitmap:=Gdip_CreateBitmap( This.W*1.10 , This.H*1.10 )
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        Brush := Gdip_BrushCreateSolid( This.BackgroundColor )
		Gdip_FillRectangle( G , Brush , This.W/20 , This.W/20 , This.W+4, This.H+4)
		Gdip_DeleteBrush( Brush )

        ;================Bakcground================
        Brush := Gdip_BrushCreateSolid( This.Hover_C1 )
        Gdip_FillRectangle( G , Brush , This.W/40 , This.W/40 , This.W*1.2 , This.H*1.2 )
        Gdip_DeleteBrush( Brush )

        ;================In Shadow================
        Pen := Gdip_CreatePen( This.InShadow_C2 , This.W/12 )
        Gdip_DrawLines( G , Pen , This.W+(This.W/20) " ,4|4,4|4," This.H+(This.H/20) " |" )
        Gdip_DeletePen( Pen )

        ;================Out Shadow================
        Pen := Gdip_CreatePen( This.OutShadow_C2 , This.W/20 )
        Gdip_DrawLines( G , Pen , This.W+(This.W/10) " ,2|" This.W+(This.W/10) " ," This.H+(This.H/10) " |2," This.H+(This.H/10) " |" )
        Gdip_DeletePen( Pen )

        ;================Top Border================
        Pen := Gdip_CreatePen( This.OutBorder_C2 , This.W/26.6 )
        Gdip_DrawLines( G , Pen , This.W+(This.W/13.33) " ,2|2,2|2," This.W+(This.H/13.33) " |" )
        Gdip_DeletePen( Pen )

        ;================Bottum Border================
        Pen := Gdip_CreatePen( This.InBorder_C2 , This.W/26.6 )
        Gdip_DrawLines( G , Pen , This.W+(This.W/13.33) " ,2|" This.W+(This.W/13.33) " ,"This.H+(This.H/13.33) " |2," This.H+(This.H/13.33) " |" )
        Gdip_DeletePen( Pen )

        ;================Cross Shadow 1================
        Pen := Gdip_CreatePen( This.Cross_Shadow_Off , This.W/8 )
        Gdip_DrawLine( G , Pen , This.W/4 , This.W/4 , This.H-(This.H/13.33) , This.H-(This.H/13.33) )
        Gdip_DeletePen( Pen )

        ;================Cross Shadow 2================
        Pen := Gdip_CreatePen( This.Cross_Shadow_Off , This.W/8 )
        Gdip_DrawLine( G , Pen , This.W-(This.W/13.33) , This.W/3.33 , This.H/3.33 , This.H-(This.H/13.33) )
        Gdip_DeletePen( Pen )

        ;================Cross 1================
        Pen := Gdip_CreatePen( "0xFFFF0000" , This.W/8 )
        Gdip_DrawLine( G , Pen , This.W/4 , This.W/4 , This.H-(This.H/8) , This.H-(This.H/8) )
        Gdip_DeletePen( Pen )

        ;================Cross 2================
        Pen := Gdip_CreatePen( "0xFFFF0000" , This.W/8 )
        Gdip_DrawLine( G , Pen , This.W-(This.W/8) , This.W/4 , This.H/4 , This.H-(This.H/8) )
        Gdip_DeletePen( Pen )
        Gdip_DeleteGraphics( G )

        This.Hover_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
    }

    Create_Pressed_Bitmap() {
	    pBitmap:=Gdip_CreateBitmap( This.W*1.10 , This.H*1.10 )
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        Brush := Gdip_BrushCreateSolid( This.BackgroundColor )
		Gdip_FillRectangle( G , Brush , This.W/20 , This.W/20 , This.W+4, This.H+4)
		Gdip_DeleteBrush( Brush )

        ;================Bakcground================
        Brush := Gdip_BrushCreateSolid( This.Pressed_C1 )
        Gdip_FillRectangle( G , Brush , This.W/40 , This.W/40 , This.W*1.2 , This.H*1.2 )
        Gdip_DeleteBrush( Brush )

        ;================In Shadow================
        Pen := Gdip_CreatePen( This.Pressed_InShadow , This.W/20 )
        Gdip_DrawLines( G , Pen , This.W+(This.W/20) " ,5|5,5|5," This.H+(This.H/20) " |" )
        Gdip_DeletePen( Pen )

        ;================Out Shadow================
        Pen := Gdip_CreatePen( This.Pressed_OutShadow , This.W/20 )
        Gdip_DrawLines( G , Pen , This.W+(This.W/10) " ,2|" This.W+(This.W/10) " ," This.H+(This.H/10) " |2," This.H+(This.H/10) " |" )
        Gdip_DeletePen( Pen )

        ;================Top Border================
        Pen := Gdip_CreatePen( This.Pressed_OutBorder_C1 , This.W/26.6 )
        Gdip_DrawLines( G , Pen , This.W+(This.W/13.33) " ,2|2,2|2," This.W+(This.H/13.33) " |" )
        Gdip_DeletePen( Pen )

        ;================Bottum Border================
        Pen := Gdip_CreatePen( This.Pressed_InBorder_C1 , This.W/26.6 )
        Gdip_DrawLines( G , Pen , This.W+(This.W/13.33) " ,2|" This.W+(This.W/13.33) " ,"This.H+(This.H/13.33) " |2," This.H+(This.H/13.33) " |" )
        Gdip_DeletePen( Pen )

        ;================Cross Shadow 1================
        Pen := Gdip_CreatePen( This.Cross_Shadow_Off , This.W/8 )
        Gdip_DrawLine( G , Pen , This.W/4 , This.W/4 , This.H-(This.H/13.33) , This.H-(This.H/13.33) )
        Gdip_DeletePen( Pen )

        ;================Cross Shadow 2================
        Pen := Gdip_CreatePen( This.Cross_Shadow_Off , This.W/8 )
        Gdip_DrawLine( G , Pen , This.W-(This.W/13.33) , This.W/3.33 , This.H/3.33 , This.H-(This.H/13.33) )
        Gdip_DeletePen( Pen )

        ;================Cross 1================
        Pen := Gdip_CreatePen( "0xFF800000" , This.W/8 )
        Gdip_DrawLine( G , Pen , This.W/4 , This.W/4 , This.H-(This.H/8) , This.H-(This.H/8) )
        Gdip_DeletePen( Pen )

        ;================Cross 2================
        Pen := Gdip_CreatePen( "0xFF800000" , This.W/8 )
        Gdip_DrawLine( G , Pen , This.W-(This.W/8) , This.W/4 , This.H/4 , This.H-(This.H/8) )
        Gdip_DeletePen( Pen )
        Gdip_DeleteGraphics( G )

        This.Pressed_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
    }

    Draw_Pressed(){
		SetTimer,CTN_Hover_Function_Close,Off
		SetImage(This.hwnd, This.Pressed_Bitmap)
		While(GetKeyState("LButton"))
			Sleep,10

		SetTimer,CTN_Hover_Function_Close,On
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