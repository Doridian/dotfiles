#!/bin/bash
set -euo pipefail
set -x

symlink_file() {
	dst="$2"
	dst_dir="$(realpath "$(dirname "$dst")")"

	src="$(realpath "$1")"
	src_rel="$(realpath -s --relative-to="${dst_dir}" "${src}")"

	mkdir -p "${dst_dir}"
	ln -sf "${src_rel}" "${dst}"
}

symlink_file gitconfig ~/.gitconfig
symlink_file ssh.config ~/.ssh/config
symlink_file config.fish ~/.config/fish/config.fish
