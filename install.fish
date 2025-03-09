#!/usr/bin/env fish

# curl -fsL https://raw.githubusercontent.com/Doridian/dotfiles/refs/heads/main/install.fish | fish

set -l _cur_filename "$(status --current-filename)"
if test "$_cur_filename" != -

    cd "$(dirname "$_cur_filename")"
end
set -e _cur_filename

if ! test -d .git

    echo 'Not ran from git repo, assuming first time setup'
    mkdir -p ~/Programming
    cd ~/Programming
    if ! test -d dotfiles

        git clone https://github.com/Doridian/dotfiles
    end
    cd dotfiles
    git pull
    ./install.fish
    exit 0
end

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
