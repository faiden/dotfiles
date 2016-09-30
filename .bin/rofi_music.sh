#!/bin/bash

# Connection Details for the MPD server
IP="192.168.0.3"
PORT="6600"

# Check if MPD is running and set the MPC variable if it is
MPC=$(mpc -h $IP -p $PORT 2>/dev/null)
if [[ -z "$MPC" ]]; then
	dunstify "MPD:" "No connection to ${IP}:$PORT" && exit $?;
fi

MPC_PLAYLIST="$(mpc -h $IP -p $PORT playlist |nl -s ' - ')"

# Check the state of MPD
if [[ $MPC == *\[playing\]* ]]; then
	read -r MPC_TITLE <<<"$MPC"
	MPC_POSITION=${MPC##*#}
	MPC_POSITION="${MPC_POSITION%%/*}"
	MPC_POSITION="$(($MPC_POSITION-1))"
elif [[ $MPC == *\[paused\]* ]]; then
	read -r MPC_TITLE <<<"$MPC"
	MPC_POSITION=${MPC##*#}
	MPC_POSITION="${MPC_POSITION%%/*}"
	MPC_POSITION="$(($MPC_POSITION-1))"
	MPC_STATE="[Paused] "
else
	MPC_STATE="[stopped] "
fi

# show rofi playlist and promp
ROFI_INPUT="$(printf %s "$MPC_PLAYLIST" |rofi -dmenu -selected-row "$MPC_POSITION" -i -p "${MPC_STATE}Search:" "$@")"

# MPD Controls
case $ROFI_INPUT in
"|")
	mpc -h $IP -p $PORT stop -q
	;;
">")
	mpc -h $IP -p $PORT next -q
	;;
"<")
	mpc -h $IP -p $PORT prev -q
	;;
"~")
	mpc -h $IP -p $PORT toggle -q
	;;
"")
	exit
	;;
*)
	mpc -q -h $IP -p $PORT play ${ROFI_INPUT%% -*}
	;;
esac
