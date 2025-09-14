function dotfiles-system-diff
    set -f system_dir (path resolve "$_dotfiles_root_dir/../system")
    set -f target_dir '/etc'

    set -f diff_output (mktemp)
    find "$system_dir/" -type f -printf '%P\0' | xargs -0 -i{} diff --color=always -u "$target_dir/{}" "$system_dir/{}" 2>&1 | grep --color=never -v '^Only in /etc/' > "$diff_output"

    function _dotfiles_system_diff_header -a title
        echo ' '
        set_color -b white
        set_color black
        echo -n "=== $title ==="
        set_color normal
        echo ' '
        echo ' '
    end

    set -l _error_regex 'diff: \(.*\): No such file or directory$'

    _dotfiles_system_diff_header 'Differing files'
    cat "$diff_output" | grep --color=never -v "$_error_regex"

    _dotfiles_system_diff_header 'Currently not installed files'
    set_color green
    cat "$diff_output" | grep --color=never "$_error_regex" | sed "s~^$_error_regex~+\1~"
    set_color normal

    _dotfiles_system_diff_header 'All done'

    rm -f "$diff_output"
end
