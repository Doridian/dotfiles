#!/bin/sh

if /fox/dotfiles/is-on-battery.sh; then
        echo 'Refusing backup on battery power!'
        exit 0
fi

if [ -f /fox/dotfiles/local.sh ]; then
        . /fox/dotfiles/local.sh
fi

exec /usr/bin/systemd-inhibit --no-ask-password --what='idle:sleep' --why='restic backup' --no-pager /fox/dotfiles/restic.sh /fox/backup/run.sh / /efi
