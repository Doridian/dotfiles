#!/usr/bin/env fish

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
