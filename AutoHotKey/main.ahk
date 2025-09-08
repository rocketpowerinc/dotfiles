#Requires AutoHotkey v2.0
#SingleInstance Force

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

^+F1:: {
  ; Run setup script from GitHub before reloading
  Run("powershell.exe -Command `"Invoke-Expression (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/rocketpowerinc/dotfiles/refs/heads/main/AutoHotKey/setup.ps1' -UseBasicParsing).Content`"", , "Hide")
  Sleep(2000) ; Wait for setup to complete
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
  Run("firefox.exe https://www.rottentomatoes.com/ https://ext.to/ https://torrentgalaxy.one/ https://pcgamestorrents.com/ https://www.ziperto.com/ https://dlpsgame.com/category/ps4/ https://getcomics.org/ https://yts.mx/ https://yts.hn/ https://thepiratebay10.xyz/ https://archive.org/ https://fmhy.net/torrenting")
}

;!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;!;;;;;;;;;;;;;;;;;      HOTKEYS    ;;;;;;;;;;;;;;;;;;;;;;
;!;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;*#>>>>>>>
;*#>>>>>>>  Launch Apps
;*#>>>>>>>

; Launch Notion with Ctrl + Shift + N
^+n::Run("C:\Users\rocket\AppData\Local\Programs\Notion\Notion.exe")

; Launch Todoist with Ctrl + Shift + O (T is used for new tabs in browsers)
^+o::Run("C:\Users\rocket\AppData\Local\Programs\todoist\Todoist.exe")

; Launch Docker Desktop with Ctrl + Shift + D
^+d::{
  ; Try to activate Docker Desktop window if it exists but it must be a taskbar pin
  if WinExist("ahk_exe Docker Desktop.exe")
    WinActivate
  else
    Run("C:\Program Files\Docker\Docker\Docker Desktop.exe")
}

; Launch Firefox
^+b::Run("C:\Program Files\Mozilla Firefox\firefox.exe")

; Launch Windows Terminal with Ctrl + Shift + Enter
^+Enter::Run("C:\Users\rocket\AppData\Local\Microsoft\WindowsApps\wt.exe")

; Launch File Explorer with Ctrl + Shift + F
^+f::Run("C:\Windows\explorer.exe")

; Launch Spotify with Ctrl + Shift + S
^+s::Run("C:\Users\rocket\AppData\Roaming\Spotify\Spotify.exe")

; Launch go-pwr with Ctrl + Shift + a
^+a::Run("go-pwr")

; Launch Steam with Ctrl + Shift + g
^+g::Run("C:\Program Files (x86)\Steam\steam.exe")

; Launch Jdownloader2 with Ctrl + Shift + J
^+j::Run("C:\Program Files\JDownloader\JDownloader2.exe")

; Launch Qbittorrent with Ctrl + Shift + Q
^+q::Run("C:\Program Files\qBittorrent\qbittorrent.exe")

;*#>>>>>>>
;*#>>>>>>>  Actions
;*#>>>>>>>

;current window always ontop
^+Up::WinSetAlwaysOnTop -1, "A"

; Launch Help with Ctrl + Shift + H
^+h::MsgBox("Main.ahk script is active")

; Minimize all windows with Ctrl + Shift + Space
^+Space::WinMinimizeAll

; Empty Recycle Bin with Ctrl + Shift + F1
^+F2::Run('powershell.exe -Command "Clear-RecycleBin -Force; (New-Object Media.SoundPlayer \"$env:WINDIR\\Media\\Windows Recycle.wav\").PlaySync()"', , "Hide")

;*#>>>>>>>
;*#>>>>>>>  Virtual Desktops Setup
;*#>>>>>>>

; Ensure exactly 5 virtual desktops and switch to the first one
^+F3:: {
  ; Windows built-in shortcuts:
  ; Win+Ctrl+D = Create new virtual desktop
  ; Win+Ctrl+Left/Right = Switch between desktops
  ; Win+Ctrl+F4 = Close current virtual desktop

  ToolTip("Setting up exactly 5 virtual desktops...")

  ; First, go to desktop 1 to establish a baseline
  Loop 10 {
    Send("#^{Left}")
    Sleep(100)
  }

  ; Move to last desktop and start closing any extras
  Loop 10 {
    Send("#^{Right}")
    Sleep(100)
  }

  ; Now close any desktop we can (this will be desktop 6+)
  Loop 10 {
    Send("#^{F4}") ; Close current desktop
    Sleep(200)
  }

  ; Go back to desktop 1 to start fresh
  Loop 10 {
    Send("#^{Left}")
    Sleep(100)
  }

  ; Create exactly 4 more desktops (total of 5)
  ToolTip("Creating desktops...")
  Loop 4 {
    Send("#^d") ; Create new desktop (this switches to the new desktop)
    Sleep(300) ; Wait for desktop creation
    ; Go back to desktop 1 after each creation
    Loop 10 {
      Send("#^{Left}")
      Sleep(50)
    }
  }

  ; Now we should be on desktop 1 - set up Notion and Firefox
  ToolTip("Setting up Desktop 1: Notion and Firefox...")

  ; Launch Notion
  Run("C:\Users\rocket\AppData\Local\Programs\Notion\Notion.exe")
  Sleep(2500) ; Wait for Notion to load

  ; Snap Notion to left side (Win + Left Arrow)
  Send("#{Left}")
  Sleep(500)

  ; Launch Firefox
  Run("C:\Program Files\Mozilla Firefox\firefox.exe")
  Sleep(2500) ; Wait for Firefox to load

  ; Snap Firefox to right side (Win + Right Arrow)
  Send("#{Right}")
  Sleep(500)

  ; Desktop 2: VS Code with scriptbin
  ToolTip("Setting up Desktop 2: VS Code with scriptbin...")
  Send("#^{Right}") ; Go to desktop 2
  Sleep(500)
  Run('C:\Users\rocket\vscode-profiles\pwr-vscode\Code.exe -n "C:\Users\rocket\GitHub-pwr\scriptbin"')
  Sleep(2500) ; Wait for VS Code to load
  Send("#{Left}") ; Snap to left side
  Sleep(500)

  ; Desktop 3: VS Code with dotfiles
  ToolTip("Setting up Desktop 3: VS Code with dotfiles...")
  Send("#^{Right}") ; Go to desktop 3
  Sleep(500)
  Run('C:\Users\rocket\vscode-profiles\pwr-vscode\Code.exe -n "C:\Users\rocket\GitHub-pwr\dotfiles"')
  Sleep(2500) ; Wait for VS Code to load
  Send("#{Left}") ; Snap to left side
  Sleep(500)

  ; Desktop 4: VS Code with docker
  ToolTip("Setting up Desktop 4: VS Code with docker...")
  Send("#^{Right}") ; Go to desktop 4
  Sleep(500)
  Run('C:\Users\rocket\vscode-profiles\pwr-vscode\Code.exe -n "C:\Users\rocket\GitHub-pwr\docker"')
  Sleep(2500) ; Wait for VS Code to load
  Send("#{Left}") ; Snap to left side
  Sleep(500)

  ; Desktop 5: VS Code with appbundles
  ToolTip("Setting up Desktop 5: VS Code with appbundles...")
  Send("#^{Right}") ; Go to desktop 5
  Sleep(500)
  Run('C:\Users\rocket\vscode-profiles\pwr-vscode\Code.exe -n "C:\Users\rocket\GitHub-pwr\appbundles"')
  Sleep(2500) ; Wait for VS Code to load
  Send("#{Left}") ; Snap to left side
  Sleep(500)

  ; Go back to desktop 1
  ToolTip("Going back to desktop 1...")
  Loop 4 {
    Send("#^{Left}")
    Sleep(200)
  }

  ; Show confirmation
  ToolTip("All 5 Virtual Desktops Ready with Apps!")
  SetTimer(() => ToolTip(), -3000)
}

;*#>>>>>>>
;*#>>>>>>>  keep at bottom of script
;*#>>>>>>>

; Confirm script is running
TrayTip("Main.ahk script is active")
SoundBeep()