StringToArray(target, replace, split) {
	For i in replace {
		target := StrReplace(target, replace[i], "")
	}
	return StrSplit(target, split)
}

ArrayToString(target, seperator := "") {
	output := ""
	For i in target {
		if (i == target.Length()) {
			seperator := ""
		}
		output .= target[i] seperator
	}
	return output
}

CleanupArray(target) {
	output := []
	for i in target {
		if (target[i] != "") {
			output.Push(target[i])
		}
	}
	return output
}

ArrayToScript(arr) {
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
					currentIndent := ArrayToString(StrSplit(currentIndent, indentString).RemoveAt(1), "")
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