-- lua/plugins/html.lua
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      html = {
        filetypes = { "html", "htmldjango" },
        on_new_config = function(new_config, new_root_dir)
          -- Get current buffer and check its filetype
          local bufnr = vim.api.nvim_get_current_buf()
          local ft = vim.bo[bufnr].filetype

          -- Apply special settings only for htmldjango
          if ft == "htmldjango" then
            new_config.settings = vim.tbl_deep_extend("force", new_config.settings or {}, {
              html = {
                format = {
                  templating = true,
                  wrapAttributes = "preserve-aligned",
                },
              },
            })
          end
        end,
      },
    },
  },
}
