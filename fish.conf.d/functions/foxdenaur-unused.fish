function foxdenaur-unused
    function __foxdenaur-unused-filter
        cut -d' ' -f1 | grep -v '^\\s' | grep .
    end

    pacman -Ss | grep '^foxdenaur/' | grep -vF '[installed]' | cut -d/ -f2 | cut -d' ' -f1 | grep -v '[-]debug$'
end
