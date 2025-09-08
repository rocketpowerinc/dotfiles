#Requires AutoHotkey v2.0
#SingleInstance Force

; =========================
; Rocket Mini Showcase (AHK v2)
; =========================

; ---- App State ----
isTopMost := true
theme := "dark"

; ---- GUI ----
win := Gui("+AlwaysOnTop +MinSize360x300", "✨ Rocket Mini Showcase")
win.BackColor := "Black"
win.MarginX := 16
win.MarginY := 12

; Status bar
sb := win.AddStatusBar()
sb.SetText("Ready")

; Header
win.SetFont("s14 w700", "Segoe UI")
win.AddText("Center cWhite w320", "Rocket Mini Panel")

; Subheader
win.SetFont("s10 w400", "Segoe UI")
win.AddText("Center cSilver w320", "A tiny window showing off a few controls.")
win.AddText("w320 h1 0x10") ; etched horizontal line

; Tabs
tab := win.AddTab("w340 h220", ["Home", "Controls", "About"])

; =================
; TAB 1: Home
; =================
tab.UseTab(1)

win.SetFont("s10 w600", "Segoe UI")
win.AddText("cWhite", "Live Clock:")
lblTime := win.AddText("w320 cSilver", "")

; Buttons
btnTopMost := win.AddButton("w160", "Disable Always On Top")
btnTheme := win.AddButton("w160 x+20", "Switch to Light Theme")
btnNotify := win.AddButton("w340", "Show Tray Tip Notification")

; Live clock timer
UpdateClock(*) => lblTime.Text := FormatTime(, "yyyy-MM-dd HH:mm:ss")
SetTimer(UpdateClock, 1000)
UpdateClock()

; Wire up buttons
btnTopMost.OnEvent("Click", ToggleTopMost)
btnTheme.OnEvent("Click", ToggleTheme)
btnNotify.OnEvent("Click", (*) => TrayTip("Rocket Mini", "Hello from the tray! ✨`nTry the tray menu.", 3))

; =================
; TAB 2: Controls
; =================
tab.UseTab(2)

win.SetFont("s10 w600", "Segoe UI")
win.AddText("cWhite", "Slider → Progress Bar")

sld := win.AddSlider("w340 Range0-100 ToolTip", 40)
pbr := win.AddProgress("w340 h18 Range0-100", 40)
lblPct := win.AddText("cSilver", "40%")

sld.OnEvent("Change", (*) => (
pbr.Value := sld.Value,
lblPct.Text := sld.Value "%",
sb.SetText("Slider set to " sld.Value)
))

win.AddText("w340 h1 0x10") ; divider

win.AddText("cWhite", "Quick ListView (double-click to edit)")
lv := win.AddListView("w340 r6", ["Name", "Value"])
lv.Add(, "Alpha", "1")
lv.Add(, "Beta", "2")
lv.Add(, "Gamma", "3")
lv.ModifyCol() ; autosize
lv.ModifyCol(2, 160)

; Edit selected row
win.AddText("cSilver", "Edit selected item’s Value:")
txtVal := win.AddEdit("w260")
btnApply := win.AddButton("w70 x+10", "Apply")

lv.OnEvent("DoubleClick", (*) => EditFromSelection())
btnApply.OnEvent("Click", (*) => ApplyEdit())

EditFromSelection() {
  global lv, txtVal, sb
  row := lv.GetNext()
  if (row = 0) {
    MsgBox("Pick a row (double-click) first.", "No selection", "Icon!")
    return
  }
  txtVal.Value := lv.GetText(row, 2)
  sb.SetText("Loaded row " row " into editor")
}

ApplyEdit() {
  global lv, txtVal, sb
  row := lv.GetNext()
  if (row = 0) {
    MsgBox("Nothing selected to update.", "No selection", "Icon!")
    return
  }
  lv.Modify(row, , , txtVal.Value) ; update column 2
  sb.SetText("Row " row " updated")
}

win.AddText("w340 h1 0x10") ; divider

; Simple contrast toggle demo
chkContrast := win.AddCheckbox("Checked", "High-contrast header text")
chkContrast.OnEvent("Click", (*) => (
win.Redraw(),
sb.SetText("Contrast " (chkContrast.Value ? "enabled" : "disabled"))
))

; =================
; TAB 3: About
; =================
tab.UseTab(3)

win.SetFont("s10 w600", "Segoe UI")
win.AddText("cWhite", "About This App")

win.SetFont("s10 w400", "Segoe UI")
aboutLines := [
"AHK Version: " A_AhkVersion
, "OS Version: " A_OSVersion
, "CPU Bits: " (A_PtrSize=8 ? "64-bit" : "32-bit")
, "User: " A_UserName
, "WorkingDir: " A_WorkingDir
]
for line in aboutLines
  win.AddText("cSilver w340", line)

btnDocs := win.AddButton("w340", "Open AutoHotkey Docs (v2)")
btnDocs.OnEvent("Click", (*) => Run("https://www.autohotkey.com/docs/v2/"))

; Finish tabs
tab.UseTab()

; =================
; Window / Tray / Hotkeys
; =================
win.OnEvent("Close", (*) => ExitApp())
win.OnEvent("Escape", (*) => ExitApp())

; Tray menu
A_TrayMenu.Delete()
A_TrayMenu.Add("Show Window", (*) => (win.Show(), sb.SetText("Shown")))
A_TrayMenu.Add("Hide Window", (*) => (win.Hide(), sb.SetText("Hidden")))
A_TrayMenu.Add()
A_TrayMenu.Add("Toggle Always On Top", ToggleTopMost)
A_TrayMenu.Add()
A_TrayMenu.Add("Exit", (*) => ExitApp())

; Handy hotkeys
Hotkey("^!r", (*) => Reload()) ; Ctrl+Alt+R => reload script
Hotkey("^!s", (*) => (win.Visible ? win.Hide() : win.Show())) ; Ctrl+Alt+S => show/hide window

; ---- Helper functions that use globals ----
ToggleTopMost(*) {
  global isTopMost, win, btnTopMost, sb
  isTopMost := !isTopMost
  win.Opt(isTopMost ? "+AlwaysOnTop" : "-AlwaysOnTop")
  if IsSet(btnTopMost) ; button exists only on Home tab
    btnTopMost.Text := isTopMost ? "Disable Always On Top" : "Enable Always On Top"
    sb.SetText("AlwaysOnTop is now " (isTopMost ? "ON" : "OFF"))
  }

  ToggleTheme(*) {
    global theme, win, btnTheme, sb
    if (theme = "dark") {
      theme := "light"
      win.BackColor := "White"
      if IsSet(btnTheme)
        btnTheme.Text := "Switch to Dark Theme"
      sb.SetText("Theme: Light")
    } else {
      theme := "dark"
      win.BackColor := "Black"
      if IsSet(btnTheme)
        btnTheme.Text := "Switch to Light Theme"
      sb.SetText("Theme: Dark")
    }
    win.Redraw()
  }

  ; ---- Show window ----
  win.Show("AutoSize Center")
  TrayTip("Rocket Mini", "Running. Try Ctrl+Alt+R to reload, or use the tray menu.", 5)
  return
