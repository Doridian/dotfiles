function vsleep -a duration
    set -f remaining $duration
    while test $remaining -gt 0
        printf "\rSleeping for $remaining second(s)...     "
        sleep 1
        set -f remaining (math $remaining - 1)
    end
    printf "\rSlept for $duration second(s)            \n"
end
