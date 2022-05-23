#SingleInstance, Force
SetCapsLockState, On
SetScrollLockState, ON
global NcName := ""
ShowTip(" |CIMATRON|")
~Enter::
    IfWinActive, ahk_class #32770
        ControlClick, , Ok, , , 1,


Return
::SIM::
    CoordMode, Mouse, Screen
    MouseClick, L, 47, 696, 1, 1
    IfWinExist, Machining Simulation
        WinWait, Machining Simulation
    WinActivate, Machining Simulation
    Sleep, 1500
    ControlClick, Button9, Machining Simulation, , , 2,
    ControlClick, Edit4, Machining Simulation, , , 1,
    Send, {End}
    Send, {ShiftDown}{Home}{ShiftUp}
    Send, -,075
    ControlClick, Button18, Machining Simulation, , , 2,
Return

Return
::EXP:: 	
    Loop, 200
    {
        ControlSend, SysListView322, {Right}{Down}, Cimatron Explorer
        sleep, 20
    }
Return
~F5::	
    Send, {CTRLDOWN}s{CTRLUP}

    IfWinActive, ahk_class XTPMainFrame
    Loop {

        IfWinExist, Cimatron Explorer,,{

            WinWait, Cimatron Explorer, 
            ControlClick, Edit1, Cimatron Explorer, , , 1,
            Sleep, 100
            Send {RIGHT}
            Send {BACKSPACE}
            Send {BACKSPACE}
            Send {BACKSPACE}
            Send {BACKSPACE}
            Send _{N}{C}
            Send, {Enter}
            return

        } else{
            return

        }

    }
return

~F24:: 
    Send, {CtrlDown}{o}{CtrlUp}
Return

~F4::	; Abre eletrodos
    IfWinNotActive, Cimatron 14.0 SP5P1,,,NC-Standard
        MsgBox, "Necessário uma instancia vazia do cimatron"
    IfWinNotActive, Cimatron 14.0 SP5P1,,,NC-Standard
        Return
    Loop, 1
    {
        SetTitleMatchMode, 2
        CoordMode, Mouse, Screen
        tt = Cimatron 14.0 SP5P1 ahk_class CimatronE Mutext x64
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
        Sleep, 150
        MouseClick, L, 228, 86, 1, 1
        Sleep, 150
        MouseClick, L, 290, 189, 1, 1
        Sleep, 150
        Send, {left}
        Sleep, 150
        Send, {Delete}
        tt = Cimatron ahk_class #32770
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
            Send, {Enter}
        tt = NC Process Manager ahk_class #32770
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
            Sleep, 150
        MouseClick, L, 47, 146, 1, 1
        tt = Cimatron Explorer ahk_class XTPMainFrame
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
            Sleep, 1000
        KeyWait, LButton, D 
        Sleep, 1000

        Send, {ENTER}{ENTER}
        Sleep, 50
        WinWait, Cimatron,
        WinActivate Cimatron,
        Sleep, 1000
        Send, {I} 
        KeyWait, RButton, D 
        KeyWait, LButton, D 
        Sleep, 100
        ControlClick, Button1, Feature Guide, , , 2,
        WinWait, Cimatron,
        WinActivate Cimatron,
        Send, {I}
        Sleep, 1500
        Send, {AltDown}{c}{s}{r}{AltUp}

        Return 
    }

return

::esq::	
    InputBox, VarEsq, Qnt Espelhos, Digite a quantidade de espelhos:,,200,150,,,,,1
    if (VarEsq = 1 || VarEsq = 2)
        esqset(VarEsq)
    else
        MsgBox, 4096, Error, ESCOLHA 1 OU 2 !		
return

F3::
    {
        ncContract(),desb()
        return
    }
F8:: 
    IsEletrode := "EL"
    WinActivate, CIMATRON
    IfWinNotActive, Cimatron 14.0 SP5P1,,,%IsEletrode%
        Goto, EletrodeReport
    MsgBox, "Essa função só funciona para arquivos salvos como eletrodo"
Return

EletrodeReport:
    rep()
    printNc()
Return
F7:: exec()

F11::
    if(varName){
        extruturaXlsx(500)
        return
    }else{
        MsgBox, nenhuma OS selecionada
        return
    }

    ^F2::ncContract()
