function youtube-download
    yt-dlp --no-post-overwrites --download-archive ~/smb4k/BENGALFOX/share/archive/YouTube/yt-dlp-archive.txt --merge-output-format mkv --sub-langs all,-live_chat --embed-subs --embed-metadata --cookies-from-browser firefox -o ~/smb4k/BENGALFOX/share/archive/YouTube/'%(channel)s/%(title)s [%(id)s].%(ext)s' $argv
end

# Use --batch-file for batches
