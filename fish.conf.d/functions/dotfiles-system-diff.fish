function dotfiles-system-diff
    set -f system_dir (realpath "$_dotfiles_root_dir/../system")
    set -f target_dir '/etc'

    set -f diff_output (mktemp)
    diff --color=always -ru "$system_dir/" "$target_dir/" 2>&1 | grep --color=never -v '^Only in /etc/' > "$diff_output"

    function _dotfiles_system_diff_header -a title
        echo ' '
        set_color -b white
        set_color black
        echo -n "=== $title ==="
        set_color normal
        echo ' '
        echo ' '
    end

    _dotfiles_system_diff_header 'Differing files'
    cat "$diff_output" | grep --color=never -v "^Only in $system_dir"

    _dotfiles_system_diff_header 'Currently not installed files'
    cat "$diff_output" | grep --color=never "^Only in $system_dir" | sed "s~^Only in $system_dir~$target_dir~; s~: ~/~"

    rm -f "$diff_output"
end
