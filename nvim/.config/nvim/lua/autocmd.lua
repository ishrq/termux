local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('bufcheck', {clear=true})

--Reload config file on change
autocmd('BufWritePost', {
  group   = 'bufcheck',
  pattern = vim.env.MYVIMRC,
  command = 'silent source %'})

--Highlight yanks
autocmd('TextYankPost', {
  group    = 'bufcheck',
  pattern  = '*',
  callback = function() vim.highlight.on_yank{timeout=300} end })

--Resume previous position
autocmd('BufReadPost', {
  pattern = '*',
  command = [[ if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]], })

-- Auro resize window
autocmd('VimResized', {
  callback = function() vim.cmd("tabdo wincmd =") end,
})

--Remove trailing whitespace on write
autocmd('BufWritePre', {
  pattern = '*',
  command = ":%s/\\s\\+$//e" })

--Don't auto comment new lines
autocmd('BufEnter', {
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o' })

--Start git messages in insert mode
autocmd('FileType', {
  group   = 'bufcheck',
  pattern = { 'gitcommit', 'gitrebase', },
  command = 'startinsert | 1' } )

--No backup, swapfile, undofile for gopass
autocmd({'BufRead', 'BufNewFile'}, {
  pattern = { '/dev/shm/gopass*' },
  command = ' setlocal noswapfile nobackup noundofile shada="" ' } )

--Color column indicator for 80 characters
autocmd({'BufRead', 'BufNewFile'}, {
  pattern = { 'gitcommit', 'markdown', 'text' },
  command = 'cc=80' } )

--Disable color column
autocmd('BufRead', {
  pattern = {'*/Journal/*', '*/Finance/*', '*/House/*', '*/List/*'},
  command = 'setlocal cc=' })

--Markdown/gitcommit
autocmd('FileType', {
    pattern = { "gitcommit", "markdown", "text", "log" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

--Fold
autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
  group = augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()' end })

--Create directory on save
autocmd('BufWritePre', {
  pattern = "*",
  group = augroup("auto_create_dir", { clear = true }),
  callback = function(ctx)
    local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
    vim.fn.mkdir(dir, "p")
  end
})

-- Open help in a new buffer instead of a vsplit
autocmd('BufWinEnter', {
  pattern = '*',
  callback = function(event)
    if vim.bo[event.buf].filetype == 'help' then
      vim.cmd.only()
      vim.bo.buflisted = true
    end
  end,
})

--Toggle relative number in Insert mode
local numbertogglegroup = augroup("numbertoggle", { clear = true })

autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
    pattern = '*',
    callback = function()
        vim.wo.relativenumber = true
    end,
    group = numbertogglegroup, })

autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
    pattern = '*',
    callback = function()
        vim.wo.relativenumber = false
    end,
    group = numbertogglegroup, })


--SKELETON

--Ledger
autocmd('BufNewFile', {
    pattern = '*/Finance/Ledger/ledger*.txt',
    command = '0r ~/.config/nvim/skeletons/ledger.txt' })

--HTML
autocmd('BufNewFile', {
    pattern = '*.html',
    command = '0r ~/.config/nvim/skeletons/html-skeleton.html' })

--CSS
autocmd('BufNewFile', {
    pattern = {'style.css', 'reset.css'},
    command = '0r ~/.config/nvim/skeletons/css-reset.css' })
