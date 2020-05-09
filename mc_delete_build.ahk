; make a backup of C:\Users\conradb\AppData\Roaming\.minecraft\saves\<game>
; Minecraft uses values of 0 to 24000 for times of day
; morning is 21000 , sunset 11000
; remember to turn off clouds, to be in survival mode. And to press F1 to hide the UI
#SingleInstance force

; reload after save
~^s::
    Sleep, 300
    ToolTip, RELOADING...
    Reload
Return


F10::
	SetKeyDelay, 30

	; please edit as needed
	pos1:= new Point(-73, 142, -460)
	pos2:= new Point(-242, 141, -314)   ; Use a 2 block thick area to handle skipped commands
	end_altitude := 68  				; or sea-level (62) wherever you prefer
	start_altitude:= pos1.y
	
	ConsoleCommand("weather clear")
	ConsoleCommand("gamerule doWeatherCycle false")
	; teleport player and mark position of selection
	ConsoleTeleport(pos1)
	ConsoleCommand("/pos1")
	ConsoleTeleport(pos2)
	ConsoleCommand("/pos2")
	sunrise := 21000
	sunset := 11000
	time := sunrise + 24000
	s := % "time set "  time
	ConsoleCommand( s )
	steps:= start_altitude - end_altitude
	interval := (sunrise - sunset)/steps

	; prepare a loop

	;MsgBox, % (4+32)
	;   , % "Timelapse build delete area (" pos1.x "," pos1.z ") - (" pos2.x "," pos2.z ") !"
	;   , % "Will delete all blocks from height " start_altitude " down to " end_altitude ".`nStart deleting?"
	;ifMsgBox, Yes
	if 1
	{
		Sleep 5000
		altitude := start_altitude
		while altitude >= end_altitude
		{
			s := % "time set "  time
			ConsoleCommand( s )
			time += interval
			ConsoleCommand("/shift 1 down")
			ConsoleCommand("/replace air")
			Sleep 1500

			altitude -= 1
			;Sleep 5000 ; large areas may take longer
			;Send, {F2} ; screenshot
		}
	}

Return

; =======================================================
con_open_delay :=140
ConsoleCommand(cmd)
{
	SendInput, /
	Sleep 140
	SendInput % cmd
	Send {Enter}
}

ConsoleTeleport(point)
{
	SendInput, /
	Sleep 140
	SendInput, % "tp @p " point.x " " point.y " " point.z
	Send {Enter}
	Sleep 400 ; this command takes a little while for chunks to load?
}

Print(obj) {
	out := ""
	for each, item in obj
		out .= each ":" item "`n"
	return out
}


Class Point{
	__New(x,y,z)
	{
		this.x:=x
		this.y:=y
		this.z:=z
	}
}

	