# Author: IA
# ---


function md -w mkdir -d 'Create and cd into directory'
	command mkdir -pv $argv
	if test $status = 0
		switch $argv[(count $argv)]
			case '-*'
			case '*'
				cd $argv[(count $argv)]
				return
		end
	end
end
