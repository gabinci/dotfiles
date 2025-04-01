return {

	{

		"folke/tokyonight.nvim",
		lazy = false,
		enabled = true,
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("tokyonight").setup({
				style = "night",
				styles = {
					comments = { italic = false }, -- Disable italics in comments
					keywords = { italic = false },
					functions = {},
					variables = {},
				},
			})
		end,
	},

	{ "Skardyy/makurai-nvim", lazy = false },

	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		opts = {
			-- Default options:
			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = false },
			functionStyle = { italic = false },
			keywordStyle = { italic = false },
			statementStyle = { bold = false },
			typeStyle = { italic = false },
			transparent = false, -- do not set background color
			dimInactive = true, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = { -- add/modify theme and palette colors
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},

			-- overrides = function(colors) -- add/modify highlights
			-- 	return {}
			-- end,
			theme = "wave", -- Load "wave" theme
			background = { -- map the value of 'background' option to a theme
				dark = "wave", -- try "dragon" !
				light = "lotus",
			},
		},
	},
	{ "nyoom-engineering/oxocarbon.nvim", lazy = false },
	{
		"loctvl842/monokai-pro.nvim",
		lazy = false,

		opts = {
			styles = {
				comment = { italic = false },
				keyword = { italic = false }, -- any other keyword
				type = { italic = false }, -- (preferred) int, long, char, etc
				storageclass = { italic = false }, -- static, register, volatile, etc
				structure = { italic = false }, -- struct, union, enum, etc
				parameter = { italic = false }, -- parameter pass in function
				annotation = { italic = false },
				tag_attribute = { italic = false }, -- attribute of tag in reactjs
			},
			filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
			-- Enable this will disable filter option
		},
	},
	{
		"navarasu/onedark.nvim",
		lazy = false,
		opts = {
			style = "darker",
			code_style = {
				comments = "none",
				keywords = "none",
				functions = "none",
				strings = "none",
				variables = "none",
			},
		},
	},
}
