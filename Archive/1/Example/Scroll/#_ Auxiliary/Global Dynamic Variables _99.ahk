


n = 2

hoho%n% = 444444444	;this value will be visible for the main script and all its functions

GlobalDynamicVariables(n)	;This function defines the desired Global Dynamic Variables 

Test(n)	;define some dynamic variables values

msgbox, ,  Main Script, % haha%n% " - " hehe%n% " - " hihi%n% " - " hoho%n%

Test1(n)

Test2(n)

exitapp

GlobalDynamicVariables(x)	;____________ Global Variables Function _________________
{
Global	;All the dynamic variables below will be defined as global dynamic variables

haha%x% := haha%x%		;The variables original values will be preserved

	;hehe%x% := hehe%x%

hihi%x% := hihi%x%
hoho%x% := hoho%x%
}

Test(x)	;_________ Test Function ______________
 {
if tata != 0
{
haha%x% = 11111	;this value is visible for the main script and all its functions
hehe%x% = 22222	;this value is not visible for the main script and all its functions
hihi%x% = 33333	;this value is visible for the main script and all its functions
tata = 0
}
msgbox, , Test, % haha%x% " - " hehe%x% " - " hihi%x% " - " hoho%x%
}

Test1(x)	;_________ Test 1 Function ______________
 {
msgbox, , Test 1, % haha%x% " - " hehe%x% " - " hihi%x% " - " hoho%x%
}

Test2(x)	;_________ Test 2 Function ______________
 {
msgbox, , Test 2, % haha%x% " - " hehe%x% " - " hihi%x% " - " hoho%x%
}










