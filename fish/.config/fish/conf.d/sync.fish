# Author: IA
# ---


function sync -d "Sync files between devices"

  # phone
  if test $USER = "u0_a1692" || test $USER = "u0_a215"

    if test $USER = "u0_a1692" #S8
      set device "s8"
      set target "m10"
      set target_ip "192.168.0.101"
    else if test $USER = "u0_a215" #M10
      set device "m10"
      set target "s8"
      set target_ip "192.168.0.103"
    end

    # phone -> phone
    if ping -c 1 $target_ip | grep -q "Unreachable"
      echo "$target is offline"
    else
      rsync -auzP --exclude=TBR/Audiobook ~/storage/shared/Documents/ $target:~/storage/shared/Documents/
      rsync -auzP ~/.local/share/newsboat/ $target:~/.local/share/newsboat/
      rsync -auzP --exclude=config ~/.config/newsboat/ $target:~/.config/newsboat/
    end

    # phone -> laptop
    if ping -c 1 192.168.0.104 | grep -q "Unreachable"
      echo "Laptop is offline"
    else
      rsync -auzp ~/storage/shared/documents/computer/ laptop:~/
      rsync -auzp ~/storage/dcim/screenshots/ laptop:~/archive/screenshots/
      rsync -auzp ~/storage/shared/backups/ laptop:~/archive/Phone-Backups/Backup-$device/
      rsync -auzp ~/.local/share/newsboat/ laptop:~/.local/share/newsboat/
      rsync -auzp --exclude=config ~/.config/newsboat/ laptop:~/.config/newsboat/
      rsync -auzp ~/.config/fish/config.fish laptop:~/.config/fish/
      rsync -auzp --exclude={autopair,fzf,sponge}.fish ~/.config/fish/conf.d/ laptop:~/.config/fish/conf.d/
      rsync -auzp ~/.config/nvim/snippets/ laptop:~/.config/nvim/snippets/
      rsync -auzp ~/.config/nvim/skeletons/ laptop:~/.config/nvim/skeletons/
      rsync -auzp --exclude=config.local ~/.config/git/config laptop:~/.config/git/
    end


    # laptop
  else
    for target in s8 m10
      if test $target = "s8"
        set target_ip "192.168.0.103"
      end

      if test $target = "m10"
        set target_ip "192.168.0.101"
      end

      if ping -c 1 $target_ip | grep -q "Unreachable"
        echo "$target is offline"
      else
        rsync -auzP ~/RESOURCES/ --exclude=Fonts/ $target:~/storage/shared/Documents/COMPUTER/RESOURCES/
        rsync -auzP ~/ARCHIVE/{Workouts,Daybook,Ledger,Weight-Log,Logs,Journal} $target:~/storage/shared/Documents/COMPUTER/ARCHIVE/
        rsync -auzp ~/.local/share/newsboat/ $target:~/.local/share/newsboat/
        rsync -auzp --exclude=config ~/.config/newsboat/ $target:~/.config/newsboat/
        rsync -auzp ~/.config/fish/config.fish $target:~/.config/fish/
        rsync -auzp --exclude={autopair,fzf,sponge}.fish ~/.config/fish/conf.d/ $target:~/.config/fish/conf.d/
        rsync -auzp ~/.config/nvim/snippets/ $target:~/.config/nvim/snippets/
        rsync -auzp ~/.config/nvim/skeletons/ $target:~/.config/nvim/skeletons/
        rsync -auzp --exclude=config.local ~/.config/git/config $target:~/.config/git/
      end
    end

  end
end
