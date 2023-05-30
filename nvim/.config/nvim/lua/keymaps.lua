-- Author: IA
-- Machine: S8


-- Set <space> as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Define map funtion
local map = vim.keymap.set
local def = { noremap=true, silent=true }

--[[ Unused keys
leader  ? ; , 0 1 2 3 4 6 7 c d e f h i j k n o p q s t u v w z
comma   , . ; / = - <space>
]]


-- General
map('v', '.', ':normal .<CR>', { desc = "Apply repeat to selected lines"})
map('v', '>', '>gv^') -- Don't leave visual mode after indenting
map('v', '<', '<gv^') -- Don't leave visual mode after indenting
map("n", "<leader>=", ":set spell!<cr>", { desc = "Spelling" })
map("n", "<leader>a", ":keepjumps normal! GVgg<cr>", def, { desc = "Select all" })
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search replace current word" })
map("n", "<leader>x", ":!chmod +x %<CR>", def, { desc = "Make file executable" })


-- Register
map('', 'gp', '`[v`]', def, {desc="Select pasted"})
map('x', '<leader>p', [["_dP]], {desc="Replace selection with register"})


-- Navigate
map('', '<UP>', 'gk', def)
map('', '<DOWN>', 'gj', def)
map('n', 'n', 'nzzzv', def) --Center next search
map('n', 'N', 'Nzzzv', def) --Center previous search
map('n', '<C-d>', '<C-d>zz') --Center screen on up
map('n', '<C-u>', '<C-u>zz') --Center screen on down


-- Move text up/down
map('', 'J', 'mzJ`z', def, {desc="Join line w/o moving cursor" })
map('n', '<A-j>', ":m .+1<CR>==", def, {desc = "Move line down"})
map('n', '<A-k>', ":m .-2<CR>==", def, {desc = "Move line up"})
map('x', '<A-j>', ":m '>+1<CR>gv-gv", def, {desc = "Move selection down"})
map('x', '<A-k>', ":m '<-2<CR>gv-gv", def, {desc = "Move selection up"})


-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, def)
map('n', ']d', vim.diagnostic.goto_next, def)
map('n', '<leader>e', vim.diagnostic.open_float)
map('n', '<leader>q', vim.diagnostic.setloclist, def)


-- nvim-treesitter/nvim-treesitter-context
map('n', '<leader>c', ':TSContextToggle<cr>', def, {desc="tree-sitter context"})
