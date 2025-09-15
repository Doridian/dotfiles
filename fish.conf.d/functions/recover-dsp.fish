function recover-dsp -a snapshot
    # TODO: sudo /fox/endpoint/restic.sh /fox/backup/restic.sh mount /mnt/backup
    set -l _fullpath '/home/doridian/.local/share/Steam/steamapps/compatdata/1366540/pfx/drive_c/users/steamuser/'
    set -l _backuproot "/mnt/backup/snapshots/$snapshot"
    # TODO: Pick a snapshot UI for user
    sudo rsync --delete -avogXAE "$_backuproot/$_fullpath" "$_fullpath"
    # TODO: sudo umount /mnt/backup
end
