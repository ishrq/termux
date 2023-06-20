# Author: IA
# ---


function daybook -d "Work Daybook"
    set day $(date +"%F")

    if test -d "$HOME/ARCHIVE"
        set file ~/ARCHIVE/Daybook/Daybook_$day.md
    else
        set file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Daybook/Daybook_$day.md
    end

    $EDITOR $file
end

abbr -a d 'daybook'
