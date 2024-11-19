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
check_dependency zsh

if ! [ -d ${HOME}/.oh-my-zsh ]; then
    echo -e "${RedColor}Please install oh my zsh first (run: sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\")${NoColor}"
    missingPackage=true
else
    echo -e "${CyanColor}Using ohmyzsh at ${HOME}/.oh-my-zsh${NoColor}"
fi

if [ "$missingPackage" == "true" ]; then
    echo -e "${RedColor}Missing packages, please install them before${NoColor}"
    exit 1
fi

set -eo pipefail
# ===================================
# ===================================
# ===================================


confirm "Using this script will remove the existing zsh configuration ('.zshrc' file, $HOME/.oh-my-zsh dir), Continue"

echo -e "${CyanColor}Cloning Dotfiles to ${dotfilesPath}${NoColor}"
rm -rf $dotfilesPath
git clone https://github.com/Curs3W4ll/Dotfiles ${dotfilesPath}

echo -e "${CyanColor}Temporarily installing chezmoi${NoColor}"
rm -rf $chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /tmp
$chezmoi init $dotfilesPath

zshCustomPath=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

zshInstallPath=$zshCustomPath/plugins/zsh-autosuggestions
if ! [ -d $zshInstallPath ]; then
    echo -e "${CyanColor}Installing zsh-autosuggestions plugin${NoColor}"
    git clone https://github.com/zsh-users/zsh-autosuggestions $zshInstallPath
fi

zshInstallPath=$zshCustomPath/plugins/zsh-syntax-highlighting
if ! [ -d $zshInstallPath ]; then
    echo -e "${CyanColor}Installing zsh-syntax-highlighting plugin${NoColor}"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $zshInstallPath
fi

zshInstallPath=$zshCustomPath/plugins/zsh-lsd
if ! [ -d $zshInstallPath ]; then
    echo -e "${CyanColor}Installing zsh-lsd plugin${NoColor}"
    git clone https://github.com/z-shell/zsh-lsd.git $zshInstallPath
fi

zshInstallPath=$zshCustomPath/themes/powerlevel10k
if ! [ -d $zshInstallPath ]; then
    echo -e "${CyanColor}Installing PowerLevel10k theme${NoColor}"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $zshInstallPath
fi

echo -e "${CyanColor}Init ~/.zshrc file${NoColor}"
$chezmoi apply ~/.zshrc ~/.p10k.zsh

echo -e "${CyanColor}Removing cloned repository and chezmoi${NoColor}"
rm -rf $dotfilesPath
rm -rf $chezmoi

echo
echo -e "${CyanColor}INSTALLATION SUCCESSFULL${NoColor}"
echo -e "${CyanColor}Please restart your shell to configure the new one${NoColor}"
