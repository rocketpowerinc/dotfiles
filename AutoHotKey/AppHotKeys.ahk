; Launch Help with Ctrl + Shift + H
^+h::MsgBox("Ctrl+Shift+Q works")

; Launch Notion with Ctrl + Shift + N
^+n::Run("C:\Users\rocket\AppData\Local\Programs\Notion\Notion.exe")

; Launch Firefox
^+b::Run("C:\Program Files\Mozilla Firefox\firefox.exe")

; Launch Windows Terminal with Ctrl + Shift + Enter
^+Enter::Run("C:\Users\rocket\AppData\Local\Microsoft\WindowsApps\wt.exe")

; Launch File Explorer with Ctrl + Shift + F
^+f::Run("C:\Windows\explorer.exe")

; Optional: Confirm script is running
TrayTip("Hotkeys are active")
SoundBeep()