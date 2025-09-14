function dotfiles-system-install
    set -f system_dir (realpath "$_dotfiles_root_dir/../system")
    set -f target_dir '/etc'

    set -f cmd_file (mktemp)
    echo 'set -euo pipefail' > "$cmd_file"
    echo 'set -x' >> "$cmd_file"

    for target_file in $argv
        set -f source_file "$system_dir/"(string replace -r "^$target_dir/" '' "$target_file")

        if not test -e "$source_file"
            echo "Source file '$source_file' does not exist."
            return 1
        end

        if not test -d (dirname "$target_file")
            echo "mkdir -p '"(dirname "$target_file")"'" >> "$cmd_file"
        end
        echo "cp -vaf '$source_file' '$target_file'" >> "$cmd_file"
    end

    cat "$cmd_file"
    sudo bash "$cmd_file"
    rm -f "$cmd_file"
end
