#fastfetch #*manually add this in $HOME/.bashrc not here so no conflicts if not installed
#!######################################################################
#!#                    Generic from a Fresh Bashrc                    ##
#!######################################################################

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

#!######################################################################
#!#                            Color Variables                        ##
#!######################################################################
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m" # Magenta (purple)
CYAN="\e[36m"    # Cyan (light blue)
WHITE="\e[37m"   # White
ENDCOLOR="\e[0m"

#!######################################################################
#!#                            Exports                                ##
#!######################################################################

# Paths
export PATH=$PATH:"$HOME/.local/bin:$HOME/.cargo/bin:/var/lib/flatpak/exports/bin:/.local/share/flatpak/exports/bin:$HOME/bin"
export PATH=$PATH:/usr/local/bin #Needed for podman-compose


# $EDITORS
export EDITOR=nvim
export VISUAL=nvim

# ETC
#export BROWSER="firefox" #I can do this is gnome gui
#export READER="zathura"
#export TERMINAL="konsole"
#export VIDEO="vlc"
#export IMAGE=""
#export OPENER="xdg-open"
#export WM="bspwm"

export TERM="xterm-256color"
export COLORTERM="truecolor"

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
#!######################################################################
#!#                            Auto Completion                        ##
#!######################################################################

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest -gt 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest -gt 0 ]]; then bind "set show-all-if-ambiguous On"; fi

#!######################################################################
#!        #######     One Liners From Apache Server       #######     ##
#!######################################################################

alias usl='curl -sSL http://192.168.1.72:9999/RocketOS-2/Ultimate-Script-Launcher.sh | bash'
alias pro='curl -sSL http://192.168.1.72:9999/RocketOS-2/Python-RocketOS.sh | bash'
alias repro='$HOME/Downloads/CustomTkinter-App/bin/python $HOME/Downloads/CustomTkinter-App/App/_MainFrame.py'
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias proexe='echo -e "\033[33mRun pro first if I want a fresh build\033[0m" && sleep 3s && $HOME/Downloads/CustomTkinter-App/bin/pyinstaller  $HOME/Downloads/CustomTkinter-App/_MainFrame_MacOS.spec && /home/rocket/dist/_MainFrame'
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias proexe='echo -e "\033[33mRun pro first if I want a fresh build\033[0m" && sleep 3s && $HOME/Downloads/CustomTkinter-App/bin/pyinstaller  $HOME/Downloads/CustomTkinter-App/_MainFrame_Linux.spec && /home/rocket/dist/_MainFrame'
fi

##########*DOTFILES
propagate-dotfiles() {

    #todo When adding new dotfiles in the proxmox repo also edit EOF-REFRESH-ONELINERS.sh file in the '207 (Apache-Server-CT)' Server
    #Nano
    mkdir $HOME/.nano/backups/ -p
    curl http://192.168.1.207/Dotfiles/nanorc -o ~/.nanorc && echo -e "\e[32mnanorc propagated\e[0m"
    sudo curl http://192.168.1.207/Dotfiles/nanorc -o /root/.nanorc && echo -e "\e[32msudo nanorc propagated\e[0m"

    #Starship
    curl http://192.168.1.207/Dotfiles/starship.toml -o $HOME/.config/starship.toml && echo -e "\e[32mstarship.toml propagated\e[0m"

    #FastFetch
    mkdir $HOME/.config/fastfetch
    curl http://192.168.1.207/Dotfiles/fastfetch.jsonc -o $HOME/.config/fastfetch/config.jsonc && echo -e "\e[32mfastfetch config.jsonc propagated\e[0m"

}

##########*Support Script
alias support-script='curl -o ~/Downloads/Proxmox-Support-Script.sh http://192.168.1.207/Proxmox-Support-Script.sh && chmod +x ~/Downloads/Proxmox-Support-Script.sh && ~/Downloads/Proxmox-Support-Script.sh'

#!#######################
#!        Websites     ##
#!#######################

alias homepage="open http://192.168.1.200:3000/"
alias files="open http://192.168.1.206:8080/"
alias ghactivate="open https://github.com/login/device"

