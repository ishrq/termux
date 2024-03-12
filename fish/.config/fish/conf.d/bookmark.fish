# Author: IA
# Desc: Bookmark script
# ---

# Dependencies: fzf

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
  set ctrl_p "become($browser --private-window {-1})"

  set alt_e "execute(rg -l {-1} $dir | xargs $EDITOR)"
  set ctrl_y "execute(echo -n {-1} | fish_clipboard_copy)+abort"

  set ctrl_b "reload(cat $bk_file)+change-prompt(Bookmarks> )+change-preview-window(hidden)+unbind(tab,ctrl-b)+rebind(change,ctrl-z,ctrl-r)"
  set ctrl_r "reload(cat $rl_file)+change-prompt(Readlater> )+change-preview-window(hidden|)+unbind(change,ctrl-r)+rebind(ctrl-z,ctrl-b,tab)"
  set ctrl_z "reload(cat $ar_file)+change-prompt(Archive> )+change-preview-window(up,1)+unbind(tab,ctrl-z)+rebind(change,ctrl-b,ctrl-r)"


  set alt_z "execute-silent(test -n {q} && date +'%F {q}' >> $ar_file || echo '$(date +"%F {-1}")' >> $ar_file )+reload(cat $ar_file)"
  set alt_r "execute-silent(test -n {q} && echo {q} >> $rl_file || echo {-1} >> $rl_file )+reload(cat $rl_file)"
  set alt_space "execute-silent(test -n {q} && echo {q} >> $bk_file || echo {-1} >> $bk_file )+reload(cat $bk_file)"

  cat $bk_file | fzf\
    -e -m +s \
    --preview='echo {-1}'\
    --preview-window='hidden'\
    --query=(commandline) \
    --prompt="Bookmarks> "\
    --header 'Bookmarks | Readlater | Archive'\
    --bind="enter:$enter,ctrl-o:$ctrl_o,ctrl-p:$ctrl_p"\
    --bind="alt-e:$alt_e"\
    --bind="ctrl-y:$ctrl_y"\
    --bind="ctrl-z:$ctrl_z,ctrl-b:$ctrl_b,ctrl-r:$ctrl_r"\
    --bind="alt-space:$alt_space,alt-z:$alt_z,alt-r:$alt_r"
  commandline -f repaint
end

bind \e\cb bookmark
