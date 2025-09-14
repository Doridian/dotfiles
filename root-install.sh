#!/bin/bash
set -euo pipefail
set -x

cd "$(dirname "$0")"

pacman -S --needed --noconfirm git fish rsync diff
mkdir -p /opt/dotfiles

cp -rvf ./system/etc/system/system/* /etc/system/system/

rsync --delete -av ./system/opt/dotfiles/ /opt/dotfiles/
cd /opt
if [ -d ./backup ]; then
    cd ./backup
    git pull
    cd ..
else
    git clone https://github.com/FoxDenHome/backup.git
fi

systemctl enable --now dotfiles-backup.timer
