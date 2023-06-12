# Author: IA
# ---


# Laptop: ia/pop-os

if test $USER="ia" && test $hostname="pop-os"
    # Fzf default
    set -x FZF_DEFAULT_OPTS '--cycle --layout=reverse --info="inline" --margin="1" --height=70% --color="fg:#c5c9c5,bg:#181616,bg+:#87a987,fg+:#181616,hl:#c4746e,hl+:#a292a3,gutter:#181616,pointer:#8ea4a2,info:#949fb5,border:#181616"'

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
    set -x FZF_DEFAULT_OPTS '--cycle --layout=reverse --info="inline" --margin="1" --preview-window="up:60%:wrap" --color="fg:#c5c9c5,bg:#000000,bg+:#87a987,fg+:#181616,hl:#c4746e,hl+:#a292a3,gutter:#181616,pointer:#8ea4a2,info:#949fb5,border:#181616"'

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
set -x FZF_DEFAULT_COMMAND 'fd --type f'

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
