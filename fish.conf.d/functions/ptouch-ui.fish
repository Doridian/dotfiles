function ptouch-ui
    set -f font_size 0
    set -f force_tape_width 0
    set -f elements ()
    set -f edited_element 0

    function _run_ptouch_print -a writepng --no-scope-shadowing
        set -f args ()

        if test "$font_size" -gt 0
            set args $args --fontsize "$font_size"
        end

        if test "$force_tape_width" -gt 0
            set args $args --force-tape-width="$force_tape_width"
        end

        set args $args $elements

        if test -n "$writepng"
            set args $args --writepng "$writepng"
        end

        ptouch-print $args
    end

    function _ptouch_cmd_info -a cmd info
        set_color blue
        echo -n "  !$cmd: "
        set_color yellow
        echo $info
    end

    function _ptouch_ui_help
        echo ' '

        set_color green
        echo '=== ptouch-ui usage help ==='
        set_color normal
        echo ' '

        echo 'ptouch-ui accepts two kinds of input:'
        echo -n '  1. '
        set_color red
        echo -n Text
        set_color normal
        echo ' to print'
        echo -n '  2. '
        set_color red
        echo -n Commands
        set_color normal
        echo ' (prefixed with !)'
        echo 'Lines starting with ! are treated as commands'
        echo 'Any other line append text to print on the label'

        echo ' '

        set_color green
        echo 'Commands:'
        set_color normal
        _ptouch_cmd_info 'info' 'Print information about the label printer'
        _ptouch_cmd_info 'clear' 'Clear the current input'
        _ptouch_cmd_info 'print' 'Print the current input'
        _ptouch_cmd_info 'help' 'Print this help message'
        _ptouch_cmd_info 'exit' 'Exit the program'
        _ptouch_cmd_info 'size PIXELS' 'Set the font size to PIXELS (0 for automatic)'
        _ptouch_cmd_info 'del' 'Delete last added element'
        _ptouch_cmd_info 'del ELEMENT' 'Delete element at index ELEMENT'
        _ptouch_cmd_info 'edit' 'Edits the last added element'
        _ptouch_cmd_info 'edit ELEMENT' 'Edits the element at index ELEMENT'
        _ptouch_cmd_info 'nl TEXT' 'Add TEXT on a new line'
        _ptouch_cmd_info 'image FILE' 'Add an image from FILE'
        _ptouch_cmd_info 'pad PIXELS' 'Add padding of PIXELS'
        _ptouch_cmd_info 'ftw PIXELS' 'Set the force tape width to PIXELS'
        echo ' '
    end

    function _ptouch_ui_pluralize -a count singular plural
        if test "$count" -eq 1
            echo $singular
        else
            echo $plural
        end
    end

    function _ptouch_pixel_pluralize -a count
        _ptouch_ui_pluralize $count 'pixel' 'pixels'
    end

    function _ptouch_ui_showinfo --no-scope-shadowing
        set_color white
        echo '== SETTINGS =='
        set_color green
        echo -n '  Font size: '
            set_color yellow
        if test "$font_size" -gt 0
            echo -n "$font_size "
            set_color white
            _ptouch_pixel_pluralize "$font_size"
        else
            echo 'Automatic'
        end
        if test "$force_tape_width" -gt 0
            set_color red
            echo -n '  Force tape width: '
            set_color yellow
            echo -n "$force_tape_width "
            set_color white
            _ptouch_pixel_pluralize "$force_tape_width"
        end
        set_color normal

        set -l edited_element_valid 0

        echo ' '
        set_color white
        echo '== LAYOUT =='
        for i in (seq 1 2 (count $elements))
            set -l j (math $i + 1)
            set -l idx (math $j / 2)
            set -l typ (string sub --start 3 -- "$elements[$i]")
            set -l val $elements[$j]
            if test "$edited_element" -eq "$idx"
                set_color yellow
                set edited_element_valid 1
            else
                set_color green
            end
            echo -n "  [$idx] "
            set -l unit ''
            set_color blue
            if test "$typ" = text
                echo -n 'Text   : '
            else if test "$typ" = image
                echo -n 'Image  : '
            else if test "$typ" = pad
                echo -n 'Padding: '
                set unit (_ptouch_pixel_pluralize "$val")
            else if test "$typ" = newline
                echo -n 'Newline: '
            else
                set_color red
                echo -n 'Unknown element type: '
                set_color yellow
                echo $typ
                continue
            end
            set_color yellow
            echo -n $val
            set_color white
            echo " $unit"
        end

        if test "$edited_element" -gt 0 -a "$edited_element_valid" -eq 0
            set_color red
            echo -n '  [!] Edited element index '
            set_color white
            echo -n "$edited_element"
            set_color red
            echo ' is invalid. Going back to append mode.'
            set_color normal
            set edited_element 0
        end

        if test "$edited_element" -eq 0
            set_color yellow
            echo -n '  [+] '
            set_color blue
            echo 'Add new element'
        end

        echo ' '
        set_color white
        echo '== PREVIEW =='
        if test (count $elements) -eq 0
            set_color yellow
            echo '  Nothing to preview'
            echo ' '
            return 0
        end

        set_color red
        set -l tmpfile (mktemp /tmp/ptouch-ui-preview-XXXXXX.png)
        _run_ptouch_print $tmpfile >/dev/null
        or echo '  Failed to preview' && rm -f $tmpfile && return 1
        set_color normal

        set_color -b grey
        echo ' '
        echo ' '
        echo -n '  '
        imgcat "$tmpfile"
        rm -f "$tmpfile"
        echo ' '
        set_color -b normal
    end

    function _ptouch_ui_addelement -a typ val --no-scope-shadowing
        if test "$edited_element" -gt 0
            set -l j (math $edited_element '*' 2)
            set -l i (math $j - 1)
            set elements[$i] $typ
            set elements[$j] $val
            set edited_element 0
        else
            set elements $elements $typ $val
        end
    end

    function _ptouch_ui_prompt --no-scope-shadowing
        set_color  green
        echo -n ptouch-ui
        set_color yellow
        if test "$edited_element" -gt 0
            echo -n "[$edited_element]"
        else
            echo -n '[+]'
        end
        set_color normal
        echo -n "> "
    end

    _ptouch_ui_showinfo
    set_color purple
    echo 'Use !help for help'

    set -f input ''
    while read -p '_ptouch_ui_prompt' -L -f input
        if test (string sub --length 1 -- "$input") = '!'
            set input (string sub --start 2 -- "$input")
            if test "$input" = info
                set_color blue
                ptouch-print --info
                set_color normal
            else if test "$input" = print
                _run_ptouch_print
            else if test "$input" = help
                _ptouch_ui_help
                continue
            else if test "$input" = clear
                set elements ()
            else if test "$input" = exit
                break
            else if test "$input" = quit
                break
            else if test "$input" = bye
                break
            else if test "$input" = del
                set -e elements[-2 -1]
            else if test "$input" = 'size auto'
                set font_size 0
            else if test "$input" = 'size automatic'
                set font_size 0
            else if string match -r -- '^del [0-9]+$' "$input" >/dev/null
                set -l idx (string sub --start 5 -- "$input")
                set -l j (math $idx '*' 2)
                set -l i (math $j - 1)
                set -e elements[$i $j]
            else if test "$input" = edit
                set edited_element (math (count $elements) / 2)
            else if string match -r -- '^edit [0-9]+$' "$input" >/dev/null
                set edited_element (string sub --start 6 -- "$input")
            else if string match -r -- '^size [0-9]+$' "$input" >/dev/null
                set font_size (string sub --start 6 -- "$input")
            else if string match -r -- '^nl ' "$input" >/dev/null
                _ptouch_ui_addelement '--newline' (string sub --start 4 -- "$input")
            else if string match -r -- '^image ' "$input" >/dev/null
                _ptouch_ui_addelement '--image' (string sub --start 7 -- "$input")
            else if string match -r -- '^pad [1-9][0-9]*$' "$input" >/dev/null
                _ptouch_ui_addelement '--pad' (string sub --start 5 -- "$input")
            else if string match -r -- '^ftw [0-9]+$' "$input" >/dev/null
                set force_tape_width (string sub --start 5 -- "$input")
            else if string match -r -- '^del ' "$input" >/dev/null
                set_color red
                echo 'Invalid parameter for !del (must be positive integer or 0):' (string sub --start 5 -- "$input")
                continue
            else if string match -r -- '^edit ' "$input" >/dev/null
                set_color red
                echo 'Invalid parameter for !edit (must be positive integer or 0):' (string sub --start 6 -- "$input")
                continue
            else if string match -r -- '^pad( |$)' "$input" >/dev/null
                set_color red
                echo 'Invalid parameter for !pad (must be positive integer):' (string sub --start 5 -- "$input")
                continue
            else if string match -r -- '^ftw( |$)' "$input" >/dev/null
                set_color red
                echo 'Invalid parameter for !ftw (must be positive integer or 0):' (string sub --start 5 -- "$input")
                continue
            else if string match -r -- '^size( |$)' "$input" >/dev/null
                set_color red
                echo 'Invalid parameter for !size (must be positive integer or 0):' (string sub --start 6 -- "$input")
                continue
            else
                set_color red
                echo "Invalid input: $input"
                continue
            end
        else if ! test -z "$input"
            _ptouch_ui_addelement '--text' "$input"
        end

        _ptouch_ui_showinfo
    end
end
