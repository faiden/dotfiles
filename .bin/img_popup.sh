#!/bin/bash
case $1 in
"popup")
bspc rule -a feh -o desktop='^5'
feh --scale-down -N --reload 60 -Z -x -B black -g 320x240+500+812 http://87.237.210.145/~checkpoi/webcam/borasenergi/boras_1_1280.jpg &
;;
"kill")
kill $(pidof feh)
;;
esac
