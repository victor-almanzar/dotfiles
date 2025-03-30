-- lua/plugins/markdown-no-lint.lua
return {
  -- Disable markdownlint in nvim-lint
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      -- Remove markdown from linters
      linters_by_ft = {
        markdown = {}, -- Empty array disables linting for markdown
      },
    },
  },

  -- Disable markdownlint in null-ls
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      -- Filter out markdownlint from the sources
      opts.sources = vim.tbl_filter(function(source)
        return source.name ~= "markdownlint_cli2"
      end, opts.sources or {})
    end,
  },

  -- Disable markdownlint in conform.nvim formatter
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        -- Override markdown formatters to remove markdownlint
        ["markdown"] = { "prettier" }, -- Keep prettier but remove markdownlint
        ["markdown.mdx"] = { "prettier" },
      },
    },
  },
}
