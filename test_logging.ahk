; 
#Warn
; reload after save
~^s::
    Sleep, 300
    ToolTip, RELOADING...
    Reload
Return

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
		this.log("===============================================")
		this.Log("Log started")
	}
	
	Log(str)
	{
		; prefix with a timestamp
		FormatTime, f, hh:mm:ss tt, time
		;MsgBox The current time is %TimeString%
		FileAppend, % f " " str "`n", % this.filename
	}
}


F11::
	alogger := new Logger("log.txt")
	alogger.log("Hello world of logging")
	
	;MsgBox The current time is %TimeStrin%.

Return
