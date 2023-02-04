#NoEnv
#SingleInstance, Force

class ObjectClass {
	isObject(obj) {
		; local target := (this) ? this : param
		; OutputDebug, % "`nIsObject: " obj "`n"
		; OutputDebug, % "String Length: " StrLen(obj) " | " StrSplit(obj) " | Keys: " obj.keys().Length() "  > "
		; if (Object.isObject(obj) == 0) {
		; 	return false
		; }
		if (Array.isArray(obj)) {
			return false
		}
		else if (IsObject(obj)) {
			
			return true
		}
		return false
	}

	keys(obj) {
		output := []
		for key, value in obj {
			output.push(key)
		}
		return output
	}
	values(obj) {
		output := []
		for key, value in obj {
			if (this.isObject(value)) {
				value := "{ Object(" this.keys(value).length() ") }"
			}
			else if (Array.isArray(value)) {
				value := "[ Array(" value.length() ") ]"
			}
			output.push(value)
		}
		return output
	}
}

; Object(items*) {
; 	items.base := new ObjectClass()
; 	; Console.log()
; 	return items
; }
Global Object = new ObjectClass()

; __Class.base.keys := Func("ObjectClass.keys")
; ("").base.isObj := Func("ObjectClass.isObj")
; (float).base.isObj := Func("ObjectClass.isObj")
; (Integer).base.isObj := Func("ObjectClass.isObj")
; ([]).base.isObj := Func("ObjectClass.isObj")
; ({}).base.isObj := Func("ObjectClass.isObj")
; ().base.isObj := Func("ObjectClass.isObj")
