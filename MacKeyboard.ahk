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
Lwin & Tab::AltTab

; --------------------------------------------------------------
; Text Editing Shortcut
; --------------------------------------------------------------

#Left::Send {Home}
#Right::Send {End}
#Up::Send ^{Home}
#Down::Send ^{End}

+#Left::Send ^+{Home}
+#Right::Send ^+{End}

!Left::Send ^{Left}
!Right::Send ^{Right}

!+Left::Send ^+{Left}
!+Right::Send ^+{Right}

!BackSpace::Send ^{BackSpace}

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

#`::    ; Next window
WinGetClass, ActiveClass, A
WinSet, Bottom,, A
WinActivate, ahk_class %ActiveClass%
return

#~::    ; Last window
WinGetClass, ActiveClass, A
WinActivateBottom, ahk_class %ActiveClass%
return

CenterActiveWindow()
{
  WinGetPos,,, Width, Height, A
  WinMove, A, , (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
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
; OS X keyboard mappings for special chars
; --------------------------------------------------------------

; Map Alt + L to @
!l::SendInput {@}

; Map Alt + N to \
+!7::SendInput {\}

; Map Alt + N to ©
!g::SendInput {©}

; Map Alt + o to ø
!o::SendInput {ø}

; Map Alt + 5 to [
!5::SendInput {[}

; Map Alt + 6 to ]
!6::SendInput {]}

; Map Alt + E to €
!e::SendInput {€}

; Map Alt + - to –
!-::SendInput {–}

; Map Alt + 8 to {
!8::SendInput {{}

; Map Alt + 9 to }
!9::SendInput {}}

; Map Alt + - to ±
!+::SendInput {±}

; Map Alt + R to ®
!r::SendInput {®}

; Map Alt + N to |
!7::SendInput {|}

; Map Alt + W to ∑
!w::SendInput {∑}

; Map Alt + N to ~
!n::SendInput {~}

; Map Alt + 3 to #
!3::SendInput {#}

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
}
