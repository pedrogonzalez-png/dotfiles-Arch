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

# 3. Lista completa do seu sistema
PACOTES=(
    7zip adobe-source-code-pro-fonts alsa-utils arandr awww aylurs-gtk-shell-git baobab base base-devel blueman bluez bluez-utils btop cloudflare-warp-bin conky coolercontrol-bin cpu-x ddcui efibootmgr evtest eww fastfetch flameshot flatpak fzf gameconqueror ghex git glava gnome-disk-utility gnome-pie gnome-system-monitor goverlay gpu-screen-recorder-gtk grub grub-customizer gst-plugins-bad gst-plugins-ugly gtk-engine-murrine gvfs gvfs-mtp hyprpolkitagent hyprshade illogical-impulse-audio illogical-impulse-backlight illogical-impulse-basic illogical-impulse-bibata-modern-classic-bin illogical-impulse-fonts-themes illogical-impulse-hyprland illogical-impulse-kde illogical-impulse-microtex-git illogical-impulse-portal illogical-impulse-python illogical-impulse-quickshell-git illogical-impulse-screencapture illogical-impulse-toolkit illogical-impulse-widgets imhex-bin inxi kdenlive konsole kvantum lact lib32-mesa lib32-vulkan-radeon libastal-hyprland-git libastal-meta libspng lightdm lightdm-gtk-greeter linux linux-firmware linux-zen linux-zen-headers liquidctl loupe lsd lutris maim mangohud mariadb-clients mercurial mousepad mpv mpv-mpris mpvpaper nano ncdu network-manager-applet nodejs noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ntfs-3g nvtop nwg-displays nwg-look obsidian ollama openrgb openrgb-plugin-effects opera-gx os-prober otf-font-awesome oversteer pacman-contrib pamixer parole picom pipewire-alsa plasma-browser-integration plymouth protonplus protontricks pyenv python-pip python-psutil python-pyquery python-requests python-virtualenv qalculate-gtk qt6-multimedia-ffmpeg qt6ct radeontop ristretto rocm-smi-lib rofi rust sddm socat sof-firmware steam sudo swaync thunar-archive-plugin thunar-media-tags-plugin thunar-volman tk ttf-droid ttf-fantasque-nerd ttf-fira-code ttf-jetbrains-mono ttf-victor-mono tty-clock umockdev unityhub unzip vesktop-bin vim virtualbox virtualbox-host-dkms visual-studio-code-bin vulkan-radeon wallust waybar wev win2xcur woff2-font-awesome xclip xdotool xf86-video-amdgpu xf86-video-vesa xfburn xfce4-appfinder xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-dict xfce4-diskperf-plugin xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-mailwatch-plugin xfce4-mount-plugin xfce4-mpc-plugin xfce4-netload-plugin xfce4-notes-plugin xfce4-notifyd xfce4-places-plugin xfce4-power-manager xfce4-pulseaudio-plugin xfce4-screensaver xfce4-screenshooter xfce4-sensors-plugin xfce4-session xfce4-settings xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-taskmanager xfce4-time-out-plugin xfce4-timer-plugin xfce4-verve-plugin xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-xkb-plugin xfdesktop xfwm4 xorg-bdftopcf xorg-font-util xorg-fonts-100dpi xorg-fonts-75dpi xorg-fonts-encodings xorg-iceauth xorg-mkfontscale xorg-server xorg-server-common xorg-server-xephyr xorg-server-xnest xorg-server-xvfb xorg-sessreg xorg-setxkbmap xorg-smproxy xorg-xauth xorg-xbacklight xorg-xcmsdb xorg-xdpyinfo xorg-xdriinfo xorg-xev xorg-xgamma xorg-xhost xorg-xinput xorg-xkbcomp xorg-xkbevd xorg-xkbutils xorg-xkill xorg-xlsatoms xorg-xlsclients xorg-xmodmap xorg-xpr xorg-xprop xorg-xrandr xorg-xrdb xorg-xrefresh xorg-xset xorg-xsetroot xorg-xvinfo xorg-xwayland xorg-xwd xorg-xwininfo xorg-xwud xwinwrap-git yay yt-dlp zsh zsh-completions
)

echo "==> Instalando programas e fontes..."
yay -S --needed --noconfirm "${PACOTES[@]}"

# 4. Copiar as suas configurações para o sistema
echo "==> Copiando dotfiles para ~/.config..."
mkdir -p ~/.config

if [ -d ".config" ]; then
    cp -r .config/* ~/.config/
else
    for dir in *; do
        if [ -d "$dir" ] && [ "$dir" != ".git" ] && [ "$dir" != "install.sh" ]; then
            cp -r "$dir" ~/.config/
        fi
    done
fi

echo "==> Instalação concluída com sucesso!"
