# Define commands directly in gum style so variables expand in the chosen string
$command = gum choose `
  'notepad $PROFILE' `
  'notepad $PROFILE.CurrentUserAllHosts' `
  --header "Select which PowerShell profile to open" `
  --cursor "> " `
  --cursor.foreground "#1E90FF" `
  --selected.foreground "#1E90FF"

# Run the selected command if the user made a choice
if ($command) {
  Invoke-Expression $command
}
