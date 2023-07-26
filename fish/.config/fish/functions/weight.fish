# Author: IA
# ---

function weight -d "Weight journal"
  set file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Journals/Weight-log/weight-$(date +"%Y").log
  echo $(date +"%F  $argv") >> $file
end
