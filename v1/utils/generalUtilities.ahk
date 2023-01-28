#SingleInstance, Force

StringToArray(target, replace, split) {
	For i in replace {
		target := StrReplace(target, replace[i], "")
	}
	return StrSplit(target, split)
}

ArrayToString(target, seperator) {
	output := ""
	For i in target {
		if (i == target.Length()) {
			seperator := ""
		}
		output .= target[i] seperator
	}
	return output
}