#!###############################################################
#!#                       Source Shells                        ##
#!################################################################
rebash() {
    printf "\033[0;33msourcing .bashrc...\033[0m\n"
    if [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc"
        printf "\033[0;32m.bashrc has been sourced\033[0m\n"
    else
        printf "\033[0;31mError: .bashrc not found\033[0m\n"
    fi
}

#!###############################################################
#!#                        Prompt                              ##
#!###############################################################
#Cyan
PS1="\[\e[01;36m\]\u@\h: bash \w \[\e[5m\e[37m\]#\[\e[25m\e[00m\]"

#!###############################################################
#!#                       Shutdown and restart                 ##
#!###############################################################

#reboot
alias reboot='sudo reboot now'
alias restart='sudo reboot now'
# Alias's for safe and forced reboots
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

#shutdown
alias shutdown='sudo shutdown now'

#Bios
alias boot-manager="sudo systemctl reboot --firmware-setup"

#!###############################################################
#!#                       Maintenance                          ##
#!###############################################################
#*Ubuntu/Debian
alias updatedebian='export NIXPKGS_ALLOW_UNFREE=1 && sudo flatpak update --noninteractive && sudo apt update && sudo apt upgrade -y && nix-channel --update && nix-env -u "*" && (command -v snap >/dev/null 2>&1 && sudo snap refresh)'
alias cleandebian='sudo flatpak uninstall --unused && command sudo apt autoclean && command sudo apt autoremove -y && nix-store --gc'

#*Arch
alias updatearch='export NIXPKGS_ALLOW_UNFREE=1 && sudo pacman -Syu && nix-channel --update && nix-env -u "*"'
alias cleanarch='sudo pacman -Yc && sudo pacman -Sc && nix-store --gc'

#*Fedora
alias updatefedora='export NIXPKGS_ALLOW_UNFREE=1 && sudo dnf check-update && sudo dnf upgrade -y && nix-channel --update && nix-env -u "*"'
alias cleanfedora='sudo dnf autoremove -y && sudo dnf clean all && nix-store --gc'

#*OpenSUSE
alias updateopensuse='export NIXPKGS_ALLOW_UNFREE=1 && sudo zypper dup --allow-vendor-change && sudo zypper refresh && sudo zypper update && sudo zypper patch && sudo zypper install-new-recommends && nix-channel --update && nix-env -u "*"'
alias cleanopensuse='sudo zypper clean && nix-store --gc'

#!###############################################################
#!#                       SystemCTL                            ##
#!###############################################################
alias sdisable='sudo systemctl disable $@'
alias senable='sudo systemctl enable $@'
alias srestart='sudo systemctl restart $@'
alias sstart='sudo systemctl start $@'
alias sstatus='sudo systemctl status $@'

#!###############################################################
#!#                       Navigation                           ##
#!###############################################################

#Home
alias home="cd ~/"
alias hm="cd ~/"
alias ~="cd ~/"

#Downloads
alias downloads="cd ~/Downloads"
alias dl="cd ~/Downloads"

#Desktop
alias desktop="cd ~/Desktop"
alias dt="cd ~/Desktop"

#Documents
alias documents="cd ~/Documents"
alias docs="cd ~/Documents"

#Directory Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

#!###############################################################
#!#                      SPELLING ALIASES                      ##
#!###############################################################

alias sudp='sudo'
alias gerp='grep'

#!###############################################################
#!#                      Remembers                             ##
#!###############################################################

alias shbang='echo -e "#!/usr/bin/env bash"'

#!###############################################################
#!#                       Edit Dotfiles                        ##
#!###############################################################

alias edit='nvim'
alias editv='gnome-text-editor'

#################* Quick
#+$admin
alias fstabrc='sudo nano /etc/fstab'
alias fstabrcv='sudo gnome-text-editor /etc/fstab'

alias hostrc='sudo nano /etc/hosts'
alias hostrcv='sudo gnome-text-editor /etc/hosts'

#+$user
alias bashrc='nano $HOME/.bashrc'
alias bashrcv='gnome-text-editor $HOME/.bashrc'

alias zshrc='nano $HOME/.zshrc'
alias zshrcv='gnome-text-editor $HOME/.zshrc'

alias nanorc='nano $HOME/.nanorc'
alias nanorcv='gnome-text-editor $HOME/.nanorc'
alias sudonanorc='sudo nano /root/.nanorc'
alias sudonanorcv='sudo gnome-text-editor /root/.nanorc'

alias pwshrc='nano $HOME/.config/powershell/profile.ps1'
alias pwshrcv='gnome-text-editor $HOME/.config/powershell/profile.ps1'

alias nvimrc='nano $HOME/.config/nvim/'
alias nvimrcv='gnome-text-editor $HOME/.config/nvim/'

alias fastfetchrc='nano $HOME/.config/fastfetch/config.jsonc'               #*might have to generate file with fastfetch --gen-config (NOT ANY MORE SINCE I HAVE MY OWN CONFIG)
alias fastfetchrcv='gnome-text-editor $HOME/.config/fastfetch/config.jsonc' #*might have to generate file with fastfetch --gen-config (NOT ANY MORE SINCE I HAVE MY OWN CONFIG)

alias atuinrc='nano $HOME/.config/atuin/config.toml'
alias atuinrcv='gnome-text-editor $HOME/.config/atuin/config.toml'

alias starshiprc='nano $HOME/.config/starship.toml'
alias starshiprcv='gnome-text-editor $HOME/.config/starship.toml'

#################* Menu
function editfile() {
    while true; do
        echo -e "\033[0;35mPlease choose an editor:\033[0m"
        select editor in "nano" "gnome-text-editor" "vscode" "neovim" "kate" "gedit" "Quit"; do
            case $editor in
            "nano")
                EDITOR='nano'
                ;;
            "gnome-text-editor")
                EDITOR='gnome-text-editor'
                ;;
            "vscode")
                EDITOR='code'
                ;;
            "neovim")
                EDITOR='nvim'
                ;;
            "kate")
                EDITOR='kate'
                ;;
            "gedit")
                EDITOR='gedit'
                ;;
            "Quit")
                return
                ;;
            *)
                echo -e "\033[0;31minvalid option $REPLY\033[0m"
                continue 2
                ;;
            esac
            if ! command -v $EDITOR &>/dev/null; then
                echo -e "\033[0;31mThe editor $EDITOR is not installed.\033[0m"
                continue 2
            fi
            break
        done
        while true; do
            echo -e "\033[0;35mPlease choose a file you would like to edit:\033[0m"
            select opt in "zshrc" "bashrc" "neofetch" "powershell" "fstab" "hosts" "Quit"; do
                case $opt in
                "zshrc")
                    file="$HOME/.zshrc"
                    ;;
                "bashrc")
                    file="$HOME/.bashrc"
                    ;;
                "neofetch")
                    file="$HOME/.config/neofetch/config.conf"
                    ;;
                "powershell")
                    file="$HOME/.config/powershell/profile.ps1"
                    ;;
                "fstab")
                    file="/etc/fstab"
                    EDITOR="sudo $EDITOR"
                    ;;
                "hosts")
                    file="/etc/hosts"
                    EDITOR="sudo $EDITOR"
                    ;;
                "Quit")
                    return
                    ;;
                *)
                    echo -e "\033[0;31minvalid option $REPLY\033[0m"
                    continue 2
                    ;;
                esac
                if [ -f "$file" ]; then
                    $EDITOR "$file"
                else
                    echo -e "\033[0;31mThe file $file does not exist.\033[0m"
                    continue 2
                fi
                break 2
            done
        done
    done
}

