#!/usr/bin/env bash

# +-------------------------------------------------------------------------+
# |                                                                         |
# |                               SCRIPT HEADER                             |
# |                                                                         |
# +-------------------------------------------------------------------------+

# Author    : Fabio Ewerton
# Website   : fabio.eti.br
# Social    : @FabioEw89

# +-------------------------------------------------------------------------+
# |                               VARIABLES                                 |
# +-------------------------------------------------------------------------+

APT_UPDATE=(
    "update --fix-missing"
    "upgrade -y"
    "autoclean"
    "autoremove -y"
    "install -f"
)

SCRIPTS=(
    "https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh"
)

APT_INSTALL=(
    "git"
    "vim"
    "curl"
    "zsh"
    "speedtest"
)

# +-------------------------------------------------------------------------+
# |                               FUNCTIONS                                 |
# +-------------------------------------------------------------------------+

remove_locks(){
    sudo rm /var/lib/dpkg/lock-frontend
    sudo rm /var/cache/apt/archives/lock 
}

apt_update(){
    for update in "${APT_UPDATE[@]}"; do
        sudo apt $update >> /dev/null 2>&1
    done
}

apt_install(){
    for pack in "${APT_INSTALL[@]}"; do
        if ! dpkg -l | grep -qw "^ii\s\+$pack"; then
            sudo apt install $pack -y >> /dev/null 2>&1
            if [ $? -eq 0 ]; then
                echo "[INFO] - O App $pack foi instalado com sucesso!"
            else
                echo "[ERROR] - Falha ao instalar o App $pack :("
            fi       
        else
            echo "[INFO] - O App $pack já está instalado ;"
        fi
    done
}

install_scripts(){
    for script in "${SCRIPTS[@]}"; do
        curl -s "$script" | sudo bash
    done    
}

install_oh_my_zsh() {
    if ! dpkg -l | grep -qw "^ii\s\+zsh"; then
        echo "[INFO] - Zsh não está instalado. Por favor, instale-o primeiro."
        return 1
    fi

    if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}" ]; then
        echo "[INFO] - Instalando o Oh-my-zsh..."
        sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" >> /dev/null 2>&1
    else
        echo "[INFO] - Oh-my-zsh já está instalado."
    fi

    if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
        echo "[INFO] - Instalando o plugin zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions >> /dev/null 2>&1
    else
        echo "[INFO] - O plugin zsh-autosuggestions já está instalado."
    fi
}

# +-------------------------------------------------------------------------+
# |                           CALL TO ACTION                                |
# +-------------------------------------------------------------------------+

# remove_locks
# apt_update
# apt_install
install_scripts
# install_oh_my_zsh

# +-------------------------------------------------------------------------+
# |                               THE END                                   |
# +-------------------------------------------------------------------------+
