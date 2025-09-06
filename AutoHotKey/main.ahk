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
::rscript::
^+ScrollLock::          ; CTRL + ALT + Scroll Lock
Run, "C:\Users\rocket\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\main.ahk"
Return


;!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;!;;;;;;;;;;;;;;;;;      Text Expantions    ;;;;;;;;;;;;;;;;;;;;;;
;!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

::]spooty.local::http://192.168.1.2:3013
::]glance.local::http://192.168.1.2:3002

;!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;!;;;;;;;;;;;;;;;;;      HOTKEYS    ;;;;;;;;;;;;;;;;;;;;;;
;!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Launch Help with Ctrl + Shift + H
^+h::MsgBox("Main.ahk script is active")

; Launch Notion with Ctrl + Shift + N
^+n::Run("C:\Users\rocket\AppData\Local\Programs\Notion\Notion.exe")

; Launch Firefox
^+b::Run("C:\Program Files\Mozilla Firefox\firefox.exe")

; Launch Windows Terminal with Ctrl + Shift + Enter
^+Enter::Run("C:\Users\rocket\AppData\Local\Microsoft\WindowsApps\wt.exe")

; Launch File Explorer with Ctrl + Shift + F
^+f::Run("C:\Windows\explorer.exe")

; Optional: Confirm script is running
TrayTip("Main.ahk  script is active")
SoundBeep()