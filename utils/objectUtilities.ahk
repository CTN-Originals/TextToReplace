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
	hasKey(obj, key) {
		for key, value in obj {
			if (key == key) {
				return true
			}
		}
		return false
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

	clone(obj, recursive := true) {
		output := {}
		for key, value in obj {
			if (recursive && this.isObject(value)) {
				value := this.clone(value)
			}
			output[key] := value
		}
		return output
	}

	; If original has the key, overwrite it with the target key value
	overwrite(original, target, createKeys := false, overwriteToNull := false) {
		output := this.clone(original)
		for key, value in target {
			overwrite := ""
			if (!createKeys && !this.hasKey(original, key)) {
				continue
			}

			if (this.isObject(value) && this.isObject(original[key])) {
				overwrite := this.overwrite(output[key], value, createKeys, overwriteToNull)
			}
			else {
				overwrite := value
			}
			if (overwriteToNull || overwrite != "") {
				output[key] := overwrite
			}
		}
		return output
	}


	toString(obj, indent := "") {
		output := ""
		for key, value in obj {
			if (this.isObject(value)) {
				value := "{" this.toString(value, indent "  ") "`n" indent "}"
			}
			else if (Array.isArray(value)) {
				value := "[ Array(" value.length() ") ]"
			}
			output .= "`n" indent key ": " value
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
