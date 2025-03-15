function yt-dlp-auto
    yt-dlp --no-post-overwrites --download-archive ./yt-dlp-archive.txt --merge-output-format mkv --sub-langs all,-live_chat --embed-subs --embed-metadata --cookies-from-browser "$_ytdlp_browser" -o ./'%(channel)s/%(title)s [%(id)s].%(ext)s' $argv
end

# Use --batch-file for batches
