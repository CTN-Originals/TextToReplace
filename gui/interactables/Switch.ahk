#SingleInstance, Force
#Include, gui/interactables/Gdip.ahk
; #Include, Gdip.ahk
; SendMode Input
; SetWorkingDir, %A_ScriptDir%

Gdip_Startup()

global CTN_Switch:=[]



; Create_Switch("x:=20", "y:=20", "w:=25", "OnTopColor:=007000")
; Create_Switch("x:=70", "y:=20", "w:=50", "OnTopColor:=007000")
; Create_Switch("x:=150", "y:=20", "w:=100", "OnTopColor:=007000")
; Create_Switch("x:=300", "y:=20", "w:=200", "OnTopColor:=007000")
; Create_Switch("x:=550", "y:=20", "w:=300", "OnTopColor:=007000")


; Gui, 1:Color, 003000
; Gui, 1:Show, w1000 h450
SetTimer, CTN_Hover_Function_Switch, 20
;return

Create_Switch(params*) {
    ;================DEFAULTS================
        x:=10,
        y:=10,
        w:=100,
        h:=100,

		switchState:=0,

    ;================Colors================
        ;================Normal Colors================
            Off_Color:="88FFFF",
            Off_Border_Color:="000000",
            Off_Slide_Color:="000040",
            Off_Slide_Border_Color:="000000",

            On_Color:="00FF00",
            On_Border_Color:="FFFFFF",
            On_Slide_Color:="000080",
            On_Slide_Border_Color:="FFFFFF",
        ;================Hover Colors================
            Off_Hover:="88FFFF",
            Off_Hover_Border:="000000",
            Off_HSlide_Color:="000080",
            Off_HSlide_Border_Color:="000000",

            On_Hover:="00FF00",
            On_Hover_Border:="FFFFFF",
            On_HSlide_Color:="0000FF",
            On_HSlide_Border_Color:="FFFFFF",
        ;================Pressed Colors================
            Off_Pressed:="88FFFF",
            Off_Pressed_Border:="FFFFFF",
            Off_PSlide_Color:="000080",
            Off_PSlide_Border_Color:="FFFFFF",

            On_Pressed:="00FF00",
            On_Pressed_Border:="000000",
            On_PSlide_Color:="0000FF",
            On_PSlide_Border_Color:="000000",
    ;================Style================
        Thickness:=2,
        Radius:=2,
        Slide_Radius:=3,
        BorderWidth:=2,
    ;================Options================
		SwitchState := 0,
        Window:=1,
        Label:="Void",
        Variable:=""
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
    
	;================Create================
	newSwitch := New Switch(x, y, w, h, switchState, Off_Color, Off_Border_Color, Off_Slide_Color, Off_Slide_Border_Color, On_Color, On_Border_Color, On_Slide_Color, On_Slide_Border_Color, Off_Hover, Off_Hover_Border, Off_HSlide_Color, Off_HSlide_Border_Color, On_Hover, On_Hover_Border, On_HSlide_Color, On_HSlide_Border_Color, Off_Pressed, Off_Pressed_Border, Off_PSlide_Color, Off_PSlide_Border_Color, On_Pressed, On_Pressed_Border, On_PSlide_Color, On_PSlide_Border_Color, Thickness, Radius, Slide_Radius, BorderWidth, Window, Label, Variable, ToolTip, OnTopColor)
    CTN_Switch.Push(newSwitch)
	return newSwitch
}

CTN_Hover_Function_Switch(){
	static Hover_On, Index
	MouseGetPos,,,,ctrl, 2
	if ( ! Hover_On && ctrl) {
		loop, % CTN_Switch.Length() {
			if (ctrl=CTN_Switch[A_Index].Hwnd) {
				CTN_Switch[A_Index].Draw_Hover()
				Hover_On:=1
				Index:=A_Index
				break
			}
		}	
	}
	else if (Hover_On)
		if ( ctrl != CTN_Switch[Index].Hwnd) {
			CTN_Switch[Index].Draw_Default()
			Hover_On:=0
		}
}






