-- Saving with Ctrl+S
vim.keymap.set({ 'n', 'v', 'i' }, '<C-s>', '<cmd>w<CR>')

vim.keymap.set('n', '<leader>qq', '<cmd>qa<CR>', { desc = 'Quit [A]ll' })

-- Buffers
vim.keymap.set('n', '<leader>bd', '<cmd>bp|bd #<CR>', { desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>ba', '<cmd>%bd|e#|bd#<CR>', { desc = '[B]uffer delete [A]ll' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']e', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<leader>jj', function()
  -- Opens jjui in a floating terminal, rooted in your project directory

  Snacks.terminal('jjui', { cwd = vim.fs.root(0, '.jj') })
end, { desc = 'Jujutsu UI' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_command 'autocmd VimResized * wincmd ='
