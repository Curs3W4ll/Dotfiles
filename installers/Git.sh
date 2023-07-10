#!/bin/bash

NoColor="\033[0m"
CyanColor="\033[0;36m"
RedColor="\033[0;91m"

dotfilesPath="/tmp/CDotfiles"
destPath="$HOME"
chezmoi="/tmp/chezmoi"

function confirm {
    local _response
    while true; do
        if [ -n "$1" ]; then
            echo -n "$1"
        else
            echo -n "Are you sure"
        fi
        echo -n " [Y/n] ? "
        read -r _response
        case "$_response" in
            [Yy][Ee][Ss]|[Yy]|"")
                return 0
            ;;
            [Nn][Oo]|[Nn])
                return 1
            ;;
            *)
                echo "Invalid input, Please response Yes or No"
            ;;
        esac
    done
}

# ===================================
# ========== Dependencies ===========
# ===================================
set +eo pipefail
missingPackage=false

curl=$(which curl)
if [ $? -ne 0 ]; then
    echo -e "${RedColor}Please install curl first${NoColor}"
    missingPackage=true
else
    echo -e "${CyanColor}Using curl at ${curl}${NoColor}"
fi

git=$(which git)
if [ $? -ne 0 ]; then
    echo -e "${RedColor}Please install git first${NoColor}"
    missingPackage=true
else
    echo -e "${CyanColor}Using git at ${git}${NoColor}"
fi

if [ "$missingPackage" == "true" ]; then
    echo -e "${RedColor}Missing packages, please install them before${NoColor}"
    exit 1
fi

set -eo pipefail
# ===================================
# ===================================
# ===================================


confirm "Using this script will remove the existing git configuration ('${HOME}/.gitconfig' file), Continue"

echo -e "${CyanColor}Cloning Dotfiles to ${dotfilesPath}${NoColor}"
rm -rf $dotfilesPath
git clone https://github.com/Curs3W4ll/Dotfiles ${dotfilesPath}

echo -e "${CyanColor}Temporarily installing chezmoi${NoColor}"
rm -rf $chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /tmp
$chezmoi init $dotfilesPath

echo -e "${CyanColor}Init ~/.gitconfig file${NoColor}"
$chezmoi apply ~/.gitconfig

echo -e "${CyanColor}Removing cloned repository and chezmoi${NoColor}"
rm -rf $dotfilesPath
rm -rf $chezmoi

echo
echo -e "${CyanColor}INSTALLATION SUCCESSFULL${NoColor}"
echo -e "${CyanColor}Please restart your shell to configure the new one${NoColor}"