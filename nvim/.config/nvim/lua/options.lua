-- Author: IA
-- Machine: Android/Termux


--CONTEXT
vim.o.number         = true
vim.o.numberwidth    = 3
vim.o.relativenumber = false
vim.o.ruler          = true
vim.o.scrolloff      = 4
vim.o.sidescrolloff  = 4
vim.o.signcolumn     = 'auto'
vim.o.list           = true
vim.o.lcs            = "eol:↴"

--FILETYPE
vim.o.encoding     = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.o.termencoding = 'utf-8'

--THEME
vim.o.syntax = 'on'
vim.o.termguicolors = true

--WHITESPACE
vim.o.expandtab   = true
vim.o.tabstop     = 4
vim.o.softtabstop = 4
vim.o.shiftwidth  = 4

--SPLITS
vim.o.splitbelow = 1
vim.o.splitright = 1

--INDENT
vim.o.autoindent  = true
vim.o.breakindent = true
vim.o.smartindent = true

--WRAP
vim.o.lbr  = true
vim.o.wrap = true

--GENERAL
vim.o.autoread    = true
vim.o.ch          = 0
vim.o.clipboard   = "unnamedplus" --system clipboard
vim.o.cursorline  = true
vim.o.foldenable  = true
vim.o.foldlevel   = 99
vim.o.foldmethod  = 'indent' --manual, indent, syntax, expr, marker
vim.o.grepprg     = 'rg' --default grep
vim.o.ls          = 0
vim.o.lazyredraw  = true
vim.o.mouse       = 'a'
vim.o.showmatch   = true --highlight [{()}]
vim.o.spo         = 'noplainbuffer' --no spellcheck in code
vim.o.timeoutlen  = 1000 --key timeout
vim.o.undofile    = true --save undo history
vim.o.updatetime  = 250  --decrease update time
-- vim.o.wbr = "%f"


--SEARCH
-- vim.o.hlsearch    = false
vim.o.ignorecase  = true
vim.o.incsearch   = true
vim.o.smartcase   = true

--Fuzzy search
-- vim.vim.o.pathappend('**') --search subdir
vim.o.wmnu = true --tab complete


--borrowed https://this-week-in-neovim.org/2023/Jan/09

local ns = vim.api.nvim_create_namespace('toggle_hlsearch')

local function toggle_hlsearch(char)
  if vim.fn.mode() == 'n' then
    local keys = { '<CR>', 'n', 'N', '*', '#', '?', '/' }
    local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end

vim.on_key(toggle_hlsearch, ns)
