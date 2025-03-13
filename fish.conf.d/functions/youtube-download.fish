function youtube-download
    yt-dlp --no-post-overwrites --download-archive "$_youtube_download_dir/yt-dlp-archive.txt" --merge-output-format mkv --sub-langs all,-live_chat --embed-subs --embed-metadata --cookies-from-browser firefox -o "$_youtube_download_dir/"'%(channel)s/%(title)s [%(id)s].%(ext)s' $argv
end

# Use --batch-file for batches
