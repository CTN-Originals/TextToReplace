#Include, C:\Users\CTN\Documents\CTN\Programming\ahk\Projects\TextToReplace\gui\interactables\Gdip.ahk
Gdip_Startup()

class BrushBase {
	__New() {
		this.rect := 
		this.bitmap := new this.BitmapVarients()
	}

	class BitmapVarients {
		__New() {
			this.default
			this.hover
			this.pressed
			this.disabled
		}
	}
	
	DrawDefault(hwnd) {
		this.hwnd := hwnd
		SetImage(hwnd, this.bitmap.default)
	}
}
class TextBrush extends BrushBase {
	init() {
		this.text := "Hello Text Brush!"
		this.color := "FFFFFF"
		this.opacity := 80
		this.font := "Impact"
		this.fontSize := 12

		this.state := "default"
		this.CreateDefaultBitmap()
	}

	CreateDefaultBitmap() {
		pBitmap := Gdip_CreateBitmap( this.rect.width, this.rect.height ) 
        graphics := Gdip_GraphicsFromImage( pBitmap )
        Gdip_SetSmoothingMode( graphics , 4 )
		
		Brush := Gdip_BrushCreateSolid( "0x00FF0000" )
        Gdip_FillRoundedRectangle( graphics , Brush , -2 , -2 , This.rect.width + 8 , This.rect.height + 8 , 0 )
        Gdip_DeleteBrush( Brush )
		
		Brush := Gdip_BrushCreateSolid( "0x" PercentToHex(this.opacity) this.color )
        Gdip_TextToGraphics( graphics , this.text , "s" this.GetFontSize() " Center c" Brush " x2 y" this.rect.y ,  this.font , this.rect.width , this.rect.height )
        Gdip_DeleteBrush( Brush )
        Gdip_DeleteGraphics( graphics )
		
		this.bitmap.default := Gdip_CreateHBITMAPFromBitmap(pBitmap)
		Gdip_DisposeImage(pBitmap)
	}

	GetFontSize() {
        div := this.rect.width / 100
		
		if (StrLen(this.text) >= 10) {
			newSize := div * this.fontSize
			; this.rect.y := (this.rect.height / 2) - newSize * 0.68 + 3
			;New_Size -= 2
		}
        else {
            newSize := div * this.fontSize * 1.50
            ; this.rect.y := (this.rect.height / 2) - newSize * 0.68 + 3
        }

		return NewSize
		; return % this.rect.y
    }
}