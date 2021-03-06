#!/bin/bash

# Check if have sudo privileges without password
sudo -n true &> /dev/null
if [ ! $? -eq 0 ]; then
    echo -e "\033[1m\033[91m/!\\ Fatal: You need the sudo privileges to use the script, add this line to the sudoers file (accessible with 'sudo visudo'): '$USER ALL=(ALL) ALL' or use script with sudo\033[0m" 1>&2
    exit 1
fi

function check_error {
    echo -e "\033[0m"
    if [ -z $1 ] || [ -z "$2" ]; then
        exit 1
    fi
    if [ $1 -eq 0 ]; then
        echo -e "\n\033[1m\033[92m$2 successfully configured\033[0m"
    else
        echo -e "\n\033[1m\033[91m/!\\ Warning: Failed to configure $2 !\033[0m" 1>&2
        exit 1
    fi
}

# Cloning Dotfile repo
echo -e "\033[1m\033[96mCloning Dotfile repository...\033[0m\n"
if [ $1 -eq 1 ] ; then
    git clone https://github.com/Curs3W4ll/Dotfiles.git /tmp/Dotfiles &> /dev/null
else
    git clone https://github.com/Curs3W4ll/Dotfiles.git /tmp/Dotfiles
fi
check_error $? "Dotfile repository"

# Config onedark neovim colorscheme
echo -e "\033[1m\033[96mConfiguring Onedark neovim colorscheme...\033[0m\n"
if [ $1 -eq 1 ] ; then
    git clone https://github.com/joshdick/onedark.vim /tmp/onedark.vim &> /dev/null
    ret_code=$?
    cp /tmp/onedark.vim/colors -r $HOME/.config/nvim/colors >> /dev/null
    ret_code=$((ret_code + $?))
    cp /tmp/onedark.vim/autoload -r $HOME/.config/nvim/autoload >> /dev/null
    ret_code=$((ret_code + $?))
else
    git clone https://github.com/joshdick/onedark.vim /tmp/onedark.vim
    ret_code=$?
    cp /tmp/onedark.vim/colors -r $HOME/.config/nvim/colors
    ret_code=$((ret_code + $?))
    cp /tmp/onedark.vim/autoload -r $HOME/.config/nvim/autoload
    ret_code=$((ret_code + $?))
fi
check_error $ret_code "Onedark neovim colorscheme"
