function is_on_battery
    for stat in (cat /sys/class/power_supply/BAT*/status 2>/dev/null)
        if test $stat = "Discharging"
            return 0
        end
    end
    return 1
end
