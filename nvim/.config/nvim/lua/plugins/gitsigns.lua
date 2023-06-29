return {
  -- https://github.com/lewis6991/gitsigns.nvim
  'lewis6991/gitsigns.nvim',
  cond = vim.fn.hostname() == 'pop-os',
  event = 'VeryLazy',
  cmd = 'Gitsigns',
  opts = {
    signs = {
      add = { text = "|" },
      change = { text = "|" },
      delete = { text = "|" },
      topdelete = { text = "|" },
      changedelete = { text = "|" },
      untracked = { text = "|" },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- Navigation
      map('n', ']h', function()
        if vim.wo.diff then return ']h' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      map('n', '[h', function()
        if vim.wo.diff then return '[h' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      -- Actions
      map('n', '<leader>hb', gs.toggle_current_line_blame, "Toggle Blame")
      map('n', '<leader>hd', gs.toggle_deleted, "Toggle Deleted")
      map('n', '<leader>hf', gs.diffthis, "Diff This")
      map('n', '<leader>hp', gs.preview_hunk, "Preview Hunk")
      map('n', '<leader>hR', gs.reset_buffer, "Reset Buffer")
      map('n', '<leader>hS', gs.stage_buffer, "Stage Buffer")
      map('n', '<leader>hu', gs.undo_stage_hunk, "Undo Stage Hunk")
      map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
      map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')


      -- Text object
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
    end,
  },
}
