--Set <Space> as Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Define map function
local map = vim.keymap.set
local def = { noremap=true, silent=true }

-- General
map('', 'gV', '`[v`]', def, {desc='Select yanked/pasted/modified text'})
map('i', '<C-z>', '<C-g>u<Esc>[S1z=`]a<C-g>u', {desc='Fix spelling'})
map('n', '<Leader>=', ':set spell!<CR>', {desc='Toggle spell check'})
map('n', '<Leader>8', ':execute "set cc=" . (&cc == "" ? "80" : "")<CR>', def, {desc="Toggle character column"})
map('n', '<Leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc='Replace current word'})
map('v', '.', ':normal .<CR>', {desc='Visual mode dot repeat'})
map('n', 'X', ':keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>', { silent=true, desc='Split line' })
map('x', 'g/', '<Esc>/\\%V', {silent=false, desc='Search inside selection'})

--NOTE: use the new command mode abbr?
-- map('n', '<Leader>x', ":!chmod +x %<CR>", def, {desc='Make executable'})

-- Search visually selected text
map('x', '*', [[y/\V<C-R>=escape(@", '/\')<CR><CR>]])
map('x', '#', [[y?\V<C-R>=escape(@", '?\')<CR><CR>]])

-- Better indenting
map('v', '<', '<gv^')
map('v', '>', '>gv^')

-- Register
map({'n', 'x'}, 'gy', '"+y', { desc = 'Yank to system clipboard' })
map({'n', 'x'}, 'gd', '"+d', { desc = 'Delete to system clipboard' })
map('n', 'gp', '"+p', { desc = 'Paste from system clipboard' })
map('x', 'gp', '"+P', { desc = 'Paste from system clipboard' })

-- Command mode movement
map('c', '<C-a>', '<Home>')
map('c', '<C-n>', '<Down>')
map('c', '<C-p>', '<Up>')
map('c', '<M-h>', '<Left>', {silent=false})
map('c', '<M-l>', '<Right>', {silent=false})

-- Insert mode movement
map('i', '<M-h>', '<Left>', {noremap=false})
map('i', '<M-j>', '<Down>', {noremap=false})
map('i', '<M-k>', '<Up>', {noremap=false})
map('i', '<M-l>', '<Right>', {noremap=false})

-- Move through line breaks
map({ 'n', 'x' }, 'j', 'v:count == 0 ? "gj" : "j"', {expr=true, silent=true })
map({ 'n', 'x' }, 'k', 'v:count == 0 ? "gk" : "k"', {expr=true, silent=true })

-- Less cursor movement
map('', 'J', 'mzJ`z')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', '*', '*zz')
map('n', '#', '#zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '{', '{zz')
map('n', '}', '}zz')
map('v', 'y', 'ygv<Esc>')

-- Add undo break-points
map('i', ',', ',<C-g>u')
map('i', '.', '.<C-g>u')
map('i', ';', ';<C-g>u')

-- Tabs, windows, frequent files
map('n', '\\b', ":tab drop ~/ARCHIVE/Journal/backlog.txt<CR>", {desc='Open backlog.txt'})
map('n', '\\j', ":tab drop ~/ARCHIVE/Journal/journal.txt<CR>", {desc='Open journal.txt'})
map('n', '\\k', ":tab drop ~/.config/nvim/lua/keymaps.lua<CR>", {desc='Open keymap.lua'})
-- map('n', '<Leader>tl', '<Cmd>tabmove +1<CR>', {desc='Swap tab with next'})
-- map('n', '<Leader>th', '<Cmd>tabmove -1<CR>', {desc='Swap tab with previous'})

-- Diagnostic keymaps
map('n', '<Leader>e', vim.diagnostic.open_float)
map('n', '<leader>q', vim.diagnostic.setloclist, def)

-- mini.trailspace
map('n', '<Leader>t', '<Cmd>lua MiniTrailspace.trim()<CR>', {desc='Trim trailspace'})
map('n', '<Leader>T', '<Cmd>lua MiniTrailspace.trim_last_lines()<CR>', {desc='Trim trail lines'})
-- map('n', '<Leader>t', '<Cmd>%s/\\s\\+$//e<CR>', {desc='Trim trailspace'})

-- Textobjects

-- Around line: with leading and trailing whitespace
-- map('v', 'al', ':<c-u>silent! normal! 0v$<cr>', { silent = true })
-- map('o', 'al', ':normal val<cr>', { noremap = false, silent = true })

-- Inner line: without leading or trailing whitespace
-- map('v', 'il', ':<c-u>silent! normal! ^vg_<cr>', { silent = true })
-- map('o', 'il', ':normal vil<cr>', { noremap = false, silent = true })


-- mini.nvim: mini.ai

local map_next = function(lhs, side, textobj_id, dsc)
    for _, mode in ipairs({ 'n', 'x', 'o' }) do
        vim.keymap.set(mode, lhs, function() MiniAi.move_cursor(side, 'i', textobj_id, { search_method = 'next', n_lines = 100 }) end, {desc=dsc})
    end
end

local map_previous = function(lhs, side, textobj_id, dsc)
    for _, mode in ipairs({ 'n', 'x', 'o' }) do
        vim.keymap.set(mode, lhs, function() MiniAi.move_cursor(side, 'i', textobj_id, { search_method = 'prev', n_lines = 100 }) end, {desc=dsc})
    end
end

map_next(']a', 'left', 'a', 'Next argument')
map_next(']A', 'right', 'a', 'Next argument end')
map_previous('[a', 'left', 'a', 'Previous argument')
map_previous('[A', 'right', 'a', 'Previous argument end')

map_next(']f', 'left', 'f', 'Next function start')
map_next(']F', 'right', 'f', 'Next function end')
map_previous('[f', 'left', 'f', 'Previous function start')
map_previous('[F', 'right', 'f', 'Previous function end')

map_next(']d', 'left', 'D', 'Next date')
map_previous('[d', 'left', 'D', 'Previous date')

map_next(']u', 'left', 'U', 'Next URL')
map_previous('[u', 'left', 'U', 'Previous URL')
