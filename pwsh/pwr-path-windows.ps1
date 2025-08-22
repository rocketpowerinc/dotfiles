#! Moving the Dotfile

Clear-Host

# Define source and destination paths
$source = Join-Path $env:USERPROFILE "Downloads\Temp\dotfiles\pwsh\profile.ps1"
$destination = Join-Path $env:USERPROFILE "Dotfiles\pwsh\profile.ps1"

# Ensure destination directory exists
$destDir = Split-Path -Parent $destination
if (-not (Test-Path $destDir)) {
    New-Item -ItemType Directory -Path $destDir -Force | Out-Null
}

# Move the file (overwrite if it exists)
Copy-Item -Path $source -Destination $destination -Force

Write-Host "File copied successfully to $destination" -ForegroundColor Green



# ! Making Sure the Source Path exist in $PROFILE.CurrentUserAllHosts

try {
    # Define the path to the pwsh profile
    $profilePath = $PROFILE.CurrentUserAllHosts
    $DotfilesPath = Join-Path $env:USERPROFILE "Dotfiles\pwsh\profile.ps1"
    $sourceLine = ". `"$DotfilesPath`""  # Corrected quoting and added space before the path

    # Determine the directory containing the profile (no need for $configDir here)
    $profileDirectory = Split-Path -Path $profilePath -Parent

    # Ensure the directory exists
    if (-not (Test-Path $profileDirectory)) {
        New-Item -ItemType Directory -Path $profileDirectory -Force | Out-Null
    }

    # Ensure the profile.ps1 file exists
    if (-not (Test-Path $profilePath)) {
        New-Item -ItemType File -Path $profilePath -Force | Out-Null
    }

    # Check if the profile already sources the dotfiles profile
    if (-not (Get-Content $profilePath | Where-Object { $_ -like "*$($sourceLine.TrimStart('.'))*" })) {
        # Using -like for more robust matching and trimming initial dot
        Add-Content -Path $profilePath -Value $sourceLine
        Write-Host "pwsh profile has been sourced!" -ForegroundColor Green
    }
    else {
        Write-Host "pwsh profile already sourced!" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "An error occurred while sourcing the pwsh profile: $($_.Exception.Message)" -ForegroundColor Red
}