Return

F12::
    InputBox, varLoop, Quantidade: ,Digite a quantidade de repetição ,,,height 150,,,,,1

    Loop, % varLoop
    {
        extrutura()
    }
return

/*
FUNCTIONS
*/
extrutura(){
    Send, {F2}
    Send, {Left}
    Send, {Del %varLength%}
    Send, %varName%
    Send, {ENTER}
    Send, {Down}
    Sleep, 100
Return 
}
extruturaXlsx(timerPress){
    Send, {ENTER}
    Sleep, timerPress
    WinWait, ahk_class XLMAIN
    IfWinActive, ahk_class XLMAIN
        Sleep, timerPress
    Send, {PgUp}
    Sleep, timerPress
    Send, {Home}
    Sleep, timerPress
    Send, {F2}
    Sleep, timerPress
    Send, {up}
    Sleep, timerPress
    Send, {Del %varLength%}{Del}
    Send, %varName%
    Send, {ENTER}
    Sleep, timerPress
    WinClose
    Sleep, timerPress
    WinWait, ahk_class NUIDialog
    Sleep, timerPress
    Send, {ENTER}
    Sleep, timerPress
    WinWait, ahk_class CabinetWClass
    Sleep, timerPress/5
    Send, {Down}
return
}
desb(){
    SetTitleMatchMode, 2
    CoordMode, Mouse, Screen

    tt = ahk_class CimatronE Mutext x64
    WinWait, %tt%
    IfWinNotActive, %tt%,, WinActivate, %tt%

    tt = NC Process Manager ahk_class #32770
    WinWait, %tt%
    IfWinNotActive, %tt%,, WinActivate, %tt%

    ncContract()

    Send, {Down}
    Send, {Blind}{Ctrl Down}cv{Ctrl Up}
    Send, {Up}
    Send, {AppsKey}
    Send, {Up}{Up}{Up}{Up}{Enter}
    Send, DESB
    Send, {Enter}
    Send, {AppsKey}
    Send, {Up}{Up}{Up}{Enter}
    Send, {CtrlDown}{Del}{CtrlUp},15{Enter 2}

Return

}

ncContract(){
    IfWinExist, NC Process Manager 
    {
        Sleep, 10
        ControlSend,GXWND1, {PgDn}{PgDn}, NC Process Manager
        Sleep, 10
        ControlSend,GXWND1, {LEFT}{LEFT}{UP}, NC Process Manager
        Sleep, 10
        ControlSend,GXWND1, {LEFT}{LEFT}{UP}, NC Process Manager
        Sleep, 10
        ControlSend,GXWND1, {LEFT}{LEFT}{UP}, NC Process Manager
        Sleep, 10
        ControlSend,GXWND1, {LEFT}{LEFT}{UP}, NC Process Manager
        Sleep, 10

    }
Return
}

exec() {

    SetTitleMatchMode, 2
    CoordMode, Mouse, Screen

    tt = ahk_class CimatronE Mutext x64
    WinWait, %tt%
    IfWinNotActive, %tt%,, WinActivate, %tt%

    Sleep, 50

    MouseClick, L, 180, 213, 1, 1

    tt = NC Process Manager ahk_class #32770
    WinWait, %tt%
    IfWinNotActive, %tt%,, WinActivate, %tt%

    Sleep, 50

    MouseClick, L, 41, 555, 1, 1

    tt = Execute ahk_class #32770
    WinWait, %tt%
    IfWinNotActive, %tt%,, WinActivate, %tt%

    Sleep, 50

    Send, {Blind}{Space}

    tt = ahk_class CimatronE Mutext x64
    WinWait, %tt%
    IfWinNotActive, %tt%,, WinActivate, %tt%

    Sleep, 50

Return

}

