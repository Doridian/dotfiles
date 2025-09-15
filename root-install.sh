#!/bin/bash
set -euo pipefail
set -x

cd "$(dirname "$0")"

pacman -S --needed --noconfirm git fish rsync diff
mkdir -p /fox/dotfiles

cp -rvf ./system/etc/system/system/* /etc/system/system/

rsync --delete -av ./system/fox/dotfiles/ /fox/dotfiles/
cd /fox
if [ -d ./backup ]; then
    cd ./backup
    git pull
    cd ..
else
    git clone https://github.com/FoxDenHome/backup.git
fi

systemctl enable --now dotfiles-backup.timer
