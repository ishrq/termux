# Author: IA
# ---


function capture
  if test $USER = "u0_a1692" || test $USER = "u0_a215" #Termux S8,M10
    set -f file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Journal/backlog.txt
  else
    set -f file ~/ARCHIVE/Journal/backlog.txt
  end
  switch $argv
    case $argv
      echo "$argv" >> $file
      echo "[Entry captured]"
    case ''
      $EDITOR $file
  end
end

abbr -a c ' capture'
