#SingleInstance, Force

#Include, utils/arrayUtilities.ahk
#Include, utils/debugUtilities.ahk
#Include, utils/tooltipUtilities.ahk
#Include, utils/objectUtilities.ahk

class UtilityClass {
	type() {
		if (this is alnum) {
			return "string"
		} 
		else if (this is number) {
			return "number"
		}
		else {
			return "unknown"
		}
		return "unknown"
	}
}

Utilities(items*) {
	items.base := UtilityClass
	return items
}

; OutputDebug, % "Type of: " 123 " = " 123.type() "`n"