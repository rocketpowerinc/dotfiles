Clear-Host

# Define source and destination paths
$source = Join-Path $env:USERPROFILE "Downloads\Temp\dotfiles\glance\glance.yml"
$destination = Join-Path $env:USERPROFILE "Docker\docker-compose\glance\config\glance.yml"

# Ensure destination directory exists
$destDir = Split-Path -Parent $destination
if (-not (Test-Path $destDir)) {
  New-Item -ItemType Directory -Path $destDir -Force | Out-Null
}

# Move the file (overwrite if it exists)
Copy-Item -Path $source -Destination $destination -Force

Write-Host "File copied successfully to $destination" -ForegroundColor Green
