# Author: IA
# ---

function ze -w z -d 'change directory and list file'
	z $argv && exa --icons --group-directories-first
end
