#!/bin/bash
IP="192.168.0.3"
SINK=$(mpc -h $IP outputs)
SINK=${SINK##*(Pulseaudio sink) is }
SINK=${SINK%%Output*}
SINK=${SINK/$'\n'/}

case $SINK in
	enabled)
		# Enable the raspi sink
		mpc -p 6600 -h 192.168.0.3 disable "Pulseaudio sink"
		dunstify --replace=1338 -a notify-send "mpd sink:" "Off"
    ;;
	disabled)
	  mpc -p 6600 -h 192.168.0.3 enable "Pulseaudio sink"
		dunstify --replace=1338 -a notify-send "mpd sink:" "On"
	  ;;
	*)
	  # If Sink is down
	  dunstify --replace=1338 -a notify-send "mpd error:" "Connection refused" 
	  ;;
esac
