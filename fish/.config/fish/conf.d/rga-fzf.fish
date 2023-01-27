# Author: IA
# ---


function __rga-fzf
    set RG_PREFIX 'rga -l'
    if test (count $argv) -gt 1
        set RG_PREFIX "$RG_PREFIX $argv[1..-2]"
    end
    set -l file $file
    set file (
        FZF_DEFAULT_COMMAND="$RG_PREFIX '$argv[-1]'" \
        fzf \
            --preview='test ! -z {} && \
                rga --pretty --context 5 {q} {}' \
            --preview-window='70%:wrap'\
            --phony -q "$argv[-1]" \
            --color='hl+:magenta,hl:dim:bright-magenta,bg+:black,fg+:underline:-1,header:white,prompt:white'\
            --bind "change:reload:$RG_PREFIX {q}" \
    )
    if test $status = 0
        $EDITOR $file
    end

    commandline -r ""
    commandline -f repaint
end

bind \e\cg __rga-fzf
