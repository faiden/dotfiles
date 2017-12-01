#!/bin/bash

. panel_colors

IP="192.168.0.3"
PORT="6600"
MPC=$(mpc -h $IP -p $PORT 2>/dev/null)
read -r MPC_TITLE <<<"$MPC"
# Extract the title
	MPC_TITLE=${MPC_TITLE//Ã¥/å} #Slay radio bad characters fix
	MPC_TITLE=${MPC_TITLE//Ã¤/ä} # --
	MPC_TITLE=${MPC_TITLE//Ãµ/õ} # --
	MPC_TITLE=${MPC_TITLE//Ã¶/ö} # --
	MPC_TITLE=${MPC_TITLE//Ã/Ö} # --
	MPC_TITLE=${MPC_TITLE//Ã±/ñ} # --
	MPC_TITLE=${MPC_TITLE//Ã©/é} # --
	MPC_TITLE=${MPC_TITLE//Ã³/ó} # --
	MPC_TITLE=${MPC_TITLE//Ãµ/õ} # --
	MPC_TITLE=${MPC_TITLE//Ã¡/á} # --
	MPC_TITLE=${MPC_TITLE//Ã¡/á} # --
	MPC_TITLE=${MPC_TITLE//Ã¼/ü} # --
	MPC_TITLE=${MPC_TITLE//Ö©/é} # --
	MPC_TITLE=${MPC_TITLE#*'Now playing: '}
	MPC_TITLE=${MPC_TITLE%%'- Join us on IRC'*}
case "$MPC" in
	*\[playing\]*)
		printf "%s" "\r ▶ ${CYAN}$MPC_TITLE%{F-}"
		;;
	*\[paused\]*)
		printf "%s" "\r ▮▮ ${CYAN}$MPC_TITLE%{F-}"
		;;
	volume*)
		printf "%s" "\r ◾"	
		;;
	*)
		printf "%s" "\r [No connection]"
		;;
esac
