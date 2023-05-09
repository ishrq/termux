# Author: IA
# ---


function daybook -d "Daily Engineering-Daybook"
    set -f day $(date +"%F")
    if test $USER = "u0_a1692" || test $USER = "u0_a215" #Termux S8,M10
        set -f file ~/storage/shared/Documents/COMPUTER/ARCHIVE/Daybook/Daybook_$day.md
    else
        set -f file ~/ARCHIVE/Daybook/Daybook_$day.md
    end
    if ! test -f $file
        echo "$day" >> $file
    end
    $EDITOR $file
end

abbr -a d 'daybook'
