# Author: IA
# ---

function cheat -d "Cheatsheet"
    # Device specific config
    if test $USER = "u0_a1692" || test $USER = "u0_a215" #Termux S8,M10
        set dir ~/storage/shared/Documents/COMPUTER/RESOURCES/Notes/Cheatsheet/
        set file ~/storage/shared/Documents/COMPUTER/RESOURCES/Notes/Cheatsheet/*.txt
        set clipboard "termux-clipboard-set"
    else
        set dir ~/RESOURCES/Notes/Cheatsheet/
        set file ~/RESOURCES/Notes/Cheatsheet/*.txt
        set clipboard "xargs echo -n | xclip -sel c"
    end

    set filter "echo {} | awk -F':' '{print \$NF }'"

    set ctrl_y "execute($filter | $clipboard)+abort"

    set selected (
        awk '!/^($|#)/' $file | fzf \
            --header "Cheatsheet" \
            --preview="$filter" \
            --preview-window="up,25%:wrap:follow" \
            --query=(commandline) \
            --bind="alt-e:$alt_e,ctrl-y:$ctrl_y" \
            --color='hl+:magenta,hl:dim:bright-magenta,bg+:black,fg+:underline:-1,header:white,prompt:white' \
            --no-bold
    )

    # replace query with selected
    if test $status -eq 0
        commandline -r -- $(echo $selected | awk -F': ' '{print $NF}')
    end

    commandline -f repaint
end

bind \e\ce cheat
