# Author: IA
# ---


function daybook -d "Daily Engineering-Daybook"
  set -f day $(date +"%F")
  if test $USER = "u0_a1692" #S8/Termux
    set -f file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Daybook/Daybook_$day.md
  else
    set -f file ~/ARCHIVE/Daybook/Daybook_$day.md
  end
  if ! test -f $file
   echo "$day" >> $file
  end
  $EDITOR $file
end

abbr -a d 'daybook'
