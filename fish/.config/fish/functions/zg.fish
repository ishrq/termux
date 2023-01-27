# Author: https://github.com/folke/dot/blob/master/config/fish/functions/zg.fish
# ---



function zg -d 'Jump to git parent directory'
    set -l d (pwd)
    if test -d $d/.git
        return
    end
    while test $d != "/"
        if test -d $d/.git
            cd $d
            return
        else
            set d (dirname $d)
        end
    end
    echo "Not in a Git repository"
    return 1
end
