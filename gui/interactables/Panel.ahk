#SingleInstance, Force
#Include, gui/interactables/Gdip.ahk
; #Include, Gdip.ahk
; SendMode Input
; SetWorkingDir, %A_ScriptDir%

Gdip_Startup()

global CTN_Panel:=[]

; Create_Panel("x:=20", "y:=20", "w:=25", "h:=25", "Title:=Header Title", "OnTopColor:=007000")
; Create_Panel("x:=70", "y:=20", "w:=50", "h:=50", "Title:=Header Title", "OnTopColor:=007000")
; Create_Panel("x:=150", "y:=20", "w:=100", "h:=100", "Title:=Header Title", "OnTopColor:=007000")
; Create_Panel("x:=300", "y:=20", "w:=200", "h:=200", "Title:=Header Title", "OnTopColor:=007000")
; Create_Panel("x:=550", "y:=20", "w:=400", "h:=400", "Title:=Header Title", "OnTopColor:=007000")

; Create_Panel("x:=20", "y:=500", "w:=200", "h:=100", "Title:=Header Title", "OnTopColor:=007000")

; Create_Panel("x:=240", "y:=500", "w:=300", "h:=180", "Title:=Header Title", "OnTopColor:=007000")

; Gui, 1:Font, s20 cWhite, Impact
; Gui, 1:Add, Text, x550 y20 w400 h80 Center 0x200 BackgroundTrans, Header Text Here!

; Gui, 1:Color, 007000
; Gui, 1:Show, w1000 h800

; SetTimer, CTN_Hover_Function_Panel, 20 ; 
;return
Create_Panel(params*) {
    ;================DEFAULTS================
        x:=10,
        y:=10,
        w:=100,
        h:=100,

        HeaderHeight:=20
        FooterHeight:=20

    ;================Colors================
        ;================Normal Colors================
            Color1:="000080",
            HeaderColor:="000040",
            PanelFooterColor:="0000FF",
            Border_Color1:="0000FF",

            Color2:="",
            Border_Color2:="",
        ;================Hover Colors================
            HColor1:="000040",
            HHeaderColor:="000040",
            HPanelFooterColor:="0000FF",
            HColor_Border1:="000040",

            HColor2:="",
            HColor_Border2:="",
        ;================Pressed Colors================
            PColor1:="000080",
            PHeaderColor:="000040",
            PPanelFooterColor:="0000FF",
            PColor_Border1:="00FF00",

            PColor2:="",
            PColor_Border2:="",
    ;================Style================
        Radius:=2,
        Border_Radius:=2,
        BorderWidth:=2,
        Border:="False"
        Header:="True"
        Footer:="True"
        HeaderBottumRadius:="False"
        FooterTopRadius:="False"
    ;================Options================
        Hover:="False"
        Pressed:="False"
        HeaderHover:="Fasle"
        HeaderPressed:="Fasle"
        FooterHover:="Fasle"
        FooterPressed:="Fasle"

        Title:=""
        FontColor:="FFFFFF"
        Font:="Impact"
        FontSize:=12

        Window:=1,
        Label:="",
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
    
    CTN_Panel.Push(New Panel(x, y, w, h, HeaderHeight, FooterHeight, Color1, HeaderColor, PanelFooterColor, Border_Color1, Color2, Border_Color2, HColor1, HHeaderColor, HPanelFooterColor, HColor_Border1, HColor2, HColor_Border2, PColor1, PHeaderColor, PPanelFooterColor, PColor_Border1, PColor2, PColor_Border2, Radius, Border_Radius, BorderWidth, Border, Header, Footer, HeaderBottumRadius, FooterTopRadius, Hover, Pressed, HeaderHover, HeaderPressed, FooterHover, FooterPressed, Title, FontColor, Font, FontSize, Window, Label, Variable, ToolTip, OnTopColor))
}




CTN_Hover_Function_Panel(){
	static Hover_On, Index
	MouseGetPos,,,,ctrl, 2
	if ( ! Hover_On && ctrl) {
		loop, % CTN_Panel.Length() {
			if (ctrl=CTN_Panel[A_Index].Hwnd) {
				CTN_Panel[A_Index].Draw_Hover()
				Hover_On:=1
				Index:=A_Index
				break
			}
		}	
	}
	else if (Hover_On)
		if ( ctrl != CTN_Panel[Index].Hwnd) {
			CTN_Panel[Index].Draw_Default()
			Hover_On:=0
		}
}


