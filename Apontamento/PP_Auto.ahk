#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#SingleInstance, force
SetCapsLockState, On
try XL := ComObjActive("Excel.Application") 				;VERIFICA SE EXCEL ESTÁ RODANDO
Catch { 
    XL := ComObjCreate("Excel.Application") 			;CRIA OBJETO (C.O.M.) EXCEL CASO EXCEL NÃO ESTEJA RODANDO
    XL.Visible := 0											;TORNA OBJETO EXCEL INVISIVEL - O CONTRÁRIO ABRE UMA NOVA PLANILHA DE EXCEL
}
Progress, b w200, Auto Apontamento, Processo Produtivo, MyTitle
Progress, 100 ; Set the position of the bar to 50%.
Sleep, 1000
Progress, Off

ShowTip(" | APONTAMENTO | `n CTRL+F5(REINICIAR)")
; Inicio

DirIni := A_MyDocuments "\Directory.ini"

if FileExist(DirIni){
    Goto, DirIniRun
}Else{

    FileAppend, , %DirIni%

}

DirIniRun:
    global Xlpp 										;CAMINHO PLANILHA PROCESSO PRODUTIVO
    global XlAp 										;CAMINHO PLANILHA APONTAMENTO

    Directory := A_MyDocuments "\Directory.ini"
    IniRead, Xlpp, %Directory%, section10, key		;FAZ LEITURA DO ARQUIVO DIR.INI PARA E JOGA PLANILHA DE PROCESSO PRODUTIVO NA VARIAVEL XlPp
    IniRead, XlAp, %Directory%, section20, key		;FAZ LEITURA DO ARQUIVO DIR.INI PARA E JOGA PLANILHA DE APONTAMENTO NA VARIAVEL XlAp

    if FileExist(Xlpp){
        Goto, MainGui
    }else{
        MsgBox,, Erro, ProcessoProdutivo.xlsx não foi encontrado ou está corrompido.`nSelecione o arquivo novamente.
        FileSelectFile, Xlpp,,,Selecione o arquivo ProcessoProdutivo.xlsx,ProcessoProdutivo.xlsx
        if(Xlpp=""){
            Goto, MainGui

        }
        IniWrite, % Xlpp, %Directory%, section10, key
        Goto, MainGui
    }

MainGui:
    Sleep, 100
    global CommentCheck
    If (XlAp = Null) ;PULA LEITURA SPLIT DO MES, CASO A PLANILHA NÃO SEJA RETORNADA
        Goto, SkipMonth
    SplitDate := ComObjGet(XlAp).Sheets("apontamento").Range("C2").Text ;CRIA OBJETO COM VARIAVEL InitDate APONTANDO DATA
    StringSplit, DateSplited, SplitDate, /, ;FAZ SPLIT DA VARIAVEL POR (/) E JOGA TODAS AS SUBDIVISOES EM UM ARRAY na variavel DateToGui1, DateToGui2, DateToGui3
SkipMonth:
    Gui, Destroy
    CustomColor := #000000
    Gui, Color, CustomColor
    Gui +LastFound +AlwaysOnTop ;+ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
    Gui, Add, Button, w245 h30 x10 y20 gRunAuto ,&Iniciar apontamento automatizado
    Gui, Add, Button, w205 h20 X10 y+5 gRunAp ,Planilha &Apontamento
    Gui, Add, Button, w35 h20 x+5 gSelectAP ,% monthConvert(DateSplited2)
    Gui, Add, Button, x10 w205 h20 y+5 gRunPp ,Processo &Produtivo
    Gui, Add, Button, w35 h20 x+5 gSelectPP ,...
    Gui, Add, Text, x50 cWhite , Velocidade
    Gui, Add, Text, x+70 cWhite , Linha Inicial
    Gui, Add, Slider,w120 x10 y+5 vSpeedF Range50-200,100
    Gui, Add, Edit, W40 X+50
    Gui, Add, UpDown, vUD Range1-200, 1
    Gui, Add, Text, cWhite x15, 0.5x 1x 2x
    Gui, Font, underline
    Gui, Add, Text, gGB cBlue x10 , By GBack
    Gui, Add, Text, x+105 cWhite ,Comentários
    Gui, Add, Checkbox, x+5 vCommentCheck
    Gui, Show, y50 , Processo Produtivo Auto

    DateSplited2 := 0
return

SelectAp: 													;SELECIONA PLANILHA DE APONTAMENTO
    Gui, Destroy
    FileSelectFile, XlAp,,,Selecione o arquivo que deseja Apontar, *Apontamento*.xlsx
    if ErrorLevel{
        MsgBox, Você não selecionou um arquivo.`nPor favor repita o processo
        Goto, MainGui
    }
    IniWrite, % XlAp, %Directory%, section20, key
    Goto, MainGui

