function vsleep -a duration
    set -f remaining $duration
    while test $remaining -gt 0
        printf "\rSleeping for $remaining seconds..."
        sleep 1
        set -f remaining (math $remaining - 1)
    end
end
