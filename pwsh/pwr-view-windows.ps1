# Define commands directly in gum style so variables expand in the chosen string
$command = gum choose `
  'notepad $PROFILE' `
  'notepad $PROFILE.CurrentUserAllHosts' `
  --header "Select which PowerShell profile to open" `
  --cursor "> " `
  --cursor.foreground 99 `
  --selected.foreground 99

# Run the selected command if the user made a choice
if ($command) {
  Invoke-Expression $command
}
