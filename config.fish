set loader_debug 1

set dotfiles_dir "$(dirname "$(realpath "$(status --current-filename)")")"
set fish_conf_d "$dotfiles_dir/fish.conf.d"

alias is_loader_debug='test $loader_debug -eq 1'

function source_file -a file
	if is_loader_debug;
		echo "Loading file $file"
	end
	source "$file"
end

function source_dir -a dir
	if is_loader_debug;
		echo "Loading dir $fish_conf_d/$dir"
	end
	for file in "$fish_conf_d/$dir"/*.fish
		source_file "$file"
	end
end

function source_config_root -a dir
	if is_loader_debug;
		echo "Loading root $fish_conf_d/$dir"
	end

	source_dir "$dir"
	if test -z "$SSH_CLIENT";
		source_dir "$dir/local"
	else
		source_dir "$dir/remote"
	end
end

source_config_root always
if status is-interactive;
	source_config_root interactive
else
	source_config_root non-interactive
end
