function _run_ptouch_print -a font_size text writepng
    set -f args=()
    if test "$font_size" -gt 0
        set -f args $args --fontsize "$font_size"
    end
    set -f args $args --text "$text"
    if test -n "$writepng"
        set -f args $args --writepng "$writepng"
    end

    ptouch-print $args 2>/dev/null
end

function ptouch-ui
    set -f font_size 0
    set -f text 'Meow :3'

    while read -L -f input
        if test (string sub --length 1 "$input") = '='
            set -f input (string sub --start 2 "$input")
            if test "$input" = 'info'
                set_color blue
                ptouch-print --info 2>/dev/null
                set_color normal
            else if test "$input" = 'print'
                _run_ptouch_print $font_size $text
            else if test "$input" = 'exit'
                break
            else if string match -r -- '^[0-9]+$' "$input"
                set -f font_size $input
            else
                set_color red
                echo "Invalid input: $input"
                set_color normal
            end
        else
            set -f text "$input"
        end

        set_color purple
        echo -n "Font size: "
        if test "$font_size" -gt 0
            set_color yellow
            echo $font_size
        else
            set_color green
            echo 'Automatic (0)'
        end
        set_color normal

        set_color purple
        echo -n "Text: "
        set_color yellow
        echo $text
        set_color normal

        _run_ptouch_print $font_size $text /dev/stdout | imgcat /dev/stdin
        or echo 'Failed to preview'
    end
end
