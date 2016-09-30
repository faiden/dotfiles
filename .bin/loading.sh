#!/bin/bash
loading(){
pid=$!
spin='-\|/'

i=0
while kill -0 $pid 2>/dev/null
do
  i=$(( (i+1) %4 ))
  printf "\r$1${spin:$i:1}"
  sleep .1
done
}
