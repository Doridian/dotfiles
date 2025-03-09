function gonorm
    set_ec_leds auto

    set_screen_backlight 40
    set_kb_backlight 100

    if ! is_on_battery
        powerprofilesctl set balanced
    end
end
