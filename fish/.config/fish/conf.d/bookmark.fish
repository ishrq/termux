# Author: IA
# Desc: Bookmark script
# ---

# Dependencies: awk, fzf

function bookmark

  if test -d "$HOME/RESOURCES"
    set browser "librewolf"
    set dir ~/RESOURCES/Bookmarks/
    set bk_file ~/RESOURCES/Bookmarks/bookmark.txt
    set rl_file ~/RESOURCES/Bookmarks/readlater.txt
    set ar_file ~/RESOURCES/Bookmarks/archive-reads.txt
  else
    set browser "termux-open-url"
    set dir ~/storage/shared/Documents/COMPUTER/RESOURCES/Bookmarks/
    set bk_file ~/storage/shared/Documents/COMPUTER/RESOURCES/Bookmarks/bookmark.txt
    set rl_file ~/storage/shared/Documents/COMPUTER/RESOURCES/Bookmarks/readlater.txt
    set ar_file ~/storage/shared/Documents/COMPUTER/RESOURCES/Bookmarks/archive-reads.txt
  end

  set enter "become($browser {-1})"
  set ctrl_o "execute-silent(open {-1} >/dev/null 2>&1 &)"

  set alt_e "execute(rg -l {-1} $dir | xargs $EDITOR)"
  set ctrl_y "execute(echo -n {-1} | fish_clipboard_copy)+abort"

  set ctrl_b "reload(awk '!/^(\$|#)/' $bk_file)+change-prompt(Bookmarks> )+change-preview-window(up,1)+unbind(tab,ctrl-b)+rebind(change,ctrl-z,ctrl-r)"
  set ctrl_r "reload(awk '!/^(\$|#)/' $rl_file)+change-prompt(Readlater> )+change-preview-window(hidden|)+unbind(change,ctrl-r)+rebind(ctrl-z,ctrl-b,tab)"
  set ctrl_z "reload(awk '!/^(\$|#)/' $ar_file)+change-prompt(Archive> )+change-preview-window(up,1)+unbind(tab,ctrl-z)+rebind(change,ctrl-b,ctrl-r)"

  set alt_z "execute-silent(test -n {q} && date +'%F {q}' >> $ar_file || echo '$(date +"%F {-1}")' >> $ar_file )+reload(awk '!/^(\$|#)/' $ar_file)"
  set alt_r "execute-silent(test -n {q} && echo {q} >> $rl_file || echo {-1} >> $rl_file )+reload(awk '!/^(\$|#)/' $rl_file)"


  awk '!/^($|#)/' $rl_file | fzf\
    -e --multi +s \
    --preview='echo {-1}'\
    --preview-window='hidden'\
    --query=(commandline) \
    --prompt="Readlater> "\
    --header 'Bookmarks | Readlater | Archive'\
    --bind="enter:$enter,ctrl-o:$ctrl_o"\
    --bind="alt-e:$alt_e"\
    --bind="ctrl-y:$ctrl_y"\
    --bind="ctrl-z:$ctrl_z,ctrl-b:$ctrl_b,ctrl-r:$ctrl_r"\
    --bind="alt-z:$alt_z,alt-r:$alt_r"\

  commandline -r -- $(echo "")
  commandline -f repaint
end

bind \e\cb bookmark
