#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


ShowTip(texto:="", pos:= "x100y100", color:="Red|yellow", size:=9) {
	static bkpParam, i
	if (bkpParam=color "," pos "," texto)
		return
	bkpParam:=color "," pos "," texto
	SetTimer, ShowTip_ChangeColor, Off
	Gui, ShowTip: Destroy
	if (texto="") ; apagar
		return          ; apagar
  ; WS_EX_NOACTIVATE:=0x08000000, WS_EX_TRANSPARENT:=0x20
	Gui, ShowTip: +LastFound +AlwaysOnTop +ToolWindow -Caption +E0x08000020
	Gui, ShowTip: Color, FFFFF0
	WinSet, TransColor, FFFFF0 50
	Gui, ShowTip: Margin, 10, 5
	Gui, ShowTip: Font, Q3 s%size% bold
	Gui, ShowTip: Add, Text,, %texto%
	Gui, ShowTip: Show, NA %pos%, ShowTip
	SetTimer, ShowTip_ChangeColor, 1000
	ShowTip_ChangeColor:
	Gui, ShowTip: +AlwaysOnTop
	guardaCores:=StrSplit(SubStr(bkpParam,1,InStr(bkpParam,",")-1),"|")
	Gui, ShowTip: Font, % "Q3 c" guardaCores[i:=Mod(Round(i),guardaCores.length())+1] ; acessa posição 1 ou 2 do array
	GuiControl, ShowTip: Font, Static1
	return
    }


