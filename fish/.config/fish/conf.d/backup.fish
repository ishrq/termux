# Author: IA
# ---

function backup -d "Backup files"

  set log ~/ARCHIVE/Logs/backup.log # log file
  set target /media/sdcard-bkp1/Backups/ # backup directory

  # set date $(date +"%Y%d%m%H%M%S")
  # tar -cvzf $target/private-files-$date.tar.gz ~/ARCHIVE/{Client-Invoices,Finances,Journals,Logs,Phone-Backups,Receipts,References,Resume,Screenshots,Travel}
  # tar -rvzf $target/private-files-$date.tar.gz ~/RESOURCES
  # echo "$date" >> $log

  rsync -ahmuqz --log-file=$log --mkpath --partial ~/ARCHIVE/ $target/ARCHIVE/
  rsync -ahmuqz --log-file=$log --mkpath --partial --exclude={Virtual-Images,SecLists,gitignore,fork-bomb} ~/RESOURCES $target

  set_color green; echo "Backup successful!"
end
