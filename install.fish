#!/usr/bin/env fish

# curl -fsL https://raw.githubusercontent.com/Doridian/dotfiles/refs/heads/main/install.fish | fish

set -l _install_script '#!/usr/bin/env fish
mkdir -p ~/Programming
cd ~/Programming
if ! test -d dotfiles
     git clone https://github.com/Doridian/dotfiles
end
cd dotfiles
git pull
./update.fish
echo "Done!"'

set -l remote $argv[1]
if ! test -z "$remote"
    echo "$_install_script" | ssh -tt "$remote" -- /usr/bin/env fish
    exit 0
end

eval "$_install_script"
