function dotfiles-system-install -a target_file
    set -f system_dir (realpath "$_dotfiles_root_dir/../system")
    set -f target_dir '/etc'

    set -f source_file "$system_dir/"(string replace -r "^$target_dir/" '' "$target_file")

    if not test -e "$source_file"
        echo "Source file '$source_file' does not exist."
        return 1
    end

    if not test -d (dirname "$target_file")
        sudo mkdir -p (dirname "$target_file")
    end
    sudo cp -vaf "$source_file" "$target_file"
end
