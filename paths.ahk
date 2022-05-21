
;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force


; ShowTip(" |PASTAS| "),PathDisplay()

F12::


Run % ReadingPath(1)
MoveUpLeft(500)
Run % ReadingPath(2)
MoveUpRight(500)
Run % ReadingPath(3)
MoveDownLeft(500)
Run % ReadingPath(4)
MoveDownRight(500)
return

PathDisplay(){
Gui, Destroy

Atualiza:
CustomColor := #000000
Gui, Color, CustomColor
Gui +LastFound +AlwaysOnTop +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Add, Button, w205 h20 x10 y20 gLauchAlterar ,&Alterar Pastas
Gui, Add, Button, w100 h50 y+25 gLauchDirectory1 ,% ReadingPath(1)
Gui, Add, Button, w100 h50 x+5 gLauchDirectory2 ,% ReadingPath(2)
Gui, Add, Button, w100 h50 x10 y+5  gLauchDirectory3 ,% ReadingPath(3)
Gui, Add, Button, w100 h50 x+5  gLauchDirectory4 ,% ReadingPath(4)
Gui, Add, Button, w205 h30 x10 y+25 gLauchDirectory5 ,% ReadingPath(5)
Gui, Add, Button, w205 h30 x10 y+5 gLauchDirectory6 ,% ReadingPath(6)
Gui, Font, underline
Gui, Add, Text, gGabrielback cRed y+5 , Por Gabriel Back
Gui, Show, , Alterar Pastas
return
}

GabrielBack:
Run, www.linkedin.com/in/gabrielluizback
return

LauchAlterar:
Gui, Destroy
InputBox, VarDir, Novo diretório:,Digite um novo diretório para salvar ,,,height 150,,,,,% Clipboard
If ErrorLevel
	PathDisplay()

If Errorlevel = 0
	
Gui, Add, Text, , Selecione a posição da pasta
Gui +LastFound +AlwaysOnTop +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Add, Button, w100 h50 y+5 gRunCalc1, Diretório1
Gui, Add, Button, w100 h50 x+5 gRunCalc2, Diretório2
Gui, Add, Button, w100 h50 x10 y+5  gRunCalc3, Diretório3
Gui, Add, Button, w100 h50 x+5  gRunCalc4, Diretório4
Gui, Add, Button, w205 h30 x10 y+5 gRunCalc5, Diretório5
Gui, Add, Button, w205 h30 x10 y+5 gRunCalc6, Diretório6
Gui, Show
return
GuiClose:
ExitApp 
return
Runcalc1:
if (VarDir){
	Gui, Destroy
	IniWrite, %VarDir%, Directory.ini, section1, key
	PathDisplay()
	return
}else{
	MsgBox, O diretorio deve conter algum endereço. Tente novamente.
	return
	}
Runcalc2:
if (VarDir){
	Gui, Destroy
	IniWrite, %VarDir%, Directory.ini, section2, key
	PathDisplay()
	return
}else{
	MsgBox, O diretorio deve conter algum endereço. Tente novamente.
	return
	}
Runcalc3:
if (VarDir){
	Gui, Destroy
	IniWrite, %VarDir%, Directory.ini, section3, key
	PathDisplay()
	return
}else{
	MsgBox, O diretorio deve conter algum endereço. Tente novamente.
	return
	}
Runcalc4:
if (VarDir){
	Gui, Destroy
	IniWrite, %VarDir%, Directory.ini, section4, key
	PathDisplay()
	return
}else{
	MsgBox, O diretorio deve conter algum endereço. Tente novamente.
	return
	}
Runcalc5:
if (VarDir){
	Gui, Destroy
	IniWrite, %VarDir%, Directory.ini, section5, key
	PathDisplay()
	return
}else{
	MsgBox, O diretorio deve conter algum endereço. Tente novamente.
	return
}
Runcalc6:
if (VarDir){
	Gui, Destroy
	IniWrite, %VarDir%, Directory.ini, section6, key
	PathDisplay()
	return
}else{
	MsgBox, O diretorio deve conter algum endereço. Tente novamente.
	return
}

LauchDirectory1:
Run % ReadingPath(1)
MoveUpLeft(500)
return

LauchDirectory2:
Run % ReadingPath(2)
MoveUpRight(500)
return

LauchDirectory3:
Run % ReadingPath(3)
MoveDownLeft(500)
return

LauchDirectory4:
Run % ReadingPath(4)
MoveDownRight(500)
return

LauchDirectory5:
Run % ReadingPath(5),,Maximize
return

LauchDirectory6:
Run % ReadingPath(6),,Maximize
return

MovePath(Direction){
	    SysGet, _, MonitorWorkArea
	   	_Width  := _Right - _Left
    	_Height := _Bottom - _Top
		
		sleep, 1500
		
		Switch Direction
			{
			Case "LeftUp": WinMove, A,, % _Left-7, 1, % _Width/2+14, % _Height/2+7 ;left/up
			Case "RightUp": WinMove, A,, % _Width/2-7, 1, % _Width/2+14, % _Height/2+7 ;right/up
			Case "LeftDown": WinMove, A,, % _Left-7, _Height/2, % _Width/2+14, % _Height/2+7 ;left/down
			Case "LeftRight": WinMove, A,, % _Width/2-7, _Height/2, % _Width/2+14, % _Height/2+7 ;Right/down
			Default: MsgBox, Error(Errorlevel)
				
			}      

		}	


MoveUpLeft(SleepTimer){
	Sleep, SleepTimer
	Send, {Blind}{LWin Down}
	Sleep, SleepTimer
	Send, {Left}{Up}{LWin Up}
	Sleep, SleepTimer
	
	return
}

MoveUpRight(SleepTimer){
	
	Sleep, SleepTimer
	Send, {Blind}{LWin Down}
	Sleep, SleepTimer
	Send, {Right}{Up}{LWin Up}
	Sleep, SleepTimer
	return
}

MoveDownLeft(SleepTimer){
	
	Sleep, SleepTimer
	Send, {Blind}{LWin Down}
	Sleep, SleepTimer
	Send, {Left}{Down}{LWin Up}
	Sleep, SleepTimer
	return
}

MoveDownRight(SleepTimer){
	
	Sleep, SleepTimer
	Send, {Blind}{LWin Down}
	Sleep, SleepTimer
	Send, {Right}{Down}{LWin Up}
	Sleep, SleepTimer
	
	return
}

ReadingPath(Number){
	IniRead, Path%Number%, Directory.ini, section%Number%, key
	Number := % Path%Number%
	return, % Number
}

GetCurrentMonitorWorkArea:
;---------------------------------------------------------------------------
    SysGet, _, MonitorWorkArea
    _Width  := _Right - _Left
    _Height := _Bottom - _Top

Return

^Home::ExitApp