#!###############################################################
#!#                       Emacs                                ##
#!###############################################################
# emacs
alias em="/usr/bin/emacs -nw"
alias emacs="emacsclient -c -a 'emacs'"
alias doomsync="~/.emacs.d/bin/doom sync"
alias doomdoctor="~/.emacs.d/bin/doom doctor"
alias doomupgrade="~/.emacs.d/bin/doom upgrade"
alias doompurge="~/.emacs.d/bin/doom purge"

#!###############################################################
#!#                       SSH                                  ##
#!###############################################################

#Make Private/Public Key Pair in Pink
alias mksshkey='echo -e "\033[1;35mEnter the key name: \033[0m\c" && read keyname && ssh-keygen -t ed25519 -C "$keyname" -f "/home/rocket/.ssh/$keyname" && echo -e "\033[1;35mKey created successfully.\033[0m"'

#Copy from a list of keys
function copykey() {
    echo -e "\033[0;35mPlease choose a file you would like to copy to clipboard:\033[0m"
    select fname in ~/.ssh/*.pub; do
        cat "$fname" | xclip -selection clipboard
        echo -e "\033[0;36mThe key has been copied to your clipboard.\033[0m"
        break
    done
}

#If I'm using sshpass (I would keep my password in that file)
alias pash='sshpass -f /home/rocket/.sshpassfile ssh'
#Or I can keep in plain text like this
#alias pash='sshpass -p 'candyass' ssh rocket@192.168.1.72'

#Remove Old Hosts file to start Fresh
alias rmssh='rm $HOME/.ssh/known_hosts && rm $HOME/.ssh/known_hosts.old'

#!###############################################################
#!#                      Source a File                         ##
#!###############################################################
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#!###############################################################
#!#                       Gum                                  ##
#!###############################################################
alias gumls="gum file"
alias ghome='bash $(gum file $HOME)'
alias gumrocketos="pwsh -c GumRocketOS"

#!###############################################################
#!#                      Nala ALias                            ##
#!###############################################################
#* better way to alias nala so both apt and nala work
#Testing This one works But I am testing -> if nala is installed statement
#apt() {
#    command nala "$@"
#}
#sudo() {
#    if [ "$1" = "apt" ]; then
#        shift
#        command sudo nala "$@"
#    else
#        command sudo "$@"
#    fi
#}

apt() {
    if command -v nala >/dev/null 2>&1; then
        command nala "$@"
    else
        command apt "$@"
    fi
}

sudo() {
    if [ "$1" = "apt" ]; then
        shift
        if command -v nala >/dev/null 2>&1; then
            command sudo nala "$@"
        else
            command sudo apt "$@"
        fi
    else
        command sudo "$@"
    fi
}
#!###############################################################
#!#                       EZA                                  ##
#!###############################################################

if command -v eza &>/dev/null; then
    alias ls='eza -al --color=always --group-directories-first'             # my preferred listing
    alias la='eza -a --color=always --group-directories-first'              # all files and dirs
    alias ll='eza -l --color=always --group-directories-first'              # long format
    alias lt='eza -aT --color=always --group-directories-first'             # tree listing
    alias l.='eza -al --color=always --group-directories-first ../'         # ls on the PARENT directory
    alias l..='eza -al --color=always --group-directories-first ../../'     # ls on directory 2 levels up
    alias l...='eza -al --color=always --group-directories-first ../../../' # ls on directory 3 levels up
fi

#!###############################################################
#!#                            FastFetch                       ##
#!###############################################################

alias ff="fastfetch"               #Should call my config
alias fff="fastfetch -c all.jsonc" #See every available module

#!######################################################################
#!#                            Atuin                                  ##
#!######################################################################
#testing - I am going to install atuin with the provided script instead of nix because it was not working right and this script adds these lines already so no need for them
#[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
#eval "$(atuin init bash)"

#!###############################################################
#!#                       History                              ##
#!###############################################################
#todo commented all out because it would not play nice with bazzite `ujust bazzite-cli` bling command
# Expand the history size
#export HISTFILESIZE=10000
#export HISTSIZE=500
#
## Don't put duplicate lines in the history and do not add lines that start with a space
#export HISTCONTROL=erasedups:ignoredups:ignorespace
#
## Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
#shopt -s histappend
#PROMPT_COMMAND='history -a'
#
## Allow ctrl-S for history navigation (with ctrl-R)
#[[ $- == *i* ]] && stty -ixon
#
##Show all the history stored.
##alias history='"$EDITOR $HISTFILE"' #*commented out because it was cause a annoying line in bazzite
#
##*History Grep (still usefull with atuin installed)
#function h() {
#    echo -e "\033[36mPlease enter the word you would like to search the history for:\033[0m"
#    read term
#    history | grep --color=auto "$term"
#}
#
#!#####################################################
#!#                       Python                     ##
#!#####################################################
alias pvenv='python3 -m venv venv && source venv/bin/activate'

#Python Servers
alias pserver='python3 -m http.server 9999'                    #*Starts a python server on port 9999 in pwd
alias pserverback='nohup python3 -m http.server 9999 &'        #*Starts a python server in the background on port 9999 in pwd and creates a $HOME /nohup.out file
alias pserverbackkill='pkill -f "python3 -m http.server 9999"' #*Kills the python server in the background on port 9999

#!##############################################################################
#!#                       What are my aliases and function                    ##
#!##############################################################################

function showbash() {
    # Part 1: List all aliases in cyan
    echo -e "\e[36mHere are your aliases:\e[0m"
    alias | awk 'BEGIN{FS="="}{print $1}'

    # Print a separator
    echo -e "\e[0m----------------------------------------\e[0m"

    # Part 2: List the last 10 functions in purple
    echo -e "\e[35mThese are the last 10 functions:\e[0m"
    compgen -A function | tail -n 10

    # Reset color
    echo -e "\e[0m"
}

#!###############################################################
#!#                       Fixes and Diagnosing                 ##
#!###############################################################

# Fixes
alias fix-nautilus='rm -rf ~/.config/nautilus'

#Diagnonising
alias jctl="journalctl -p 3 -xb"
alias jf='journalctl -f'
alias topgradewtf='topgrade --dry-run'

alias p="ps aux | grep "
alias topcpu="ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Show all logs in /var/log
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"
#!###############################################################
#!#                       #Open Apps                           ##
#!###############################################################

alias blackbox="flatpak run com.raggesilver.BlackBox"

#!###############################################################
#!#                       Package Managers                     ##
#!###############################################################

#Pacman
alias fixpacman="sudo rm /var/lib/pacman/db.lck"

#Pacman fastest mirrors
alias pacmanmirrors='sudo pacman-mirrors --fasttrack && sudo pacman -Syyu'
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

#!###############################################################
#!#                       ProtonVPN                           ##
#!###############################################################
#Proton vpn Connect/disconnect
alias vpnc='protonvpn-cli connect --cc CA && protonvpn-cli ks --permanent'
alias vpnd='protonvpn-cli ks --off && protonvpn-cli disconnect'

#!###############################################################
#!#                       Shells                               ##
#!###############################################################

#Show Current Shell
alias shell='printf "My current shell - %s\n" "$SHELL"'
alias shells="cat /etc/shells"

#Switch shells
tobash() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sudo chsh -s /opt/homebrew/bin/bash "$USER" && echo 'Now log out.'
    else
        sudo chsh $USER -s /bin/bash && echo 'Now log out.'
    fi
}

tozsh() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sudo chsh -s /bin/zsh "$USER" && echo 'Now log out.'
    else
        sudo chsh $USER -s /bin/zsh && echo 'Now log out.'
    fi
}

tofish() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sudo chsh -s /opt/homebrew/bin/fish "$USER" && echo 'Now log out.'
    else
        sudo chsh $USER -s /bin/fish && echo 'Now log out.'
    fi
}

topwsh() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sudo chsh -s /usr/local/bin/pwsh-preview "$USER" && echo 'Now log out.'
    else
        sudo chsh $USER -s /snap/bin/pwsh-preview && echo 'Now log out.'
    fi
}

#!###############################################################
#!#                       Github                              ##
#!###############################################################

alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status' # 'status' is protected name so using 'stat' instead
alias tag='git tag'
alias newtag='git tag -a'

gcom() {
    git add .
    git commit -m "$1"
}
lazyg() {
    git add .
    git commit -m "$1"
    git push
}
#!###############################################################
#!#                       Misc                                 ##
#!###############################################################
alias df='df -h'               # human-readable sizes
alias free='free -m'           # show sizes in MB
alias grep='grep --color=auto' # colorize output (good for log files)
alias mkdir='mkdir -p'
alias df='df -h'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias locaterefresh='sudo updatedb' #mlocate refresh database
alias grubup="sudo update-grub"
alias diff='colordiff -u'
alias installdeb="sudo dpkg -i"
alias pwdc="pwd| xclip -sel clipboard"
alias clickpaste='sleep 3; xdotool type "$(xclip -o -selection clipboard)"'

# Alias's for archives
alias tarnow='tar -acf'
alias untar='tar -zxvf'
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# cd into the old directory
alias bd='cd "$OLDPWD"'

# Search files in the current folder
alias f="find . | grep "

#vim to nvim
alias vi='nvim'
alias svi='sudo vi'
alias vis='nvim "+set si"'

#htop to bpytop
if command -v btop >/dev/null 2>&1; then
    alias htop="btop"
fi

#DT scripts
alias hub='dm-hub' # reason I dont need the path is cause DT put path in script?

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
#alias rm='rm -i' #*commented out because I use trash instead of rm
alias rmd='rm --recursive --force --verbose' # Remove a directory and all files

#Trash instead of hard deleting
if command -v trash >/dev/null 2>&1; then
    alias rm='trash -v'
fi

# alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# SHA1
alias sha1='openssl sha1'

#Zerotier
alias zt="sudo zerotier-cli status"

#Speed test
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'

# Hardware Info
alias hw='hwinfo --short'

# Alias's to show disk space and space used in a folder
mb() {
    for f in .[^.]* *; do
        if [ -e "$f" ]; then
            du -sh --block-size=1M "$f"
        fi
    done | sort -rh | awk '{print "\033[0;36m" $1 "MB\t" $2 "\033[0m"}'
}
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# alias to show the date
alias da='date "+%Y-%m-%d %A %T %Z"'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
#!###############################################################
#!#                       BAT                                  ##
#!###############################################################

#testing - going to try again because now installing bat with nix
# Check if 'bat' exists at the specified path and is executable
if [[ -x "/home/rocket/.nix-profile/bin/bat" ]]; then
    alias cat='/home/rocket/.nix-profile/bin/bat'
else
    unalias cat 2>/dev/null
fi
#*BATCAT - Simpler if I don't use any of these for conflict reasons with the ubuntu problem

#alias bat='batcat' #for ubuntu only because of a conflict with another package called bat
#alias cat='batcat' #for ubuntu only because of a conflict with another package called bat
#alias cat='bat' # for every other ditro use this one

# Replace batcat with cat on Fedora as batcat is not available as a RPM in any form #* this was a fix from titus
#if command -v lsb_release >/dev/null; then
#    DISTRIBUTION=$(lsb_release -si)
#
#    if [ "$DISTRIBUTION" = "Fedora" ] || [ "$DISTRIBUTION" = "Arch" ]; then
#        alias cat='bat'
#    else
#        alias cat='batcat'
#    fi
#fi
#!###############################################################
#!#                       Rofi                                 ##
#!###############################################################
#alias rofi='rofi -combi-modi window,drun,ssh -theme sidebar -font "hack 10" -show combi -icon-theme "Papirus" -show-icons'
#alias rofi='rofi -combi-modi window,drun,ssh -theme mountains -show combi -show-icons'

#!###############################################################
#!#                       VSCODE                               ##
#!###############################################################

#could make vscode alias's like this to open projects
#alias blog='code /Users/travisrodgers/Desktop/tm-hugo-new/travis-media-hugo'

#!###############################################################
#!#                       Proxmox                              ##
#!###############################################################

#SSH KEYS
alias cprogdesktopkey='read -p $'\''\e[95mEnter the guest ID: \e[0m'\'' id; qm guest exec $id --timeout 0 -- /bin/bash -c '\''echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPPQ1hCyXoqnBo/NiZR/eqxb5aK0rbgUNCkyjhOYz99l ROG-Desktop_key" >> /home/rocket/.ssh/authorized_keys'\'

#Unlock container
alias unlockprox='read -p $'\''\e[95mWhich VM or container would you like to unlock? \e[0m'\'' id; rm /var/lock/qemu-server/lock-$id.conf'

#!###############################################################
#!#                      debian-btrfs-bashrc                   ##
#!###############################################################

# Timeshift On Demand snapshots
snapshot() {
    read -p $'\e[1;32mEnter a comment for the snapshot: \e[0m' myvariable
    sudo timeshift --create --comments "$myvariable"
}

gold-snapshot() {
    read -p $'\e[1;31mAre you sure you want to delete all snapshots and create a single golden snapshot? (y/n): \e[0m' confirm
    if [[ $confirm =~ ^[Yy]$ ]]; then
        read -p $'\e[1;32mEnter a comment for the gold-snapshot -> Note: Goldsnapshot - \e[0m' myvariable
        sudo timeshift --delete-all && sudo timeshift --create --comments "Goldsnapshot - $myvariable"
    else
        echo "Snapshot creation cancelled."
    fi
}

#!###############################################################
#!#                       Distrobox Stuff                      ##
#!###############################################################

alias archbox='distrobox enter Arch' # easier to get to arch box
alias archbox='distrobox enter Arch' # easier to get to arch box

###
# When a command does not exist on your container, it will be automatically executed back on the host:
command_not_found_handle() {
    # this makes it so it don't run if not in a container
    if [ ! -e /run/.containerenv ] && [ ! -e /.dockerenv ]; then
        exit 127
    fi

    distrobox-host-exec "${@}"
}
if [ -n "${ZSH_VERSION-}" ]; then
    command_not_found_handler() {
        command_not_found_handle "$@"
    }
fi

#!######################################################################
#!#                       Update my docker-compose                    ##
#!######################################################################
function compose-update() {

    #*PROMPT ME TO TAKE A SNAPSHOT OF VM OR CT
    # Define a function to display text in yellow
    yellow() {
        echo -e "\e[33m$1\e[0m"
    }

    # Prompt the user
    yellow "Have you taken a snapshot of the VM or CT before updating? (Press Enter to continue, q to quit)"
    read -n 1 -r answer

    # Check the user's response
    if [[ $answer =~ ^[Qq]$ ]]; then
        yellow "Please take a snapshot before proceeding. Stopping script."
        return
    fi

    #*Show running containers list and prompt user to cd into which working container directory

    # Get a list of all running Docker containers
    containers=$(sudo docker ps --format '{{.Names}}')

    # Convert the list into an array
    containers_array=($containers)

    # Use the select command to present the options to the user
    echo "Please select a container to cd in its working directory:"
    select container_name in "${containers_array[@]}"; do
        if [[ -n $container_name ]]; then
            # Use docker inspect to find the working directory
            working_dir=$(sudo docker inspect --format '{{ index .Config.Labels "com.docker.compose.project.working_dir"}}' $container_name)

            # Change to the working directory of the selected container
            cd $working_dir
            echo "Changed directory to: $working_dir"
            break
        else
            echo "Invalid selection"
        fi
    done

    #!UPDATE CONTAINER
    sudo docker-compose down
    sudo docker-compose pull
    sudo docker-compose up -d
    sudo docker image prune -af

}
#!######################################################################
#!#                            Remove App                             ##
#!######################################################################
remove-app() {
    echo -e "\\e[31mEnter the name of the app you want to remove:\\e[0m"
    read app

    if dpkg -s "$app" &>/dev/null; then
        sudo apt remove "$app" -y
        sudo apt purge "$app" -y
        command sudo apt autoclean && sudo apt autoremove
        echo -e "\\e[32mThe app $app has been removed successfully.\\e[0m"
    else
        echo -e "\\e[31mThe app $app is not installed on your system.\\e[0m"
    fi
}

#!######################################################################
#!#                       Titus Functions                             ##
#!######################################################################
#https://github.com/ChrisTitusTech/mybash/blob/main/.bashrc

#######################################################
# SPECIAL FUNCTIONS
#######################################################
# Extracts any archive(s) (if unp isn't installed)
extract() {
    for archive in "$@"; do
        if [ -f "$archive" ]; then
            case $archive in
            *.tar.bz2) tar xvjf $archive ;;
            *.tar.gz) tar xvzf $archive ;;
            *.bz2) bunzip2 $archive ;;
            *.rar) rar x $archive ;;
            *.gz) gunzip $archive ;;
            *.tar) tar xvf $archive ;;
            *.tbz2) tar xvjf $archive ;;
            *.tgz) tar xvzf $archive ;;
            *.zip) unzip $archive ;;
            *.Z) uncompress $archive ;;
            *.7z) 7z x $archive ;;
            *) echo "don't know how to extract '$archive'..." ;;
            esac
        else
            echo "'$archive' is not a valid file!"
        fi
    done
}

# Searches for text in all files in the current folder
ftext() {
    # -i case-insensitive
    # -I ignore binary files
    # -H causes filename to be printed
    # -r recursive search
    # -n causes line number to be printed
    # optional: -F treat search term as a literal, not a regular expression
    # optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
    grep -iIHrn --color=always "$1" . | less -r
}

# Copy file with a progress bar
cpp() {
    set -e
    strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
        awk '{
	count += $NF
	if (count % 10 == 0) {
		percent = count / total_size * 100
		printf "%3d%% [", percent
		for (i=0;i<=percent;i++)
			printf "="
			printf ">"
			for (i=percent;i<100;i++)
				printf " "
				printf "]\r"
			}
		}
	END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}

# Copy and go to the directory
cpg() {
    if [ -d "$2" ]; then
        cp "$1" "$2" && cd "$2"
    else
        cp "$1" "$2"
    fi
}

# Move and go to the directory
mvg() {
    if [ -d "$2" ]; then
        mv "$1" "$2" && cd "$2"
    else
        mv "$1" "$2"
    fi
}

# Create and go to the directory
mkdirg() {
    mkdir -p "$1"
    cd "$1"
}

# Goes up a specified number of directories  (i.e. up 4)
up() {
    local d=""
    limit=$1
    for ((i = 1; i <= limit; i++)); do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}

# Automatically do an ls after each cd, z, or zoxide
cd() {
    if [ -n "$1" ]; then
        builtin cd "$@" && ls
    else
        builtin cd ~ && ls
    fi
}

# Returns the last 2 fields of the working directory
pwdtail() {
    pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

# Show the current distribution
distribution() {
    local dtype="unknown" # Default to unknown

    # Use /etc/os-release for modern distro identification
    if [ -r /etc/os-release ]; then
        source /etc/os-release
        case $ID in
        fedora | rhel | centos)
            dtype="redhat"
            ;;
        sles | opensuse*)
            dtype="suse"
            ;;
        ubuntu | debian)
            dtype="debian"
            ;;
        gentoo)
            dtype="gentoo"
            ;;
        arch)
            dtype="arch"
            ;;
        slackware)
            dtype="slackware"
            ;;
        *)
            # If ID is not recognized, keep dtype as unknown
            ;;
        esac
    fi

    echo $dtype
}

# Show the current version of the operating system
ver() {
    local dtype
    dtype=$(distribution)

    case $dtype in
    "redhat")
        if [ -s /etc/redhat-release ]; then
            cat /etc/redhat-release
        else
            cat /etc/issue
        fi
        uname -a
        ;;
    "suse")
        cat /etc/SuSE-release
        ;;
    "debian")
        lsb_release -a
        ;;
    "gentoo")
        cat /etc/gentoo-release
        ;;
    "arch")
        cat /etc/os-release
        ;;
    "slackware")
        cat /etc/slackware-version
        ;;
    *)
        if [ -s /etc/issue ]; then
            cat /etc/issue
        else
            echo "Error: Unknown distribution"
            exit 1
        fi
        ;;
    esac
}

# Automatically install the needed support files for this .bashrc file
install_bashrc_support() {
    local dtype
    dtype=$(distribution)

    case $dtype in
    "redhat")
        sudo yum install multitail tree zoxide trash-cli fzf bash-completion fastfetch
        ;;
    "suse")
        sudo zypper install multitail tree zoxide trash-cli fzf bash-completion fastfetch
        ;;
    "debian")
        sudo apt-get install multitail tree zoxide trash-cli fzf bash-completion
        # Fetch the latest fastfetch release URL for linux-amd64 deb file
        FASTFETCH_URL=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep "browser_download_url.*linux-amd64.deb" | cut -d '"' -f 4)

        # Download the latest fastfetch deb file
        curl -sL $FASTFETCH_URL -o /tmp/fastfetch_latest_amd64.deb

        # Install the downloaded deb file using apt-get
        sudo apt-get install /tmp/fastfetch_latest_amd64.deb
        ;;
    "arch")
        sudo paru multitail tree zoxide trash-cli fzf bash-completion fastfetch
        ;;
    "slackware")
        echo "No install support for Slackware"
        ;;
    *)
        echo "Unknown distribution"
        ;;
    esac
}

# IP address lookup
alias whatismyip="whatsmyip"
function whatsmyip() {
    # Internal IP Lookup.
    if [ -e /sbin/ip ]; then
        echo -n "Internal IP: "
        /sbin/ip addr show wlan0 | grep "inet " | awk -F: '{print $1}' | awk '{print $2}'
    else
        echo -n "Internal IP: "
        /sbin/ifconfig wlan0 | grep "inet " | awk -F: '{print $1} |' | awk '{print $2}'
    fi

    # External IP Lookup
    echo -n "External IP: "
    curl -s ifconfig.me
}

# View Apache logs
apachelog() {
    if [ -f /etc/httpd/conf/httpd.conf ]; then
        cd /var/log/httpd && ls -xAh && multitail --no-repeat -c -s 2 /var/log/httpd/*_log
    else
        cd /var/log/apache2 && ls -xAh && multitail --no-repeat -c -s 2 /var/log/apache2/*.log
    fi
}

# Edit the Apache configuration
apacheconfig() {
    if [ -f /etc/httpd/conf/httpd.conf ]; then
        sedit /etc/httpd/conf/httpd.conf
    elif [ -f /etc/apache2/apache2.conf ]; then
        sedit /etc/apache2/apache2.conf
    else
        echo "Error: Apache config file could not be found."
        echo "Searching for possible locations:"
        sudo updatedb && locate httpd.conf && locate apache2.conf
    fi
}

# Edit the PHP configuration file
phpconfig() {
    if [ -f /etc/php.ini ]; then
        sedit /etc/php.ini
    elif [ -f /etc/php/php.ini ]; then
        sedit /etc/php/php.ini
    elif [ -f /etc/php5/php.ini ]; then
        sedit /etc/php5/php.ini
    elif [ -f /usr/bin/php5/bin/php.ini ]; then
        sedit /usr/bin/php5/bin/php.ini
    elif [ -f /etc/php5/apache2/php.ini ]; then
        sedit /etc/php5/apache2/php.ini
    else
        echo "Error: php.ini file could not be found."
        echo "Searching for possible locations:"
        sudo updatedb && locate php.ini
    fi
}

# Edit the MySQL configuration file
mysqlconfig() {
    if [ -f /etc/my.cnf ]; then
        sedit /etc/my.cnf
    elif [ -f /etc/mysql/my.cnf ]; then
        sedit /etc/mysql/my.cnf
    elif [ -f /usr/local/etc/my.cnf ]; then
        sedit /usr/local/etc/my.cnf
    elif [ -f /usr/bin/mysql/my.cnf ]; then
        sedit /usr/bin/mysql/my.cnf
    elif [ -f ~/my.cnf ]; then
        sedit ~/my.cnf
    elif [ -f ~/.my.cnf ]; then
        sedit ~/.my.cnf
    else
        echo "Error: my.cnf file could not be found."
        echo "Searching for possible locations:"
        sudo updatedb && locate my.cnf
    fi
}

# Trim leading and trailing spaces (for scripts)
trim() {
    local var=$*
    var="${var#"${var%%[![:space:]]*}"}" # remove leading whitespace characters
    var="${var%"${var##*[![:space:]]}"}" # remove trailing whitespace characters
    echo -n "$var"
}

#+##############################################################################
#+##############################################################################
#+##############################################################################
#+##############################################################################

#+                 ⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣆⠀⠀⠀⠘⣿⣿⣿⣧⡀⠀⣰⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀
#+                 ⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣧⠀⠀⠀⠈⢿⣿⢿⣶⣴⣿⣿⣿⠉⠀⠀⠀⠀⠀⠀⠀
#+                 ⠀⠀⠀⠀⢀⣤⣤⣤⣼⣿⣿⣿⣧⣤⣤⣤⣬⣿⣿⡿⣟⣿⣷⠃⠀⠀⠀⡀⠀⠀⠀⠀
#+                 ⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⡄⠀⠀⠀⣼⣿⡄⠀⠀⠀
#+                 ⠀⠀⠀⠉⠉⠉⠉⠉⣩⣿⣿⣿⠟⠉⠉⠉⠉⠉⠁⠻⣿⣿⣿⣆⢀⣾⣿⣿⡿⠀⠀⠀
#+                 ⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣟⠏⠀⠀⠀⠀⠀⠀⠀⠀⠹⣷⣿⣿⣾⣿⣿⡿⠁⠀⠀⠀
#+                 ⣴⣷⣶⣶⣶⣶⣾⣿⣿⣯⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦
#+                 ⠻⢿⢿⡻⢿⣿⣟⣯⣷⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⡿⠿⠿⠿⠿⠿⠟
#+                 ⠀⠀⠀⢀⣾⣿⢿⡻⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀
#+                 ⠀⠀⠠⣾⣿⣿⠿⠁⠙⣿⣿⣿⣧⣀⣀⣀⣀⣀⣀⣴⣿⣿⣿⣋⣀⣀⣀⣀⣀⠀⠀⠀
#+                 ⠀⠀⠀⠘⢿⡟⠀⠀⠀⢘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀
#+                 ⠀⠀⠀⠀⠈⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⡛⠓⠛⠛⢺⣿⢿⣿⡗⠛⠓⠛⠁⠀⠀⠀⠀
#+                 ⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⠟⢻⣿⣿⣷⡄⠀⠀⠀⠻⣿⣟⣷⣆⠀⠀⠀⠀⠀⠀⠀
#+                 ⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⠏⠀⠀⢻⣿⣿⣿⡄⠀⠀⠀⠹⣿⡿⡟⠀⠀⠀

#+################################################################
function rebuild() {
  sudo nixos-rebuild switch
}



#!+Rebuil NixOS by calling my github repo

#function rebuild() {
#    if gum confirm "Run Part 1 - Refresh sources? "; then
#
#        #Confirm run usl-initial-install-part1.sh
#        echo -e "${MAGENTA}Running Part 1 - Getting Latest Repo Changes...${ENDCOLOR}"
#        cd $HOME && gh api repos/ReevesA1/HyprNix/contents/usl-initial-install-part1.sh | jq -r '.content' | base64 --decode | bash
#
#        #Confirm run usl-initial-install-part2.sh
#        if gum confirm "Run Part 2 - Choose host to run 'sudo nixos-rebuild switch' against? "; then
#            echo -e "${MAGENTA}Running part 2${ENDCOLOR}"
#            /home/rocket/HyprNix/usl-initial-install-part2.sh
#        else
#            echo -e "${RED}Rebuild Canceled${ENDCOLOR}"
#        fi
#
#    else
#        echo -e "${RED}Rebuild Canceled${ENDCOLOR}"
#    fi
#}

function setup_nixpkgs() {
    #*Install with the one-liner
    sudo curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    # Source Bashrc - for nix package manager to take effect
    source ~/.bashrc

    # Enable Nix Daemon
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

    # Add Unstable Channel
    echo -e "\e[33mUpdating Nix Unstable Channel\e[0m"
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable
    nix-channel --update
}

#!###############################  EVALS KEEP AT THE BOTTOM   ###############################################

#!###############################################################
#!#                         Zoxide                             ##
#!###############################################################
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
    bind '"\C-f":"zi\n"'
fi

#*FYI I  will not alias z to cd because I want to keep the cd command but I could with this next line
#eval "$(zoxide init --cmd cd bash)"

#!###############################################################
#!#                         Starship                           ##
#!###############################################################
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi
