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

    set log ~/storage/shared/Documents/COMPUTER/ARCHIVE/Logs/sync.log

    # phone -> phone
    if ping -c 1 $target_ip | grep -q "Unreachable"
      set_color red; echo "$target is offline"
    else
      rsync -ahmuqz --log-file=$log --mkpath --partial --exclude=TBR/Audiobook ~/storage/shared/Documents/ $target:~/storage/shared/Documents/
      rsync -ahmuqz --log-file=$log --mkpath --partial ~/.local/share/newsboat/ $target:~/.local/share/newsboat/
      rsync -ahmuqz --log-file=$log --mkpath --partial --exclude=config ~/.config/newsboat/ $target:~/.config/newsboat/
      set_color green; echo "Sync with $target successful"
    end

    # phone -> laptop
    if ping -c 1 192.168.0.104 | grep -q "Unreachable"
      set_color red; echo "Laptop is offline"
    else
      rsync -ahmuqz --log-file=$log --mkpath --partial ~/storage/shared/documents/computer/ laptop:~/
      rsync -ahmuqz --log-file=$log --mkpath --partial ~/storage/dcim/screenshots/ laptop:~/Archive/screenshots/
      rsync -ahmuqz --log-file=$log --mkpath --partial ~/storage/shared/backups/ laptop:~/Archive/Phone-Backups/Backup-$device/
      rsync -ahmuqz --log-file=$log --mkpath --partial ~/.local/share/newsboat/ laptop:~/.local/share/newsboat/
      rsync -ahmuqz --log-file=$log --mkpath --partial --exclude=config ~/.config/newsboat/ laptop:~/.config/newsboat/
      rsync -ahmuqz --log-file=$log --mkpath --partial ~/.config/fish/config.fish laptop:~/.config/fish/
      rsync -ahmuqz --log-file=$log --mkpath --partial --exclude={autopair,fzf,sponge}.fish ~/.config/fish/conf.d/ laptop:~/.config/fish/conf.d/
      rsync -ahmuqz --log-file=$log --mkpath --partial ~/.config/nvim/snippets/ laptop:~/.config/nvim/snippets/
      rsync -ahmuqz --log-file=$log --mkpath --partial ~/.config/nvim/skeletons/ laptop:~/.config/nvim/skeletons/
      rsync -ahmuqz --log-file=$log --mkpath --partial --exclude=config.local ~/.config/git/config laptop:~/.config/git/
      set_color green; echo "Sync with laptop successful"
    end


# laptop
  else
    set log ~/ARCHIVE/Logs/sync.log
    for target in s8 m10
      if test $target = "s8"
        set target_ip "192.168.0.103"
      end

      if test $target = "m10"
        set target_ip "192.168.0.101"
      end

      if ping -c 1 $target_ip | grep -q "Unreachable"
        set_color red; echo "$target is offline"
      else
        rsync -ahmuqz --log-file=$log --mkpath --partial --exclude={Fonts,Fork-bombs,gitignore} ~/RESOURCES/ $target:~/storage/shared/Documents/COMPUTER/RESOURCES/
        rsync -ahmuqz --log-file=$log --mkpath --partial --exclude={Audiobook,Ebook,Old_References,Papers,Phone-Backups,Projects,Screenshots,Travel} ~/ARCHIVE/ $target:~/storage/shared/Documents/COMPUTER/ARCHIVE/
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
end
