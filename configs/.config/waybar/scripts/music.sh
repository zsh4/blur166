#!/usr/bin/env bash
STATUS=$(playerctl status 2>/dev/null)

if [ -z "$STATUS" ] || [ "$STATUS" = "No players found" ]; then
  printf '{"text":"","class":"stopped","tooltip":""}'
  exit 0
fi

TITLE=$(playerctl metadata title 2>/dev/null | cut -c1-40)
ARTIST=$(playerctl metadata artist 2>/dev/null | cut -c1-25)
[ "${#TITLE}" -ge 40 ] && TITLE="${TITLE}…"
[ "${#ARTIST}" -ge 25 ] && ARTIST="${ARTIST}…"

[ "$STATUS" = "Playing" ] && CLASS="playing" || CLASS="paused"

# Escapa aspas para não quebrar o JSON
TITLE=$(echo "$TITLE" | sed 's/"/\\"/g')
ARTIST=$(echo "$ARTIST" | sed 's/"/\\"/g')

printf '{"text":"%s  %s","tooltip":"%s","class":"%s"}' \
  "$TITLE" "$ARTIST" "$ARTIST" "$CLASS"