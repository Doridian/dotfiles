#!/usr/bin/env fish

set -l mode $argv[1]
set -l remote $argv[2]

if test -z "$mode"
    echo "Usage: <mode> [remote]"
    echo "  mode: The mode to install the dotfiles in (endpoint or server)"
    echo "  remote: The remote to install the dotfiles on"
    exit 1
end

if test -z "$remote"
    set -U _dotfiles_mode "$mode"
else
    echo "$remote" >> "machines/$mode.txt"
    git commit -a -m "Add machine $remote as a $mode"
    git push
end

git pull
./update.fish gitpulldone
