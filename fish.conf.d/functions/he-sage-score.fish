function he-sage-score
    echo '=== TRACEROUJTE ==='
    traceroute -6 google.com
    echo '=== DIG AAAA ==='
    dig AAAA icefox.doridian.net @8.8.8.8
    echo '=== DIG PTR ==='
    dig PTR -x 2607:5300:60:7065::1 @8.8.8.8
    echo '=== PING ==='
    ping -c4 -6n google.com
    echo '=== WHOIS ==='
    whois '2607:5300:60:7065::1'
end
