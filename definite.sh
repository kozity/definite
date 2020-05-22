#!/bin/dash

case $1 in
  "record"|"i")
    newterm=$(dialog --stdout --inputbox 'Input term:' 80 80 | sed "s/ *$// ; s/^ *// ")
    # ensure new term is nonempty
    if [ -z "$newterm" ]; then
      dialog --msgbox 'Empty term input. Exiting without addition.' 80 80
      exit 1
    # ensure new term is unique
    elif [ -n "$(awk -F'////' '{print $1}' /home/ty/git/definite/pairs | grep $newterm)" ]; then
      dialog --msgbox 'Term already defined. Exiting without addition.' 80 80
      exit 1
    else
      newdef=$(dialog --stdout --inputbox 'Input definition:' 80 80 | sed "s/ *$// ; s/^ *// ")
    fi
    # ensure new definition is nonempty
    if [ -z "$newdef" ]; then
      dialog --msgbox 'Empty definition input. Exiting without addition.' 80 80
      exit 1
    else
      echo "${newterm}////${newdef}" >> /home/ty/git/definite/pairs
    fi
  ;;
  "recall"|"o")
    # use dmenu to select term
    choice=$(awk -F'////' '{print $1}' /home/ty/git/definite/pairs | \
      sort | \
      dmenu -i -b -fn 'Roboto Mono:pixelsize=25.8:bold:antialias=true:autohint:true' -nb '#2e3440' -nf '#d8dee9' -sb '#8fbcbb' -sf '#eceff4')

    if [ -z "$choice" ]; then
      exit 1
    # ensure term is defined
    elif [ -z "$(awk -F'////' '{print $1}' /home/ty/git/definite/pairs | grep $newterm)" ]; then
      dialog --msgbox "Term is undefined." 80 80
    else
      # print definition
      def=$(awk -F'////' "/$choice/ {print \$2}" /home/ty/git/definite/pairs)
      dialog --msgbox "$def" 80 80
    fi
  ;;
  "remove"|"x")
    removeterm=$(dialog --stdout --inputbox 'Input term to be removed:' 80 80)
    # check if string is empty
    if [ -z "$removeterm" ]; then
      dialog --msgbox 'Empty term input. Exiting without removal.' 80 80
      exit 1
    # check if string is undefined
    elif [ -z "$(awk '{print $1}' /home/ty/git/definite/pairs | grep $removeterm)" ]; then
      dialog --msgbox 'Term is undefined. Exiting without removal.'
      exit 1
    # remove term and definition
    else
      # -i allows sed to edit source rather than stream only
      sed -i "/$removeterm/d" /home/ty/git/definite/pairs
      dialog --msgbox 'Term found and removed.' 80 80
    fi
  ;;
  *)
    exit 1
  ;;
esac

exit 0
