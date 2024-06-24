return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  config = function()
    require('typescript-tools').setup {}
    vim.keymap.set('n', '<leader>ti', '<cmd>TSToolsAddMissingImports<cr>', { desc = 'TS: Add [M]issing Imports' })
    vim.keymap.set('n', '<leader>to', '<cmd>TSToolsOrganizeImports<cr>', { desc = 'TS: [O]rganize Imports' })
    vim.keymap.set('n', '<leader>tr', '<cmd>TSToolsRenameFile<cr>', { desc = 'TS: [R]ename file' })
    vim.keymap.set('n', '<leader>tu', '<cmd>TSToolsRemoveUnusedImports<cr>', { desc = 'TS: Remove [U]nused Imports' })
  end,
}
