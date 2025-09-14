#!/bin/sh

if /opt/dotfiles/is-on-battery.sh; then
        echo 'Refusing backup on battery power!'
        exit 0
fi

if [ -f /opt/dotfiles/local.sh ]; then
        . /opt/dotfiles/local.sh
fi

exec /usr/bin/systemd-inhibit --no-ask-password --what='idle:sleep' --why='restic backup' --no-pager /opt/dotfiles/restic.sh /opt/backup/run.sh / /efi
