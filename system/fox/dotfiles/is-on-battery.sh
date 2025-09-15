#!/bin/sh
for stat in `cat /sys/class/power_supply/BAT*/status 2>/dev/null`; do
        if [ "$stat" = "Discharging" ]; then
                exit 0
        fi
done

exit 1
