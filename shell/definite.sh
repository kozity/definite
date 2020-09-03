#!/bin/dash

pairs=/home/ty/git/definite/pairs

case $1 in
  "list"|"l")
    awk -F'////' '{print $1}' $pairs
  ;;
  "record"|"i")
    if [ -z "$2" ]; then
      echo "Enter term: "
      read term
    else
      term=$2
    fi
    [ -z "$term" ] && echo "Empty input; exiting." && exit 1
    if [ -n "$(awk -F'////' '{print $1}' $pairs | grep -x "$term")" ]; then
      echo "$term already defined as:"
      # echo to remove grep coloring
      echo $(grep "^$term////" $pairs | awk -F'////' '{print $2}')
      echo "Edit [y/n]?"
      read yesno
      if [ $(echo $yesno | grep y) ]; then
        echo "Enter definition:"
        read def
        sed -i "/^${term}\/\/\/\//d" $pairs
        echo "$term////$def" >> $pairs
      else
        echo "Old definition retained; exiting."
      fi
    else
      while true; do
        echo "Enter definition:"
        read def
        [ -n "$def" ] && echo "$term////$def" >> $pairs ; break
      done
    fi
  ;;
  "recall"|"o")
    if [ -z "$2" ]; then
      awk -F'////' '{print $1}' $pairs
      while true; do
        echo "Enter term:"
        read term
        [ "$term" ] && break
      done
    else
      term=$2
    fi
    if [ "$(awk -F'////' '{print $1}' $pairs | grep -x "$term")" ]; then
      echo "Definition of ${term}:"
      awk -F'////' "/$term\/\/\/\//{print \$2}" $pairs
      echo "--ENTER TO CLOSE--"
      read temp
    else
      echo "Term not found."
      echo "--ENTER TO CLOSE--"
      read temp
      exit 1
    fi
  ;;
  "remove"|"x")
    if [ -z "$2" ]; then
      awk -F'////' '{print $1}' $pairs
      while true; do
        echo "Enter term:"
        read term
        [ $term ] && break
      done
    else
      term=$2
    fi
    [ "$(awk -F'////' '{print $1}' $pairs | grep -x "$term")" ] && \
      sed -i "/$term\/\/\/\//d" $pairs || \
      echo "Term not found; exiting." ; exit 1
  ;;
  *)
    echo "Argument not recognized; exiting."
    exit 1
  ;;
esac

exit 0
