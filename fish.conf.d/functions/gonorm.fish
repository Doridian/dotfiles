function gonorm
    sudo ectool led battery auto
    sudo ectool led power auto

    set_screen_backlight 40
    set_kb_backlight 100

    if ! is_on_battery
        powerprofilesctl set balanced
    end
end
