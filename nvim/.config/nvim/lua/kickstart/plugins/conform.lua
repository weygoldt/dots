return {
  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },

      -- Prepend -l (--local) flag to latexindent to use local config
      -- Prepend -m (--modifylinebreaks) flag to latexindent to modify line breaks
      -- Prepend -s (--silent) flag to latexindent to suppress logfiles
      formatters = {
        latexindent = {
          command = 'latexindent',
          inherit = true,
          prepend_args = { '-l', '-m' },
        },
      },

      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        svelte = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },

        tex = { 'latexindent' },

        -- Choose python formatter based on whether ruff_format is available
        python = function(bufnr)
          if require('conform').get_formatter_info('ruff_format', bufnr).available then
            return { 'ruff_format' }
          else
            return { 'isort', 'black' }
          end
        end,
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
