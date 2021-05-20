#NoEnv
Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!
SendMode, Input
SetWorkingDir, %A_ScriptDir%

#SingleInstance, force

#IfWinActive ahk_exe slack.exe

OnMessage(0x404, "AHK_NOTIFYICON")
AHK_NOTIFYICON(wParam, lParam, uMsg, hWnd)
{
	if (lParam = 0x201) ;WM_LBUTTONDOWN := 0x201
	{
		Reload
	}
}

NumpadAdd::
	send, {:}{+}{1}
	sleep 100
	send, {Enter}