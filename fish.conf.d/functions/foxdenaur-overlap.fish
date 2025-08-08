function __foxdenaur-overlap-filter
	cut -d' ' -f1 | grep -v '^\\s' | grep .
end

function foxdenaur-overlap
    pacman -Ss | grep '^foxdenaur/' | cut -d/ -f2 | __foxdenaur-overlap-filter > /tmp/foxdenaur-overlap.txt
    pacman -Ss | grep -v '^foxdenaur/' | __foxdenaur-overlap-filter > /tmp/foxdenaur-overlap-other.txt
    for x in (cat /tmp/foxdenaur-overlap.txt)
        cat /tmp/foxdenaur-overlap-other.txt | grep "/$x\$"
    end
    rm -f /tmp/foxdenaur-overlap.txt /tmp/foxdenaur-overlap-other.txt
end
