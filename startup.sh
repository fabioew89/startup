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

MY_NAME="Fabio Ewerton"
MY_EMAIL="fabioew89@gmail.com"

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
git_config(){
    if dpkg -l | grep -qw "^ii\s\+git"; then
        git config --global user.name "$MY_NAME"
        git config --global user.email "$MY_EMAIL"
    fi
}
install_zsh(){
    if ! dpkg -l | grep -qw "^ii\s\+zsh"; then
        echo "[INFO] - Installing Oh-my-zsh..."
        sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    else
        echo "[INFO] - The app Oh-my-zsh is already installed"
    fi
}  

# +-------------------------------------------------------------------------+
# |                           CALL TO ACTION                                |
# +-------------------------------------------------------------------------+

remove_locks
apt_update
apt_install
install_zsh
git_config

# +-------------------------------------------------------------------------+
# |                               THE END                                   |
# +-------------------------------------------------------------------------+
