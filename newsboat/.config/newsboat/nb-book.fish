#!/usr/bin/fish

# available args:
# url $1,
# title $2,
# description $3,
# feed_title $4

if test $USER = "u0_a1692" || test $USER = "u0_a215"
    set file ~/storage/shared/Documents/COMPUTER/RESOURCES/Bookmarks/archive-reads.txt
else
    set file ~/RESOURCES/Bookmarks/archive-reads.txt
end
echo $(date +"%F  $argv[1]") >> $file
