# Author: IA
# ---

function sync -d "Sync files between devices"

  # Set log file
  if test -d "$HOME/ARCHIVE"
    set -g log ~/ARCHIVE/Logs/sync.log
  else
    set -g log ~/storage/shared/Documents/COMPUTER/ARCHIVE/Logs/sync.log
  end

  # phone
  if test $USER = "u0_a1692" || test $USER = "u0_a215" || test $USER = "u0_a241"
    if test $USER = "u0_a1692" #S8
      set -g device "s8"
    else if test $USER = "u0_a215" #M10
      set -g device "m10"
    else if test $USER = "u0_a241" #A20
      set -g device "a20"
    end
    ____phone-to-laptop
    ____phone-to-phone

# laptop
  else
    ____laptop-to-phone
  end
end

function ____phone-to-phone
  for target in s8 m10 a20
    if test $target = "s8"
      set target_ip "192.168.0.103"
    else if test $target = "m10"
      set target_ip "192.168.0.101"
    else if test $target = "a20"
      set target_ip "192.168.0.106"
    end
  if test $target != $device
    if ping -c 1 $target_ip | grep -q "Unreachable"
      set_color red; echo "$target is offline"
    else
      curl -S "$target_ip:1821/sshd"
      rsync -ahmuqz --log-file=$log --mkpath --partial ~/storage/shared/Documents/COMPUTER/ $target:~/storage/shared/Documents/COMPUTER/
      rsync -ahmuqz --log-file=$log --mkpath --partial ~/.local/share/newsboat/ $target:~/.local/share/newsboat/
      rsync -ahmuqz --log-file=$log --mkpath --partial --exclude=config ~/.config/newsboat/ $target:~/.config/newsboat/
      set_color green; echo "Sync with $target successful"
    end
  end
  end
end

function ____phone-to-laptop
  if ping -c 1 192.168.0.104 | grep -q "Unreachable"
    set_color red; echo "Laptop is offline"
  else
    rsync -ahmuqz --log-file=$log --mkpath --partial ~/storage/shared/Documents/COMPUTER/ laptop:~/
    rsync -ahmuqz --log-file=$log --mkpath --partial ~/storage/dcim/Screenshots/ laptop:~/ARCHIVE/Screenshots/
    rsync -ahmuqz --log-file=$log --mkpath --partial ~/storage/shared/backups/ laptop:~/ARCHIVE/Phone-Backups/Backup-$device/
    rsync -ahmuqz --log-file=$log --mkpath --partial ~/.local/share/newsboat/ laptop:~/.local/share/newsboat/
    rsync -ahmuqz --log-file=$log --mkpath --partial --exclude=config ~/.config/newsboat/ laptop:~/.config/newsboat/
    rsync -ahmuqz --log-file=$log --mkpath --partial ~/.config/fish/config.fish laptop:~/.config/fish/
    rsync -ahmuqz --log-file=$log --mkpath --partial --exclude={autopair,fzf,sponge}.fish ~/.config/fish/conf.d/ laptop:~/.config/fish/conf.d/
    rsync -ahmuqz --log-file=$log --mkpath --partial ~/.config/nvim/snippets/ laptop:~/.config/nvim/snippets/
    rsync -ahmuqz --log-file=$log --mkpath --partial ~/.config/nvim/skeletons/ laptop:~/.config/nvim/skeletons/
    rsync -ahmuqz --log-file=$log --mkpath --partial --exclude=config.local ~/.config/git/config laptop:~/.config/git/
    set_color green; echo "Sync with laptop successful"
  end
end

function ____laptop-to-phone
  for target in s8 m10 a20
    if test $target = "s8"
      set target_ip "192.168.0.103"
    else if test $target = "m10"
      set target_ip "192.168.0.101"
    else if test $target = "a20"
      set target_ip "192.168.0.106"
    end
    if ping -c 1 $target_ip | grep -q "Unreachable"
      set_color red; echo "$target is offline"
    else
      curl -S "$target_ip:1821/sshd"
      rsync -ahmuqz --log-file=$log --mkpath --partial --exclude={Design-Assets,Fonts,Fork-bombs,gitignore} ~/RESOURCES/ $target:~/storage/shared/Documents/COMPUTER/RESOURCES/

      rsync -ahmuqz --log-file=$log --mkpath --partial ~/ARCHIVE/{Client-Invoices,Journals,Logs,Receipts,References} $target:~/storage/shared/Documents/COMPUTER/ARCHIVE/

      rsync -ahmuqz --log-file=$log --mkpath --partial ~/.local/share/newsboat/ $target:~/.local/share/newsboat/
      rsync -ahmuqz --log-file=$log --mkpath --partial --exclude=config ~/.config/newsboat/ $target:~/.config/newsboat/
      rsync -ahmuqz --log-file=$log --mkpath --partial ~/.config/fish/config.fish $target:~/.config/fish/
      rsync -ahmuqz --log-file=$log --mkpath --partial --exclude={autopair,fzf,sponge}.fish ~/.config/fish/conf.d/ $target:~/.config/fish/conf.d/
      rsync -ahmuqz --log-file=$log --mkpath --partial ~/.config/nvim/snippets/ $target:~/.config/nvim/snippets/
      rsync -ahmuqz --log-file=$log --mkpath --partial ~/.config/nvim/skeletons/ $target:~/.config/nvim/skeletons/
      rsync -ahmuqz --log-file=$log --mkpath --partial --exclude=config.local ~/.config/git/config $target:~/.config/git/
      set_color green; echo "Sync with $target successful"
    end
  end
end
