; make a backup of C:\Users\conradb\AppData\Roaming\.minecraft\saves\<game>
; Minecraft uses values of 0 to 24000 for times of day
; morning is 21000 , sunset 11000
; remember to turn off clouds, to be in survival mode. And to press F1 to hide the UI
; NOTE, you must be in fly mode as well!
#SingleInstance force
#Warn

; reload after save
~^s::
    Sleep, 300
    ToolTip, RELOADING...
    Reload
Return


F10::
	SetKeyDelay, 30
	global con_open_delay
	con_open_delay :=1040

	global mylogger
	mylogger:= new Logger("log.txt")
	debug := false

	; please edit as needed
	pos1:= new Point(-73, 142, -460)
	pos2:= new Point(-242, 141, -314)   ; Use a 2 block thick area to handle skipped commands
	end_altitude := 70  				; or sea-level (62) wherever you prefer
	start_altitude:= pos1.y
	
	ConsoleCommand("weather clear")
	ConsoleCommand("gamerule doWeatherCycle false")
	Sleep 1000
	; teleport player and mark position of selection
	ConsoleTeleport(pos1)
	ConsoleCommand("/pos1")
	ConsoleTeleport(pos2)
	ConsoleCommand("/pos2")
	; return player to viewpoint
	ConsoleCommand("tp @p -242 136 -314")

	sunrise := 21000 
	sunset := 22000 + 24000  ; sunset on previous day since we are going backwards
	time := sunset
	s := % "time set "  time
	ConsoleCommand( s )
	steps:= start_altitude - end_altitude
	interval := Floor( Abs(sunrise - sunset)/ (steps +1))
	mylogger.log("=== DEBUG ===")
	mylogger.log("sunset= " sunset)
	mylogger.log("sunrise= " sunrise)
	mylogger.log("interval= " interval)
	mylogger.log("steps= " steps)
	mylogger.log("start_altitude= " start_altitude)
	mylogger.log("end_altitude= " end_altitude)
	
	; prepare a loop
	if ! debug
	{
		Sleep 5000
	} 
	altitude := start_altitude
	while altitude >= end_altitude
	{
		s := % "time set "  time
		ConsoleCommand( s )
		time -= interval
		if ! debug
		{
			ConsoleCommand("/shift 1 down")
			ConsoleCommand("/replace air")
		}
		altitude -= 1
		; delay long enough to let the console overlay fade away
		if ! debug
		{
			Sleep 5500 ; large areas may take longer, but shorter delays cause terrain tearing to be seen
			Send, {F2} ; screenshot
		} else {
			Sleep 100
		}
	}
	; return player to viewpoint
	ConsoleCommand("tp @p -242 136 -314")
Return

; =======================================================

ConsoleCommand(cmd)
{
	global mylogger
	global con_open_delay
	mylogger.log("SendCommand() " cmd)

	SendInput, /
	Sleep % con_open_delay
	SendInput % cmd
	Send {Enter}
}

ConsoleTeleport(point)
{
	global mylogger
	global con_open_delay
	mylogger.log("ConsoleTeleport() " Print(point))
	SendInput, /
	Sleep % con_open_delay
	SendInput, % "tp @p " point.x " " point.y " " point.z
	Send {Enter}
	Sleep 1000 ; this command takes a little while for chunks to load?
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
	
class Logger
{
	__New(filename)
	{
		this.filename:=filename
		this.Start()
	}
	
	Start()
	{
		FileAppend, "`n", % this.filename
		this.log( "===============================================")
		FormatTime, f, ShortDate, time
		this.Log("Logging started on " f )
	}
	
	Log(str)
	{
		; prefix with a timestamp
		FormatTime, f, hh:mm:ss tt, time
		FileAppend, % f " " str "`n", % this.filename
	}
}