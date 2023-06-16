-- markdown-preview.nvim
vim.keymap.set('n', '<C-p>', '<Plug>MarkdownPreviewToggle', {desc='Markdown Preview'})


-- Mini.ai custom textobject
-- TODO: add textobject for footnote
local spec_pair = require('mini.ai').gen_spec.pair
vim.b.miniai_config = {
    custom_textobjects = {
        ['*'] = spec_pair('*', '*', { type = 'greedy' }),
        ['_'] = spec_pair('_', '_', { type = 'greedy' }),
        ['~'] = spec_pair('~', '~', { type = 'greedy' }),
    },
}
