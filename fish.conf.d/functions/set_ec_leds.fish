function set_ec_leds -a mode
        sudo ectool led battery "$mode"
        sudo ectool led power "$mode"
end
