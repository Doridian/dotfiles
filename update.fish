#!/usr/bin/env fish

# curl -fsL https://raw.githubusercontent.com/Doridian/dotfiles/refs/heads/main/install.fish | fish

set -l _cur_filename "$(status --current-filename)"
cd "$(dirname "$_cur_filename")"

function _fconfd_symlink_file -a src dst
    set -l dst_dir "$(realpath "$(dirname "$dst")")"

    set -l src "$(realpath "$src")"
    set -l src_rel "$(realpath -s --relative-to="$dst_dir" "$src")"

    mkdir -p "$dst_dir"
    echo "Symlinking $src_rel to $dst"
    ln -sf "$src_rel" "$dst"
end

_fconfd_symlink_file gitconfig ~/.gitconfig
_fconfd_symlink_file ssh.config ~/.ssh/config
_fconfd_symlink_file config.fish ~/.config/fish/config.fish
