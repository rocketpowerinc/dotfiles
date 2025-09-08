#Requires AutoHotkey v2.0
#SingleInstance Force

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

  ; Step 1: Go to the first desktop
  Loop 20 {
    Send("#^{Left}")
    Sleep(25)
  }

  ; Step 2: Close all extra desktops by going right and closing everything beyond desktop 5
  ; Move to desktop 6 (if it exists) and start closing
  Loop 5 {
    Send("#^{Right}")
    Sleep(50)
  }

  ; Now close any desktop we can (this will be desktop 6+)
  Loop 15 {
    Send("#^{F4}") ; Close current desktop
    Sleep(100)
  }

  ; Step 3: Go back to desktop 1
  Loop 20 {
    Send("#^{Left}")
    Sleep(25)
  }

  ; Step 4: Create exactly 4 more desktops (total of 5)
  ToolTip("Creating desktops...")
  Loop 4 {
    Send("#^d") ; Create new desktop
    Sleep(200) ; Increased delay to ensure desktop creation
  }

  ToolTip("Going back to desktop 1...")
  Sleep(500) ; Brief pause before final navigation

  ; Step 5: Go back to desktop 1
  Loop 20 {
    Send("#^{Left}")
    Sleep(50) ; Increased delay for more reliable navigation
  }

  ; Step 6: Launch Notion and Firefox on desktop 1 in split screen
  ToolTip("Launching Notion and Firefox...")

  ; Launch Notion
  Run("C:\Users\rocket\AppData\Local\Programs\Notion\Notion.exe")
  Sleep(2000) ; Wait for Notion to load

  ; Snap Notion to left side (Win + Left Arrow)
  Send("#{Left}")
  Sleep(500)

  ; Launch Firefox
  Run("C:\Program Files\Mozilla Firefox\firefox.exe")
  Sleep(2000) ; Wait for Firefox to load

  ; Snap Firefox to right side (Win + Right Arrow)
  Send("#{Right}")
  Sleep(500)

  ; Step 7: Set up VS Code on desktops 2-5
  ToolTip("Setting up VS Code on other desktops...")

  ; Desktop 2: VS Code with scriptbin
  Send("#^{Right}") ; Go to desktop 2
  Sleep(500)
  Run('C:\Users\rocket\vscode-profiles\pwr-vscode\Code.exe -n "C:\Users\rocket\GitHub-pwr\scriptbin"')
  Sleep(2000) ; Wait for VS Code to load
  Send("#{Left}") ; Snap to left side
  Sleep(500)

  ; Desktop 3: VS Code with dotfiles
  Send("#^{Right}") ; Go to desktop 3
  Sleep(500)
  Run('C:\Users\rocket\vscode-profiles\pwr-vscode\Code.exe -n "C:\Users\rocket\GitHub-pwr\dotfiles"')
  Sleep(2000) ; Wait for VS Code to load
  Send("#{Left}") ; Snap to left side
  Sleep(500)

  ; Desktop 4: VS Code with docker
  Send("#^{Right}") ; Go to desktop 4
  Sleep(500)
  Run('C:\Users\rocket\vscode-profiles\pwr-vscode\Code.exe -n "C:\Users\rocket\GitHub-pwr\docker"')
  Sleep(2000) ; Wait for VS Code to load
  Send("#{Left}") ; Snap to left side
  Sleep(500)

  ; Desktop 5: VS Code with appbundles
  Send("#^{Right}") ; Go to desktop 5
  Sleep(500)
  Run('C:\Users\rocket\vscode-profiles\pwr-vscode\Code.exe -n "C:\Users\rocket\GitHub-pwr\appbundles"')
  Sleep(2000) ; Wait for VS Code to load
  Send("#{Left}") ; Snap to left side
  Sleep(500)

  ; Go back to desktop 1
  Loop 20 {
    Send("#^{Left}")
    Sleep(30)
  }

  ; Step 5: Go back to desktop 1
  Loop 20 {
    Send("#^{Left}")
    Sleep(50) ; Increased delay for more reliable navigation
  }

  ; Show confirmation
  ToolTip("All 5 Virtual Desktops Ready with Apps!")
  SetTimer(() => ToolTip(), -3000)
}