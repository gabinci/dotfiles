-- Filename: catppuccin-macchiato.lua
-- Last Change: Fri, 25 Nov 2022 - 18:33:01
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local status, catppuccin = pcall(require, "catppuccin")
if not status then
	return
end

catppuccin.setup({
	compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
	transparent_background = false,
	term_colors = false,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	color_overrides = {},
	custom_highlights = {},
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		telescope = true,
		treesitter = true,
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})

vim.cmd([[highlight normal guibg=#24273A]])
vim.cmd([[highlight endOfBuffer guibg=#24273A]])
vim.cmd([[highlight SignColumn guibg=#24273A]])

vim.cmd([[highlight NvimTreeNormal guibg=NONE]])
vim.cmd([[highlight NvimTreeEndOfBuffer guibg=NONE]])
