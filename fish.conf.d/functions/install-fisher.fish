function install-fisher
    set -l _url 'https://raw.githubusercontent.com/jorgebucaran/fisher/refs/tags/4.4.5/functions/fisher.fish'
    set -l _sha256 '59640d07bda182f2ad0fdfe9dc8a799fb79f46e6e5fc460354ffe2e21f759688'

    set -l _tmpf (mktemp --suffix .fish)
    curl -fL -o"$_tmpf" "$_url"
    set -l data_sha256 (sha256sum "$_tmpf" | cut -d' ' -f1)
    if test "$_sha256" != "$data_sha256"
        echo "Error: SHA256 checksum mismatch for $_url"
        rm -fv "$_tmpf"
        return 1
    end

    source "$_tmpf"
    rm -fv "$_tmpf"
    fisher install jorgebucaran/fisher
end
