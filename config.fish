set _fconfd_loader_debug 0

set _fconfd_root_dir "$(dirname "$(realpath "$(status --current-filename)")")/fish.conf.d"

function _fconfd_source_file -a file
    if test "$_fconfd_loader_debug" -eq 1

        echo "Loading file $file"
    end
    source "$file"
end

function _fconfd_source_dir -a dir
    if test "$_fconfd_loader_debug" -eq 1

        echo "Loading dir $_fconfd_root_dir/$dir"
    end
    for file in "$_fconfd_root_dir/$dir"/*.fish
        _fconfd_source_file "$file"
    end
end

function _fconfd_source_config_root -a dir
    if test "$_fconfd_loader_debug" -eq 1

        echo "Loading root $_fconfd_root_dir/$dir"
    end

    _fconfd_source_dir "$dir"
    if test -z "$SSH_CLIENT"

        _fconfd_source_dir "$dir/local"
    else
        _fconfd_source_dir "$dir/remote"
    end
end

set -x fish_function_path "$_fconfd_root_dir/functions" $fish_function_path

function fconfd_reload
    _fconfd_source_config_root always
    if status is-interactive
        _fconfd_source_config_root interactive
    else
        _fconfd_source_config_root non-interactive
    end
end

fconfd_reload
