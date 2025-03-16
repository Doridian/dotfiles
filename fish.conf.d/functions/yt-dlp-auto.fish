function yt-dlp-auto
    yt-dlp --no-post-overwrites --download-archive ./yt-dlp-archive.txt --merge-output-format mkv --sub-langs all,-live_chat --embed-subs --embed-metadata --cookies-from-browser "$_ytdlp_browser" -o ./'%(uploader)s/%(title)s [%(id)s].%(ext)s' --batch-file ./downloads.txt
end