Class Panel {
    __New(x,y,w,h,HeaderHeight,FooterHeight,Color1:="",HeaderColor:="",PanelFooterColor:="",Border_Color1:="",Color2:="",Border_Color2:="",HColor1:="",HHeaderColor:="",HPanelFooterColor:="",HColor_Border1:="",HColor2:="",HColor_Border2:="",PColor1:="",PHeaderColor:="",PPanelFooterColor:="",PColor_Border1:="",PColor2:="",PColor_Border2:="",Radius:="",Border_Radius:="",BorderWidth:="",Border:="",Header:="",Footer:="",HeaderBottumRadius:="",FooterTopRadius:="",Hover:="",Pressed:="",HeaderHover:="",HeaderPressed:="",FooterHover:="",FooterPressed:="",Title:="",FontColor:="",Font:="",FontSize:="",Window:="",Label:="",Variable:="",ToolTip:="",OnTopColor:=""){
        This.X:=x
		This.Y:=y
		This.W:=w
		This.H:=h

        This.HeaderHeight:=HeaderHeight
        This.FooterHeight:=FooterHeight

		;========Color========
            This.Color1:= "0xFF" Color1
            This.HeaderColor := "0xFF" HeaderColor
            This.PanelFooterColor := "0xFF" PanelFooterColor
            This.Border_Color1:= "0xFF" Border_Color1
            if (Color2 = "") {
                This.Color2:= "0xFF" Color1
            }
            else {
                This.Color2:= "0xFF" Color2
            }
            
            if (Border_Color2 = "") {
                This.Border_Color2 := "0xFF" Border_Color1
            }
            else {
                This.Border_Color2:= "0xFF" Border_Color2
            }
		;========Hover Color========
            This.HColor1:= "0xFF" HColor1
            This.HHeaderColor := "0xFF" HHeaderColor
            This.HPanelFooterColor := "0xFF" HPanelFooterColor
            This.HColor_Border1:= "0xFF" HColor_Border1
            if (HColor2 = "") {
                This.HColor2 := "0xFF" HColor1
            }
            else {
                This.HColor2 := "0xFF" HColor2
            }
            
            if (HColor_Border2 = ""){
                This.HColor_Border2 := "0xFF" HColor_Border1
            }
            else {
                This.HColor_Border2 := "0xFF" HColor_Border2
            }
		;========Pressed Color========
            This.PColor1:= "0xFF" PColor1
            This.PHeaderColor := "0xFF" PHeaderColor
            This.PPanelFooterColor := "0xFF" PPanelFooterColor
            This.PColor_Border1:= "0xFF" PColor_Border1
            if (PColor2 = "") {
                This.PColor2:= "0xFF" PColor1
            }
            else {
                This.PColor2:= "0xFF" PColor2
            }
            
            if (PColor_Border2 = ""){
                This.PColor_Border2 := "0xFF" PColor_Border1
            }
            else {
                This.PColor_Border2 := "0xFF" PColor_Border2
            }

		;========Style========
            This.Radius:=Radius
            This.Border_Radius:=Border_Radius
            This.BorderWidth:=BorderWidth
            This.Border:=Border
            This.Header:=Header
            This.Footer:=Footer
            This.HeaderBottumRadius:=HeaderBottumRadius
            This.FooterTopRadius:=FooterTopRadius
            if (This.Border == "False") {
                This.Border_Color1 := "0x00" Border_Color1
                This.Border_Color2 := "0x00" Border_Color2

                This.HColor_Border1 := "0x00" HColor_Border1
                This.HColor_Border2 := "0x00" HColor_Border2

                This.PColor_Border1 := "0x00" PColor_Border1
                This.PColor_Border2 := "0x00" PColor_Border2
            }
		;========Options========
            This.Hover:=Hover
            This.Pressed:=Pressed
            This.HeaderHover:=HeaderHover
            This.HeaderPressed:=HeaderPressed
            This.FooterHover:=FooterHover
            This.FooterPressed:=FooterPressed

            This.Title:=Title
            This.FontColor:= "0xFF" FontColor
            This.Font:=Font
            This.FontSize:=FontSize

            
			This.Window:=Window
			This.Label:=Label
            This.Variable:=Variable
            This.OnTopColor:= "0xFF" OnTopColor
            This.Tooltip := ToolTip
            This.ShowToolTip := ObjBindMethod(This, "ShowToolTipFunc") 

		;========Functions========
			This.Create_Trigger()
			This.Create_Default_Bitmap()
			; This.Create_Hover_Bitmap()
			; This.Create_Pressed_Bitmap()

		sleep,20
		This.Draw_Default()
    }

    Create_Trigger(){
		Gui,% This.Window ": Add",Picture,  % "x" This.X " y" This.Y " w" This.W " h" This.H " hwndhwnd 0xE" This.Variable
        if (This.Hover == "False") {
            This.Hwnd:=hwnd "No H"
        }
        else {
            This.Hwnd:=hwnd
        }
		BPC:=This.Draw_Pressed.Bind(This)
		GuiControl,+G,% This.Hwnd,% BPC
        GuiControl, +BackgroundTrans, % This.Hwnd, % BPC
		if (This.Label){
			(IsFunc(This.Label))?(This.Function:=Func(This.Label),This.Type:="Function"):(This.Type:="Label")
		}
		
	}

    Create_Default_Bitmap() {
        if (This.Border == "False") {
            pBitmap:=Gdip_CreateBitmap( This.W+2, This.H+2 )
        }
        else {
            pBitmap:=Gdip_CreateBitmap( This.W+this.BorderWidth*2+2, This.H+this.BorderWidth*2+2 )
        }
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        ;================Background================
        Brush := Gdip_BrushCreateSolid( This.OnTopColor )
        Gdip_FillRectangle( G , Brush , -2 , -2 , This.W+8 , This.H+8 )
        Gdip_DeleteBrush( Brush )

        ;================Panel================
        Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , This.Color1 , This.Color2 , 1 , 1 )
        Gdip_FillRoundedRectangle( G , Brush , 0 , 0 , This.W , This.H , ((This.W/100)+(This.H/100))*This.Radius ) ;0 , 0 , 100 , 100 , 10 
        Gdip_DeleteBrush( Brush )

        ;================Header================
        if (This.Header == "True") {
            Brush := Gdip_BrushCreateSolid( This.HeaderColor )
            Gdip_FillRoundedRectangle( G , Brush , 0 , 0 , This.W , This.H/(This.HeaderHeight)*4 , ((This.W/100)+(This.HeaderHeight/100))*This.Radius ) ;0 , 0 , 100 , 100 , 10 
            if (This.HeaderBottumRadius == "False") {
                Gdip_FillRectangle( G , Brush , 0 , This.H/(This.HeaderHeight)*4-(This.W/25) , This.W/25 , This.W/25 )
                Gdip_FillRectangle( G , Brush , This.W-(This.W/25) , This.H/(This.HeaderHeight)*4-(This.W/25) , This.W/25 , This.W/25 )
            }
            Gdip_DeleteBrush( Brush )

            if (This.Title != "") {
                StringLength := StrLen(This.Title)
                Brush := Gdip_BrushCreateSolid( This.FontColor )
                Gdip_TextToGraphics( G , This.Title , "s" Ceil((This.FontSize/2)*(This.H/(This.HeaderHeight)/2)-((This.H/This.H)*3)) " Center c" Brush " x2 y" Ceil((This.FontSize/2)*(This.H/(This.HeaderHeight)/2)/10) ,  This.Font , This.W , (This.FontSize/2)*(This.H/(This.HeaderHeight)/2) )
                Gdip_DeleteBrush( Brush )
            }
        }

        ;================Footer================
        if (This.Footer == "True") {
            Brush := Gdip_BrushCreateSolid( This.PanelFooterColor )
            Gdip_FillRoundedRectangle( G , Brush , 0 , This.H-(This.H/(This.FooterHeight)*4) , This.W , This.H/(This.FooterHeight)*4 , ((This.W/100)+(This.FooterHeight/100))*This.Radius ) ;0 , 0 , 100 , 100 , 10 
            if (This.FooterTopRadius == "False") {
                Gdip_FillRectangle( G , Brush , 0 , This.H-(This.H/(This.FooterHeight)*4) , This.W/25 , This.W/25 )
                Gdip_FillRectangle( G , Brush , This.W-(This.W/25) , This.H-(This.H/(This.FooterHeight)*4) , This.W/25 , This.W/25 )
            }
            Gdip_DeleteBrush( Brush )
        }

        ;================Border================
        Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , This.Border_Color1 , This.Border_Color2 , 1 , 1 )
        Pen := Gdip_CreatePenFromBrush( Brush , This.BorderWidth*((This.W/100)+(This.H/100))/4 ) ;2
        Gdip_DeleteBrush( Brush )
        Gdip_DrawRoundedRectangle( G , Pen , 0 , 0 , This.W , This.H , ((This.W/100)+(This.H/100))*This.Border_Radius ) ;0 , 0 , 100 , 100 , 10 

        Gdip_DeletePen( Pen )
        Gdip_DeleteGraphics( G )

        This.Default_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
    }

    Create_Hover_Bitmap() {
        if (This.Border == "False") {
            pBitmap:=Gdip_CreateBitmap( This.W+2, This.H+2 )
        }
        else {
            pBitmap:=Gdip_CreateBitmap( This.W+this.BorderWidth*2+2, This.H+this.BorderWidth*2+2 )
        }
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        ;================Background================
        Brush := Gdip_BrushCreateSolid( This.OnTopColor )
        Gdip_FillRectangle( G , Brush , -2 , -2 , This.W+8 , This.H+8 )
        Gdip_DeleteBrush( Brush )

        ;================Panel================
        Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , This.HColor1 , This.HColor2 , 1 , 1 )
        Gdip_FillRoundedRectangle( G , Brush , 0 , 0 , This.W , This.H , ((This.W/100)+(This.H/100))*This.Radius ) ;0 , 0 , 100 , 100 , 10 
        Gdip_DeleteBrush( Brush )

        ;================Border================
        Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , This.HColor_Border1 , This.HColor_Border2 , 1 , 1 )
        Pen := Gdip_CreatePenFromBrush( Brush , This.BorderWidth*((This.W/100)+(This.H/100))/4 ) ;2
        Gdip_DeleteBrush( Brush )
        Gdip_DrawRoundedRectangle( G , Pen , 0 , 0 , This.W , This.H , ((This.W/100)+(This.H/100))*This.Border_Radius ) ;0 , 0 , 100 , 100 , 10 

        Gdip_DeletePen( Pen )
        Gdip_DeleteGraphics( G )

        This.Hover_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
    }

    Create_Pressed_Bitmap() {
	    pBitmap:=Gdip_CreateBitmap( This.W+this.BorderWidth*2+2, This.H+this.BorderWidth*2+2 )
        G := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( G , 4 )

        ;================Background================
        Brush := Gdip_BrushCreateSolid( This.OnTopColor )
        Gdip_FillRectangle( G , Brush , -2 , -2 , This.W+8 , This.H+8 )
        Gdip_DeleteBrush( Brush )

        ;================Panel================
        Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , This.PColor1 , This.PColor2 , 1 , 1 )
        Gdip_FillRoundedRectangle( G , Brush , 0 , 0 , This.W , This.H , ((This.W/100)+(This.H/100))*This.Radius ) ;0 , 0 , 100 , 100 , 10 
        Gdip_DeleteBrush( Brush )

        ;================Border================
        Brush := Gdip_CreateLineBrushFromRect( 0 , 0 , This.W , This.H , This.PColor_Border1 , This.PColor_Border2 , 1 , 1 )
        Pen := Gdip_CreatePenFromBrush( Brush , This.BorderWidth*((This.W/100)+(This.H/100))/4 ) ;2
        Gdip_DeleteBrush( Brush )
        Gdip_DrawRoundedRectangle( G , Pen , 0 , 0 , This.W , This.H , ((This.W/100)+(This.H/100))*This.Border_Radius ) ;0 , 0 , 100 , 100 , 10 

        Gdip_DeletePen( Pen )
        Gdip_DeleteGraphics( G )

        This.Pressed_Bitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
    }

    Draw_Pressed(){
        if (This.Pressed == "False") {
            return
        }
		SetTimer,CTN_Hover_Function_Panel,Off
		SetImage(This.hwnd, This.Pressed_Bitmap)
		While(GetKeyState("LButton"))
			Sleep,10

		SetTimer,CTN_Hover_Function_Panel,On
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
        if (This.Hover == "False") {
            return
        }
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