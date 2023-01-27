# Author: IA
# ---


# ---DEPENDENCIES
# rg, sd

# ---

function journal
  set -f time $(date +"%H:%M")
  set -f day $(date +"%F")
  if test $USER = "u0_a1692" #S8/Termux
    set -f file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Journal/journal.txt
  else
    set -f file ~/ARCHIVE/Journal/journal.txt
  end
  switch $argv
    case ''
      $EDITOR $file
    case $argv
      set -f entry "$argv"
      if rg -q ^$day $file
        sd $day $day\n$entry $file
      else
        sd === ===\n\n$day $file
        # 01 Jan
        if date +"%m-%d" | rg -q "01-01"
          sd $day $day\n\n\$(date +"%Y")\nYEAR\ GOAL $file
        end
        # 22 Sep
        if date +"%m-%d" | rg -q "09-22"
          sd $day $day\nBIRTHDAY $file
        end
        # 1st day of month
        if date +"%d" | rg -q "01"
          sd $day $day\n\n\$(date +"%Y-%m")\nMONTH\ GOAL $file
        end
        # Saturday
        if date +"%a" | rg -q "Sat"
          sd $day $day\nWEEKLY\ REVIEW $file
        end
        sd $day $day\n$entry $file
      end
        echo "[Entry added on $day]"
  end
end

abbr -a j ' journal'
