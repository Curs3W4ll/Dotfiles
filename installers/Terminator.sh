#!/bin/bash

NoColor="\033[0m"
CyanColor="\033[0;36m"
RedColor="\033[0;91m"

dotfilesPath="/tmp/CDotfiles"
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

# $1: Dependency command (to check if installed with 'which'
# [$2]: Prettier name of the dependency
function check_dependency() {
    name=$1
    if [ -z "$1" ]; then
        return 1
    fi
    if [ -n "$2" ]; then
        name=$2
    fi

    out=$(which $1)
    if [ $? -ne 0 ]; then
        echo -e "${RedColor}Please install ${name} first ${NoColor}"
        missingPackage=true
        return 1
    else
        echo -e "${CyanColor}Using ${name} at ${out}${NoColor}"
    fi
}


check_dependency curl
check_dependency git
check_dependency terminator

if [ "$missingPackage" == "true" ]; then
    echo -e "${RedColor}Missing packages, please install them before${NoColor}"
    exit 1
fi

set -eo pipefail
# ===================================
# ===================================
# ===================================


confirm "Using this script will remove the existing terminator configuration ('${HOME}/.config/terminator/config' file), Continue"

echo -e "${CyanColor}Cloning Dotfiles to ${dotfilesPath}${NoColor}"
rm -rf $dotfilesPath
git clone https://github.com/Curs3W4ll/Dotfiles ${dotfilesPath}

echo -e "${CyanColor}Temporarily installing chezmoi${NoColor}"
rm -rf $chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /tmp
$chezmoi init $dotfilesPath

echo -e "${CyanColor}Init ~/.config/terminator/config file${NoColor}"
$chezmoi apply ~/.config/terminator/config

echo -e "${CyanColor}Removing cloned repository and chezmoi${NoColor}"
rm -rf $dotfilesPath
rm -rf $chezmoi

echo
echo -e "${CyanColor}INSTALLATION SUCCESSFULL${NoColor}"
echo -e "${CyanColor}Please close every instance of terminator and start a new one${NoColor}"
