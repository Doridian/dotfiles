#!/usr/bin/env fish

cd (dirname (status --current-filename))

if test "$argv[1]" != gitpulldone
    git pull
    ./update.fish gitpulldone
    exit 0
end

# TRY NOT TO EDIT ABOVE THIS LINE, IT MAKES AUTO UPDATES HARDER!

function _dotfiles_symlink_file -a src dst
    set -l dst_dir (realpath (dirname "$dst"))

    set -l src (realpath "$src")
    set -l src_rel (realpath -s --relative-to="$dst_dir" "$src")

    mkdir -p "$dst_dir"
    echo "Symlinking $src_rel to $dst"
    ln -sf "$src_rel" "$dst"
end

_dotfiles_symlink_file "user/gitconfig-$_dotfiles_mode" ~/.gitconfig
_dotfiles_symlink_file user/ssh.config ~/.ssh/config
_dotfiles_symlink_file user/ssh.authorized_keys ~/.ssh/authorized_keys
_dotfiles_symlink_file config.fish ~/.config/fish/config.fish
exit 0
