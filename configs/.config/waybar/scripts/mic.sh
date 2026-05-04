#!/usr/bin/env bash
# Pega o volume do microfone padrão (source)
VOL=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null)

if echo "$VOL" | grep -q "MUTED"; then
  printf '{"text":"󰍭 mudo","class":"muted","tooltip":"microfone mutado"}'
else
  # Extrai o número decimal e converte para porcentagem
  NUM=$(echo "$VOL" | awk '{print $2}')
  PCT=$(echo "$NUM * 100" | bc | cut -d'.' -f1)
  printf '{"text":"󰍬 %s%%","class":"active","tooltip":"microfone: %s%%"}' "$PCT" "$PCT"
fi
