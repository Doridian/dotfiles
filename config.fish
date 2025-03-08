set loader_debug 0

set dotfiles_dir "$(dirname "$(realpath "$(status --current-filename)")")"
set fish_conf_d "$dotfiles_dir/fish.conf.d"

alias is_loader_debug='test $loader_debug -eq 1'

if is_loader_debug;
	echo "Loading from $fish_conf_d"
end

function source_file -a file
	if is_loader_debug;
		echo "Sourcing $file"
	end
	source "$file"
end

for file in "$fish_conf_d/always"/*.fish
	source_file "$file"
end
if status is-interactive;
	for file in "$fish_conf_d/interactive"/*.fish
		source_file "$file"
	end
else
	for file in "$fish_conf_d/non-interactive"/*.fish
		source_file "$file"
	end
end
