return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- calling `setup` is optional for customization
    local fzf = require 'fzf-lua'
    fzf.setup {
      lsp = {
        jump1 = true,
      },
      keymap = {
        fzf = {
          ['ctrl-q'] = 'select-all+accept',
        },
      },
    }

    vim.keymap.set('n', '<leader><leader>', fzf.files, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>sb', fzf.buffers, { desc = '[S]earch [B]uffers' })
    vim.keymap.set('n', '<leader>sg', fzf.live_grep_glob, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sq', fzf.quickfix, { desc = '[S]earch [Q]uickfix' })
    vim.keymap.set('n', '<leader>bl', fzf.lines, { desc = 'Search [B]uffer [L]ines' })
    vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  end,
}
