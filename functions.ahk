#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

isActiveCimatron =: ""

    trimSurface(){

        IfWinActive, ahk_class CimatronE Mutext x64
        {

            IfWinExist, Feature Guide, Trim Face,{

                WinWait, Feature Guide, Trim Face 
                WinActivate, ahk_class CimatronE Mutext x64
                Sleep, 200
                Send, {MButton}
                MouseClick, left 
                Sleep, 300
                MouseClick, Right 
                Sleep, 200
                ControlSend,Button2 , %A_Space%, Feature Guide
                return

            } else{
                IfWinActive, ahk_class CimatronE Mutext x64
                    Send, {CTRLDOWN}{SHIFTDOWN}t{SHIFTUP}{CTRLUP}
                return

            }

        }
    }

    renamePrograms(){
        IfWinNotActive, NC Process Manager
            Return
        Send, {F2}
        Send, %CNumber%
        Send, {Enter}
        Sleep, 50
        Send, {Left}
        Sleep, 20
        Send, {Left}
        Send, {Down}
        Send, {Enter}
        CNumber += 1
        ToolTip, %CNumber% 
        ControlSetText, Static2, %CNumber%, Gui77
        SetTimer, Tooltip,2000
        Gosub, SaveSettings
        Return
    }