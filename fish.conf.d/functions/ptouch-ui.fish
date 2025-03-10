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

function _ptouch_cmd_info -a cmd info
    set_color blue
    echo -n "    !$cmd: "
    set_color yellow
    echo $info
    set_color normal
end

function _ptouch_ui_help
    echo ' '

    set_color green
    echo '=== ptouch-ui usage help ==='
    set_color normal
    echo ' '

    echo 'ptouch-ui accepts two kinds of input:'
    echo -n '    1. '; set_color red; echo -n 'Text'; set_color normal; echo ' to print'
    echo -n '    2. '; set_color red; echo -n 'Commands'; set_color normal; echo ' (prefixed with !)'
    echo 'Lines starting with ! are treated as commands'
    echo 'Any other line changes the text to print on the label to the current input'

    echo ' '

    set_color green
    echo 'Commands:'
    set_color normal
    _ptouch_cmd_info 'info' 'Print information about the label printer'
    _ptouch_cmd_info 'print' 'Print the current text'
    _ptouch_cmd_info 'help' 'Print this help message'
    _ptouch_cmd_info 'exit' 'Exit the program'
    _ptouch_cmd_info '<number>' 'Set the font size to <number> (0 for automatic)'

    echo ' '

end

function ptouch-ui
    set -f font_size 0
    set -f text 'Meow :3'

    set_color blue
    echo 'Use !help for help'
    set_color normal

    while read -L -f input
        if test (string sub --length 1 "$input") = '!'
            set -f input (string sub --start 2 "$input")
            if test "$input" = 'info'
                set_color blue
                ptouch-print --info 2>/dev/null
                set_color normal
            else if test "$input" = 'print'
                _run_ptouch_print $font_size $text
            else if test "$input" = 'help'
                _ptouch_ui_help
                continue
            else if test "$input" = 'exit'
                break
            else if test "$input" = 'quit'
                break
            else if test "$input" = 'bye'
                break
            else if string match -r -- '^[0-9]+$' "$input" >/dev/null
                set -f font_size $input
            else
                set_color red
                echo "Invalid input: $input"
                set_color normal
                _ptouch_ui_help
                continue
            end
        else if ! test -z "$input"
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
