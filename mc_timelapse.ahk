; Mincecraft spectator mode timelapse screenshots script
; Minecraft uses values of 0 to 24000 for times of day
; User must be in creative mode, and the UI must be hidden (press F1)
; /gamemode creative
; F1
F10::
	SetKeyDelay, 30
	
	SendInput, /
	Sleep 100
	SendInput, weather clear
	Send {Enter}
	; normally takes about 8 seconds to stop weather
	Sleep 1000

	SendInput, /
	Sleep 100
	SendInput, gamerule doWeatherCycle false
	Send {Enter}
	Sleep 100
	
	sunrise = 21000
	sunset = 11000
	Loop, 12
	{
		SendInput, /
		; allow for panel to open
		Sleep 200
		
	    time:=(sunrise + (A_Index * 500))
		SendInput time set %time%
		Send {Enter}
		Sleep 5000
		Send, {F2} ; screenshot
	}
	
	Loop, 12
	{
		SendInput, /
		; allow for panel to open
		Sleep 200
		
	    time:=(sunset + (A_Index * 500))
		SendInput time set %time%
		Send {Enter}
		Sleep 5000
		Send, {F2} ; screenshot
	}

Return