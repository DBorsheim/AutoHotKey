#SingleInstance force
#include MouseDelta.ahk

ShiftKey := "F24"

VolStart := 0
VolStartFlag := 0

global MediaChangeFlag := False

global xPool := 0

md := new MouseDelta("MouseEvent").Start()
md.SetState(0)

hotkey, % ShiftKey, ShiftPressed
hotkey, % ShiftKey " up", ShiftReleased
return

ShiftPressed:
	if !VolStartFlag
	{
		SoundGet, VolStart
		VolStartFlag := 1
	}

	MouseGetPos, xpos, ypos

	;BlockInput, MouseMove
	md.SetState(1)
	return

ShiftReleased:
	SoundGet, VolEnd
	if (VolStart - VolEnd = 0)
	{
		Send {Media_Play_Pause}
	}
	;BlockInput, MouseMoveOff
	md.SetState(0)
	xPool := 0
	VolStartFlag := 0
	MediaChangeFlag := False
	; Gosub, VolumeOSDHide
	return

XPoolChange(amt){
	xPool += amt

	if (xPool > 300 && !MediaChangeFlag)
	{
		Send {Media_Next}
		xPool := 0
		MediaChangeFlag := True
	}
	if (xPool < -300 && !MediaChangeFlag)
	{
		Send {Media_Prev}
		xPool := 0
		MediaChangeFlag := True
	}
}

; Gets called when mouse moves or stops
; x and y are DELTA moves (Amount moved since last message), NOT coordinates.

MouseEvent(MouseID, x := 0, y := 0){

	if (MouseID){
		SoundSet, +y/-20
		try if ((shellProvider := ComObjCreate("{C2F03A33-21F5-47FA-B4BB-156362A2F239}", "{00000000-0000-0000-C000-000000000046}"))) {
				try if ((flyoutDisp := ComObjQuery(shellProvider, "{41f9d2fb-7834-4ab6-8b1b-73e74064b465}", "{41f9d2fb-7834-4ab6-8b1b-73e74064b465}"))) {
					 DllCall(NumGet(NumGet(flyoutDisp+0)+3*A_PtrSize), "Ptr", flyoutDisp, "Int", 0, "UInt", 0)
					,ObjRelease(flyoutDisp)
				}
				ObjRelease(shellProvider)
				}
		; Gosub, VolumeOSDShow
		if(x != 0)
			XPoolChange(x)
	}
}

VolumeOSDShow:
	SoundGet, CurVol

	CurVol := Round(CurVol)

	Gui, Add, Text,,%CurVol%
	Gui, Show
	return

VolumeOSDHide:
	Gui, Hide
	return