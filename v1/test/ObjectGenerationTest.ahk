#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%



Generate_ProgSwitch(x:=100, y:=40, w:=40, h:=40)

Gui, Color, Black
Gui, Show, w400 h250, Object Generation Test
return



Generate_ProgSwitch(x, y, w, h) {

    X:=x
    Y:=y
    W:=w
    H:=h


    for index, param in params {
        for index2, param2 in StrSplit(param, ",") {
            ParamObj := StrSplit(param2, ":=")
            Var := ParamObj[1]
            MsgBox, %Var%
            %Var% := ParamObj[2]
        }
    }


    Gui, Add, Progress, % "x" X " y" Y " w" W " h" H
}