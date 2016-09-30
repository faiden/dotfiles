#!/bin/bash
i="0"
SENSOR=$(sensors)
. panel_colors	
while [ $i -lt 4 ]
	do
# Get the number values
		TEMP="${SENSOR/#*'Core '$i}"
		TEMP=${TEMP%%.*}
		TEMP[$i]=${TEMP/#*'+'}
# Adding colors for the panel
		if [ "${TEMP[$i]}" -le 40 ]; then
			CTEMP[$i]="$GREEN${TEMP[$i]}%{F-}°"
		elif [ "${TEMP[$i]}" -le 59 ]; then
			CTEMP[$i]="$YELLOW${TEMP[$i]}%{F-}°"
		elif [ "${TEMP[$i]}" -ge 60 ]; then
			CTEMP[$i]="$RED${TEMP[$i]}%{F-}°"
		fi

	i=$[$i+1]
done
printf "%s " ${CTEMP[*]}
