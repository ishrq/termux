# Author: IA
# ---


# ---DEPENDENCIES
# grep, sed

function journal
  set -f day $(date +"%F")

  if test -d "$HOME/ARCHIVE"
    set file ~/ARCHIVE/Journal/journal.txt
  else
    set file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Journal/journal.txt
  end

  switch $argv
    case ''
      $EDITOR $file
    case $argv
      set -f entry "$argv"
      if grep -q "^$day" $file
        sed -i "s/$day/$day\\n$entry/g" $file && echo "[Entry added on $day]"
      else
        sed -i "s/===/===\\n\\n$day\\n$entry/g" $file && echo "[Entry created for $day]"
      end
  end
end

abbr -a j ' journal'
