#!/bin/dash

case $1 in
  "record"|"i")
    newterm=$(dialog --stdout --inputbox 'Input term:' 0 0)
    newdef=$(dialog --stdout --inputbox 'Input definition:' 0 0)
    echo "${newterm}////${newdef}" >> /home/ty/git/definite/pairs
    exit 0
  ;;
  "recall"|"o")
    # use dmenu to select term
    choice=$(awk -F'////' '{print $1}' /home/ty/git/definite/pairs | \
      sort | \
      dmenu -fn 'Roboto Mono:pixelsize=20:bold:antialias=true:autohint:true' -nb '#2e3440' -nf '#d8dee9' -sb '#8fbcbb' -sf '#eceff4')

    if [ -z "$choice" ]; then
      exit 0
    else
      # print definition
      def=$(awk -F'////' "/$choice/ {print \$2}" /home/ty/git/definite/pairs)
      dialog --msgbox "$def" 0 0
      exit 0
    fi
  ;;
  *) # default
    exit 1
  ;;
esac
