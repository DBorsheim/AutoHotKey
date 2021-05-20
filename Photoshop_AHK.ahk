#NoEnv
Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!
SendMode, Input
SetWorkingDir, %A_ScriptDir%\support_files\

coordmode, pixel, Window
coordmode, mouse, Window

#SingleInstance, force

#IfWinActive ahk_exe Photoshop.exe

OnMessage(0x404, "AHK_NOTIFYICON")
AHK_NOTIFYICON(wParam, lParam, uMsg, hWnd)
{
	if (lParam = 0x201) ;WM_LBUTTONDOWN := 0x201
	{
		Reload
	}
}

^+m::clickOnImage("add a mask.png")
^+!t::
	send, !^+t
	sleep 5
	send {Enter}
	return
F2:: send, ^!+s
F3:: clickOnImage("add a mask.png")
F4::
	send, !^+t
	sleep 5
	send {Enter}
	return
F5:: send, F1
F6::
	send, ^w
	sleep 500
	send, n




clickOnImage(imageName)
{
	IfNotExist, %A_WorkingDir%\%imageName%
    	MsgBox Error: Your file either doesn't exist or isn't in this location.
	ImageSearch, OutputVarX, OutputVarY, 0, 0, 3840, 2160, %A_WorkingDir%\%imageName%
	MouseGetPos, xposP, yposP
	MouseMove, %OutputVarX%, %OutputVarY%, 0
	MouseClick, left, , , 1
	MouseMove, %xposP%, %yposP%, 0
}