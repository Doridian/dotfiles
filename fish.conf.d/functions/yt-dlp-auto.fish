function _yt-dlp-one
    echo "Invoking yt-dlp for: $argv"
    yt-dlp --no-post-overwrites --download-archive ./yt-dlp-archive.txt --merge-output-format mkv --sub-langs all,-live_chat --embed-subs --embed-metadata --cookies-from-browser "$_ytdlp_browser" -o ./'%(uploader)s/%(title)s [%(id)s].%(ext)s' $argv
end

function yt-dlp-auto
    set -f tmpfile (mktemp)
    set -f tmpfile_used 0

    for line in (cat ./downloads.txt)
        set -f line (string trim $line)
        if test -z "$line"
            continue
        end
        if string match -q -- '#*' $line
            continue
        end

        if string match -q -- '*youtube.com/watch?v=*' $line
            echo "$line" >> $tmpfile
            set -f tmpfile_used 1
            continue
        end

        _yt-dlp-one $line

        echo 'Done, sleeping for 60 seconds...'
        sleep 60s
    end

    if test "$tmpfile_used" = 1
        _yt-dlp-one --batch-file "$tmpfile"
    end

    rm -fv "$tmpfile"
end
