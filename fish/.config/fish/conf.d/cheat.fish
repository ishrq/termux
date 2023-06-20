# Author: IA
# ---

function cheat -d "Cheatsheet"

  if test -d "$HOME/RESOURCES"
    set file ~/RESOURCES/Notes/Cheatsheet/*.txt
  else
    set file ~/storage/shared/Documents/COMPUTER/RESOURCES/Notes/Cheatsheet/*.txt
  end

  set filter "echo -n {} | awk -F':' '{print \$NF }'"

  set ctrl_y "execute($filter | fish_clipboard_copy)+abort"

  set selected (
  awk '!/^($|#)/' $file | fzf \
    --header "Cheatsheet" \
    --preview="$filter" \
    --preview-window="up,25%:wrap:follow" \
    --query=(commandline) \
    --bind="alt-e:$alt_e,ctrl-y:$ctrl_y" \
    --no-bold
  )

  # replace query with selected
  if test $status -eq 0
    commandline -r -- $(echo $selected | awk -F': ' '{print $NF}')
  end

  commandline -f repaint
end

bind \e\ce cheat
