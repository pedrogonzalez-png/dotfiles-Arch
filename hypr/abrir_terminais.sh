#!/usr/bin/env bash

# 1. Abre o terminal decorativo com o fastfetch (definindo uma classe própria para ele)
kitty --class kitty-decorativo -e fastfetch &

# 2. Espera um milissegundo para o Hyprland renderizar
sleep 0.15

# 3. Abre o seu terminal de uso normal
kitty &

# 4. Espera o terminal de uso abrir e ajusta a proporção para o decorativo ficar mais estreito
sleep 0.15
hyprctl dispatch splitratio -0.2
