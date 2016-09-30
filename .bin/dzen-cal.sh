#!/bin/bash

# pop-up calendar for dzen
#

#SCREEN_WIDTH=$(sres -W)

WIDTH=180
LINES=7

XPOS=1093
YPOS=941

BACKGROUND="#151515"
FOREGROUND="#D7D0C7"

HIGHLIGHT="#546a29"
HLTODAY="#546a29"
TODAY=$(date +'%-d')




#TODAY=$(expr `date +'%d'` + 0)
#MONTH=`date +'%m'`
#YEAR=`date +'%Y'`

#(echo
# current month, hilight header and today
#cal | sed -re "s/^(.*[A-Za-z][A-Za-z]*.*)$/^fg($HIGHLIGHT)\1^fg()/;s/(^|[ ])($TODAY)($|[ ])/\1^fg($HIGHLIGHT)\2^fg()\3/"

# next month, hilight header
#[ $MONTH -eq 12 ] && YEAR=`expr $YEAR + 1`
#cal `expr \( $MONTH + 1 \) % 12` $YEAR \
#    | sed -e "s/^\(.*[A-Za-z][A-Za-z]*.*\)$/\1/"
#) | dzen2 -p -bg $BACKGROUND -fg $FOREGROUND -fn "${FONT}:pixelsize=${FONT_SIZE}" -x $XPOS -y $YPOS -w $WIDTH -l $LINES -sa c -e 'onstart=uncollapse;button1=exit;button3=exit' -title-name 'dzen-popup-cal'

#cal -m | sed -re "s/^(.*[A-Za-z][A-Za-z]*.*)$/^fg($HIGHLIGHT)\1^fg()/;s/(^|[ ])($TODAY)($|[ ])/\1^fg($HIGHLIGHT)\2^fg()\3/" |dzen2 -p -bg "$BACKGROUND" -fg $FOREGROUND -l "$LINES" -w "$WIDTH" -x "$XPOS" -y "$YPOS" -sa c -e 'onstart=uncollapse;button1=exit;button3=exit' -title-name 'dzen-popup-cal' -fn '-*-tewi-medium-*-*-*-*-*-*-*-*-*-*-*'

cal -m | sed -re "s/^(.*[A-Za-z][A-Za-z]*.*)$/^fg($HIGHLIGHT)^bg($BACKGROUND)\1/;s/(^|[ ])($TODAY)($|[ ])/\1^bg($HLTODAY)^fg($BACKGROUND)\2^fg($FOREGROUND)^bg($BACKGROUND)\3/" |dzen2 -p -bg "$BACKGROUND" -fg $FOREGROUND -l "$LINES" -w "$WIDTH" -x "$XPOS" -y "$YPOS" -sa c -e 'onstart=uncollapse;button1=exit;button3=exit' -title-name 'dzen-popup-cal' -fn '-*-tewi-medium-*-*-*-*-*-*-*-*-*-*-*'

