#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%



	ShowTipRememberSave(stringText:="", pos:= "x100y100", color:="Red|yellow", size:=9) {
		static bkpParametros, index
		if (bkpParametros=color "," pos "," stringText)
			return
		bkpParametros:=color "," pos "," stringText
		SetTimer, ShowTip_ChangeColorRemember, Off
		Gui, ShowTip: Destroy
		if (stringText="") 
			return 

		Gui, ShowTip: +LastFound +AlwaysOnTop +ToolWindow -Caption +E0x08000020
		Gui, ShowTip: Color, FFFFF0
		WinSet, TransColor, FFFFF0 50
		Gui, ShowTip: Margin, 10, 5
		Gui, ShowTip: Font, Q3 s%size% bold
		Gui, ShowTip: Add, Text,, %stringText%
		Gui, ShowTip: Show, NA %pos%, ShowTip
		SetTimer, ShowTip_ChangeColorRemember, -1000
		ShowTip_ChangeColorRemember:
		Gui, ShowTip: +AlwaysOnTop
		guardaCores:=StrSplit(SubStr(bkpParametros,1,InStr(bkpParametros,",")-1),"|")
		Gui, ShowTip: Font, % "Q3 c" guardaCores[index:=Mod(Round(index),guardaCores.length())+1]
		GuiControl, ShowTip: Font, Static1
		return
	}

