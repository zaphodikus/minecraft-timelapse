#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
FileGetTime ScriptStartModTime, %A_ScriptFullPath%
SetTimer CheckScriptUpdate, 100, 0x7FFFFFFF ; 100 ms, highest priority

; Uncomment the appropiate Send lines below for each tune
^j::
WinActivate, Mountain
SetKeyDelay, 100, 200
WinActivate, Mountain
;==(Achievement) song Hearts
;ControlSend,,	ssfssfsfjhggf, Mountain
;== song Frogs
;ControlSend,, bbaassa`,`,mmnnb, Mountain
;== (Accomplishment) song Snowglobe
;ControlSend,, bbbbcb, Mountain
;== Song Flames
;ControlSend,, cvbnmbm, Mountain
;== (Accomplishment )Song Fish
;ControlSend,, cxzxcccxxxcbb, Mountain
;== Song Coins
;ControlSend,, cccccccbzxc, Mountain
;== Song Blood
;ControlSend,, mmmmmm`,mnab, Mountain
;== (Accomplishment sooner) Song Artefacts
;ControlSend,, vmvmamamadadadgnanad, Mountain
;== (Accomplishment sooner) Song clean mountain
;ControlSend,, sss`,aaam, Mountain
;== (Accomplishment sooner) Apocalypse
;ControlSend,, as`,zb, Mountain

;== (Accomplishment) Unlock keyboard row 3
;ControlSend,, asa`,mnbvcvv, Mountain
;==  SHOW STATS
;ControlSend,, fs`,n`,sfs`,n`,s`,, Mountain
;==  song Hallelujah
;ControlSend,, maaa asss maaa asss as ss sa aa am as, Mountain
;ControlSend,, m as s s am m m as s s am `,mn bvb, Mountain
;ControlSend,, b a f h f vc m s f s vb a f h f vc m s f s xz b `, s `, zx n a d a x, Mountain

;==  song Keyboard cat
;ControlSend,, bnmnbnmn vbnbvbnb cvbvcvbv xxxxxxxx, Mountain

return

CheckScriptUpdate() {
    global ScriptStartModTime
    FileGetTime curModTime, %A_ScriptFullPath%
    If (curModTime == ScriptStartModTime)
        return
    SetTimer CheckScriptUpdate, Off
    Loop
    {
        reload
        ; if the reload fails, the next line will run. Normally this script exits here.
        Sleep 500 ; ms
        MsgBox 0x2, %A_ScriptName%, Reload failed. ; 0x2 = Abort/Retry/Ignore
        IfMsgBox Abort
            ExitApp
        IfMsgBox Ignore
            break
    } ; loops reload on "Retry"
}