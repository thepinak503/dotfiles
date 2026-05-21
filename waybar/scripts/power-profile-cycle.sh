#!/usr/bin/env bash
current=$(powerprofilesctl get)
case "$current" in
  power-saver) powerprofilesctl set balanced ;;
  balanced) powerprofilesctl set performance ;;
  performance) powerprofilesctl set power-saver ;;
esac
