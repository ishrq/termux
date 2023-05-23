# Author: IA
# ---


# ---DEPENDENCIES
# grep, sed

function journal
  set -f day $(date +"%F")
  if test $USER = "u0_a1692" || test $USER = "u0_a215" #Termux S8,M10
    set -f file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Journal/journal.txt
  else
    set -f file ~/ARCHIVE/Journal/journal.txt
  end
  switch $argv
    case ''
      $EDITOR $file
    case $argv
      set -f entry "$argv"
      if grep -q "^$day" $file
        sed -i "s/$day/$day\\n$entry/g" $file
      else
        sed -i "s/===/===\\n\\n$day\\n$entry/g" $file
      end
        echo "[Entry added on $day]"
  end
end

abbr -a j ' journal'
