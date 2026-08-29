#!/usr/bin/env bash

set -e

echo "==> Atualizando pacotes do sistema..."
sudo pacman -Syu --noconfirm

# 1. Garantir que Git e utilitários de compilação estejam instalados
echo "==> Instalando dependências básicas..."
sudo pacman -S --needed --noconfirm git base-devel

# 2. Instalar o YAY caso ele não exista no sistema novo
if ! command -v yay &> /dev/null; then
    echo "==> Instalação do gerenciador AUR (yay)..."
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    cd /tmp/yay-bin
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay-bin
fi

# 3. Lista de programas, programas visuais e fontes que a sua interface precisa
PACOTES=(
    hyprland
    kitty
    waybar
    rofi-wayland
    swww
    swaylock-effects
    wlogout
    mako
    grim
    slurp
    wl-clipboard
    cliphist
    polkit-gnome
    pamixer
    pavucontrol
    playerctl
    brightnessctl
    qt5-wayland
    qt6-wayland
    qt5ct
    qt6ct
    ttf-jetbrains-mono-nerd
    ttf-font-awesome
    noto-fonts-emoji
    papirus-icon-theme
    python
    jq
    socat
    lsd
    fastfetch
)

echo "==> Instalando programas e fontes da interface..."
yay -S --needed --noconfirm "${PACOTES[@]}"

# 4. Copiar as suas configurações para o sistema
echo "==> Copiando dotfiles para ~/.config..."
mkdir -p ~/.config

if [ -d ".config" ]; then
    cp -r .config/* ~/.config/
else
    # Caso as pastas estejam direto na raiz do repositório
    for dir in *; do
        if [ -d "$dir" ] && [ "$dir" != ".git" ]; then
            cp -r "$dir" ~/.config/
        fi
    done
fi

echo "==> Instalação concluída com sucesso! Reinicie o Hyprland."
