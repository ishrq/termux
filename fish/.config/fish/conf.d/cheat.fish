# Author: IA
# ---

# Dependencies: fzf, awk

function cheat -d "Cheatsheet"
  if test -d "$HOME/RESOURCES"
    set file ~/RESOURCES/Lists/cheatsheet.txt
  else
    set file ~/storage/shared/Documents/COMPUTER/RESOURCES/Lists/cheatsheet.txt
  end

  set selected (
  awk '!/^($|#)/' $file | fzf -d ' # ' \
    --header "Cheatsheet" \
    --preview="echo -n {1}" \
    --preview-window="up,25%:wrap:follow" \
    --query=(commandline) \
    --bind="ctrl-y:execute(echo -n {1} | fish_clipboard_copy)+abort" \
    --no-bold +m
  )

  # replace query with selected
  if test $status -eq 0
    commandline -r -- $(echo $selected)
  end

  commandline -f repaint
end

bind \e\ce cheat
