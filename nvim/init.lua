-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- Force telescope/nvim tree to always use cwd as the root
vim.g.root_spec = { 'cwd' }

require 'options'

require 'keymaps'

require 'lazy-bootstrap'

require 'lazy-plugins'

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.s', '*.inc' },
  callback = function()
    vim.opt.ft = 'asm_ca65'
  end,
})

function P(table)
  print(vim.inspect(table))
  return table
end

local function bind(lhs, rhs)
  vim.keymap.set('n', lhs, rhs, { remap = true, buffer = true })
end

vim.api.nvim_create_autocmd('filetype', {
  pattern = 'netrw',
  desc = 'Better mappings for netrw',
  callback = function()
    bind('<C-l>', require('smart-splits').move_cursor_right)
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
