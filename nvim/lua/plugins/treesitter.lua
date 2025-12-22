return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function(_, opts)
    local ts = require 'nvim-treesitter'
    ts.install {
      'bash',
      'sh',
      'c',
      'html',
      'javascript',
      'json',
      'lua',
      'luadoc',
      'python',
      'markdown',
      'regex',
      'rust',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
    }
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

    -- ---@diagnostic disable-next-line: missing-fields
    -- require('nvim-treesitter.configs').setup(opts)

    ---@type fun(args: vim.api.keyset.create_autocmd.callback_args): boolean?
    local install_parser_and_enable_features = function(event)
      local lang = event.match

      -- Try to start the parser install for the language.
      local ok, task = pcall(ts.install, { lang }, { summary = true })
      if not ok then
        return
      end

      -- Wait for the installation to finish (up to 10 seconds).
      task:wait(10000)

      -- Enable syntax highlighting for the buffer
      ok, _ = pcall(vim.treesitter.start, event.buf, lang)
      if not ok then
        return
      end

      -- Enable other features as needed.

      -- Enable indentation based on treesitter for the buffer.
      -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

      -- Enable folding based on treesitter for the buffer.
      -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end

    -- Install missing parsers on file open.
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('ui.treesitter', { clear = true }),
      pattern = { '*' },
      callback = install_parser_and_enable_features,
    })
  end,
}
