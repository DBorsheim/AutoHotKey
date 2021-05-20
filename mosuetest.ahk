; This example allows you to move the mouse around to see
; the title of the window currently under the cursor:
#Persistent
SetTimer, WatchCursor, 10
return

WatchCursor:
SoundGet, sound
ToolTip, % Round(sound)
return