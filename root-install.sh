#!/bin/bash
set -euo pipefail
set -x

cd "$(dirname "$0")"

pacman -S --needed --noconfirm git fish rsync diff
mkdir -p /opt/dotfiles

rsync --delete -av ./system/opt/dotfiles/ /opt/dotfiles/
