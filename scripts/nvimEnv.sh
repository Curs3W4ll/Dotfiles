#!/bin/bash

# ==========================
# === Colors definition  ===
# ==========================
none="\033[0m"
bold="\033[1m"
italic="\033[3m"
underlined="\033[4m"
blink="\033[5m"

red="\033[0;31m"
green="\033[0;32m"
cyan="\033[0;36m"
yellow="\033[0;93m"

success="${green}${bold}"
step="${cyan}${bold}"
error="${red}${bold}"
warning="${yellow}${bold}"
info="${cyan}"
# ==========================


SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

docker="false"
configLocation="$HOME/.local/share/nvim.repro"
reproBinaryLocation="$HOME/.local/bin"
reproBinary="nvim-repro"
packagePath="$HOME/.local/share/nvim-repro.zip"
packageFilesToIgnore=(
    "lazy-lock.json"
)
dockerImageName="nvim-repro:latest"
dockerContainerName="nvim-repro"
dockerConfigLocation="$HOME/.local/share/nvim.repro.docker"
dockerInsideConfigLocation="/root/.config/nvim"


# Package a directory into a zip file while excluding files and folders in $packageFilesToIgnore
# $1: The directory to package
# $2: The path to the zip archive package
function package-dir-into-zip {
    dirToPackage="$1"
    packagePath="$2"

    tmpConfigDir="/tmp"
    tmpConfigName="nvim-repro-tmp"
    tmpConfigPath="${tmpConfigDir}/${tmpConfigName}"

    rm -rf "${tmpConfigPath}"
    rm -rf "${packagePath}"

    zip=$(which zip)
    if [ $? -ne 0 ]; then
        echo -e "${error}Cannot find zip binary, please install it to generate a package${none}"
        exit 1
    fi
    echo -e "${info}Using zip at ${zip}${none}"

    cp -r "${dirToPackage}" "${tmpConfigPath}"
    for file in "${packageFilesToIgnore[@]}"; do
        rm -rf "${tmpConfigPath}/${file}"
    done
    cd ${tmpConfigDir} ; zip -r "${packagePath}" "${tmpConfigName}" ; cd -

    rm -rf "${tmpConfigPath}"
}


function usage {
    echo -e "${bold}Usage: $0 [OPTIONS] <command>${none}"
    echo "Create a stub environment for testing Neovim with a minimal configuration"
    echo
    echo -e "${bold}COMMANDS${none}"
    echo -e "create  \tCreate a new environment for testing"
    echo -e "remove  \tRemoving an existing environment for testing"
    echo -e "recreate\tRemove existing and create a new environment for testing"
    echo -e "package \tPackage the reproduce environment into a zip archive"
    echo -e "cd      \tOpen a shell in the reproduce config directory"
    echo
    echo -e "${bold}OPTIONS${none}"
    echo -e "-p,--path  \tThe path where the reproduced environment will be located."
    echo -e "           \tHave no impact if used with --docker option."
    echo -e "-d,--docker\tDeal with a stub environment inside a Docker container instead of in the filesystem"
    echo
    echo -e "${bold}RETURN CODES${none}"
    echo -e "0\tOperation succeeded"
    echo -e "1\tOperation failed"
    echo -e "2\tInvalid user argument"

    exit $1
}

function create_fs {
    echo -e "create| ${step}Creating a new Neovim environment...${none}"

    if [ -d "$configLocation" ] || [ -f "$configLocation" ]; then
        echo -e "create| ${error}This config directory ($configLocation) already exists. Please remove it or use the recreate command${none}"
        exit 1
    fi

    reproCommand="nvim -u ${configLocation}/init.lua"

    cp -r $SCRIPT_DIR/files/nvimEnv/nvimConf "$configLocation"
    mkdir -p "$reproBinaryLocation"
    echo -e "#!/bin/bash\n\n${reproCommand} \$@" > "${reproBinaryLocation}/${reproBinary}"
    chmod +x "${reproBinaryLocation}/${reproBinary}"
    echo "$PATH" | grep "${reproBinaryLocation}" 1>/dev/null 2>/dev/null
    if [ $? -ne 0 ]; then
        echo -e "create| ${warning}${reproBinaryLocation} does not seems to be in your \$PATH env var, consider adding it to use the custom command ${reproBinary}${none}"
    fi

    echo -e "create| ${success}A new Neovim environment has been created at ${configLocation}${none}"
    echo -e "create| ${info}You can use it using '${reproCommand}', you can also use the ${reproBinary} command${none}"
    echo -e "create| ${info}Use '$0 cd' to open the config directory${none}"
}

