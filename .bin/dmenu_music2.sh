#!/bin/bash
. dmenu.src

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
	MPC_POSITION="${MPC_POSITION%%/*}."
elif [[ $MPC == *\[paused\]* ]]; then
	read -r MPC_TITLE <<<"$MPC"
	MPC_POSITION=${MPC##*#}
	MPC_POSITION="${MPC_POSITION%%/*}."
	MPC_STATE="[Paused] "
else
	MPC_STATE="[stopped] "
fi

# show dmenu playlist and promp
DMENU_INPUT="$(printf %s "$MPC_PLAYLIST" |dmenu -i -p "$MPC_STATE$MPC_POSITION$MPC_TITLE" "$@")"

# MPD Controls
case $DMENU_INPUT in
"|")
	mpc -h $IP -p $PORT stop
	;;
">")
	mpc -h $IP -p $PORT next
	;;
"<")
	mpc -h $IP -p $PORT prev
	;;
"~")
	mpc -h $IP -p $PORT toggle
	;;
*)
	mpc -q -h $IP -p $PORT play ${DMENU_INPUT%% -*}
	;;
esac
