return {
  "nvimtools/none-ls.nvim",
  optional = true,
  opts = function(_, opts)
    local nls = require("null-ls")
    opts.sources = vim.list_extend(opts.sources or {}, {
      -- Add djlint for diagnostics (linting)
      nls.builtins.diagnostics.djlint.with({
        filetypes = { "htmldjango" },
      }),
      -- Add djlint for formatting
      nls.builtins.formatting.djlint.with({
        filetypes = { "htmldjango" },
      }),
    })
  end,
}
