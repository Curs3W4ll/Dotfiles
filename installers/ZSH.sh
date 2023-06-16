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

git=$(which git)
if [ $? -ne 0 ]; then
    echo -e "${RedColor}Please install git first${NoColor}"
    missingPackage=true
else
    echo -e "${CyanColor}Using git at ${git}${NoColor}"
fi

zsh=$(which zsh)
if [ $? -ne 0 ]; then
    echo -e "${RedColor}Please install ZSH first${NoColor}"
    missingPackage=true
else
    echo -e "${CyanColor}Using ZSH at ${zsh}${NoColor}"
fi

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

zshInstallPath=$zshCustomPath/themes/powerlevel10k
if ! [ -d $zshInstallPath ]; then
    echo -e "${CyanColor}Installing PowerLevel10k theme${NoColor}"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $zshInstallPath
fi

echo -e "${CyanColor}Init ~/.zshrc file${NoColor}"
$chezmoi apply ~/.zshrc

echo -e "${CyanColor}Removing cloned repository and chezmoi${NoColor}"
rm -rf $dotfilesPath
rm -rf $chezmoi

echo
echo -e "${CyanColor}INSTALLATION SUCCESSFULL${NoColor}"
echo -e "${CyanColor}Please restart your shell to configure the new one${NoColor}"
