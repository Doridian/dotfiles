#!/bin/bash
set -euo pipefail
set -x

mkdir -p /etc/pki/sbsign
chmod 700 /etc/pki/sbsign

openssl req -newkey rsa:4096 -nodes -keyout /etc/pki/sbsign/db.key -new -x509 -sha256 -days 36500 -subj "/CN=FoxDen local DB key/" --outform PEM -out /etc/pki/sbsign/db.crt
cp /etc/pki/sbsign/db.crt /efi/DB.crt
openssl x509 -in /efi/DB.crt -out /efi/DB.cer -outform DER
