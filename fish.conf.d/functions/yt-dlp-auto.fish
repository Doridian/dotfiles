function yt-dlp-auto
    yt-dlp --no-post-overwrites --download-archive "$_ytdlp_auto_dir/yt-dlp-archive.txt" --merge-output-format mkv --sub-langs all,-live_chat --embed-subs --embed-metadata --cookies-from-browser firefox -o "$_ytdlp_auto_dir/"'%(channel)s/%(title)s [%(id)s].%(ext)s' $argv
end

# Use --batch-file for batches
