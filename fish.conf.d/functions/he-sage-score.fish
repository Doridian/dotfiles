function he-sage-score
    set -f ipv6file (dirname (status -f))/he-ipv6.ssv
    set -f lineno (random 1 (wc -l $ipv6file | cut -d ' ' -f1))
    set -f curline (head -n $lineno $ipv6file | tail -n 1)

    set -f trh (echo $curline | cut -d ' ' -f1)
    set -f tri (echo $curline | cut -d ' ' -f2)

    set -f trptr (printf "2001:470:a:%x::1" (random 1 3072))

    echo '=== DIG AAAA ==='
    dig AAAA "$trh" @8.8.8.8
    echo '=== DIG PTR ==='
    dig PTR -x "$trptr" @8.8.8.8
    echo '=== WHOIS ==='
    whois "$tri"
    echo '=== PING ==='
    ping -c4 -6n "$trh"
    echo '=== TRACEROUTE ==='
    traceroute -6 "$tri"
end
