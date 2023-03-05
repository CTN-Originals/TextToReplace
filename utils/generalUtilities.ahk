#SingleInstance, Force

#Include, C:\Users\CTN\Documents\CTN\Programming\ahk\Projects\TextToReplace/utils/arrayUtilities.ahk
#Include, C:\Users\CTN\Documents\CTN\Programming\ahk\Projects\TextToReplace/utils/debugUtilities.ahk
#Include, C:\Users\CTN\Documents\CTN\Programming\ahk\Projects\TextToReplace/utils/tooltipUtilities.ahk
#Include, C:\Users\CTN\Documents\CTN\Programming\ahk\Projects\TextToReplace/utils/objectUtilities.ahk

PercentToHex(num) {
	hexNum := Round(num * 2.55)
	return Format("{:x}", hexNum + 0)
}