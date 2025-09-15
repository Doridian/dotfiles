function dotfiles-system-install
    set -f system_dir (path resolve "$_dotfiles_root_dir/../system")

    set -f cmd_file (mktemp)
    echo 'set -euo pipefail' > "$cmd_file"
    echo 'set -x' >> "$cmd_file"

    for target_file in $argv
        set -f source_file "$system_dir/"(string replace -r "^/" '' "$target_file")

        if not test -e "$source_file"
            echo "Source file '$source_file' does not exist."
            return 1
        end

        if not test -d (path dirname "$target_file")
            echo "mkdir -p '"(path dirname "$target_file")"'" >> "$cmd_file"
        end
        echo "cp -vaf '$source_file' '$target_file'" >> "$cmd_file"
    end

    echo "rsync --delete -av '$system_dir/fox/dotfiles/' /fox/dotfiles/" >> "$cmd_file"

    cat "$cmd_file"
    sudo bash "$cmd_file"
    rm -f "$cmd_file"
end
