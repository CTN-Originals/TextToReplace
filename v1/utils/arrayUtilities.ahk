class ArrayClass {
	isArray(arr) {
		return !!arr.MaxIndex()
	}

	indexOf(arr, item) {
		for i in arr {
			if (arr[i] == item) {
				return i
			}
		}
		return -1
	}
	contains(arr, item) {
		return (Array.indexOf(arr, item) != -1)
	}

	removeAt(ByRef arr, index) {
		output := []
		for i in arr {
			if (i != index) {
				output.Push(arr[i])
			}
		}
		arr := output
		return output
	}
	remove(ByRef arr, item) {
		output := Array.RemoveAt(arr, Array.indexOf(arr, item))
		arr := output
		return output
	}

	join(arr, seperator := "") {
		output := ""
		for i in arr {
			if (i == arr.MaxIndex()) {
				seperator := ""
			}
			output .= arr[i] seperator
		}
		return output
	}
	split(arr, seperator) {
		return StrSplit(arr, seperator)
		output := []
		current := ""
		; split := StrSplit(arr, seperator)
		for i in arr {
			if (arr[i] == seperator) {
				output.Push(current)
				current := ""
			}
			else {
				current .= arr[i]
			}
		}
		output.Push(current)
		return output
	}

	cleanup(arr) {
		output := []
		for i in arr {
			if (arr[i] != "") {
				output.Push(arr[i])
			}
		}
		return output
	}

	toScript(arr) {
		incIndent := ["{", ":" ":"]
		decIndent := ["}", "return"]
		output := ""
	
		indentString := "`t"
		currentIndent := ""
		for i in arr {
			line := arr[i]
			line := StrReplace(line, "\t", "`t")
	
			if (StrSplit(currentIndent).Length() > 0) {
				for i in decIndent {
					if (InStr(line, decIndent[i])) {
						currentIndent := Array.toString(StrSplit(currentIndent, indentString).RemoveAt(1), "")
						break
					}
				}
			}
	
			if (i == 1) {
				output .= currentIndent line
			}
			else {
				output .= "`n" currentIndent line
			}
	
			for i in incIndent {
				if (InStr(line, incIndent[i])) {
					currentIndent .= indentString
					break
				}
			}
		}
	
		return output
	}
}
; Array(items*) {
; 	items.base := ArrayClass
; 	return items
; }
Global Array := new ArrayClass()


