# Author: IA
# ---


# Laptop: ia/pop-os

if test $USER="ia" && test $hostname="pop-os"
    # Fzf default
    set -x FZF_DEFAULT_OPTS '--cycle --no-bold --layout=reverse --info=inline --margin=1 --border=thinblock --height=60% --tabstop=4 --scrollbar="▏▕" --color="bg:#181616,fg:#c5c9c5,bg+:#87a987,fg+:#181616,hl:#c4746e,hl+:#ffffff,gutter:#181616,pointer:#8ea4a2,marker:#c4b28a,info:#949fb5,border:#181616" --bind="ctrl-y:execute(echo -n {} | fish_clipboard_copy)+abort" --bind="alt-e:execute(echo -n {} | xargs $EDITOR)+abort" --bind="ctrl-q:close,ctrl-p:toggle-preview,ctrl-a:beginning-of-line,ctrl-e:end-of-line,ctrl-l:clear-query"'

    # bun
    set --export BUN_INSTALL "$HOME/.bun"
    set --export PATH $BUN_INSTALL/bin $PATH

    # Abbreviations
    abbr -a b 'vi ~/RESOURCES/Lists/book-rec.txt'
    abbr -a bc 'bluetoothctl connect FC:E8:06:E9:03:B9'
    abbr -a bd 'bluetoothctl disconnect FC:E8:06:E9:03:B9'
    abbr -a i 'inkscape'
    abbr -a t 'vi -c ":cd ~/ARCHIVE/Journals/Backlog/ " ~/ARCHIVE/Journals/Backlog/todo.txt'

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
    abbr -a b 'vi ~/storage/shared/Documents/COMPUTER/RESOURCES/Lists/book-rec.txt'
    abbr -a t 'vi -c ":cd ~/storage/shared/Documents/COMPUTER/ARCHIVE/Journals/Backlog/ " ~/storage/shared/Documents/COMPUTER/ARCHIVE/Journals/Backlog/todo.txt'

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
abbr -a y ' yt-dlp -q --progress --restrict-filenames --write-auto-sub'
abbr -a yv ' yt-dlp -q --progress --restrict-filenames -a link'
abbr -a ya ' yt-dlp -q --progress --restrict-filenames -a link --audio-format mp3'

abbr -a la 'lsd -a'
abbr -a ld 'lsd -d'
abbr -a ll 'lsd -l'
abbr -a ls 'lsd'
abbr -a tree 'lsd --tree --depth 2'

abbr -a g 'git'
abbr -a ga 'git add'
abbr -a gb 'git branch'
abbr -a gc 'git commit'
abbr -a gca 'git commit -am'
abbr -a gcm 'git commit -m'
abbr -a gd 'git diff'
abbr -a gf 'git fetch'
abbr -a gk 'git checkout (git branch -a | fzf | xargs)'
abbr -a gl 'git log --oneline'
abbr -a gm 'git merge (git branch -a | fzf | xargs)'
abbr -a gp 'git push'
abbr -a gpl 'git pull'
abbr -a gpr 'git prune -v'
abbr -a gr 'git rebase (git branch -a | fzf | xargs)'
abbr -a gt 'git stash'

abbr -a n 'newsboat'
abbr -a na 'newsboat -u ~/.config/newsboat/urls-alt -c ~/.local/share/newsboat/cache-alt.db'
abbr -a nv 'newsboat -u ~/.config/newsboat/urls-video -c ~/.local/share/newsboat/cache-video.'

abbr -a p 'gopass'
abbr -a pc 'gopass -c'
abbr -a po 'gopass otp'
