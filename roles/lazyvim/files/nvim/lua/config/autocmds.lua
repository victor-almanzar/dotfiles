-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Django template detection for HTML files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.html",
  callback = function()
    local path = vim.fn.expand("%:p")

    -- Check if we're in a templates directory
    if path:match("/templates/") then
      -- Extract the path up to templates
      local before_templates, _ = path:match("(.*/templates)/.*")
      if before_templates then
        -- Get the parent directory (the app directory)
        local app_dir = vim.fn.fnamemodify(before_templates, ":h")
        -- Get the project root (parent of the app directory)
        local project_root = vim.fn.fnamemodify(app_dir, ":h")
        -- Check if manage.py exists in the project root
        if vim.fn.filereadable(project_root .. "/manage.py") == 1 then
          vim.bo.filetype = "htmldjango"
          vim.bo.tabstop = 4
          vim.bo.shiftwidth = 4
          vim.bo.expandtab = true
        end
      end
    end
  end,
})
