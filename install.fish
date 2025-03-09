#!/usr/bin/env fish

# curl -fsL https://raw.githubusercontent.com/Doridian/dotfiles/refs/heads/main/install.fish | fish

if test -z "$argv[1]"
    echo "Usage: <mode> [remote]"
    echo "  mode: The mode to install the dotfiles in (endpoint or server)"
    echo "  remote: The remote to install the dotfiles on"
    exit 1
end

set -l _install_script "#!/usr/bin/env fish
set -U _fconfd_mode "$argv[1]"
mkdir -p ~/Programming
cd ~/Programming
if ! test -d dotfiles
     git clone https://github.com/Doridian/dotfiles
end
cd dotfiles
git pull
./update.fish
exit 0"

set -l remote $argv[2]
if ! test -z "$remote"
    echo "$_install_script" | ssh "$remote" -- /usr/bin/env fish
    exit 0
end

eval "$_install_script"
