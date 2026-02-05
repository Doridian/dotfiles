function yt-dlp-auto
    function _yt-dlp-one
        echo "Invoking yt-dlp for: $argv"
        yt-dlp --remote-components ejs:github --js-runtimes node --no-post-overwrites --download-archive ./yt-dlp-archive.txt --merge-output-format mkv --sub-langs all,-live_chat --embed-subs --embed-metadata --cookies-from-browser "$_ytdlp_browser" -o ./'%(uploader)s/%(title)s [%(id)s].%(ext)s' $argv
    end

    function _yt-dlp-youtube-m3u8 -a playlist
        echo "Invoking yt-dlp for m3u8 playlist: $playlist"

        set -f playlist_data (yt-dlp --flat-playlist --dump-single-json "$playlist")

        set -f playlist_id (echo "$playlist_data" | jq -r '.id')
        set -f playlist_title (echo "$playlist_data" | jq -r '.title' | sed 's~/~⧸~g')
        set -f playlist_video_ids (echo "$playlist_data" | jq -r '.entries[].id')

        set -f playlist_file "$playlist_title [$playlist_id].m3u8"

        set -f folder '.'
        for videoid in $playlist_video_ids
            set -f filename (find "$folder" -name "*\\[$videoid\\]*" -print -quit)
            if test "$folder" = '.'
                set -f folder (path dirname $filename)
                echo '#EXTM3U' > "$folder/$playlist_file"
            end

            basename "$filename" >> "$folder/$playlist_file"
        end
    end

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

        if string match -q -- '*youtube.com/watch?v=*' $line || string match -q -- '*youtu.be/*' $line
            echo "$line" >> $tmpfile
            set -f tmpfile_used 1
            continue
        end

        _yt-dlp-one $line

        if string match -q -- '*youtube.com/list?list=*' $line
            _yt-dlp-youtube-m3u8 $line
        end

        echo 'Done!'
        vsleep 60
    end

    if test "$tmpfile_used" = 1
        _yt-dlp-one --batch-file "$tmpfile"
    end

    rm -fv "$tmpfile"
end
