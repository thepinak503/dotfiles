#!/bin/bash
# Waybar media module — shows currently playing track

playerctl_status=$(playerctl status 2>/dev/null)

if [ "$playerctl_status" = "Playing" ] || [ "$playerctl_status" = "Paused" ]; then
  artist=$(playerctl metadata artist 2>/dev/null)
  title=$(playerctl metadata title 2>/dev/null)
  status_icon=$([ "$playerctl_status" = "Playing" ] && echo "" || echo "")

  if [ -n "$artist" ]; then
    text="$artist - $title"
  else
    text="$title"
  fi

  printf '{"text":"%s %s","class":"%s","alt":"%s"}\n' \
    "$status_icon" \
    "$text" \
    "$(echo "$playerctl_status" | tr '[:upper:]' '[:lower:]')" \
    "$playerctl_status"
else
  printf '{"text":"","class":"stopped","alt":"Stopped"}\n'
fi
