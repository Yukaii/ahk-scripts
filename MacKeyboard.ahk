;-----------------------------------------
; Mac keyboard to Windows Key Mappings
;=========================================

; --------------------------------------------------------------
; NOTES
; --------------------------------------------------------------
; ! = ALT
; ^ = CTRL
; + = SHIFT
; # = WIN
;
; Debug action snippet: MsgBox You pressed Control-A while Notepad is active.

#InstallKeybdHook
#SingleInstance force
SetTitleMatchMode 2
SendMode Input

; --------------------------------------------------------------
; OS X system shortcuts
; --------------------------------------------------------------

; Make Ctrl + S work with cmd (windows) key
#s::^s

; Selecting
#a::^a

; Copying
#c::^c

; Pasting
#v::^v

; Cutting
#x::^x

; Opening
#o::^o

; Finding
#f::Send ^f

; Undo
#z::^z

; Redo
#y::^y

; New tab
#t::^t

; close tab
#w::^w

; Close windows (cmd + q to Alt + F4)
#q::Send !{F4}

; Remap Windows + Tab to Alt + Tab.
; Lwin & Tab::AltTab

; --------------------------------------------------------------
; Virtual Desktop Shortcut
; --------------------------------------------------------------

^!Left::Send #^{Left}
^!Right::Send #^{Right}
^!Up::Send #{Tab}

; Be sure to setup https://github.com/Eun/MoveToDesktop
; Move windown to another desktop
^+[::
  Send #!{Left}
  Send ^#{Left}
  Return
^+]::
  Send #!{Right}
  Send ^#{Right}
  Return

; --------------------------------------------------------------
; Text Editing Shortcut
; --------------------------------------------------------------

#Left::Send {Home}
#Right::Send {End}
#Up::Send ^{Home}
#Down::Send ^{End}

+#Left::Send +{Home}
+#Right::Send +{End}
+#Up::Send ^+{Home}
+#Down::Send ^+{End}

!Left::Send ^{Left}
!Right::Send ^{Right}

!+Left::Send ^+{Left}
!+Right::Send ^+{Right}

GroupAdd excludeEdit, ahk_exe ConEmu.exe
#IfWinNotActive ahk_group excludeEdit
{
  !BackSpace::Send ^{BackSpace}
}

#BackSpace::
  Send +{Home}
  Send {BackSpace}
return

; --------------------------------------------------------------
; Window Control
; --------------------------------------------------------------

#m::WinMinimize,a ; minimize windows
!+m::WinMaximize,a
!+n::WinRestore,a

!+l::Send #{Right}
!+h::Send #{Left}

!+c::CenterActiveWindow()

!#+h::MoveWindow(-10, 0)
!#+l::MoveWindow(10, 0)
!#+j::MoveWindow(0, 10)
!#+k::MoveWindow(0, -10)

^!#+h::ResizeWindow(-10, 0)
^!#+l::ResizeWindow(10, 0)
^!#+j::ResizeWindow(0, 10)
^!#+k::ResizeWindow(0, -10)


; Modify from https://superuser.com/a/691418
; Active window switcher
#`:: ; Next window
WinGet, ActiveProcess, ProcessName, A
WinGet, WinClassCount, Count, ahk_exe %ActiveProcess%

IF WinClassCount = 1
  Return
Else
WinGet, List, List, % "ahk_exe " ActiveProcess
Loop, % List
{
  index := List - A_Index + 1
  WinGet, State, MinMax, % "ahk_id " List%index%
  if (State <> -1)
  {
    WinID := List%index%
    break
  }
}
WinActivate, % "ahk_id " WinID
return

#+`:: ; Last window
WinGet, ActiveProcess, ProcessName, A
WinGet, WinClassCount, Count, ahk_exe %ActiveProcess%
IF WinClassCount = 1
  Return
Else
WinGet, List, List, % "ahk_exe " ActiveProcess
Loop, % List
{
  index := List - A_Index + 1
  WinGet, State, MinMax, % "ahk_id " List%index%
  if (State <> -1)
  {
    WinID := List%index%
    break
  }
}
WinActivate, % "ahk_id " WinID
return

CenterActiveWindow()
{
  WinGetPos,,, Width, Height, A
  WinGetPos,,,,h, ahk_class Shell_TrayWnd
  WinMove, A, , (A_ScreenWidth/2)-(Width/2), ((A_ScreenHeight-h)/2)-(Height/2)
}

MoveWindow(moveX, moveY)
{
  WinGetPos, X, Y, , , A
  WinMove, A, , X + moveX, Y + moveY
}

ResizeWindow(deltaWidth, deltaHeight)
{
  WinGetPos, , , W, H, A
  WinMove, A, , , , W + deltaWidth, H + deltaHeight
}

; --------------------------------------------------------------
; Application specific
; --------------------------------------------------------------

; Opera
#IfWinActive, ahk_exe opera.exe
{
  ; Show Web Developer Tools with cmd + alt + i
  #!i::Send ^+i

  ; Show source code with cmd + alt + u
  #!u::Send ^u

  ; next/previous remapping
  ^n::Send {Down}
  ^p::Send {Up}

  ; new window remap
  #n::Send ^n
  #+n::Send ^+n

  #w::Send ^w
  #t::Send ^t

  ; Text editing remap
  ^w::Send ^{BackSpace}

  #+k::Send ^{PgDn}
  #+j::Send ^{PgUp}

  #1::Send ^1
  #2::Send ^2
  #3::Send ^3
  #4::Send ^4
  #5::Send ^5
  #6::Send ^6
  #7::Send ^7
  #8::Send ^8
  #9::
    Send ^1
    Send ^{PgUp}
    return
}

#IfWinActive, ahk_exe Code.exe
{
  ^-::Send !{Left}
  ^+::Send !{Right}
  ^=::Send !{Right}

  #w::Send ^{F4}
}

#IfWinActive, ahk_exe ConEmu.exe
{
  ^w::Send !{BackSpace}
  #w::Send ^w
}
