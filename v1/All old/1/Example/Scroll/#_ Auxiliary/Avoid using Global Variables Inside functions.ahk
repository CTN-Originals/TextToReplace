


loop, 10
Test( )

msgbox, % Test("Addition") "`n`n" Test("Test") "`n`n" Test("Auto") "`n`n" Test("Code") "`n`n" Test("Lol")

msgbox, % Addition "`n`n" Test "`n`n" Auto "`n`n" Code "`n`n" Lol	;these variables from the main script are all blank


Test("", "Avoid using Global Variables Inside functions.txt")	;read ".ini" files directly from the function
					;"Error" output if no file found


msgbox, % Test("Addition") "`n`n" Test("Test") "`n`n" Test("Auto") "`n`n" Test("Code") "`n`n" Test("Lol")

msgbox, % Addition "`n`n" Test "`n`n" Auto "`n`n" Code "`n`n" Lol	;these variables from the main script are all blank



Test(GetStaticVarValue := "", Load := "")	;___________ Test (Function) ____________
{
static Addition, Test, Auto, Code, Lol

	if Load !=		;if "Load" is not blank
	{
	Iniread, Addition, %Load%, section, Addition
	Iniread, Test, %Load%, section, Test
	Iniread, Auto, %Load%, section, Auto
	Iniread, Code, %Load%, section, Code
	Iniread, Lol, %Load%, section, Lol
	return
	}

	if GetStaticVarValue !=		;if "GetStaticVarValue" is not blank
	{
	GetStaticVarValue := %GetStaticVarValue%
	return, GetStaticVarValue
	}

Addition++
Test = Alot of test
Auto = no manual
Code = Script
Lol = not funny
}


