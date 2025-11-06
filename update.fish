#!/usr/bin/env fish

cd (path dirname (status --current-filename))

if test "$argv[1]" != gitpulldone
    git pull
    ./update.fish gitpulldone
    exit 0
end

# TRY NOT TO EDIT ABOVE THIS LINE, IT MAKES AUTO UPDATES HARDER!

function _dotfiles_symlink_dir -a src dst
    rmdir "$dst" 2>/dev/null || true
    _dotfiles_symlink_file "$src" "$dst"
end

function _dotfiles_symlink_file -a src dst
    set -l dst_dir (path resolve (path dirname "$dst"))

    set -l src (path resolve "$src")
    set -l src_rel (realpath -s --relative-to="$dst_dir" "$src")

    mkdir -p "$dst_dir"
    echo "Symlinking $src_rel to $dst"
    ln -Tsf "$src_rel" "$dst"
end

_dotfiles_symlink_file config.fish ~/.config/fish/config.fish

_dotfiles_symlink_file "user/gitconfig-$_dotfiles_mode" ~/.gitconfig
_dotfiles_symlink_file user/ssh.config ~/.ssh/config
_dotfiles_symlink_file user/ssh.authorized_keys ~/.ssh/authorized_keys
_dotfiles_symlink_file user/modprobed-db.conf ~/.config/modprobed-db.conf
_dotfiles_symlink_file user/wezterm.lua ~/.wezterm.lua
_dotfiles_symlink_file user/screenrc ~/.screenrc
_dotfiles_symlink_file user/terraformrc ~/.terraformrc
_dotfiles_symlink_dir user/pipewire.conf.d ~/.config/pipewire/pipewire.conf.d
_dotfiles_symlink_dir user/environment.d ~/.config/environment.d

exit 0
