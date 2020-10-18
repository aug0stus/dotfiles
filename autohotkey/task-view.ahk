﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#IfWinActive ahk_class Windows.UI.Core.CoreWindow 
^k::Send, {Up}
^j::Send, {Down}
^h::Send, {Left}
^l::Send, {Right}
#IfWinActive