Class Switch {
	__New(x,y,w,h, switchState:=0 ,Off_Color:="",Off_Border_Color:="",Off_Slide_Color:="",Off_Slide_Border_Color:="",On_Color:="",On_Border_Color:="",On_Slide_Color:="",On_Slide_Border_Color:="",Off_Hover:="",Off_Hover_Border:="",Off_HSlide_Color:="",Off_HSlide_Border_Color:="",On_Hover:="",On_Hover_Border:="",On_HSlide_Color:="",On_HSlide_Border_Color:="",Off_Pressed:="",Off_Pressed_Border:="",Off_PSlide_Color:="",Off_PSlide_Border_Color:="",On_Pressed:="",On_Pressed_Border:="",On_PSlide_Color:="",On_PSlide_Border_Color:="",Thickness:="",Radius:="",Slide_Radius:="",BorderWidth:="",Window:="",Label:="",Variable:="",ToolTip:="",OnTopColor:=""){
		This.X:=x
		This.Y:=y
		This.W:=w
		This.H:= Ceil(This.W/3+((This.W/3/5*3)+(This.W/75)))

		This.SwitchState := switchState

		;========Color========
            This.Off_Color:= "0xFF" Off_Color
            This.Off_Border_Color:= "0xFF" Off_Border_Color
            This.Off_Slide_Color:= "0xFF" Off_Slide_Color
            This.Off_Slide_Border_Color:= "0xFF" Off_Slide_Border_Color

            This.On_Color:= "0xFF" On_Color
            This.On_Border_Color:= "0xFF" On_Border_Color
            This.On_Slide_Color:= "0xFF" On_Slide_Color
            This.On_Slide_Border_Color:= "0xFF" On_Slide_Border_Color
		;========Hover Color========
            This.Off_Hover:= "0xFF" Off_Hover
            This.Off_Hover_Border:= "0xFF" Off_Hover_Border
            This.Off_HSlide_Color:= "0xFF" Off_HSlide_Color
            This.Off_HSlide_Border_Color:= "0xFF" Off_HSlide_Border_Color

            This.On_Hover:= "0xFF" On_Hover
            This.On_Hover_Border:= "0xFF" On_Hover_Border
            This.On_HSlide_Color:= "0xFF" On_HSlide_Color
            This.On_HSlide_Border_Color:= "0xFF" On_HSlide_Border_Color
		;========Pressed Color========
            This.Off_Pressed:= "0xFF" Off_Pressed
            This.Off_Pressed_Border:= "0xFF" Off_Pressed_Border
            This.Off_PSlide_Color:= "0xFF" Off_PSlide_Color
            This.Off_PSlide_Border_Color:= "0xFF" Off_PSlide_Border_Color

            This.On_Pressed:= "0xFF" On_Pressed
            This.On_Pressed_Border:= "0xFF" On_Pressed_Border
            This.On_PSlide_Color:= "0xFF" On_PSlide_Color
            This.On_PSlide_Border_Color:= "0xFF" On_PSlide_Border_Color

		;========Style========
            This.Thickness:=Thickness
            This.Radius:=Radius
            This.Slide_Radius:=Slide_Radius
            This.BorderWidth:=BorderWidth
		;========Options========
			This.Window:=Window
			This.Label:=Label
            This.Variable:=Variable
            This.OnTopColor:= "0xFF" OnTopColor
            This.Tooltip := ToolTip
            This.ShowToolTip := ObjBindMethod(This, "ShowToolTipFunc") 

		;========Functions========
			This.Create_Trigger()
			This.Create_Default_Bitmap(SwitchState:=0)
			This.Create_Default_Bitmap(SwitchState:=1)
			This.Create_Hover_Bitmap(SwitchState:=0)
			This.Create_Hover_Bitmap(SwitchState:=1)
			This.Create_Pressed_Bitmap(SwitchState:=0)
			This.Create_Pressed_Bitmap(SwitchState:=1)

		sleep,20
		This.Draw_Default()
    }

    Create_Trigger(){
		Gui,% This.Window ": Add",Picture,  % "x" This.X " y" This.Y " w" This.W " h" This.H " hwndhwnd 0xE v" This.Variable
		This.Hwnd:=hwnd
		BPC:=This.Draw_Pressed.Bind(This)
		GuiControl,+G,% This.Hwnd,% BPC
        GuiControl, +BackgroundTrans, % This.Hwnd, % BPC
		if (This.Label){
			(IsFunc(This.Label))?(This.Function:=Func(This.Label),This.Type:="Function"):(This.Type:="Label")
		}
	}

    Create_Default_Bitmap(SwitchState) {
        if (This.H > 30) {
            pBitmap:=Gdip_CreateBitmap( This.W+2 , This.H+8 )
        }
	    else if (This.H <= 30) {
            pBitmap:=Gdip_CreateBitmap( This.W+2 , This.H*1.1 )
        }
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        ;================Background================
            Brush := Gdip_BrushCreateSolid( This.OnTopColor )
            if (This.H > 30) {
               Gdip_FillRectangle( G , Brush , -2 , -2 , This.W+8 , This.H*1.1 ) 
            }
            else if (This.H <= 30) {
                Gdip_FillRectangle( G , Brush , -2 , -2 , This.W+8 , This.H+8 )
            }
            Gdip_DeleteBrush( Brush )
        
        ;================SwitchBackgroundBorder================
            if (!SwitchState) {
                Pen := Gdip_CreatePen( This.Off_Border_Color , This.Thickness*(This.W/75/2) )
            }
            else if (SwitchState) {
                Pen := Gdip_CreatePen( This.On_Border_Color , This.Thickness*(This.W/75/2)/2 )
            }
            Gdip_DrawRoundedRectangle( G , Pen , This.W/3/10 , This.W/3/5 , This.W-(This.W/3/5) , This.W/3+((This.W/3/5)+(This.W/3/20)) , (This.W/3/10)+(This.W/6) ) ;50 , 40 , 300 , 120 , 40
            Gdip_DeletePen( Pen )

        ;================SwitchBackground================
            if (!SwitchState) {
                Brush := Gdip_BrushCreateSolid( This.Off_Color )
                Gdip_FillRoundedRectangle( G , Brush , This.W/3/10 , This.W/3/5 , This.W-(This.W/3/5) , This.W/3+((This.W/3/5)+(This.W/3/20)) , (This.W/3/10)+(This.W/6) ) ;50 , 40 , 300 , 120 , 40

            }
            else if (SwitchState) {
                Brush := Gdip_BrushCreateSolid( This.On_Color )
                Gdip_FillRoundedRectangle( G , Brush , This.W/3/10 , This.W/3/5 , This.W-(This.W/3/5) , This.W/3+((This.W/3/5)+(This.W/3/20)) , (This.W/3/10)+(This.W/6) ) ;50 , 40 , 300 , 120 , 40
            }
            Gdip_DeleteBrush( Brush )

        ;================SlideBorder================
            if (!SwitchState) {
                if (This.W <= 50) {
                    Pen := Gdip_CreatePen( This.Off_Slide_Border_Color , This.Thickness*(This.W/75/2)*4 )
                }
                else {
                    Pen := Gdip_CreatePen( This.Off_Slide_Border_Color , This.Thickness*(This.W/75/2) )
                }
                Gdip_DrawRoundedRectangle( G , Pen , This.W/75 , This.W/75 , (This.W/3)+((This.W/3/10)+(This.W/6)) , (This.W/3)+((This.W/3/10)+(This.W/6)) , This.W/5 ) ;40 , 30 , 140 , 140 , 60
            }
            else if (SwitchState) {
                if (This.W <= 50) {
                    Pen := Gdip_CreatePen( This.On_Slide_Border_Color , This.Thickness*(This.W/75/2)*4 )
                }
                else {
                    Pen := Gdip_CreatePen( This.On_Slide_Border_Color , This.Thickness*(This.W/75/2)/2 )
                }
                Gdip_DrawRoundedRectangle( G , Pen , (This.W-(This.W/75))-((This.W/5)+(This.W/3)) , This.W/75 , (This.W/3)+((This.W/3/10)+(This.W/6)) , (This.W/3)+((This.W/3/10)+(This.W/6)) , This.W/5 ) ;40 , 30 , 140 , 140 , 60
            }
            Gdip_DeletePen( Pen )

        ;================Slide================
            if (!SwitchState) {
                Brush := Gdip_BrushCreateSolid( This.Off_Slide_Color )
                Gdip_FillRoundedRectangle( G , Brush , This.W/75 , This.W/75 , (This.W/3)+((This.W/3/10)+(This.W/6)) , (This.W/3)+((This.W/3/10)+(This.W/6)) , This.W/5 ) ;40 , 30 , 140 , 140 , 60

            }
            else if (SwitchState) {
                Brush := Gdip_BrushCreateSolid( This.On_Slide_Color )
                Gdip_FillRoundedRectangle( G , Brush , (This.W-(This.W/75))-((This.W/5)+(This.W/3)) , This.W/75 , (This.W/3)+((This.W/3/10)+(This.W/6)) , (This.W/3)+((This.W/3/10)+(This.W/6)) , This.W/5 ) ;40 , 30 , 140 , 140 , 60

            }
            Gdip_DeleteBrush( Brush )

        Gdip_DeleteGraphics( G )
        if (!SwitchState) {
            This.Default_Bitmap_Off:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
        }
        else if (SwitchState) {
            This.Default_Bitmap_On:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
        }
		Gdip_DisposeImage(pBitmap)
    }

    Create_Hover_Bitmap(SwitchState) {
	    if (This.H > 30) {
            pBitmap:=Gdip_CreateBitmap( This.W+2 , This.H+8 )
        }
	    else if (This.H <= 30) {
            pBitmap:=Gdip_CreateBitmap( This.W+2 , This.H*1.1 )
        }
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        ;================Background================
            Brush := Gdip_BrushCreateSolid( This.OnTopColor )
            if (This.H > 30) {
               Gdip_FillRectangle( G , Brush , -2 , -2 , This.W+8 , This.H*1.1 ) 
            }
            else if (This.H <= 30) {
                Gdip_FillRectangle( G , Brush , -2 , -2 , This.W+8 , This.H+8 )
            }
            Gdip_DeleteBrush( Brush )
        
        ;================SwitchBackgroundBorder================
            if (!SwitchState) {
                Pen := Gdip_CreatePen( This.Off_Hover_Border , This.Thickness*(This.W/75/2) )
            }
            else if (SwitchState) {
                Pen := Gdip_CreatePen( This.On_Hover_Border , This.Thickness*(This.W/75/2) )
            }
            Gdip_DrawRoundedRectangle( G , Pen , This.W/3/10 , This.W/3/5 , This.W-(This.W/3/5) , This.W/3+((This.W/3/5)+(This.W/3/20)) , (This.W/3/10)+(This.W/6) ) ;50 , 40 , 300 , 120 , 40
            Gdip_DeletePen( Pen )

        ;================SwitchBackground================
            if (!SwitchState) {
                Brush := Gdip_BrushCreateSolid( This.Off_Hover )
                Gdip_FillRoundedRectangle( G , Brush , This.W/3/10 , This.W/3/5 , This.W-(This.W/3/5) , This.W/3+((This.W/3/5)+(This.W/3/20)) , (This.W/3/10)+(This.W/6) ) ;50 , 40 , 300 , 120 , 40

            }
            else if (SwitchState) {
                Brush := Gdip_BrushCreateSolid( This.On_Hover )
                Gdip_FillRoundedRectangle( G , Brush , This.W/3/10 , This.W/3/5 , This.W-(This.W/3/5) , This.W/3+((This.W/3/5)+(This.W/3/20)) , (This.W/3/10)+(This.W/6) ) ;50 , 40 , 300 , 120 , 40
            }
            Gdip_DeleteBrush( Brush )

        ;================SlideBorder================
            if (!SwitchState) {
                Pen := Gdip_CreatePen( This.Off_HSlide_Border_Color , This.Thickness*(This.W/75/1.5) )
                Gdip_DrawRoundedRectangle( G , Pen , This.W/75 , This.W/75 , (This.W/3)+((This.W/3/10)+(This.W/6)) , (This.W/3)+((This.W/3/10)+(This.W/6)) , This.W/5 ) ;40 , 30 , 140 , 140 , 60
            }
            else if (SwitchState) {
                Pen := Gdip_CreatePen( This.On_HSlide_Border_Color , This.Thickness*(This.W/75/1.5) )
                Gdip_DrawRoundedRectangle( G , Pen , (This.W-(This.W/75))-((This.W/5)+(This.W/3)) , This.W/75 , (This.W/3)+((This.W/3/10)+(This.W/6)) , (This.W/3)+((This.W/3/10)+(This.W/6)) , This.W/5 ) ;40 , 30 , 140 , 140 , 60
            }
            Gdip_DeletePen( Pen )

        ;================Slide================
            if (!SwitchState) {
                Brush := Gdip_BrushCreateSolid( This.Off_HSlide_Color )
                Gdip_FillRoundedRectangle( G , Brush , This.W/75 , This.W/75 , (This.W/3)+((This.W/3/10)+(This.W/6)) , (This.W/3)+((This.W/3/10)+(This.W/6)) , This.W/5 ) ;40 , 30 , 140 , 140 , 60

            }
            else if (SwitchState) {
                Brush := Gdip_BrushCreateSolid( This.On_HSlide_Color )
                Gdip_FillRoundedRectangle( G , Brush , (This.W-(This.W/75))-((This.W/5)+(This.W/3)) , This.W/75 , (This.W/3)+((This.W/3/10)+(This.W/6)) , (This.W/3)+((This.W/3/10)+(This.W/6)) , This.W/5 ) ;40 , 30 , 140 , 140 , 60

            }
            Gdip_DeleteBrush( Brush )
        
        Gdip_DeleteGraphics( G )
        if (!SwitchState) {
            This.Hover_Bitmap_Off:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
            
        }
        else if (SwitchState) {
            This.Hover_Bitmap_On:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
        }
        
		Gdip_DisposeImage(pBitmap)
    }

    Create_Pressed_Bitmap(SwitchState) {
	    if (This.H > 30) {
            pBitmap:=Gdip_CreateBitmap( This.W+2 , This.H+8 )
        }
	    else if (This.H <= 30) {
            pBitmap:=Gdip_CreateBitmap( This.W+2 , This.H*1.1 )
        }
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        ;================Background================
            Brush := Gdip_BrushCreateSolid( This.OnTopColor )
            if (This.H > 30) {
               Gdip_FillRectangle( G , Brush , -2 , -2 , This.W+8 , This.H*1.1 ) 
            }
            else if (This.H <= 30) {
                Gdip_FillRectangle( G , Brush , -2 , -2 , This.W+8 , This.H+8 )
            }
            Gdip_DeleteBrush( Brush )
        
        ;================SwitchBackgroundBorder================
            if (!SwitchState) {
                Pen := Gdip_CreatePen( This.Off_Pressed_Border , This.Thickness*(This.W/75/2) )
            }
            else if (SwitchState) {
                Pen := Gdip_CreatePen( This.On_Pressed_Border , This.Thickness*(This.W/75/2) )
            }
            Gdip_DrawRoundedRectangle( G , Pen , This.W/3/10 , This.W/3/5 , This.W-(This.W/3/5) , This.W/3+((This.W/3/5)+(This.W/3/20)) , (This.W/3/10)+(This.W/6) ) ;50 , 40 , 300 , 120 , 40
            Gdip_DeletePen( Pen )

        ;================SwitchBackground================
            if (!SwitchState) {
                Brush := Gdip_BrushCreateSolid( This.Off_Pressed )
                Gdip_FillRoundedRectangle( G , Brush , This.W/3/10 , This.W/3/5 , This.W-(This.W/3/5) , This.W/3+((This.W/3/5)+(This.W/3/20)) , (This.W/3/10)+(This.W/6) ) ;50 , 40 , 300 , 120 , 40

            }
            else if (SwitchState) {
                Brush := Gdip_BrushCreateSolid( This.On_Pressed )
                Gdip_FillRoundedRectangle( G , Brush , This.W/3/10 , This.W/3/5 , This.W-(This.W/3/5) , This.W/3+((This.W/3/5)+(This.W/3/20)) , (This.W/3/10)+(This.W/6) ) ;50 , 40 , 300 , 120 , 40
            }
            Gdip_DeleteBrush( Brush )

        ;================SlideBorder================
            if (!SwitchState) {
                Pen := Gdip_CreatePen( This.Off_PSlide_Border_Color , This.Thickness*(This.W/75/2) )
                Gdip_DrawRoundedRectangle( G , Pen , This.W/75 , This.W/75 , (This.W/3)+((This.W/3/10)+(This.W/6)) , (This.W/3)+((This.W/3/10)+(This.W/6)) , This.W/5 ) ;40 , 30 , 140 , 140 , 60
            }
            else if (SwitchState) {
                Pen := Gdip_CreatePen( This.On_PSlide_Border_Color , This.Thickness*(This.W/75/2) )
                Gdip_DrawRoundedRectangle( G , Pen , (This.W-(This.W/75))-((This.W/5)+(This.W/3)) , This.W/75 , (This.W/3)+((This.W/3/10)+(This.W/6)) , (This.W/3)+((This.W/3/10)+(This.W/6)) , This.W/5 ) ;40 , 30 , 140 , 140 , 60
            }
            Gdip_DeletePen( Pen )

        ;================Slide================
            if (!SwitchState) {
                Brush := Gdip_BrushCreateSolid( This.Off_PSlide_Color )
                Gdip_FillRoundedRectangle( G , Brush , This.W/75 , This.W/75 , (This.W/3)+((This.W/3/10)+(This.W/6)) , (This.W/3)+((This.W/3/10)+(This.W/6)) , This.W/5 ) ;40 , 30 , 140 , 140 , 60

            }
            else if (SwitchState) {
                Brush := Gdip_BrushCreateSolid( This.On_PSlide_Color )
                Gdip_FillRoundedRectangle( G , Brush , (This.W-(This.W/75))-((This.W/5)+(This.W/3)) , This.W/75 , (This.W/3)+((This.W/3/10)+(This.W/6)) , (This.W/3)+((This.W/3/10)+(This.W/6)) , This.W/5 ) ;40 , 30 , 140 , 140 , 60

            }
            Gdip_DeleteBrush( Brush )
        
        Gdip_DeleteGraphics( G )
        if (!SwitchState) {
            This.Pressed_Bitmap_Off:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
        }
        else if (SwitchState) {
            This.Pressed_Bitmap_On:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
        }
        
		Gdip_DisposeImage(pBitmap)
    }

    Draw_Pressed(){
		SetTimer,CTN_Hover_Function_Switch,Off
        if (!This.SwitchState) {
            SetImage(This.hwnd, This.Pressed_Bitmap_Off)
        }
		else if (This.SwitchState) {
            SetImage(This.hwnd, This.Pressed_Bitmap_On)
        }
		While(GetKeyState("LButton"))
			Sleep,10

		SetTimer,CTN_Hover_Function_Switch,On
		MouseGetPos,,,,ctrl,2

		if (ctrl=This.Hwnd) {
            if (!This.SwitchState) {
                This.SwitchState := 1
            }
            else if (This.SwitchState) {
                This.SwitchState := 0
            }
			This.Draw_Hover()

			if (This.Type="Function") {
				This.Function.Call()
			}

			else if (This.Type:="Label") {
				gosub,% This.Label
			}
		}

		else {
			This.Draw_Default()
		}
	}

    Draw_Hover(){
        if (!This.SwitchState) {
            SetImage(This.hwnd, This.Hover_Bitmap_Off)
            
        }
		else if (This.SwitchState) {
            SetImage(This.hwnd, This.Hover_Bitmap_On)
        }
        if (This.ToolTip != "") {
            ShowToolTip := This.ShowToolTip
            SetTimer, % ShowToolTip, 50
        }
	}
    Draw_Default(){
        if (!This.SwitchState) {
            SetImage(This.hwnd, This.Default_Bitmap_Off)
        }
		else if (This.SwitchState) {
            SetImage(This.hwnd, This.Default_Bitmap_On)
        }
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

; SwitchState:
;     if (!SwitchState) {
;         Global SwitchState := 1
;     }
;     else if (SwitchState) {
;         Global SwitchState := 0
;     }
; return

; Switch:

; return

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