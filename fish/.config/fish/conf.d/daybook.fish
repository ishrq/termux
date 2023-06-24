# Author: IA
# ---


function daybook -d "Work Daybook"
    set day $(date +"%F")

    if test -d "$HOME/ARCHIVE"
        set dir ~/ARCHIVE/Daybook/
        set file ~/ARCHIVE/Daybook/Daybook_$day.md
    else
        set dir ~/storage/shared/Documents/COMPUTER/ARCHIVE/Daybook/
        set file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Daybook/Daybook_$day.md
    end

    $EDITOR -c ":cd $dir" $file
end

abbr -a d 'daybook'
