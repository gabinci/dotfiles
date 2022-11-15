-- Filename: catppuccin-macchiato.lua
-- Last Change: 
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

-- vim.cmd([[highlight NvimTreeNormal guibg=#181926]])
-- vim.cmd([[highlight NvimTreeEndOfBuffer guibg=#181926]])

-- rosewater = "#F4DBD6",
-- flamingo = "#F0C6C6",
-- pink = "#F5BDE6",
-- mauve = "#C6A0F6",
-- red = "#ED8796",
-- maroon = "#EE99A0",
-- peach = "#F5A97F",
-- yellow = "#EED49F",
-- green = "#A6DA95",
-- teal = "#8BD5CA",
-- sky = "#91D7E3",
-- sapphire = "#7DC4E4",
-- blue = "#8AADF4",
-- lavender = "#B7BDF8",
--
-- text = "#CAD3F5",
-- subtext1 = "#B8C0E0",
-- subtext0 = "#A5ADCB",
-- overlay2 = "#939AB7",
-- overlay1 = "#8087A2",
-- overlay0 = "#6E738D",
-- surface2 = "#5B6078",
-- surface1 = "#494D64",
-- surface0 = "#363A4F",
--
-- base = "#24273A",
-- mantle = "#1E2030",
-- crust = "#181926",
