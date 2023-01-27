# Author: IA
# Modified from https://kau.sh/blog/magic-enter-shell-fish/
# ---

function magic-enter-cmd -d "git status or ls on pressing enter in a dir"
    set -l cmd exa --icons --group-directories-first
    set -l is_git_repository (fish -c "git rev-parse --is-inside-work-tree >&2" 2>| grep true) # variable indicating git.
    set -l repo_has_changes (git status -s --ignore-submodules=dirty)

    if test -n "$is_git_repository"
        if test -n "$repo_has_changes"
            set cmd git status -s
        end
    end

    echo $cmd
end

function magic-enter
    set -l cmd (commandline)
    if test -z "$cmd"
        commandline -r (magic-enter-cmd)
        commandline -f suppress-autosuggestion
    end
    commandline -f execute
    commandline -f repaint
end

bind \r magic-enter
