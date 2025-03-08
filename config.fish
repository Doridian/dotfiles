set fconfd_loader_debug 0

set fconfd_root_dir "$(dirname "$(realpath "$(status --current-filename)")")/fish.conf.d"

alias fconfd_is_loader_debug='test $fconfd_loader_debug -eq 1'

function fconfd_source_file -a file
	if fconfd_is_loader_debug;
		echo "Loading file $file"
	end
	source "$file"
end

function fconfd_source_dir -a dir
	if fconfd_is_loader_debug;
		echo "Loading dir $fconfd_root_dir/$dir"
	end
	for file in "$fconfd_root_dir/$dir"/*.fish
		fconfd_source_file "$file"
	end
end

function fconfd_source_config_root -a dir
	if fconfd_is_loader_debug;
		echo "Loading root $fconfd_root_dir/$dir"
	end

	fconfd_source_dir "$dir"
	if test -z "$SSH_CLIENT";
		fconfd_source_dir "$dir/local"
	else
		fconfd_source_dir "$dir/remote"
	end
end

fconfd_source_config_root always
if status is-interactive;
	fconfd_source_config_root interactive
else
	fconfd_source_config_root non-interactive
end
