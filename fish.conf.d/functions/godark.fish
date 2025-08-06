function godark
    set-led --led chromeos:multicolor:charging --color red --brightness 100
    set-led --led chromeos:white:power --brightness 0

    set_screen_backlight 0
    set_kb_backlight 20

    powerprofilesctl set power-saver
end
