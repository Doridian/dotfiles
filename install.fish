#!/usr/bin/env fish

set -l _cur_filename "$(status --current-filename)"
if test "$_cur_filename" != '-';
    cd "$(dirname "$_cur_filename")"
end
set -e _cur_filename

if ! test -d .git;
    echo 'Not ran from git repo, assuming first time setup'
    mkdir -p ~/Programming
    cd ~/Programming
    if ! test -d dotfiles;
        git clone https://github.com/Doridian/dotfiles
    end
    cd dotfiles
    git pull
    ./install.fish
    exit 0
end

function symlink_file -a src dst
    set dst_dir "$(realpath "$(dirname "$dst")")"

    set src "$(realpath "$src")"
    set src_rel "$(realpath -s --relative-to="$dst_dir" "$src")"

    mkdir -p "$dst_dir"
    echo "Symlinking $src_rel to $dst"
    ln -sf "$src_rel" "$dst"
end

symlink_file gitconfig ~/.gitconfig
symlink_file ssh.config ~/.ssh/config
symlink_file config.fish ~/.config/fish/config.fish
