-- Set <Space> as Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Declare variables
local map = vim.keymap.set
local default = { noremap=true, silent=true }
local allow_remap = { noremap=false, silent=true }
local expr = { expr=true, silent=true }

-- General
map('n', '<Leader>=', ':set spell!<CR>', {desc='Toggle spell check'})
map('n', '<Leader>8', ':execute "set cc=" . (&cc == "" ? "80" : "")<CR>', default, {desc='Toggle character column'})
map('n', 'X', ':keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>', {desc='Split line'})
map('i', '<C-z>', '<C-g>u<Esc>[S1z=`]a<C-g>u', {desc='Fix spelling'})

-- Better indenting
map('v', '<', '<gv^')
map('v', '>', '>gv^')

-- Command mode movement
map('c', '<C-a>', '<Home>')
map('c', '<C-n>', '<Down>')
map('c', '<C-p>', '<Up>')

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
map('n', 'zo', 'zozz')
map('n', 'zr', 'zrzz')
map('n', 'zR', 'zRzz')
map('n', 'zc', 'zczz')
map('n', 'zm', 'zmzz')
map('n', 'zM', 'zMzz')
map('v', 'y', 'ygv<Esc>')

-- Add undo break-points
map('i', ',', ',<C-g>u')
map('i', '.', '.<C-g>u')
map('i', ';', ';<C-g>u')

-- Tabs, windows, frequent files
map('n', '\\b', ":tab drop ~/ARCHIVE/Journal/backlog.txt<CR>", {desc='Open backlog.txt'})
map('n', '\\j', ":tab drop ~/ARCHIVE/Journal/journal.txt<CR>", {desc='Open journal.txt'})

-- Diagnostic keymaps
map('n', '<Leader>e', vim.diagnostic.open_float)
map('n', '<leader>q', vim.diagnostic.setloclist, default)

-- Smart `dd` (don't yank blank lines)
-- https://nanotipsforvim.prose.sh/keeping-your-register-clean-from-dd
map('n', 'dd', function ()

  if vim.fn.getline(".") == "" then return '"_dd' end

  return 'dd'

end, {expr = true})


-- mini.basic
map({ 'n', 'i', 'x' }, '<C-s>', '<Nop>')

-- mini.files
map('n', '<C-t>', '<Cmd>lua MiniFiles.open()<CR>', {desc='Open file tree'})

-- mini.trailspace
map('n', '<Leader>t', '<Cmd>lua MiniTrailspace.trim()<CR>', {desc='Trim trailing space'})
map('n', '<Leader>T', '<Cmd>lua MiniTrailspace.trim_last_lines()<CR>', {desc='Trim trailing lines'})

-- mini.ai
local nxo = {'n','x','o'}
map(nxo, ']a', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'a')<CR>", {desc='Next argument'})
map(nxo, ']A', "<Cmd>lua MiniAi.move_cursor('right', 'i', 'a')<CR>", {desc='Next argument end'})
map(nxo, '[a', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'a', {search_method='prev'})<CR>", {desc='Previous argument'})
map(nxo, '[A', "<Cmd>lua MiniAi.move_cursor('right', 'i', 'a', {search_method='prev'})<CR>", {desc='Previous argument end'})
map(nxo, ']f', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'f')<CR>", {desc='Next function'})
map(nxo, ']F', "<Cmd>lua MiniAi.move_cursor('right', 'i', 'f')<CR>", {desc='Next function end'})
map(nxo, '[f', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'f', {search_method='prev'})<CR>", {desc='Previous function'})
map(nxo, '[F', "<Cmd>lua MiniAi.move_cursor('right', 'i', 'f', {search_method='prev'})<CR>", {desc='Previous function end'})
