#!/bin/bash

# Sensor inteligente: espera o Hyprland aceitar comandos (sem tempo fixo, vai na velocidade máxima do seu PC)
while ! hyprctl activeworkspace &>/dev/null; do
    sleep 0.05
done

# 1. Vai para a Workspace 1
hyprctl dispatch workspace 1

# 2. Abre o Relógio
kitty --class=kitty-clock -e tty-clock -c -B -C 7 &

# Espera o relógio aparecer para não atropelar a próxima janela
while ! hyprctl clients | grep -q "class: kitty-clock"; do
    sleep 0.05
done

# 3. Prepara o corte para a direita
hyprctl dispatch layoutmsg preselect r

# 4. Abre o Fastfetch
kitty --class=kitty-fetch -e sh -c "fastfetch; exec fish" &

# Espera o Fastfetch aparecer
while ! hyprctl clients | grep -q "class: kitty-fetch"; do
    sleep 0.05
done

# 5. Foca no Fastfetch
hyprctl dispatch focuswindow class:kitty-fetch

# 6. Prepara o corte para baixo
hyprctl dispatch layoutmsg preselect d

# 7. Abre o btop
kitty --class=kitty-btop -e btop &
