#!/usr/bin/env bash

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
    "hollywood"
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
            sudo apt install $pack -y # >> /dev/null
            if [ $? -eq 0 ]; then
                echo "[INFO] - O App $pack foi instalado com sucesso!"
            else
                echo "[ERROR] - Falha ao instalar o App $pack :("
            fi       
        else
            echo "[INFO] - O App $pack já está instalado \ o /"
        fi
    done
}
# ....................................................................... #

# .............................. CALL to ACTION ......................... #
apt_update
apt_install
# ....................................................................... #