rep() {

    SetTitleMatchMode, 2
    CoordMode, Mouse, Screen

    tt = ahk_class CimatronE Mutext x64
    WinWait, %tt%
    IfWinNotActive, %tt%,, WinActivate, %tt%

    Sleep, 100

    MouseClick, L, 188, 226, 1, 1 
    Sleep, 100
    MouseClick, L, 425, 79, 1, 1 
    tt = ahk_class CimatronE Mutext x64
    WinWait, %tt%
    IfWinNotActive, %tt%,, WinActivate, %tt%

    Sleep, 100

    MouseClick, L, 183, 215, 1, 1

    tt = NC Process Manager ahk_class #32770
    WinWait, %tt%
    IfWinNotActive, %tt%,, WinActivate, %tt%

    Sleep, 100

    MouseClick, L, 34, 880, 1, 1

    tt = NC Setup Report ahk_class #32770
    WinWait, %tt%
    IfWinNotActive, %tt%,, WinActivate, %tt%

    Sleep, 100

    Send, {Blind}{Enter}

    Sleep, 100

    tt = GPP2 - Input = 
    WinWait, %tt%
    IfWinNotActive, %tt%,, WinActivate, %tt%
    Sleep, 100
    MouseClick, L, 211, 66, 1, 1
    tt = ahk_class XLMAIN
    WinWait, %tt%
    IfWinNotActive, %tt%,, WinActivate, %tt%

    Sleep, 100

Return

}

espPost(varPost){
    timerSet = 100
    TimerToTransition = 2000
    If (varPost = 1){
        SetTitleMatchMode, 2
        CoordMode, Mouse, Screen

        tt = NC Process Manager ahk_class #32770
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%

        MouseClick, L, 200, 266, 1, 1

        MouseClick, L, 200, 266, 1, 1

        tt = ahk_class CimatronE Mutext x64
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%

        loop,
        {
            ImageSearch, FoundX,, 50,80, 230, 230, %A_ScriptDir%\IMAGE_SEARCH\transform.bmp	
            sleep 100
            IF (FoundX>1){
                Break
            }
        }
        MouseClick, L, 407, 377, 1, 1

        tt = ahk_class CimatronE Mutext x64
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
        Sleep, timerSet
        MouseClick, L, 640, 300, 1, 1 
        tt = Procedure Selection ahk_class #32770
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
        Sleep, timerSet
        ControlSend, Button7, %A_Space%, Procedure Selection ahk_class #32770
        tt = ahk_class CimatronE Mutext x64
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
        Sleep, timerSet
        MouseClick, L, 338, 201, 1, 1
        Sleep, timerSet
        tt = NC Process Manager ahk_class #32770
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
        Sleep, timerSet
        Return
    }else If (varPost = 2){
        SetTitleMatchMode, 2
        CoordMode, Mouse, Screen

        tt = NC Process Manager ahk_class #32770
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%

        Sleep, timerSet

        MouseClick, L, 192, 288, 1, 1

        MouseClick, L, 192, 288, 1, 1

        tt = ahk_class CimatronE Mutext x64
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%

        loop,
        {
            ImageSearch, FoundX,, 50,80, 230, 230, %A_ScriptDir%\IMAGE_SEARCH\transform.bmp	
            sleep 100
            IF (FoundX>1){
                Break
            }
        }
        MouseClick, L, 443, 379, 1, 1
        Sleep, timerSet
        MouseClick, L, 642, 298, 1, 1
        tt = Procedure Selection ahk_class #32770
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
        ControlSend, Button7, %A_Space%, Procedure Selection ahk_class #32770
        MouseClick, L, 338, 201, 1, 1
        tt = NC Process Manager ahk_class #32770
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
        WinWaitClose, Procedure Selection ahk_class #32770
        tt = NC Process Manager ahk_class #32770
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
        MouseClick, L, 219, 327, 1, 1
        MouseClick, L, 219, 327, 1, 1
        tt = ahk_class CimatronE Mutext x64
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
        loop,
        {
            ImageSearch, FoundX,, 50,80, 230, 230, %A_ScriptDir%\IMAGE_SEARCH\transform.bmp	
            sleep 100
            IF (FoundX>1){
                Break
            }
        }

        MouseClick, L, 407, 377, 1, 1

        tt = ahk_class CimatronE Mutext x64
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
        MouseClick, L, 642, 318, 1, 1
        tt = Procedure Selection ahk_class #32770
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
        Sleep, timerSet
        ControlSend, Button7, %A_Space%, Procedure Selection ahk_class #32770
        tt = ahk_class CimatronE Mutext x64
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
        Sleep, timerSet
        MouseClick, L, 338, 201, 1, 1
        Sleep, timerSet
        tt = NC Process Manager ahk_class #32770
        WinWait, %tt%
        IfWinNotActive, %tt%,, WinActivate, %tt%
        Sleep, timerSet
        Return
    }
Return
}

