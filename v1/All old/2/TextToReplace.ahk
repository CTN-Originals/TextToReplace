#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Include, Neutron.ahk


neutron := new NeutronWindow()
neutron.Load("html/Home.html")

neutron.Show("w800 h500")
return

Test(neutron) {
    msgbox, tested
}