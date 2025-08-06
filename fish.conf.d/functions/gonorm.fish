function gonorm
    set-led --led chromeos:multicolor:charging --trigger default
    set-led --led chromeos:white:power --trigger default

    set_screen_backlight 40
    set_kb_backlight 100

    if ! is_on_battery
        powerprofilesctl set balanced
    end

    dimland stop || true
end
