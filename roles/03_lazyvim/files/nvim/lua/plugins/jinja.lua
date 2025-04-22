-- ~/.config/nvim/lua/plugins/jinja.lua
return {
	--[[
  -- === Notes ===
  -- Ensure that in your ~/.config/nvim/lua/config/autocmds.lua you have 
  --
  -- vim.filetype.add({
  --   extension = {
  --     ["html.j2"] = "jinja"
  --   },
  -- })
  --
  -- vim.api.nvim_create_autocmd("FileType", {
  --   pattern = "jinja",
  --   callback = function()
  --     vim.opt_local.shiftwidth = 4
  --     vim.opt_local.tabstop = 4
  --     vim.opt_local.softtabstop = 4
  --     vim.opt_local.expandtab = true
  --   end,
  --   desc = "Set indent to 4 spaces for Jinja files",
  -- })
  --
  --]]

	-- === Mason ===
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"djlint",
				-- Ensure cargo is installed on your OS
				"jinja-lsp",
				"html-lsp",
			})
		end,
	},

	-- === Treesitter ===
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function(_, opts)
			-- Define the custom Jinja parser configuration
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			---@diagnostic disable-next-line: inject-field
			parser_config.jinja2 = {
				install_info = {
					url = "https://github.com/varpeti/tree-sitter-jinja2",
					files = { "src/parser.c" },
					revision = "a533cd3c33aea6acb0f9bf9a56f35dcfe6a8eb53",
					requires_generate_from_grammar = false,
				},
			}
			vim.treesitter.language.register("jinja2", "jinja")
		end,
		opts = {
			ensure_installed = { "jinja2" },
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = { enable = true },
		},
	},

	-- === LSP ===
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				jinja_lsp = {
					init_options = {
						backend = { "./src", "./app" },
						templates = { "./templates" },
						lang = "python",
					},
					filetypes = { "jinja" },
				},
				html = {
					filetypes = { "html", "htm", "shtml", "xhtml", "jinja" },
				},
			},
		},
	},

	-- === Linting ===
	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				jinja = { "djlint" },
			},
		},
	},

	-- === Formatting ===
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				jinja = { "djlint" },
			},
		},
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {
			aliases = {
				jinja = "html",
			},
		},
	},
	{
		-- ensure extras luasnip plugin is installed
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip").filetype_extend("jinja", { "html" })
		end,
	},
}
