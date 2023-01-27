#SingleInstance, Force

TextLineNumber = 1

LineBreak = ----------------------------------------------------------------------------------------------------------------------------------
LineCollum = --------------------------------------------||----------||----------------------------------------------

html =
(
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="utf-8">
    </head>
    <style>
        body {
            min-height: 100em;
            max-width: 100vw !important;
            margin: 0;
            background-image: linear-gradient(#0043c0, #0011ce);

            overflow-x: hidden;
            overflow-y: scroll;
            z-index: 100;
        }
    </style>
    <body>

    </body>
</html>

)

;================GUI================

    Gui, Edit:New

    Gui, Edit:Add, Pic, BackgroundTrans x0 y0 w600 h850, ..\Images\BG.png
    ; Gui, Edit:Add, Pic, BackgroundTrans x0 y340 w600 h-1, ..\Images\BG 2.png
    ; Gui, Edit:Add, Pic, BackgroundTrans x0 y680 w600 h-1, ..\Images\BG.png
    ; Gui, Edit:Add, Pic, BackgroundTrans x0 y1020 w600 h-1, ..\Images\BG 2.png

    Gui, Edit:Font, cWhite s12, Ariel
    Gui, Edit:Add, Text, BackgroundTrans x0 y0,

    ; Gui, Add, ActiveX, vWB x0 y0 w600 h850, about:<!doctype html><meta http-equiv='X-UA-Compatible' content='IE=edge'>
    ; WB.document.write(html)


    ;================Examples================
        Gui, Edit:Font, cWhite s16, Impact
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+-5 w600, %LineCollum%
        Gui, Edit:Font, cWhite s12
        Gui, Edit:Add, Button, Center gEdit1 x280 y+-25 w50 h30, Edit

        Gui, Edit:Font, cWhite s16, Impact
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+8 w600, Hello
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+8 w600 r1, Hi there how are you?

        Gui, Edit:Font, cWhite s16, Impact
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+10 w600, %LineCollum%
        Gui, Edit:Font, cWhite s12
        Gui, Edit:Add, Button, gDelete1 x280 y+-25 w50 h30, Delete


        Gui, Edit:Font, cBlack s12
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+5   w600, %LineBreak%
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+-18 w600, %LineBreak%
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+-18 w600, %LineBreak%


        Gui, Edit:Font, cWhite s16, Impact
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+5 w600, %LineCollum%
        Gui, Edit:Font, cWhite s12
        Gui, Edit:Add, Button, Center gEdit1 x280 y+-25 w50 h30, Edit

        Gui, Edit:Font, cWhite s16, Impact
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+8 w600, btw
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+8 w600 r1, By the way!

        Gui, Edit:Font, cWhite s16, Impact
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+10 w600, %LineCollum%
        Gui, Edit:Font, cWhite s12
        Gui, Edit:Add, Button, gDelete1 x280 y+-25 w50 h30, Delete


        Gui, Edit:Font, cBlack s12
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+5   w600, %LineBreak%
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+-18 w600, %LineBreak%
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+-18 w600, %LineBreak%


        Gui, Edit:Font, cWhite s16, Impact
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+5 w600, %LineCollum%
        Gui, Edit:Font, cWhite s12
        Gui, Edit:Add, Button, Center gEdit1 x280 y+-25 w50 h30, Edit

        Gui, Edit:Font, cWhite s16, Impact
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+8 w600, solar system
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+8 w600 r1, the Sun, Mercury, Venus, Eurth, Mars, Uranes, Jupeter, Saturnes, Pluto 

        Gui, Edit:Font, cWhite s16, Impact
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+10 w600, %LineCollum%
        Gui, Edit:Font, cWhite s12
        Gui, Edit:Add, Button, gDelete1 x280 y+-25 w50 h30, Delete


        Gui, Edit:Font, cBlack s12
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+5   w600, %LineBreak%
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+-18 w600, %LineBreak%
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+-18 w600, %LineBreak%


        Gui, Edit:Font, cWhite s16, Impact
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+5 w600, %LineCollum%
        Gui, Edit:Font, cWhite s12
        Gui, Edit:Add, Button, Center gEdit1 x280 y+-25 w50 h30, Edit

        Gui, Edit:Font, cWhite s16, Impact
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+8 w600, Tsting
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+8 w600 r1, Succefull/Unsuccesfull

        Gui, Edit:Font, cWhite s16, Impact
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+10 w600, %LineCollum%
        Gui, Edit:Font, cWhite s12
        Gui, Edit:Add, Button, gDelete1 x280 y+-25 w50 h30, Delete


        Gui, Edit:Font, cBlack s12
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+5   w600, %LineBreak%
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+-18 w600, %LineBreak%
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+-18 w600, %LineBreak%


        Gui, Edit:Font, cWhite s16, Impact
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+5 w600, %LineCollum%
        Gui, Edit:Font, cWhite s12
        Gui, Edit:Add, Button, Center gEdit1 x280 y+-25 w50 h30, Edit

        Gui, Edit:Font, cWhite s16, Impact
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+8 w600, ABC
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+8 w600 r1, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'

        Gui, Edit:Font, cWhite s16, Impact
        Gui, Edit:Add, Text, BackgroundTrans Center x0 y+10 w600, %LineCollum%
        Gui, Edit:Font, cWhite s12
        Gui, Edit:Add, Button, gDelete1 x280 y+-25 w50 h30, Delete


    
    
    
    Gui, Edit:+Border
    Gui, Edit:Show, w600 h850, Text Replacer / Edit Submited
return


Delete1:
Gui Edit:Destroy
return

Edit1:

return





    ; Gui, Edit:Font, cBlack s16, Impact
    ; Gui, Edit:Add, Text, BackgroundTrans x20 y+20, %TextLineNumber%
    ; Gui, Edit:Font, cWhite s16, Impact
    ; Gui, Edit:Add, Text, BackgroundTrans x+20 w120, 1234567890
    ; Gui, Edit:Add, Text, BackgroundTrans x+20, <>
    ; Gui, Edit:Add, Text, BackgroundTrans x+20 w300, 123456789012345678901234
    ; Gui, Edit:Font, cWhite s12, Ariel
    ; Gui, Edit:Add, Button, gEdit1 x480 y+-30 w50 h30, Edit
    ; Gui, Edit:Add, Button, gRemove1 x540 y+-30 w50 h30, Delete
    ; TextLineNumber++