function gonorm
    set_ec_leds auto

    set_screen_backlight 40
    set_kb_backlight 100

    if ! /opt/endpoint/is-on-battery.sh
        powerprofilesctl set balanced
    end
end
