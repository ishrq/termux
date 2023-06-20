# Author: IA
# ---


function workout -d "Workout log"
  set file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Workouts/workout-$(date +"%Y-%m").txt

  switch $argv
    case $argv
      echo "$(date +"%n%F $argv")" >> $file
  end
  $EDITOR $file
end
