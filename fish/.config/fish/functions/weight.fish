# Author: IA
# ---

function weight -d "Weight journal"
  set file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Weight-log/weight-$(date +"%Y").txt
  echo $(date +"%F  $argv") >> $file
end