function create_docker {
    echo -e "create| ${step}Creating a new Neovim environment in Docker...${none}"

    docker ps -a | grep " ${dockerContainerName}\$" >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
        echo -e "create| ${error}A Neovim environment test Docker container already exists. Please remove it or use the recreate command${none}"
        exit 1
    fi
    if [ -d "$dockerConfigLocation" ]; then
        echo -e "create| ${info}Removing old Docker configuration at ${dockerConfigLocation}${none}"
        rm -rf "${dockerConfigLocation}"
    fi

    cp -r $SCRIPT_DIR/files/nvimEnv/nvimConf "$dockerConfigLocation"

    echo -e "create| ${info}Building Docker image used to create the container${none}"
    docker build -t "${dockerImageName}" ./files/nvimEnv/
    if [ $? -ne 0 ]; then
        echo -e "${error}Failed to build Docker image used for Neovim environment${none}"
        exit 1
    fi
    echo -e "create| ${info}Creating Docker container from '${dockerImageName}' image${none}"
    echo -e "create| ${info}You can leave the Docker shell that will display and open it later using ${bold}${0} -d cd${none}"
    docker run -it --name "${dockerContainerName}" -v "${dockerConfigLocation}:${dockerInsideConfigLocation}" "${dockerImageName}"

    echo -e "create| ${success}A new Neovim environment has been created in the ${dockerContainerName} Docker container${none}"
    echo -e "create| ${info}You can use it using Neovim normally inside the Docker container${none}"
    echo -e "create| ${info}Use '$0 -d cd' to open the config directory inside the Docker container\nThis config is also shared with your machine, you can find it at ${dockerConfigLocation}${none}"
}

function remove_fs {
    echo -e "remove| ${step}Removing an existing Neovim environment at ${configLocation}...${none}"

    if [ -f "$configLocation" ]; then
        echo -e "remove| ${error}The config directory is currently a file, cannot remove it for security reasons. This file may be an important file to the user${none}"
    fi
    if ! [ -d "$configLocation" ]; then
        echo -e "remove| ${info}The config directory does not exists, nothing to do${none}"
        return
    fi

    rm -rf "$configLocation"
    rm -rf "${reproBinaryLocation}/${reproBinary}"

    echo -e "remove| ${success}The Neovim environment at ${configLocation} as been successfully removed${none}"
}

function remove_docker {
    echo -e "remove| ${step}Removing an existing Neovim environment in the '${dockerContainerName}' Docker container...${none}"

    docker ps | grep " ${dockerContainerName}\$" >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
        echo -e "remove| ${info}Docker container is running, stopping it${none}"
        docker stop "${dockerContainerName}"
        if [ $? -ne 0 ]; then
            echo -e "${error}Failed to stop the Docker container${none}"
            exit 1
        fi
    fi
    docker ps -a | grep " ${dockerContainerName}\$" >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
        echo -e "remove| ${info}Removing the Docker container itself${none}"
        docker rm "${dockerContainerName}"
        if [ $? -ne 0 ]; then
            echo -e "${error}Failed to remove the Docker container${none}"
            exit 1
        fi
    fi

    rm -rf "$dockerConfigLocation"

    echo -e "remove| ${success}The Neovim environment in the '${dockerContainerName}' Docker container as been successfully removed${none}"
}

function recreate_fs {
    remove_fs
    create_fs
}

function recreate_docker {
    remove_docker
    create_docker
}

function package_fs {
    echo -e "package| ${step}Packaging an existing Neovim environment at ${configLocation}...${none}"

    if ! [ -d "$configLocation" ]; then
        echo -e "package| ${error}The config directory does not exists, cannot package it${none}"
        exit 1
    fi

    versionFile="${configLocation}/VERSION.txt"
    rm -rf "$versionFile"
    touch "$versionFile"
    which nvim >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "====== Neovim ======" >> "$versionFile"
        nvim --version >> "$versionFile"
    fi
    which lsb_release >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "====== OS ======" >> "$versionFile"
        lsb_release -a >> "$versionFile"
    fi

    package-dir-into-zip "$configLocation" "$packagePath"

    rm -rf "$versionFile"

    echo -e "package| ${success}The Neovim environment at ${configLocation} as been successfully packaged to ${packagePath}${none}"
}

