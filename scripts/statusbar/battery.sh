#!/bin/sh
battery () {
  CHARGE=$(cat /sys/class/power_supply/BAT0/capacity)
  STATUS=$(cat /sys/class/power_supply/BAT0/status)
  if [ "$STATUS" = "Charging" ]; then
    printf "充電%s%%" "$CHARGE"
  else
    printf "放電%s%%" "$CHARGE" 
  fi
}

