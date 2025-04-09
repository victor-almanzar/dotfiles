return {
	"folke/tokyonight.nvim",
	lazy = true,
	opts = {
		style = "night",
		transparent = true,
	},
	-- Add jellybeans.nvim to your plugins
	{
		"wtfox/jellybeans.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "dark", -- or "light" if you prefer
			transparent = false,
			italics = true,
			flat_ui = true,
			plugins = {
				all = false,
				auto = true, -- automatically apply colors for installed plugins
			},
		},
	},

	-- Set Jellybeans as the default colorscheme
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "jellybeans",
		},
	},
}
