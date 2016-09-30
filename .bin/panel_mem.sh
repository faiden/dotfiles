#!/bin/bash

# 0 = MemTotal
# 1 = MemFree
# 3 = Buffers
# 4 = Cached
# 21 = Slab

IFS=$'\n' read -d '' -r -a MEMINFO < /proc/meminfo

i="0"

for LINE in "${MEMINFO[@]}" ; do
	MEM[$i]="${LINE//[!0-9]/}"
	((i++))
done

MEMUSED="$(((${MEM[0]}) - (${MEM[1]} + ${MEM[3]} + ${MEM[4]} + ${MEM[21]})))"
MEMPERC=`echo "scale=2; 100 * (${MEM[0]} - ${MEM[1]} - ${MEM[3]} - ${MEM[4]} - ${MEM[21]}) / ${MEM[0]}" |bc`

printf "%s" "$((${MEMUSED} /1024))MB ${MEMPERC}%"