SelectPP: 													;SELECIONA PROCESSO PRODUTIVO E SALVA EM UM ARQUIVO (.INI) EM MEUS DOCUMENTOS
    Gui, Destroy
    FileSelectFile, Xlpp,,,Selecione o arquivo ProcessoProdutivo.xlsx,ProcessoProdutivo.xlsx
    if ErrorLevel{
        MsgBox, Você não selecionou um Processo Produtivo.`nPor favor repita o processo
        Goto, MainGui
        Return
    }
    IniWrite, % Xlpp, %Directory%, section10, key
    Goto, MainGui

GuiClose: 													;FECHA APLICAÇÃO
ExitApp
return

RunAp: 														;INICIA PLANILHA DE APONTAMENTO PARA ATUALIZAÇÃO
    if (XlAp){
        Run % XlAp ,,Maximize
    }Else{
        Goto, SelectAp
    }
return

RunPp: 														;INICIA PLANILHA DE PROCESSO PRODUTIVO PARA ATUALIZAÇÃO
    if (Xlpp){
        Run % Xlpp,,Maximize
    }Else{
        Goto, SelectPp
    }
return

GB:															;LINK PARA CONTATO
    Run, www.linkedin.com/in/gabrielluizback,,Maximize
return

RunAuto:
    Gui, Submit
    Gui, Destroy
    MsgBox, 4, , Iniciando apontamento automatizado.`nDeseja continuar?
    IfMsgBox, Yes
    Goto, inicio
    IfMsgBox, No
    Gui, Destroy
    Goto, MainGui

inicio:
    if (UD = 1 )
        UD := 2
    Ini := UD
    SpeedF := SpeedF/100
    Loop, 
    {	

        filepath1 := XlAp
        planilha1 := ComObjGet(FilePath1) 				;OBJETO PARA APONTAMENTO

        filepath2 := Xlpp
        planilha2 := ComObjGet(FilePath2) 				;OBJETO PARA PROCESSO PRODUTIVO

        Cell := "A"Ini
        global Var1 := planilha1.Sheets("apontamento").Range(Cell).Offset(0,1).text 					;CELULA 2 (ORDEM DE SERVIÇO)
        ;global Foundcell1 := planilha2.ActiveSheet.Range("A:A").Find(Var1).offset(0,1).Text 			;PROCURA (PROCESSO PRODUTIVO) NA PLANILHA PROCESSO PRODUTIVO BASEADO NA (O.S.) COLETADA NA PLANILHA APONTAMENTO
        global Foundcell1 := planilha1.Sheets("OS").Range("A:A").Find(Var1).offset(0,1).Text 			;PROCURA (PROCESSO PRODUTIVO) NA ABA OS BASEADO NA (O.S.) COLETADA NA PLANILHA APONTAMENTO
        global FoundCell2 := planilha1.Sheets("apontamento").Range(Cell).Offset(0,0).text 				;CELULA 1 (PROCESSO PRODUTIVO)
        global FoundCell3 := planilha1.Sheets("apontamento").Range(Cell).Offset(0,2).text 				;CELULA 3 (DATA INICIO)
        global FoundCell4 := planilha1.Sheets("apontamento").Range(Cell).Offset(0,3).text 				;CELULA 4 (HORA INICIO)
        global FoundCell5 := planilha1.Sheets("apontamento").Range(Cell).Offset(0,4).text 				;CELULA 5 (DATA FINAL)
        global FoundCell6 := planilha1.Sheets("apontamento").Range(Cell).Offset(0,5).text 				;CELULA 6 (HORA FINAL)
        global FoundCell14 := planilha1.Sheets("apontamento").Range(Cell).Offset(0,14).text 			;COMENTARIO

        if(FoundCell2){																					;SE HOUVER PROCESSO PRODUTIVO
            Post(300/SpeedF)

        }else{
            MsgBox,, PROCESSO PRODUTIVO, Linha %Ini% Não foi encontrada`n`nFinalizando...,3
            TrayTip Auto Apontamento, Apontamento Finalizado
            ToolTip
            Sleep 3000 ; Let it display for 3 seconds.
            HideTrayTip()
            Goto, MainGui
            return

        }

        Ini++
        ToolTip, Pressione CapsLock para parar`nLINHA_%Ini%, 700, 250
    }

return

;

;~~~~~~~~~~~FUNÇÕES~~~~~~~~~~~~~~~~

;
Post(TimerPost) { 											;IMPUT DE TECLAS NO PROGRAMA DE APONTAMENTO (GRV)

    ;IfWinNotActive, ahk_class TFRMENU
    ;WinWait, ahk_class TFRMENU, ,
    state := GetKeyState("CapsLock", "T")
    if (state = 1) {
        Send, % FoundCell1
        Send, {Enter}
        Sleep, 350
        Send, % FoundCell3
        Send, {Enter}
        Sleep, TimerPost
        Send, % FoundCell4
        Send, {Enter}
        Sleep, TimerPost
        Send, % FoundCell5
        Send, {Enter}
        Sleep, TimerPost
        Send, % FoundCell6
        Send, {Enter}
        Sleep, TimerPost
        Send, {1}{5}
        Sleep, 350
        Send, {Enter}
        Sleep, TimerPost
        Send, {Enter}
        Sleep, TimerPost
        if(CommentCheck = 1)
            Send, % FoundCell14
        Send, {Enter}
        Sleep, TimerPost
        return
    }else{
        OkCancelExit("Deseja parar aplicação?")
        return
    }

}

OkCancelExit(confirm_message) 								;MENSAGEM DE CANCELAMENTO
{
    msgbox, 4097, , %confirm_message%
    IfMsgBox Ok
    Reload
    SetCapsLockState, On
}
ShowTip(s:="", pos:= "X1160y5", color:="Red|00FFFF") { 		;EXIBE NOME DO PROGRAMA PARA INDICAR QUE O MESMO ESTÁ RODANDO
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

monthConvert(month){
    Switch month
    {
        Case "01": RETURN "JAN"
        Case "02": RETURN "FEV"
        Case "03": RETURN "MAR"
        Case "04": RETURN "ABR"
        Case "05": RETURN "MAI"
        Case "06": RETURN "JUN"
        Case "07": RETURN "JUL"
        Case "08": RETURN "AGO"
        Case "09": RETURN "SET"
        Case "10": RETURN "OUT"
        Case "11": RETURN "NOV"
        Case "12": RETURN "DEZ"
        Default: RETURN "..."

    } 

}

HideTrayTip() {
    TrayTip ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 200 ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}

NumpadDot::
    IfWinActive, ahk_class XLMAIN
    {
        Send, {Blind}{Shift Down}{vkBF}{Shift Up}
        Return
    }else{
        send, ,
    }
RETURN
vkC2:: 
    IfWinActive, ahk_class XLMAIN
    {
        Send, {Blind}{Shift Down}{vkBF}{Shift Up}
        Return
    }else{
        send, .
    }
RETURN

NumpadEnter::
    IfWinActive, ahk_class XLMAIN
    {
        Send, {TAB}
        Return
    }else{
        Send, {ENTER}
    }
RETURN

^Home::ExitApp

~^F5::Reload



