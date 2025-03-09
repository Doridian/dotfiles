#!/usr/bin/env fish

set -l _stage2 $argv[1]

set -l _cur_filename "$(status --current-filename)"
cd "$(dirname "$_cur_filename")"
set -e _cur_filename

if test "$_stage2" != gitpulldone
    git pull
    ./update.fish gitpulldone
    exit 0
end
# TRY NOT TO EDIT ABOVE THIS LINE, IT MAKES AUTOUPDATES HARDER!

function _fconfd_symlink_file -a src dst
    set -l dst_dir "$(realpath "$(dirname "$dst")")"

    set -l src "$(realpath "$src")"
    set -l src_rel "$(realpath -s --relative-to="$dst_dir" "$src")"

    mkdir -p "$dst_dir"
    echo "Symlinking $src_rel to $dst"
    ln -sf "$src_rel" "$dst"
end

_fconfd_symlink_file "gitconfig-$_fconfd_mode" ~/.gitconfig
_fconfd_symlink_file ssh.config ~/.ssh/config
_fconfd_symlink_file config.fish ~/.config/fish/config.fish
exit 0
