# Author: IA
# ---

# ---DEPENDENCIES: rg, sd


function ledger
    if test $USER = "u0_a1692" || test $USER = "u0_a215" #Termux S8,M10
    set -f file ~/storage/shared/Documents/COMPUTER/AREAS/Finance/Ledger/ledger-$(date +"%Y%m").txt
  else
    set -f file ~/AREAS/Finance/Ledger/ledger-$(date +"%Y%m").txt
  end
  if ! test -f $file
    cp ~/.config/nvim/templates/ledger.txt $file
    echo "New ledger created."
  end
  switch $argv[1]
    case ''
      $EDITOR $file
    case '*'
      set -f day $(date +"%d/%m/%Y")
      set -f entry "\t$argv[1] $argv[2]"
      if rg -q ^$day $file
        sd $day $day\n$entry $file
      else
        sd DAILY DAILY\n\n$day $file
        sd $day $day\n$entry $file
      end
      echo "[Entry added]"
 end
end

abbr -a lgr ' ledger'
