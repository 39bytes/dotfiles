-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- Force telescope/nvim tree to always use cwd as the root
vim.g.root_spec = { 'cwd' }

require 'options'

require 'keymaps'

require 'lazy-bootstrap'

require 'lazy-plugins'

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'single'
  opts.max_width = opts.max_width or 80
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

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

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
