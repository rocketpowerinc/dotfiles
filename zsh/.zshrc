#!###############
#!   One Liners #
#!###############
alias usl='curl -sSL http://192.168.1.72:9999/RocketOS-2/Ultimate-Script-Launcher.sh | bash'
alias pro='curl -sSL http://192.168.1.72:9999/RocketOS-2/Python-RocketOS.sh | bash'
alias repro='$HOME/Downloads/CustomTkinter-App/bin/python $HOME/Downloads/CustomTkinter-App/App/_MainFrame.py'
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias proexe='echo -e "\033[33mRun pro first if I want a fresh build\033[0m" && sleep 3s && $HOME/Downloads/CustomTkinter-App/bin/pyinstaller  $HOME/Downloads/CustomTkinter-App/_MainFrame_MacOS.spec && /home/rocket/dist/_MainFrame'
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias proexe='echo -e "\033[33mRun pro first if I want a fresh build\033[0m" && sleep 3s && $HOME/Downloads/CustomTkinter-App/bin/pyinstaller  $HOME/Downloads/CustomTkinter-App/_MainFrame_Linux.spec && /home/rocket/dist/_MainFrame'
fi

#!######################################################################
#!#                            Atuin                                  ##
#!######################################################################
#testing - I am going to install atuin with the provided script instead of nix because it was not working right and this script adds these lines already so no need for them
#eval "$(atuin init zsh)"
