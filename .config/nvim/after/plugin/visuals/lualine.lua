local status, lualine = pcall(require, "lualine")
if not status then
	require("core.log").log_error("lualine")
	return
end
local utils = require("core.utils")

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local icon = function()
	return ""
end

local modified = function()
	if utils.wasModified() then
		return ""
	else
		return ""
	end
end

-- configs {{{
local config = {
	theme = "auto", -- lualine theme
	options = {
		disabled_filetypes = {
			"alpha",
			"dashboard",
			"NvimTree",
			"Outline",
			statusline = {},
			winbar = {},
		},
		always_divide_middle = true,
		icons_enabled = true,
		component_separators = "",
		section_separators = "",
		-- theme = {
		-- 	normal = { c = { fg = colors.fg, bg = colors.bg } },
		-- 	inactive = { c = { fg = colors.fg, bg = colors.bg } },
		-- },
	},

	sections = {
		lualine_a = {
			{
				icon,
				padding = { left = 1, rigth = 0 },
			},
			{ "mode" },
		},
		lualine_b = {},
		lualine_c = {
			{ modified, padding = { left = 1, right = 0 } },
			{
				"filename",
				conditions = conditions.buffer_not_empty,
				padding = { left = 1, right = 1 },
				symbols = {
					modified = "", -- Text to show when the file is modified.
					readonly = "", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
					newfile = "[New]", -- Text to show for new created file before first writting
				},
			},
			{
				"filetype",
				icon_only = true,
				cond = conditions.buffer_not_empty,
				padding = { left = 0, right = 0 },
			},
		},

		lualine_x = {
			{
				"diagnostics",
				sections = { "error", "warn" },
				always_visible = true,
				update_on_insert = true,
				cond = conditions.buffer_not_empty,
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = " ",
				},
			},
			{ "progress", padding = { left = 0, right = 1 } },
		},

		lualine_y = {},
		lualine_z = {
			{
				"location",
				cond = conditions.buffer_not_empty,
				icon = { "", align = "right" },
				padding = { left = 1, right = 1 },
			},
		},
	},
	extensions = { "nvim-tree" },
}
-- }}}
lualine.setup(config)
