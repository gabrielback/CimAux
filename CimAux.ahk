#SingleInstance, Force
#Include, Library.ahk

SendMode Input
SetWorkingDir, %A_ScriptDir%
IsActive := 1

Gosub, ReadSettings

Settimer, SaveSettings,10000
Settimer, ReadSettings,10000

; ShowTip(" |N_PROG| ", pos:= "X960y5", color:="red|00FFF0")

If (SaveRemember = 1)
    Settimer, TimeToSaveLabel ,% -(TimeToSave*1*1000)

Return



~t:: trimSurface()

~Home:: 
    IfWinExist, Gui77
    {
        Gosub, SaveSettings
        Gui, Destroy
        return
    }
    Gosub, ReadSettings
    Gosub, MainGui
Return

MainGui:
    TargetWindow := "ahk_class Progman"

    Gui, destroy

    if WinExist(TargetWindow) or if WinExist(ahk_class #32770)
    {
        WinGetPos,Xpos, YPos,WidthW,HeightH,%TargetWindow%
        PosX := XPos+80, PosY := YPos +90

        Gui +AlwaysOnTop -Caption +ToolWindow
        Gui, Color, 005090 ;FA0000
        Gui, font,cFF0000 S12 Bold, Arial

        Gui, Add, text, x10 y20 w100 h20, [F6]- NProg:
        Gui, Add, text, x+10 vCNumber gSaveSettings , %CNumber%

        Gui, font,c00FF00 S15 Bold , Arial
        Gui, Add, text, x10 y+10 w100 h20, Functions
        Gui, font,cFF0000 S9 Bold, Arial

        Gui, Add, text,cFF0000 x10 y+5 w100 h20,[F5]- Salvar
        Gui, Add, Text, X10 y+5 w100 h20, SaveTime
        Gui, Add, CheckBox, x+10 Checked%SaveRemember% vSaveRemember gSaveSettings ; 
        Gui, Add, Edit, x+10 w50
        Gui, Add, UpDown, x+10 vTimeToSave gSaveSettings Range1-30, %TimeToSave%

        Gui, Add, text,cFF0000 x10 y+20 w100 h20,[T]- Trimar
        Gui, Add, CheckBox, x+10 Checked%Trim% vTrim gSaveSettings ; 

        Gui, Add, Button,x10 y+20 w50 gCim, Cim
        Gui, Add, Button,x+5 w50 gApt, PP
        Gui, Add, Button,x+5 w50 gPath, Pastas
        Gui, font,cFF0000 S7 Bold, Arial
        Gui, Add, text, c000000 x10 y+5, [HOME]- MINIMIZAR`n[ScrollLock] - PAUSAR`n[CTRL+HOME] - FECHAR

        Gui, Show, NA x%PosX% y%PosY% ,Gui77
        WinSet, TransColor,FA0000, Gui77
    }
return




ReadSettings:
    IniRead,CNumber,Settings.dfd,Settings,Programa_Atual
    IniRead,TimeToSave,Settings.dfd,Settings,TimeSave
    IniRead,Atalho,Settings.dfd,Settings,Tecla_Atalho
    IniRead,Trim,Settings.dfd,Settings,Trim
    IniRead,SaveRemember,Settings.dfd,Settings,SaveRememberCheck
Return

SaveSettings:
    Gui, Submit, NoHide
    IniWrite,%CNumber%,Settings.dfd,Settings,Programa_Atual
    IniWrite,%TimeToSave%,Settings.dfd,Settings,TimeSave
    IniWrite,%Atalho%,Settings.dfd,Settings,Tecla_Atalho
    IniWrite,%Trim%,Settings.dfd,Settings,Trim
    IniWrite,%SaveRemember%,Settings.dfd,Settings,SaveRememberCheck
    Gosub, ReadSettings
Return

F6:: renamePrograms()

F11:: ListVars



; Labels

Tooltip:
    tooltip
Return

Reload:
    Gosub, SaveSettings
    Reload
return

atualiza:
    IfWinNotActive,Gui77
    {
        WinGetPos,Xpos, YPos,WidthW,HeightH,%TargetWindow%
        PosX := XPos+20, PosY := YPos+20
        Gui, Show,x%PosX% y%PosY%,Gui77
        WinMove,Gui77,,PosX,PosY
    }
Return

Cim:
:b0:cim::
    Run, cimatron.ahk
return

Apt:
:b0:apt::
    Run, apontamento\PP_Auto.ahk
return

Path:
:b0:ini::
    Run, paths.ahk
return

TimeToSaveLabel:
    ; ShowTipRemember("Salvar", pos:="x600y400", color:="red|blue|green|yellow", size:=150)
Return

; Hotkeys

^HOME::ExitApp
<^>!UP:: Send, {Volume_Up}
<^>!DOWN:: Send, {Volume_Down}
<^>!NumpadMult:: Send, {Volume_Mute}
<^>!Right::Send {Media_Next}
<^>!Left::Send {Media_Prev}
<^>!Space::Send {Media_Play_Pause}
+NumpadAdd:: Send, {Volume_Up}
+NumpadSub:: Send, {Volume_Down}