# Author: IA
# ---


function capture
  if test -d "$HOME/ARCHIVE"
    set dir ~/ARCHIVE/Journals/Backlog/
    set file ~/ARCHIVE/Journals/Backlog/capture.txt
  else
    set dir ~/storage/shared/Documents/COMPUTER/ARCHIVE/Journals/Backlog/
    set file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Journals/Backlog/capture.txt
  end

  switch $argv
    case $argv
      echo $argv >> $file && echo "[Entry captured]"
    case ''
      $EDITOR -c ":cd $dir" $file
  end
end

abbr -a c ' capture'
