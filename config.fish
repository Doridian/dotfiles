set _dotfiles_loader_debug 0

set _dotfiles_root_dir (path dirname (path resolve (status --current-filename)))/fish.conf.d

function _dotfiles_source_file -a file
    if test "$_dotfiles_loader_debug" -eq 1

        echo "Loading file $file"
    end
    source "$file"
end

function _dotfiles_source_dir -a dir
    if test "$_dotfiles_loader_debug" -eq 1

        echo "Loading dir $_dotfiles_root_dir/$dir"
    end
    for file in "$_dotfiles_root_dir/$dir"/*.fish
        _dotfiles_source_file "$file"
    end
end

function _dotfiles_source_config_root -a dir
    if test "$_dotfiles_loader_debug" -eq 1

        echo "Loading root $_dotfiles_root_dir/$dir"
    end

    _dotfiles_source_dir "$dir"
    if test -z "$SSH_CLIENT"

        _dotfiles_source_dir "$dir/local"
    else
        _dotfiles_source_dir "$dir/remote"
    end
end

function _dotfiles_reload
    set -l _dotfiles_functions_dir "$_dotfiles_root_dir/functions"
    if not contains $_dotfiles_functions_dir $fish_function_path
        set -x fish_function_path $fish_function_path[1] $_dotfiles_functions_dir $fish_function_path[2..]
    end

    set -l _dotfiles_completions_dir "$_dotfiles_root_dir/completions"
    if not contains $_dotfiles_completions_dir $fish_complete_path
        set -x fish_complete_path $fish_complete_path[1] $_dotfiles_completions_dir $fish_complete_path[2..]
    end

    _dotfiles_source_config_root always
    if status is-interactive
        _dotfiles_source_config_root interactive
    else
        _dotfiles_source_config_root non-interactive
    end
end

_dotfiles_reload
