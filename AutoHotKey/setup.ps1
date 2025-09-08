############ Temp Clone Repository Snippet ############
# Config
$RepoUrl = "https://github.com/rocketpowerinc/dotfiles.git"
$DownloadPath = Join-Path $env:USERPROFILE "Downloads\Temp\dotfiles"

# Make sure parent directory exists
$parentDir = Split-Path -Parent $DownloadPath
if (-not (Test-Path $parentDir)) {
    New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
}

# Remove old copy if it exists
if (Test-Path $DownloadPath) {
    Write-Host "Removing old folder: $DownloadPath"
    Remove-Item -Recurse -Force $DownloadPath
}

# Clone repository
Write-Host "Cloning $RepoUrl into $DownloadPath..."
git clone $RepoUrl $DownloadPath

Write-Host "Temp folder cloned/refreshed successfully!" -ForegroundColor Green


Copy-Item -Path "C:\Users\rocket\Downloads\Temp\dotfiles\AutoHotKey\main.ahk" `
  -Destination "C:\Users\rocket\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\main.ahk" `
  -Force
