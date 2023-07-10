#!/bin/bash

NoColor="\033[0m"
CyanColor="\033[0;36m"
RedColor="\033[0;91m"

dotfilesPath="/tmp/CDotfiles"
nvimPath="$HOME/.config/nvim"
cocPath="$HOME/.config/coc"

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
check_dependency nvim neovim
check_dependency node nodeJS
check_dependency yarn
check_dependency pip "Python pip"
check_dependency rg "ripgrep(https://github.com/BurntSushi/ripgrep)"
check_dependency fd "fd(https://github.com/sharkdp/fd)"
check_dependency tar
check_dependency cmake

if [ "$missingPackage" == "true" ]; then
    echo -e "${RedColor}Missing packages, please install them before${NoColor}"
    exit 1
fi

set -eo pipefail
# ===================================
# ===================================
# ===================================


confirm "Using this script will remove the existing Neovim configuration ('${HOME}/.config/nvim/**' files), Continue"

echo -e "${CyanColor}Install pynvim${NoColor}"
pip install pynvim

echo -e "${CyanColor}Installing vim-plug for neovim${NoColor}"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo -e "${CyanColor}Cloning Dotfiles to ${dotfilesPath}${NoColor}"
rm -rf $dotfilesPath
git clone https://github.com/Curs3W4ll/Dotfiles ${dotfilesPath}

echo -e "${CyanColor}Copying plugins list${NoColor}"
rm -rf $nvimPath
mkdir -p $nvimPath
cp $dotfilesPath/data/nvim/plugs-set/vimplug.vim $nvimPath/init.vim

echo -e "${CyanColor}Installing onedark${NoColor}"
rm -rf /tmp/onedark
git clone https://github.com/joshdick/onedark.vim /tmp/onedark
cp /tmp/onedark/colors $dotfilesPath/data/nvim/colors -r
cp /tmp/onedark/autoload $dotfilesPath/data/nvim/autoload -r

echo -e "${CyanColor}Installing plugins${NoColor}"
nvim -c PlugInstall -c qa

echo -e "${CyanColor}Copying full config${NoColor}"
rm -rf $nvimPath
mkdir -p $nvimPath
cp $dotfilesPath/data/nvim/* $nvimPath -r
rm -rf $cocPath
mkdir -p $cocPath
cp $dotfilesPath/data/coc/* $cocPath -r

echo -e "${CyanColor}Installing last plugins and coc${NoColor}"
nvim -c PlugInstall -c PlugUpdate -c qa
nvim -c "CocInstall coc-tabnine coc-snippets coc-yaml coc-tsserver coc-styled-components coc-sh coc-python coc-json coc-clangd"
nvim -c "NightfoxCompile" -c qa

echo -e "${CyanColor}Removing cloned repository${NoColor}"
rm -rf $dotfilesPath

echo
echo -e "${CyanColor}INSTALLATION SUCCESSFULL${NoColor}"
