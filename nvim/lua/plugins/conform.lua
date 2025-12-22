return { -- Autoformat
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      javascript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      html = { 'prettierd' },
      astro = { 'prettierd' },
      python = { 'ruff_format' },
      go = { 'gofmt' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      eruby = { 'erb_format' },
      ocaml = { 'ocamlformat' },
      clojure = { 'zprint' },
      java = { 'google-java-format' },
      typst = { 'typstyle' },
    },
    formatters = {
      clang_format = {
        prepend_args = { '--style=file', '--fallback-style=WebKit' },
      },
    },
  },
}
