# Author: IA
# ---


# Laptop: ia/pop-os

if test $USER="ia" && test $hostname="pop-os"
    # Fzf default
    set -x FZF_DEFAULT_OPTS '--cycle --no-bold --layout=reverse --info=inline --margin=1 --border=thinblock --height=60% --tabstop=4 --scrollbar="▏▕" --color="bg:#181616,fg:#c5c9c5,bg+:#87a987,fg+:#181616,hl:#c4746e,hl+:#ffffff,gutter:#181616,pointer:#8ea4a2,marker:#c4b28a,info:#949fb5,border:#181616" --bind="ctrl-y:execute(echo -n {} | fish_clipboard_copy)+abort" --bind="alt-e:execute(echo -n {} | xargs $EDITOR)+abort" --bind="ctrl-q:close,ctrl-p:toggle-preview,ctrl-a:beginning-of-line,ctrl-e:end-of-line,ctrl-l:clear-query"'


    # Abbreviations
    abbr -a a 'aerc'
    abbr -a b 'vi ~/ARCHIVE/Journal/books.txt'
    abbr -a n 'newsboat'
    abbr -a bc 'bluetoothctl connect FC:E8:06:E9:03:B9'
    abbr -a bd 'bluetoothctl disconnect FC:E8:06:E9:03:B9'

end



# S8/M10: Termux

if test $USER = "u0_a1692" || test $USER = "u0_a215"
    # Command not found
    function __fish_command_not_found_handler --on-event fish_command_not_found
        /data/data/com.termux/files/usr/libexec/termux/command-not-found $argv[1]
    end

    # Fzf default
    set -x FZF_DEFAULT_OPTS '--cycle --no-bold --layout=reverse --info=inline --margin=1 --border=thinblock --preview-window="up:80%:wrap" --height=70% --tabstop=4 --scrollbar="▏▕" --color="bg:#181616,fg:#c5c9c5,bg+:#87a987,fg+:#181616,hl:#c4746e,hl+:#ffffff,gutter:#181616,pointer:#8ea4a2,marker:#c4b28a,info:#949fb5,border:#181616" --bind="ctrl-y:execute(echo -n {} | fish_clipboard_copy)+abort" --bind="alt-e:execute(echo -n {} | xargs $EDITOR)+abort" --bind="ctrl-q:close,ctrl-p:toggle-preview,ctrl-a:beginning-of-line,ctrl-e:end-of-line,ctrl-l:clear-query"'

    # Abbreviations
    abbr -a b 'vi ~/storage/shared/Documents/COMPUTER/ARCHIVE/Journal/books.txt'
    abbr -a n 'newsboat -C ~/.config/newsboat/config_phone'

end



# Global

starship init fish | source
zoxide init fish | source

set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx GPG_TTY $(tty)


# Interactive shells
# if status is-interactive
# else
# end

# Fzf
# set -x FZF_DEFAULT_COMMAND 'rg --files'
set -x FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix'

# Go
set -Ux GOPATH ~/.go
fish_add_path $GOPATH $GOPATH/bin

# Abbreviations

abbr -a cp 'cp -rv'
abbr -a mkdir 'mkdir -v'
abbr -a mv 'mv -v'
abbr -a y '  yt-dlp'
#exa
abbr -a la 'exa -a --icons --group-directories-first'
abbr -a ld 'exa -d */'
abbr -a ll 'exa -lhaGFmU --git --icons --group-directories-first'
abbr -a ls 'exa --icons --group-directories-first'
abbr -a tree 'exa --icons --tree --level=2'
#git
abbr -a g 'git'
abbr -a ga 'git add'
abbr -a gc 'git commit'
abbr -a gd 'git diff'
abbr -a gk 'git checkout (git branch -a | fzf | xargs)'
abbr -a gm 'git merge'
abbr -a gp 'git push'
abbr -a p 'gopass'
abbr -a pc 'gopass -c'
abbr -a po 'gopass otp'
