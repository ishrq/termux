# Author: IA
# Machine: S8
# ---

function weight -d "Weight journal"
  set file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Weight-log/weight-$(date +"%Y%m").txt
  if ! test -f $file
    echo "Timestamp           Weight(kg)" >> $file
  end
  echo $(date +"%F %H:%M%t$argv") >> $file
end

