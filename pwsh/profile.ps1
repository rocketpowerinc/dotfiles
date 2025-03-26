#! Profile Path
# Windows Mac Linux
# $PROFILE.CurrentUserAllHosts

#Long Version
#Windows= $env:USERPROFILE\Documents\PowerShell\profile.ps1
#Mac=
#Linux= $HOME/.config/powershell/profile.ps1






#?                   .oodMMMMMMMMMMMMM
#?       ..oodMMM  MMMMMMMMMMMMMMMMMMM
#? oodMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
#? MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
#? MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
#? MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
#? MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
#? MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
#?
#? MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
#? MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
#? MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
#? MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
#? MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
#? `^^^^^^MMMMMMM  MMMMMMMMMMMMMMMMMMM
#?       ````^^^^  ^^MMMMMMMMMMMMMMMMM
#?

if ($IsWindows) {
  #At Boot
  fastfetch

  #todo FYI all the linux LIKE commands are all done automaticaly with Titus Powershell Profile now

  #!#####################################
  #!#         Exported Paths            #
  #!#####################################
  Write-Host "Path Exports:" -ForegroundColor Magenta -NoNewline; Write-Host '$env:USERPROFILE\Bin' -ForegroundColor Blue
  Write-Host "Path Exports:" -ForegroundColor Magenta -NoNewline; Write-Host '$env:USERPROFILE\Bin\Templates' -ForegroundColor Blue
  Write-Host "Path Exports:" -ForegroundColor Magenta -NoNewline; Write-Host '$env:USERPROFILE\Bin\Cross-Platform-Powershell' -ForegroundColor Blue

  $Env:Path += ";$env:USERPROFILE\Bin"
  $Env:Path += ";$env:USERPROFILE\Bin\Templates"
  $Env:Path += ";$env:USERPROFILE\Bin\Cross-Platform-Powershell"

  #!###############################
  #!#         Remember            #
  #!###############################
  Write-Host "Path Exports:" -ForegroundColor Magenta -NoNewline; Write-Host 'HASH!/usr/bin/env bash, echo $XDG_SESSION_TYPE, sudo nixos-rebuild switch, wsl --list --online ' -ForegroundColor Blue  

  #*############################
  #*#         Admin            #
  #*############################

  Write-Host "Admin Commands:" -ForegroundColor Magenta -NoNewline; Write-Host " runas, shutdown, reboot, rebootbios, rebootsettings, test, edit, get-life, resource" -ForegroundColor Blue


  function Test {
    Write-Host -ForegroundColor Red "3..."
    Start-Sleep -Seconds 1
    Write-Host -ForegroundColor Yellow "2..."
    Start-Sleep -Seconds 1
    Write-Host -ForegroundColor Green "1..."
    Start-Sleep -Seconds 1

    Write-Host -ForegroundColor Magenta "TEST"

    Read-Host "Press Enter to Exit"
  }


  Write-Host "Dotfile Commands:" -ForegroundColor Magenta -NoNewline; Write-Host " Edit (PROFILE.CurrentUserAllHosts), EditTitus" -ForegroundColor Blue

  #* Edit pwsh $Profile
  function Edit { notepad $PROFILE.CurrentUserAllHosts }
  function EditTitus { notepad $PROFILE }

  #* Source PWSH
  function resource { . $PROFILE.CurrentUserAllHosts }
  function fff { fastfetch -c all.jsonc }


  function Get-Life {
    # Get the OS installation date
    $osInstallDate = (Get-WmiObject Win32_OperatingSystem).InstallDate
    $osInstallDateParsed = [System.Management.ManagementDateTimeConverter]::ToDateTime($osInstallDate)

    # Get the current date
    $currentDate = Get-Date

    # Calculate the difference in days
    $daysDifference = ($currentDate - $osInstallDateParsed).Days

    # Output the difference
    Write-Output "Windows has been installed for $daysDifference days"
  }



  function runas { Start-Process -Verb RunAs "wt.exe" -ArgumentList "--profile pwsh" }
  function shutdown { shutdown.exe -s -t 0 }
  function reboot { shutdown.exe -r -t 0 }
  function rebootbios { shutdown.exe -t 0 -r -fw }
  function rebootsettings { shutdown.exe -t 0 -r -o }

  #*###############################################################
  #*#                       Navigation                           ##
  #*###############################################################
  Write-Host "Navigation Commands:" -ForegroundColor Magenta -NoNewline; Write-Host " home/hm/~, downloads/dl, desktop/dt, documents/docs, ghub, ......" -ForegroundColor Blue


  function home { Set-Location -Path $env:USERPROFILE }
  function hm { Set-Location -Path $env:USERPROFILE }
  function ~ { Set-Location -Path $env:USERPROFILE }

  function downloads { Set-Location -Path "$env:USERPROFILE\Downloads" }
  function dl { Set-Location -Path "$env:USERPROFILE\Downloads" }

  function desktop { Set-Location -Path "$env:USERPROFILE\Desktop" }
  function dt { Set-Location -Path "$env:USERPROFILE\Desktop" }

  function documents { Set-Location -Path "$env:USERPROFILE\Documents" }
  function docs { Set-Location -Path "$env:USERPROFILE\Documents" }

  function ghub { Set-Location -Path "$env:USERPROFILE\Github" }


  function .. { Set-Location -Path .. }
  function ... { Set-Location -Path ../.. }
  function .... { Set-Location -Path ../../.. }
  function ..... { Set-Location -Path ../../../.. }
  function ...... { Set-Location -Path ../../../../.. }



  #*############################
  #*#         Backups           #
  #*############################
  Write-Host "Backup Commands:" -ForegroundColor Magenta -NoNewline; Write-Host " Zipit, MainStackBackup, ReposBackup, UniGetBackup" -ForegroundColor Blue
  function Zipit { & 'C:\Program Files\7-Zip\7z.exe' a -tzip "archived-$(Get-Date -Format 'yyyy-MM-dd').zip" * -pProxmoxcandyass87! -mem=AES256 -mx=5 }



  #*################################
  #*#         Docker-Compose       #
  #*################################
  Write-Host "Docker-Compose Commands:" -ForegroundColor Magenta -NoNewline; Write-Host " Docker {Up, down, Pull, Update, Clean, IP}" -ForegroundColor Blue

  function DockerUp { docker-compose up -d }

  function DockerDown { docker-compose down }
  function DockerPull { docker-compose pull }
  function DockerUpdate {
    Write-Host "Stopping the Docker Compose services..."
    docker-compose down
    Write-Host "Pulling the latest images..."
    docker-compose pull
    Write-Host "Starting the Docker Compose services in detached mode..."
    docker-compose up -d
    Write-Host "Pruning unused Docker images..."
    docker image prune -af
    Write-Host "Docker Compose services have been updated and cleaned up."
  }

  function DockerClean { docker image prune -af }

  function DockerIP {
    $containers = docker ps -q
    foreach ($container in $containers) {
      $info = docker inspect --format '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container
      $formattedInfo = $info -replace '^/', ''
      Write-Host $formattedInfo -ForegroundColor Yellow
    }
  }

  #*######################################
  #*#         Docker Main-Stack           #
  #*######################################

  Write-Host "Docker Main Stack Commands:" -ForegroundColor Magenta -NoNewline; Write-Host " MainStack {Up, Down, Update, Backup}" -ForegroundColor Blue
  function MainStackUp { & "$env:USERPROFILE\WinPower\Host\Main-Stack\.Stack-Up.ps1" }
  function MainStackDown { & "$env:USERPROFILE\WinPower\Host\Main-Stack\.Stack-Down.ps1" }
  function MainStackUpdate { & "$env:USERPROFILE\WinPower\Host\Main-Stack\.Stack-Update.ps1" }
  function MainStackBackup { & "$env:USERPROFILE\WinPower\Host\Main-Stack\.Stack-Backup.ps1" }

  #*###################################
  #*#         RocketPowerInc          #
  #*###################################
  function Website {
    # Define variables
    $repoURL = "https://github.com/rocketpowerinc/website.git"
    $tempPath = "$([Environment]::GetFolderPath('Desktop'))\temp_repo"
    $targetPath = "$([Environment]::GetFolderPath('Desktop'))\rocketpowerinc-MAIN"

    # Clone the repository into a temporary folder
    Write-Output "Cloning the repository into a temporary folder..."
    git clone $repoURL $tempPath

    # Check if the specific directory exists within the cloned repo
    $sourcePath = Join-Path -Path $tempPath -ChildPath "rocketpowerinc-MAIN"
    if (Test-Path -Path $sourcePath) {
      # Remove the existing target directory on the Desktop, if it exists
      if (Test-Path -Path $targetPath) {
        Write-Output "Target directory 'rocketpowerinc-MAIN' already exists. Deleting it..."
        Remove-Item -Recurse -Force $targetPath
        Write-Output "Existing target directory deleted."
      }

      # Move the new directory to the Desktop
      Write-Output "Moving the 'rocketpowerinc-MAIN' directory to the Desktop..."
      Move-Item -Path $sourcePath -Destination $targetPath -Force
      Write-Output "'rocketpowerinc-MAIN' successfully moved to the Desktop."
    }
    else {
      Write-Output "The 'rocketpowerinc-MAIN' directory does not exist in the repository."
    }

    # Remove the temporary repository folder
    Write-Output "Cleaning up temporary files..."
    Remove-Item -Recurse -Force $tempPath
    Write-Output "Temporary repository folder deleted."
  }


  #*###############################
  #*#         Doomsday            #
  #*###############################
  Write-Host "Doomsday Commands:" -ForegroundColor Magenta -NoNewline; Write-Host " doomsort" -ForegroundColor Blue
  function doomsort {
    # Change Directory
    Set-Location "D:\New Downloads\JDownloader"

    # Move all files to the current directory
    Get-ChildItem -Path . -Recurse -File | Move-Item -Destination .

    # Define the destination variable
    $destination = "$PWD\DELETE"

    # Create the 'Not MP4' folder if it doesn't exist
    if (-not (Test-Path -Path $destination)) {
      New-Item -ItemType Directory -Path $destination
    }

    # Move all files that are not .mp4 to the 'Not MP4' folder
    Get-ChildItem -File -Recurse | Where-Object { $_.Extension -ne ".mp4" } | Move-Item -Destination $destination

    # Move any remaining empty folders to the 'Not MP4' folder, excluding the destination directory itself and its subdirectories
    Get-ChildItem -Directory -Recurse | Where-Object {
      $_.GetFileSystemInfos().Count -eq 0 -and
      $_.FullName -ne $destination -and
      $_.FullName -notlike "$destination\*"
    } | Move-Item -Destination $destination

    # Check again and move any empty folders left after the previous operations, excluding the destination directory itself and its subdirectories
    Get-ChildItem -Directory -Recurse | Where-Object {
      $_.GetFileSystemInfos().Count -eq 0 -and
      $_.FullName -ne $destination -and
      $_.FullName -notlike "$destination\*"
    } | Move-Item -Destination $destination
  }

  #*############################
  #*#         Titus            #
  #*############################
  Write-Host "Titus Commands:" -ForegroundColor Magenta -NoNewline; Write-Host " Titus, TitusDev" -ForegroundColor Blue

  function titus { Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "iwr -useb https://christitus.com/win | iex"' -Verb RunAs }
  function titusdev { Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "irm https://christitus.com/windev | iex"' -Verb RunAs }


  #*##################################
  #*#         Power-Greeter          #
  #*##################################
  Write-Host "RocketPowerInc Commands:" -ForegroundColor Magenta -NoNewline; Write-Host " pwr {pwr-greeter}" -ForegroundColor Blue

  # Define an alias for the script
  Set-Alias -Name pwr-greeter -Value pwr

  # Define the function
  function pwr {
    # Clone the repository into $HOME\Downloads
    $REPO_URL = "https://github.com/rocketpowerinc/windows-greeter.git"
    $DOWNLOAD_PATH = "$env:USERPROFILE\Downloads\windows-greeter"

    # Clean up
    if (Test-Path -Path $DOWNLOAD_PATH) {
      Remove-Item -Recurse -Force $DOWNLOAD_PATH
    }

    # Clone repo
    git clone $REPO_URL $DOWNLOAD_PATH

    # Check if the clone was successful
    if (!(Test-Path -Path $DOWNLOAD_PATH)) {
      [System.Windows.MessageBox]::Show("Failed to clone the repository.", "Error", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
      return
    }

    # Grant execute permissions for any *.ps1 files in the folder
    Get-ChildItem -Path $DOWNLOAD_PATH -Filter "*.ps1" -Recurse | ForEach-Object {
      $_.Attributes = $_.Attributes -bor [System.IO.FileAttributes]::Normal
    }

    # Run the script
    $scriptPath = Join-Path $DOWNLOAD_PATH "pwr-greeter.ps1"
    if (Test-Path -Path $scriptPath) {
      pwsh -ExecutionPolicy Bypass -File $scriptPath -NoLogo -NoExit
    }
    else {
      [System.Windows.MessageBox]::Show("Script not found.", "Error", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
      return
    }

    # Clean up
    Remove-Item -Recurse -Force $DOWNLOAD_PATH
  }



  #*############################
  #*#         PYTHON           #
  #*############################

  Write-Host "Python Commands:" -ForegroundColor Magenta -NoNewline; Write-Host " pyvenv, pyserver" -ForegroundColor Blue

  function pyvenv {
    python -m venv venv
    .\venv\Scripts\Activate.ps1 -Verbose
  }

  function pyserver { python -m http.server 9999 } #*Starts a python server on port 9999 in current folder
}

###################################################################################################
#                       .888
#                     .8888'
#                    .8888'
#                    888'
#                    8'
#       .88888888888. .88888888888.
#    .8888888888888888888888888888888.
#  .8888888888888888888888888888888888.
# .&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
# `%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
# `00000000000000000000000000000000000'
#  `000000000000000000000000000000000'
#   `0000000000000000000000000000000'
#     `###########################'
#       `#######################'
#         `#########''########'
#
elseif ($IsMacOS) {

  #*############################
  #*#         PYTHON           #
  #*############################
  function pyvenv {
    python3 -m venv venv
    .\venv\bin\Activate.ps1
  }

  function pserver { python3 -m http.server 9999 } #*Starts a python server on port 9999 in current folder
}





###################################################################################################
#*    _nnnn_
#*        dGGGGMMb
#*       @p~qp~~qMb
#*       M|@||@) M|
#*       @,----.JM|
#*      JS^\__/  qKL
#*     dZP        qKRb
#*    dZP          qKKb
#*   fZP            SMMb
#*   HZM            MMMM
#*   FqM            MMMM
#* __| ".        |\dS"qML
#* |    `.       | `' \Zq
#*_)      \.___.,|     .'
#*\____   )MMMMMP|   .'
#*     `-'       `--' hjm
#*
elseif ($IsLinux) {

  #!#####################################
  #!#         Exported Paths            #
  #!#####################################
  Write-Host "Path Exports:" -ForegroundColor Magenta -NoNewline; Write-Host '$HOME/.local/bin' -ForegroundColor Blue
  Write-Host "Path Exports:" -ForegroundColor Magenta -NoNewline; Write-Host '$HOME/.local/bin/Templates' -ForegroundColor Blue
  Write-Host "Path Exports:" -ForegroundColor Magenta -NoNewline; Write-Host '$HOME/.local/bin/Cross-Platform-Powershell' -ForegroundColor Blue

  $env:PATH += ":$HOME/.local/bin"
  $env:PATH += ":$HOME/.local/bin/Templates"
  $env:PATH += ":$HOME/.local/bin/Cross-Platform-Powershell"

  function bashtest {
    write-host -ForegroundColor Red "RED TEST..."
  }
  #*############################
  #*#         PYTHON           #
  #*############################
  function pyvenv {
    python3 -m venv venv
    .\venv\bin\Activate.ps1
  }

  function pserver { python3 -m http.server 9999 } #*Starts a python server on port 9999 in current folder



  #*############################
  #*#         Admin            #
  #*############################

  function Test {
    Write-Host -ForegroundColor Red "3..."
    Start-Sleep -Seconds 1
    Write-Host -ForegroundColor Yellow "2..."
    Start-Sleep -Seconds 1
    Write-Host -ForegroundColor Green "1..."
    Start-Sleep -Seconds 1

    Write-Host -ForegroundColor Magenta "TEST"

    Read-Host "Press Enter to Exit"
  }







}


