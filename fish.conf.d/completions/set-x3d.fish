function _set-x3d-help
    printf 'cache\tPrefer core with largest cache\n'
    printf 'frequency\tPrefer core with highest max frequency\n'
end
complete -e set-x3d
complete -c set-x3d -x --arguments '(_set-x3d-help)'
