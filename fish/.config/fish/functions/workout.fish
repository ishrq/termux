# Author: IA
# Machine: S8
# ---


function workout -d "Workout log"
    set file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Workouts/workout-$(date +"%Y-%m").txt
    if ! test -f $file
        echo "WORKOUT LOG - $(date +"%Y %B%n===")" >> $file
    end
    switch $argv
        case $argv
            echo "$(date +"%n%F%t$argv")" >> $file
    end
    $EDITOR $file
end

abbr -a w 'workout'
