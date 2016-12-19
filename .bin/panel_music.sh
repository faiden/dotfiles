#!/bin/bash

. panel_colors

IP="192.168.0.3"
PORT="6600"
MPC=$(mpc -h $IP -p $PORT 2>/dev/null)

if [[ -n $MPC ]]; then
	read -r MPC_TITLE <<<"$MPC"
	MPC_TITLE=${MPC_TITLE//Ã¥/å} #Slay radio bad characters fix	
	MPC_TITLE=${MPC_TITLE//Ã¤/ä} # --
	MPC_TITLE=${MPC_TITLE//Ã¶/ö} # --
	MPC_TITLE=${MPC_TITLE//Ã±/ñ} # --
	MPC_TITLE=${MPC_TITLE//Ã©/é} # --
	MPC_TITLE=${MPC_TITLE//Ã³/ó} # -- 
	MPC_TITLE=${MPC_TITLE//Ãµ/õ} # --
	MPC_TITLE=${MPC_TITLE//Ã¡/á} # --
	MPC_TITLE=${MPC_TITLE//Ã¼/ü} # --
	MPC_TITLE=${MPC_TITLE#*'Now playing: '}
	MPC_TITLE=${MPC_TITLE%%'- Join us on IRC'*}
	if [[ $MPC == *\[playing\]* ]]; then
		printf "%s" "\r ▶ ${CYAN}$MPC_TITLE%{F-}"
		elif [[ $MPC == *\[paused\]* ]]; then
		printf "%s" "\r ▮▮ ${CYAN}$MPC_TITLE%{F-}"
	else
		printf "%s" "\r ◾"	
	fi
else 
	printf "%s" "\r [No connection]"
fi