function package_docker {
    echo -e "package| ${step}Packaging an existing Neovim environment from ${dockerContainerName} Docker container...${none}"

    docker ps -a | grep " ${dockerContainerName}\$" >/dev/null 2>/dev/null
    if [ $? -ne 0 ]; then
        echo -e "package| ${error}Docker container not found. Cannot package its configuration${none}"
        exit 1
    fi

    docker ps | grep " ${dockerContainerName}\$" >/dev/null 2>/dev/null
    if [ $? -ne 0 ]; then
        echo -e "${info}Starting Docker container has it is not running${none}"
        docker start "$dockerContainerName"
        if [ $? -ne 0 ]; then
            echo -e "${error}Cannot start the Docker container${none}"
            exit 1
        fi
    fi
    versionFile="${dockerInsideConfigLocation}/VERSION.txt"
    docker exec "$dockerContainerName" rm -rf "$versionFile"
    docker exec "$dockerContainerName" touch "$versionFile"
    docker exec "$dockerContainerName" which nvim >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
        docker exec "$dockerContainerName" bash -c "echo '====== Neovim ======' >> '$versionFile'"
        docker exec "$dockerContainerName" bash -c "nvim --version >> '$versionFile'"
    fi
    docker exec "$dockerContainerName" which lsb_release >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
        docker exec "$dockerContainerName" bash -c "echo '====== OS ======' >> '$versionFile'"
        docker exec "$dockerContainerName" bash -c "lsb_release -a >> '$versionFile'"
    fi
    docker stop "$dockerContainerName"

    package-dir-into-zip "$dockerConfigLocation" "$packagePath"

    echo -e "package| ${success}The Neovim environment from the ${dockerContainerName} Docker container as been successfully packaged to ${packagePath}${none}"
}

function cd_fs {
    if ! [ -d "${configLocation}" ]; then
        echo -e "cd| ${error}Could not find the '${configLocation}' directory${none}"
        exit 1
    fi

    if [ -z "$SHELL" ]; then
        SHELL="bash"
    fi
    $SHELL -c "cd ${configLocation} ; $SHELL ; exit"
}

function cd_docker {
    docker ps -a | grep " ${dockerContainerName}\$" >/dev/null 2>/dev/null
    if [ $? -ne 0 ]; then
        echo -e "cd| ${error}Could not find any Neovim reproduce Docker environment${none}"
        exit 1
    fi

    docker ps | grep " ${dockerContainerName}\$" >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
        echo -e "cd| ${info}Neovim reproduce Docker environment is already running, creating a new connection to it${none}"
        echo -e "cd| ${warn}This connection will be stopped if the main connection is interrupted${none}"
        docker exec -it "${dockerContainerName}" /bin/bash
    else
        docker start -ai "${dockerContainerName}"
    fi
}


[ $# -eq 0 ] && usage 2
# Parsing options
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do 
    case $1 in
        -h | --help)
            usage 0
            ;;
        -p | --path)
            configLocation="$2"
            shift
            ;;
        -d | --docker)
            docker=$(which docker)
            if [ $? -ne 0 ]; then
                echo -e "${error}You need to install Docker first to use a Docker environment${end}"
                exit 1
            fi
            echo -e "${step}Using docker at ${docker}${none}"
            docker="true"
            ;;
        *)
            echo -e "${error}$0: Invalid option $1${none}" >&2
            usage 2
            ;;
    esac; shift
done
if [[ "$1" == '--' ]]; then shift; fi

# Parsing positionnal arguments
case $1 in
    h | help)
        usage 0
        ;;
    create)
        if [ "$docker" == "true" ]; then
            create_docker
        else
            create_fs
        fi
        ;;
    remove)
        if [ "$docker" == "true" ]; then
            remove_docker
        else
            remove_fs
        fi
        ;;
    recreate)
        if [ "$docker" == "true" ]; then
            recreate_docker
        else
            recreate_fs
        fi
        ;;
    package)
        if [ "$docker" == "true" ]; then
            package_docker
        else
            package_fs
        fi
        ;;
    cd)
        if [ "$docker" == "true" ]; then
            cd_docker
        else
            cd_fs
        fi
        ;;
    *)
        echo -e "${error}$0: Invalid command $1${none}" >&2
        usage 2
        ;;
esac; shift

# Also make easier to use a reproduce env in nvim (`vc='XDG_CONFIG_HOME=/home/corentin/Documents/Dotfiles/data/nvim.lua nvim')?
