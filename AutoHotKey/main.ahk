#Requires AutoHotkey v2.0
#SingleInstance Force
#WinActivateForce
KeyHistory 500 ; Max 500

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
::]reload:: {
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
;*#>>>>>>>  Help Menu
;*#>>>>>>>

; Launch Help with Ctrl + Shift + H
^+h:: {
  ; Create the Help GUI
  HelpGUI := Gui("+Resize +MinSize600x500", "AutoHotkey Script Help - All Hotkeys & Text Expansions")
  HelpGUI.SetFont("s10")

  ; Add title
  HelpGUI.Add("Text", "x10 y10 w580 h30 Center", "🚀 Main.ahk Script - All Available Commands").SetFont("s14 Bold")

  ; Create tabs for organization
  TabControl := HelpGUI.Add("Tab3", "x10 y50 w580 h410", ["Hotkeys", "Virtual Desktops", "Text Expansions", "System"])

  ; Tab 1: Hotkeys (Combined App Launchers and Actions)
  TabControl.UseTab(1)
  HelpGUI.Add("Text", "x20 y80 w560 h20", "Application Launchers:").SetFont("s12 Bold")
  HelpGUI.Add("Text", "x30 y105 w540 h180", 
  "Ctrl + Shift + N → Launch Notion`n" .
  "Ctrl + Shift + O → Launch Todoist`n" .
  "Ctrl + Shift + D → Launch Docker Desktop`n" .
  "Ctrl + Shift + B → Launch Firefox`n" .
  "Ctrl + Shift + Enter → Launch Windows Terminal`n" .
  "Ctrl + Shift + F → Launch File Explorer`n" .
  "Ctrl + Shift + S → Launch Spotify`n" .
  "Ctrl + Shift + A → Launch go-pwr`n" .
  "Ctrl + Shift + G → Launch Steam`n" .
  "Ctrl + Shift + J → Launch JDownloader2`n" .
  "Ctrl + Shift + Q → Launch qBittorrent")

  HelpGUI.Add("Text", "x20 y295 w560 h20", "Window & System Actions:").SetFont("s12 Bold")
  HelpGUI.Add("Text", "x30 y320 w540 h100",
  "Ctrl + Shift + Up → Toggle Always On Top`n" .
  "Ctrl + Shift + Down → Minimize All Windows`n" .
  "Ctrl + Shift + Left → Go to Virtual Desktop 1`n" .
  "Ctrl + Shift + F2 → Empty Recycle Bin`n" .
  "Ctrl + Shift + H → Show This Help Menu`n" .
  "Ctrl + Shift + F1 → Update Script from GitHub")

  ; Tab 2: Virtual Desktops
  TabControl.UseTab(2)
  HelpGUI.Add("Text", "x20 y80 w560 h20", "Virtual Desktop Setup:").SetFont("s12 Bold")
  HelpGUI.Add("Text", "x30 y105 w540 h300",
  "Ctrl + Shift + F3 → Setup 5 Virtual Desktops with Apps`n`n" .
  "This creates exactly 5 virtual desktops and launches:`n" .
  "• Desktop 1: Notion + Firefox (split screen)`n" .
  "• Desktop 2: VS Code with scriptbin project`n" .
  "• Desktop 3: VS Code with dotfiles project`n" .
  "• Desktop 4: VS Code with docker project`n" .
  "• Desktop 5: VS Code with appbundles project`n`n" .
  "Quick Navigation:`n" .
  "• Ctrl + Shift + Left → Jump to Desktop 1 from anywhere")

  ; Tab 3: Text Expansions
  TabControl.UseTab(3)
  HelpGUI.Add("Text", "x20 y80 w560 h20", "Text Expansions (type these anywhere):").SetFont("s12 Bold")

  HelpGUI.Add("Text", "x30 y105 w540 h18", "Server Shortcuts:").SetFont("s11 Bold")
  HelpGUI.Add("Text", "x40 y125 w520 h40",
  "]spooty.local → http://192.168.1.2:3013`n" .
  "]glance.local → http://192.168.1.2:3002")

  HelpGUI.Add("Text", "x30 y175 w540 h18", "Quick Actions:").SetFont("s11 Bold")
  HelpGUI.Add("Text", "x40 y195 w520 h40",
  "]pirate → Opens multiple piracy/media websites`n" .
  "]reload → Reloads this AutoHotkey script")

  ; Tab 4: System Info
  TabControl.UseTab(4)
  HelpGUI.Add("Text", "x20 y80 w560 h20", "System Information:").SetFont("s12 Bold")
  HelpGUI.Add("Text", "x30 y105 w540 h280",
  "Script Status: ✅ Active and Running`n`n" .
  "AutoHotkey Version: v2.0`n" .
  "Single Instance: Enabled`n`n" .
  "Auto-Update: Ctrl + Shift + F1`n" .
  "GitHub Source: rocketpowerinc/dotfiles`n`n" .
  "Key Symbols:`n" .
  "• # = Windows Key`n" .
  "• ^ = Ctrl Key`n" .
  "• + = Shift Key`n" .
  "• ! = Alt Key")

  ; Add Close button
  CloseBtn := HelpGUI.Add("Button", "x260 y470 w80 h30", "&Close")
  CloseBtn.OnEvent("Click", (*) => HelpGUI.Destroy())

  ; Handle GUI close event
  HelpGUI.OnEvent("Close", (*) => HelpGUI.Destroy())

  ; Show the GUI
  HelpGUI.Show("w600 h510")
}

;*#>>>>>>>
;*#>>>>>>>  Actions
;*#>>>>>>>

; Empty Recycle Bin with Ctrl + Shift + F2
^+F2::Run('powershell.exe -Command "Clear-RecycleBin -Force; (New-Object Media.SoundPlayer \"$env:WINDIR\\Media\\Windows Recycle.wav\").PlaySync()"', , "Hide")

;*#>>>>>>>
;*#>>>>>>>  Arrows
;*#>>>>>>>

; Minimize all windows with Ctrl + Shift + Space
^+Down::WinMinimizeAll

;current window always ontop
^+Up::WinSetAlwaysOnTop -1, "A"

; Go back to Virtual Desktop 1 with Ctrl + Shift + Left Arrow
^+Left:: {
  ToolTip("Going to Desktop 1...")

  Loop 10 {
    Send("{LWin down}{LCtrl down}{Left}{LCtrl up}{LWin up}")
    Sleep(150) ; Longer delay to prevent overwhelming the system
  }

  ; Clear any stuck modifier keys
  Send("{LWin up}{LCtrl up}{Left up}")

  SetTimer(() => ToolTip(), -1000)
}

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
    Send("{LWin down}{LCtrl down}{Left}{LCtrl up}{LWin up}")
    Sleep(150)
  }

  ; Move to last desktop and start closing any extras
  Loop 10 {
    Send("{LWin down}{LCtrl down}{Right}{LCtrl up}{LWin up}")
    Sleep(150)
  }

  ; Now close any desktop we can (this will be desktop 6+)
  Loop 10 {
    Send("{LWin down}{LCtrl down}{F4}{LCtrl up}{LWin up}")
    Sleep(250)
  }

  ; Go back to desktop 1 to start fresh
  Loop 10 {
    Send("{LWin down}{LCtrl down}{Left}{LCtrl up}{LWin up}")
    Sleep(150)
  }

  ; Create exactly 4 more desktops (total of 5)
  ToolTip("Creating desktops...")
  Loop 4 {
    Send("{LWin down}{LCtrl down}d{LCtrl up}{LWin up}")
    Sleep(400) ; Wait for desktop creation
    ; Go back to desktop 1 after each creation
    Loop 10 {
      Send("{LWin down}{LCtrl down}{Left}{LCtrl up}{LWin up}")
      Sleep(80)
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
  Send("{LWin down}{LCtrl down}{Right}{LCtrl up}{LWin up}")
  Sleep(500)
  Run('C:\Users\rocket\vscode-profiles\pwr-vscode\Code.exe -n "C:\Users\rocket\GitHub-pwr\scriptbin"')
  Sleep(2500) ; Wait for VS Code to load
  Send("{LWin down}{Left}{LWin up}") ; Snap to left side
  Sleep(500)

  ; Desktop 3: VS Code with dotfiles
  ToolTip("Setting up Desktop 3: VS Code with dotfiles...")
  Send("{LWin down}{LCtrl down}{Right}{LCtrl up}{LWin up}")
  Sleep(500)
  Run('C:\Users\rocket\vscode-profiles\pwr-vscode\Code.exe -n "C:\Users\rocket\GitHub-pwr\dotfiles"')
  Sleep(2500) ; Wait for VS Code to load
  Send("{LWin down}{Left}{LWin up}") ; Snap to left side
  Sleep(500)

  ; Desktop 4: VS Code with docker
  ToolTip("Setting up Desktop 4: VS Code with docker...")
  Send("{LWin down}{LCtrl down}{Right}{LCtrl up}{LWin up}")
  Sleep(500)
  Run('C:\Users\rocket\vscode-profiles\pwr-vscode\Code.exe -n "C:\Users\rocket\GitHub-pwr\docker"')
  Sleep(2500) ; Wait for VS Code to load
  Send("{LWin down}{Left}{LWin up}") ; Snap to left side
  Sleep(500)

  ; Desktop 5: VS Code with appbundles
  ToolTip("Setting up Desktop 5: VS Code with appbundles...")
  Send("{LWin down}{LCtrl down}{Right}{LCtrl up}{LWin up}")
  Sleep(500)
  Run('C:\Users\rocket\vscode-profiles\pwr-vscode\Code.exe -n "C:\Users\rocket\GitHub-pwr\appbundles"')
  Sleep(2500) ; Wait for VS Code to load
  Send("{LWin down}{Left}{LWin up}") ; Snap to left side
  Sleep(500)

  ; Go back to desktop 1
  ToolTip("Going back to desktop 1...")
  Loop 4 {
    Send("{LWin down}{LCtrl down}{Left}{LCtrl up}{LWin up}")
    Sleep(200)
  }

  ; Clear any stuck modifier keys
  Send("{LWin up}{LCtrl up}")

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