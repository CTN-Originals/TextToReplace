Global LastConsoleOutputInstance := ""
Global LastConsoleOutputMessage := ""
Global LastConsoleOutputMessageLines := []

class Console {
	__New(name, indent := "  ") {
		this.name := name
		this.indent := indent

		this._currentIndent := ""

		; default options
		this.objectOptions := {nullValues: true, privateValues: false, brackets: true}
		this.arrayOptions := {}
		this.options := {prefix: true, object: this.objectOptions, array: this.arrayOptions}
	}

	log(msg, args := "") {
		options := Object.overwrite(this.options, args)
		; OutputDebug, % Object.toString(options) "`n`n"
		this._log(msg, options)
		LastConsoleOutputInstance := this.name
	}

	_log(msg, options) {
		prefix := (options.prefix == true) ? this.name : (options.prefix != 0 && options.prefix != "") ? options.prefix ": " : ""

		output := ""
		if (Array.isArray(msg)) {
			output := this._formatArrayToString(msg, options.array)
		}
		else if (Object.isObject(msg)) {
			output := this._formatObjectToString(msg, options.object)
		}
		else {
			output := msg
		}
		
		output := prefix output "`n"

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

	_formatArrayToString(arr, options) {
		output := "["
		if (arr.Length() > 5) {
			output .= "`n"
		}
		this._setIndent(true) ; increase indent
		for i in arr {
			lineEnding := (i != arr.MaxIndex()) ? "," : "" ; if this is the last item, don't add a comma
			if (arr.MaxIndex() > 5) {
				lineEnding .= "`n"
				output .= this._currentIndent arr[i] lineEnding ; add the current line
			}
			else {
				if (i < arr.MaxIndex()) {
					lineEnding .= " " ; add a space if this is not the last item
				}
				output .= arr[i] lineEnding ; add the current line
			}

		}
		this._setIndent(false) ; decrease indent
		output .= this._currentIndent "]"
		return output
	}
	_formatObjectToString(obj, options) {
		output := "{`n"
		fields := []
		objectFields := []
		arrayFields := []
		this._setIndent(true) ; increase indent
		for key, value in obj {
			if ((!options.nullValues && value == "") || (!options.privateValues && SubStr(key, 1, 1) == "_")) {
				continue
			}

			lineEnding := (obj[Object.keys(obj)[Object.keys(obj).MaxIndex()]] != obj[key]) ? "," : "" 
			if (Array.isArray(value)) {
				if (!options.nullValues && value.Length() == 0) {
					continue
				}
				value := this._formatArrayToString(value, {}) ; format the array recursively to a string
				arrayFields.Push(this._currentIndent key ": " value lineEnding "`n")
			}
			else if (Object.isObject(value)) {
				if (!options.nullValues && Array.cleanup(Object.values(obj[key])).Length() < 1) {
					continue
				}
				value := this._formatObjectToString(value, options) ; format the object recursively to a string
				objectFields.Push(this._currentIndent key ": " value lineEnding "`n")
			}
			else {
				fields.Push(this._currentIndent key ": " value lineEnding "`n")
			}
		}
		this._setIndent(false) ; decrease indent
		output .= Array.join(fields) ; Array.join(Array.sortByLength(fields))
		output .= Array.join(objectFields) ; Array.join(Array.sortByLength(objectFields))
		output .= Array.join(arrayFields) ; Array.join(Array.sortByLength(arrayFields))
		output .= this._currentIndent "}"

		if (!options.brackets) {
			output := Array.join(Array.split(output, "}`n"))
			output := Array.join(Array.split(output, "},`n"))
			output := Array.join(Array.split(output, "]`n"))
			output := Array.join(Array.split(output, "],`n"))
			output := StrReplace(output, ": {", ": ")
			output := StrReplace(output, ": [", ": ")
			
		}
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