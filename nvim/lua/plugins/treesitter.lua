return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  version = false,
  lazy = false,
  build = ':TSUpdate',
  config = function(_, opts)
    local ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'jsonc',
      'lua',
      'luadoc',
      'luap',
      'markdown',
      'markdown_inline',
      'printf',
      'python',
      'query',
      'regex',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'xml',
      'yaml',
    }

    local ts = require 'nvim-treesitter'
    local already_installed = require('nvim-treesitter.config').get_installed()
    local to_install = vim
      .iter(ensure_installed)
      :filter(function(parser)
        return not vim.tbl_contains(already_installed, parser)
      end)
      :totable()

    ts.install(to_install)
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'User: enable treesitter highlighting',
      callback = function(ctx)
        -- highlights
        local hasStarted = pcall(vim.treesitter.start) -- errors for filetypes with no parser

        -- indent
        local noIndent = {}
        if hasStarted and not vim.list_contains(noIndent, ctx.match) then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
