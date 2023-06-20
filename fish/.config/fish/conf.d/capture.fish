# Author: IA
# ---


function capture
  if test -d "$HOME/ARCHIVE"
    set file ~/ARCHIVE/Journal/backlog.txt
  else
    set file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Journal/backlog.txt
  end

  switch $argv
    case $argv
      echo $argv >> $file && echo "[Entry captured]"
    case ''
      $EDITOR $file
  end
end

abbr -a c ' capture'
