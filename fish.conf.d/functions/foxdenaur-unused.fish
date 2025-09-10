function foxdenaur-unused
    pacman -Ss | grep '^foxdenaur/' | grep -vF '[installed]' | cut -d/ -f2 | cut -d' ' -f1 | grep -v '[-]debug$'
end