esqSet(VarEsq){
    CoordMode, Mouse, Screen
    ncContract()
    if(VarEsq = 1){
        If WinExist("NC Process Manager"){
            WinActivate, NC Process Manager
            Send, {PgDn}
            MouseClick, L, 1500, 188, 1, 1
            Sleep, 100
            MouseClick, L, 34, 188, 1, 1
            WinWait, NC Template
            Send, {Tab}
            Send, {Tab}
            Send, {End}
            Send, {ENTER}
            Send, {ShiftDown}{Tab}{Tab}{ShiftUp}
            Send, {Enter}
            WinWaitClose, Templates Selection
            WinWait, NC Process Manager
            ncContract()
            Send, {Down}
            Send, {Down}
            Send, {Del}
            Send, {ENTER}
            Send, {PgDn}
            Send, {Right}
            WinWaitClose, Templates Selection
            WinWait, NC Process Manager
            espPost(VarEsq)
            ncContract()
            Return
        }

    }Else if(VarEsq = 2){

        desb()
        If WinExist("NC Process Manager"){
            WinActivate, NC Process Manager
            Send, {PgDn}
            MouseClick, L, 1500, 188, 1, 1
            Sleep, 100
            MouseClick, L, 34, 188, 1, 1
            WinWait, NC Template
            Send, {Tab}
            Send, {Tab}
            Send, {End}
            Send, {ENTER}
            WinWait, Templates Selection
            Send, {ShiftDown}{Tab}{Tab}{ShiftUp}
            Send, {Enter}
            WinWaitClose, Templates Selection
            WinWait, NC Process Manager
            espPost(VarEsq)
            ncContract()

            Return

        }Else{
            return
        } 

    }else{
        MsgBox, 4096, Error, ESCOLHA ENTRE 1 E 2!
    }

}

printNc(){

    WinWait, ahk_class XLMAIN
    IfWinActive, ahk_class XLMAIN
        Sleep, 500
    Send, {CtrlDown}{p}{CtrlUp}
    Sleep, 1500
    Send, {Enter}
    WinWait, ahk_class XLMAIN
    Sleep, 1000
    IfWinNotActive, ahk_class XLMAIN
        WinActivate, ahk_class XLMAIN
    WinClose, ahk_class XLMAIN
    Send, {n}
Return
}

^Home::ExitApp
F1::ncContract()Return
PartName(){
    ClipboardBkp := % Clipboard
    IfWinNotActive, Cimatron Explorer
        Return
    Send, ^c
    Clipwait						
    SplitPath, Clipboard, name
    clipboard := name		
    StringSplit, word_array, name, .,
    NcName := % word_array1
    Clipboard := % ClipboardBkp
Return NcName
}

~XButton1::
    KeyWait, XButton1, U
    KeyWait, XButton1, D, T0.2
    If (ErrorLevel = 0)
        send, {F8}
return

XButton2:: Send, {F6}
MsgBox, OI


ShowTip(s:="", pos:= "X1025y5", color:="Red|00FFFF") {
    static bak, idx
    if (bak=color "," pos "," s)
        return
    bak:=color "," pos "," s
    SetTimer, ShowTip_ChangeColor, Off
    Gui, ShowTip: Destroy
    if (s="")
        return
    Gui, ShowTip: +LastFound +AlwaysOnTop +ToolWindow -Caption +E0x08000020
    Gui, ShowTip: Color, FFFFF0
    WinSet, TransColor, FFFFF0 150
    Gui, ShowTip: Margin, 10, 5
    Gui, ShowTip: Font, Q3 s9 bold
    Gui, ShowTip: Add, Text,, %s%
    Gui, ShowTip: Show, NA %pos%, ShowTip
    SetTimer, ShowTip_ChangeColor, 1000
ShowTip_ChangeColor:
    Gui, ShowTip: +AlwaysOnTop
    r:=StrSplit(SubStr(bak,1,InStr(bak,",")-1),"|")
    Gui, ShowTip: Font, % "Q3 c" r[idx:=Mod(Round(idx),r.length())+1]
    GuiControl, ShowTip: Font, Static1
return
}
