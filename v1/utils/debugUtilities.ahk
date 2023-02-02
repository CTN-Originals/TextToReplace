Global LastConsoleOutputInstance := ""
Global LastConsoleOutputMessage := ""
Global LastConsoleOutputMessageLines := []

class Console {
	__New(name, indent := "  ") {
		this.name := name
		this.indent := indent

		this._currentIndent := ""
	}

	log(msg, noPrefix := false) {
		if (noPrefix) {
			this._log(msg)
		} else {
			this._log(msg, this.name)
		}

		LastConsoleOutputInstance := this.name
	}

	_log(msg, prefix := "") {
		output := ""
		if (Array.isArray(msg)) {
			output := this._formatArrayToString(msg)
		}
		else if (Object.isObject(msg)) {
			output := this._formatObjectToString(msg)
		}
		else {
			output := msg
		}
		
		output := (prefix) ? prefix ": " output : output
		output .= "`n"

		; if the last message has multiple lines, add a new line before the new message
		if (StrSplit(output, "`n").Length() > 2) {
			; lastLine := LastConsoleOutputMessageLines[LastConsoleOutputMessageLines.MaxIndex()]
				; lastLineMsg := StrSplit(lastLine, ":")[StrSplit(lastLine, ":").MaxIndex()]
				; OutputDebug, % "LastLineMsg: " lastLineMsg "`n"
				; if (StrSplit(lastLine).Length() < 2) {
				; 	output .= "`n"
				; }
				; else {
				; 	output := "`n" output "`n"
			; }
			output := "`n" output
		}

		OutputDebug, % output
		LastConsoleOutputMessage := output ; store this message
		LastConsoleOutputMessage := StrSplit(output, "`n") ; store the lines of this message
	}

	_formatArrayToString(arr) {
		output := "[`n"
		this._setIndent(true) ; increase indent
		for i in arr {
			lineEnding := (i != arr.MaxIndex()) ? "," : "" ; if this is the last item, don't add a comma
			output .= this._currentIndent arr[i] lineEnding "`n" ; add the current line
		}
		this._setIndent(false) ; decrease indent
		output .= this._currentIndent "]"
		return output
	}
	_formatObjectToString(obj) {
		output := "{`n"
		this._setIndent(true) ; increase indent
		for key, value in obj {
			if (Array.isArray(value)) {
				value := this._formatArrayToString(value) ; format the array recursively to a string
			}
			else if (Object.isObject(value)) {
				value := this._formatObjectToString(value) ; format the object recursively to a string
			}
			lineEnding := (obj[Object.keys(obj)[Object.keys(obj).MaxIndex()]] != obj[key]) ? "," : "" 
			output .= this._currentIndent key ": " value lineEnding "`n"
		}
		this._setIndent(false) ; decrease indent
		output .= this._currentIndent "}"
		return output
	}

	_setIndent(increase) {
		if (increase) {
			this._currentIndent .= this.indent
		} else {
			this._currentIndent := Substr(this._currentIndent, 1, StrLen(this._currentIndent) - StrLen(this.indent))
		}
	}
}