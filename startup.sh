#!/usr/bin/env bash
#
# Author: Fabio Ewerton
# Site: fabio.eti.br 
# Social: FabioEw89
#
# .............................. VARIABLES .............................. #
APT_UPDATE=(
    "update --fix-missing"
    "upgrade -y"
    "autoclean"
    "autoremove -y"
    "install -f"
)

APT_INSTALL=(
    "git"
    "vim"
    "curl"
    "zsh"
)
# ....................................................................... #

# .............................. FUNCTIONS .............................. #
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
    install_zsh(){
        if ! dpkg -l | grep -qw "^ii\s\+zsh"; then
            if [ $? -eq 0 ]; then
                echo "[INFO] - O app Oh-my-zsh ja esta instalado"
            else
                sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
                git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions                
            fi

        fi
    }
}


# ....................................................................... #

# .............................. CALL to ACTION ......................... #

apt_update
apt_install
install_zsh    
# ....................................................................... #
