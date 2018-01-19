#!/bin/bash

# Lemonbar music title/progress script
# Shows the current song that mpd is playing with status icons and progression % background of the song title.

. panel_colors

# Get values from mpd 
_ip="192.168.0.3"
_port="6600"
_mpc=$(mpc -h $_ip -p $_port 2>/dev/null)

# Sort the values up i arrays
IFS=$'\n' read -ra _mpc -d '' <<<"$_mpc"

# Get the song title
_mpc_title=${_mpc[0]}

# Get the Current progress of the song
_mpc_progress="${_mpc[1]}"
_mpc_progress="${_mpc_progress#*(}"
_mpc_progress="${_mpc_progress%\%*}"

# Slay radio locale fix (lazy)
_mpc_title=${_mpc_title//Ã¥/å}
_mpc_title=${_mpc_title//Ã¤/ä} 
_mpc_title=${_mpc_title//Ãµ/õ}
_mpc_title=${_mpc_title//Ã¶/ö}
_mpc_title=${_mpc_title//Ã/Ö}
_mpc_title=${_mpc_title//Ã±/ñ}
_mpc_title=${_mpc_title//Ã©/é}
_mpc_title=${_mpc_title//Ã³/ó}
_mpc_title=${_mpc_title//Ãµ/õ}
_mpc_title=${_mpc_title//Ã¡/á}
_mpc_title=${_mpc_title//Ã¡/á}
_mpc_title=${_mpc_title//Ã¼/ü}
_mpc_title=${_mpc_title//Ö©/é}
_mpc_title=${_mpc_title#*'Now playing: '}
_mpc_title=${_mpc_title%%'- Join us on IRC'*}

# Make sure that the lenght of the song title does not go above 66. The song title aligned to left and the rest right.
# 66 is usually the most characters that I can show of the song.
if [[ ${#_mpc_title} -le "66" ]]; then
	_title_progress="$(($((${#_mpc_title}*${_mpc_progress}))/100))"
else
	_title_progress="$(($((66*${_mpc_progress}))/100))"
fi

# Check if mpd is playing/paused etc and output the title/progression as background color behind the current title.
case "${_mpc[1]}" in
	*\[playing\]*)
		 printf "%s" "\r ▶ %{B#373b41}${_mpc_title:0:$_title_progress}""%{B-}""${_mpc_title:$_title_progress}%{F-}"
		;;
	*\[paused\]*)
		printf "%s" "\r ▮▮ %{B#373b41}${_mpc_title:0:$_title_progress}""%{B-}""${_mpc_title:$_title_progress}%{F-}"
		;;
	volume*)
		printf "%s" "\r ◾"	
		;;
	*)
		printf "%s" "\r [No connection]"
		;;
esac
