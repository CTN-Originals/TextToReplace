
x = 2

tata = 3		;"tata" is a static variable

%x%test = 10	;"%x%test" is a dynamic variable

gui, add, button, gButtonCount, Main Script Count +
gui, add, edit, w250 vEdit1, 
gui, add, text, x+5,  ("Update" Function)
gui, add, edit, xm w250 vEdit2, 
gui, add, text, x+5,  ("Update1" Function)

gui, add, button, xm gButtonCount1, Function Count +
gui, add, edit, w250 vEdit3, 
gui, add, text, x+5,  ("Update" Main Script)
gui, add, edit, xm w250 vEdit4, 
gui, add, text, x+5,  ("Update1" Main Script)

gui, add, button, xm gButtonCount2, Function Count 1 +
gui, add, edit, w250 vEdit5, 
gui, add, text, x+5,  ("Update" Main Script)
gui, add, edit, xm w250 vEdit6, 
gui, add, text, x+5,  ("Update1" Main Script)

Update(x)
Update1(x)

gui, show,  
return

ButtonCount:	;__________Button count_____________

%x%test++
tata++

Update(x)
Update1(x)

return

ButtonCount1:	;__________Button count 1_____________

Count(x)

guicontrol, , Edit3, % %x%test " - " %v%tata	;values from "Count()" function are visible to main script dynamic variables
				;since "x = 2" and "v = blank", we have "2test" and "tata" variables

guicontrol, , Edit4, % 2test " - " tata		;values from "Count()" function are visible to main script static variables

return

ButtonCount2:	;__________Button count 2_____________

Count1(x)

guicontrol, , Edit5, % %x%test " - " %v%tata	;values from "Count()" function are visible to main script dynamic variables
				;since "x = 2" and "v = blank", we have "2test" and "tata" variables

guicontrol, , Edit6, % 2test " - " tata		;values from "Count()" function are visible to main script static variables

return

guiclose:	;___________ Gui Close _____________
exitapp

	;__________Functions_______________

Update(y)
{
guicontrol, , Edit1, % %y%test " - " %v%tata	;"%y%test" and "%v%tata" are dynamic varianles, so, their values from  main script will be visible in this function
				;since "y = 2" and "v = blank", we have "2test" and "tata" variables
				;but using static "2test" and "tata" variables instead "%y%test" and "%v%tata" dynamic variables, their values from  main script will not be visible in this function
}

Update1(y)
{
guicontrol, , Edit2, % 2test " - " tata		;but using static "2test" and "tata" variables instead "%y%test" and "%v%tata" dynamic variables, their values from  main script will not be visible in this function
				;"2test" and "tata" values are not blank in the main script, but in this function they are blank	
}


Count(y)
{
%y%test++	;the variables values from the main script will be visible to this function (so, the count will be continued!)
%v%tata++	;after addig +1, the values from this function will be visible to the main script! 
}

Count1(y)
{
2test++		;the variables values from the main script will not be visible to this function (so, the count will strat from 0!)
tata++		;after addig +1, the values from this function will not be visible to the main script! (so, the main script values will not be altered)	
}










