function he-sage-score
    set -f tridd (random 1 65535)
    set -f tridh (string replace '0x' '' (math -b 16 $tridd))

    set -f trh "$tridd.github.io"
    set -f tri "2a0a:8d80:0:a000::$tridh"

    echo '=== TRACEROUJTE ==='
    #traceroute -6 "$tri"
    echo '=== DIG AAAA ==='
    dig AAAA "$trh" @8.8.8.8
    echo '=== DIG PTR ==='
    dig PTR -x "$tri" @8.8.8.8
    echo '=== PING ==='
    ping -c4 -6n "$trh"
    echo '=== WHOIS ==='
    whois "$tri"
end
