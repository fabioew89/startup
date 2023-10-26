#!/usr/bin/env bash

# +-------------------------------------------------------------------------+
# |                                                                         |
# |                               SCRIPT HEADER                             |
# |                                                                         |
# +-------------------------------------------------------------------------+

# Author    : Fabio Ewerton
# Website   : fabio.eti.br
# Social    : @FabioEw89

# Version   : 1.0.19

# +-------------------------------------------------------------------------+
# |                               VARIABLES                                 |
# +-------------------------------------------------------------------------+

APT_UPDATE_LIST=(
    "update --fix-missing"
    "upgrade -y"
    "autoclean"
    "autoremove -y"
    "install -f"
)

SCRIPTS_LIST=(
    "https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh"
)

APT_INSTALL_LIST=(
    "git"
    "vim"
    "curl"
    "zsh"
    "speedtest"
)

# +-------------------------------------------------------------------------+
# |                               FUNCTIONS                                 |
# +-------------------------------------------------------------------------+

sudo rm -rf /var/lib/dpkg/lock-frontend && \
sudo rm -rf /var/cache/apt/archives/lock # Remove locks?

apt_update(){
    for update in "${APT_UPDATE_LIST[@]}"; do
        sudo apt $update >> /dev/null 2>&1
    done
}

apt_install(){
    for pack in "${APT_INSTALL_LIST[@]}"; do
        if ! dpkg -l | grep -qw "^ii\s\+$pack"; then
            sudo apt install $pack -y >> /dev/null 2>&1
            [ $? -eq 0 ] && echo "[INFO] - O App $pack foi instalado com sucesso!"
        fi
    done
}

install_scripts(){
    for script in "${SCRIPTS_LIST[@]}"; do
        curl -s "$script" | sudo bash
    done    
}

install_oh_my_zsh() {
    local zsh_path="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"
    local autosuggestions_path="$zsh_path/plugins/zsh-autosuggestions"

    # Verifique se o zsh está instalado
    dpkg -l | grep -qw "^ii\s\+zsh" || \
    { echo "[INFO] - Zsh não está instalado. Por favor, instale-o primeiro."; return 1; }

    # Instale o Oh-my-zsh se não estiver presente
    [ -d "$zsh_path" ] && echo "[INFO] - Oh-my-zsh já está instalado." || \
    { echo "[INFO] - Instalando o Oh-my-zsh..."; \
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" >> /dev/null 2>&1; }

    # Instale o plugin zsh-autosuggestions se não estiver presente
    [ -d "$autosuggestions_path" ] && echo "[INFO] - O plugin zsh-autosuggestions já está instalado." || \
    { echo "[INFO] - Instalando o plugin zsh-autosuggestions..."; \
    git clone https://github.com/zsh-users/zsh-autosuggestions $autosuggestions_path >> /dev/null 2>&1; }
}

# +-------------------------------------------------------------------------+
# |                           CALL TO ACTION                                |
# +-------------------------------------------------------------------------+

apt_update
apt_install
install_scripts
install_oh_my_zsh
apt_update

# +-------------------------------------------------------------------------+
# |                               THE END                                   |
# +-------------------------------------------------------------------------+
