;https://github.com/how-to-work-from-home/autohotkey/wiki/AutoHotkey-AHK-My-fav-scripts
;!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;! Description:    AutoHotkey scripts that make my daily life a bit easier :)   ;
;!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;* Keyboard shortcuts Matrix
; (hash)                #    Windows logo key
; (exclamation mark)    !    ALT
; (caret)               ^    CTRL
; (plus)                +    Shift

;!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;!;;;;;;;;;;;;;;;;;      Reload main.ahk    ;;;;;;;;;;;;;;;;;;;;;;
;!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
::rscript:: {
  Reload
}

^+ScrollLock:: {
  Reload
}

;!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;!;;;;;;;;;;;;;;;;;      Text Expantions    ;;;;;;;;;;;;;;;;;;;;;;
;!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;*Servers
::]spooty.local::http://192.168.1.2:3013
::]glance.local::http://192.168.1.2:3002

;*Websites
::]pirate:: {
  Run("firefox.exe https://www.rottentomatoes.com/ https://ext.to/ https://torrentgalaxy.one/")
}

;!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;!;;;;;;;;;;;;;;;;;      HOTKEYS    ;;;;;;;;;;;;;;;;;;;;;;
;!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Launch Help with Ctrl + Shift + H
^+h::MsgBox("Main.ahk script is active")

; Launch Notion with Ctrl + Shift + N
^+n::Run("C:\Users\rocket\AppData\Local\Programs\Notion\Notion.exe")

; Launch Todoist with Ctrl + Shift + T
^+t::Run("C:\Users\rocket\AppData\Local\Programs\todoist\Todoist.exe")

; Launch Firefox
^+b::Run("C:\Program Files\Mozilla Firefox\firefox.exe")

; Launch Windows Terminal with Ctrl + Shift + Enter
^+Enter::Run("C:\Users\rocket\AppData\Local\Microsoft\WindowsApps\wt.exe")

; Launch File Explorer with Ctrl + Shift + F
^+f::Run("C:\Windows\explorer.exe")

; Optional: Confirm script is running
TrayTip("Main.ahk script is active")
SoundBeep()