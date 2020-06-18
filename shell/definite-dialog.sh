#!/bin/dash

pairs=/home/ty/git/definite/pairs

case $1 in
  "record"|"i")
    newterm=$(dialog --stdout --inputbox 'Input term:' 80 80 | sed "s/ *$// ; s/^ *// ")
    # ensure new term is nonempty
    if [ -z "$newterm" ]; then
      dialog --msgbox 'Empty term input. Exiting without addition.' 80 80
      clear
      exit 1
    # ensure new term is unique
    elif [ -n "$(awk -F'////' '{print $1}' $pairs | grep $newterm'////')" ]; then
      dialog --msgbox 'Term already defined. Exiting without addition.' 80 80
      clear
      exit 1
    else
      newdef=$(dialog --stdout --inputbox 'Input definition:' 80 80 | sed "s/ *$// ; s/^ *// ")
    fi
    # ensure new definition is nonempty
    if [ -z "$newdef" ]; then
      dialog --msgbox 'Empty definition input. Exiting without addition.' 80 80
      clear
      exit 1
    else
      echo "${newterm}////${newdef}" >> $pairs
      clear
    fi
  ;;
  "recall"|"o")
    execute="dialog --stdout --menu 'Term:' 80 80 69 "
    execute="$execute""$(sed 's/"/\\"/g ; s/^/"/ ; s/\/\/\/\//" "/ ; s/$/"/' $pairs | paste -s -d ' ')"
    choice="$(eval $execute)"
    clear
    echo "Definition of ${choice}:\n$(grep "${choice}////" $pairs | awk -F'////' '{print $2}')"
  ;;
  "remove"|"x")
    execute="dialog --stdout --menu 'Term:' 80 80 69 "
    execute="$execute""$(sed 's/"/\\"/g ; s/^/"/ ; s/\/\/\/\//" "/ ; s/$/"/' $pairs | paste -s -d ' ')"
    choice="$(eval $execute)"
    clear
    sed -i "/^$choice\/\/\/\//d" $pairs
  ;;
  *)
    exit 1
  ;;
esac

exit 0
