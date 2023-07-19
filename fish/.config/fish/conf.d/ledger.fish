# Author: IA
# ---

# ---DEPENDENCIES: grep, sed


function ledger
  set month $(date +"%Y-%m")

  if test -d "$HOME/ARCHIVE"
    set dir ~/ARCHIVE/Ledger/
    set file ~/ARCHIVE/Ledger/ledger-$month.txt
  else
    set dir ~/storage/shared/Documents/COMPUTER/ARCHIVE/Ledger/
    set file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Ledger/ledger-$month.txt
  end

  if ! test -f $file
    echo "New ledger created."
  end

  switch $argv
    case ''
      $EDITOR -c ":cd $dir" $file
    case '*'
      set entry "$(date +"%F") $argv"
      echo $entry >> $file && echo "[Entry added]"
  end
end

abbr -a lgr ' ledger'
