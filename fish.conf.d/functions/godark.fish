function godark
    sudo ectool led battery red
    sudo ectool led power off

    set_screen_backlight 0
    set_kb_backlight 20

    powerprofilesctl set power-saver
end
