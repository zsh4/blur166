#!/bin/bash

player_status=$(playerctl status 2>/dev/null)

if [ "$player_status" = "Playing" ]; then
    title=$(playerctl metadata title)
    artist=$(playerctl metadata artist)
    # Limita o tamanho do texto para não quebrar a barra
    text=$(echo " $title - $artist" | cut -c1-40)
    if [ ${#text} -ge 40 ]; then text="$text..."; fi
    
    echo "{\"text\": \"$text\", \"class\": \"playing\", \"tooltip\": \"$title - $artist\"}"
elif [ "$player_status" = "Paused" ]; then
    title=$(playerctl metadata title)
    text=$(echo " $title" | cut -c1-30)
    
    echo "{\"text\": \"$text\", \"class\": \"paused\", \"tooltip\": \"Pausado: $title\"}"
else
    # Se não houver música, retorna vazio (a Waybar esconde o módulo)
    echo "{\"text\": \"\", \"class\": \"stopped\"}"
fi
