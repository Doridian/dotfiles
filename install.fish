#!/usr/bin/env fish

set -l mode $argv[1]
set -l remote $argv[2]

if test -z "$mode"
    echo "Usage: <mode> [remote]"
    echo "  mode: The mode to install the dotfiles in (endpoint or server)"
    echo "  remote: The remote to install the dotfiles on"
    exit 1
end

function _add_machine -a mode host
    set -l listfile 'machines/'"$mode"'s.txt'
    if ! test -f "$listfile"
        echo "Unknown mode $mode"
        return 1
    end

    if ! string match -q -- "*.*" $host
	set -f host "$host.foxden.network"
    end

    echo "$host" >> 'machines/'"$mode"'s.txt'
    git commit -a -m "Add machine $host as a $mode"
    git push
end

if test -z "$remote"
    set -U _dotfiles_mode "$mode"

    _add_machine $mode (hostname -f)
    or exit 1
else
    _add_machine $mode $remote
    or exit 1

    ./update-servers.fish "$remote"
end

git pull
./update.fish gitpulldone
