local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local colors = {
	bg = "#181926",
	fg = "#6E738D",

	magenta = "#8C73B2",
	violet = "#C6A0F6",
	blue = "#8AADF4",
	cyan = "#8BD5CA",
	green = "#A6DA95",
	yellow = "#EED49F",
	orange = "#F5A97F",
	red = "#ED8796",
}

local modecolor = function()
	-- auto change color according to neovims mode
	local mode_color = {
		n = colors.yellow,
		i = colors.green,
		v = colors.blue,
		[""] = colors.blue,
		V = colors.blue,
		c = colors.magenta,
		no = colors.red,
		s = colors.orange,
		S = colors.orange,
		[""] = colors.orange,
		ic = colors.yellow,
		R = colors.violet,
		Rv = colors.violet,
		cv = colors.red,
		ce = colors.red,
		r = colors.cyan,
		rm = colors.cyan,
		["r?"] = colors.cyan,
		["!"] = colors.red,
		t = colors.red,
	}
	return { fg = mode_color[vim.fn.mode()] }
end

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

--    cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	-- local chars = { "", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇" }
	local chars = { " ", "▁", "▂", "▃", "▄", "▅", "▆", "▇" }
	-- local chars = { " ", "▏", "▎", "▍", "▌", "▋", "▊", "▉", "█" }

	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

-- Config
local config = {
	options = {
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
		icons_enabled = true,
		component_separators = "",
		section_separators = "",
		theme = {
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},

	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},

	extenxions = { "NvimTree" },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	progress,
	color = modecolor,
	padding = { left = 0, right = 0 },
})

ins_left({
	-- mode component
	"mode",
	icon = { "", align = "right" },
	color = modecolor,
	padding = { left = 1, right = 1 },
})

ins_left({
	function()
		return "%="
	end,
})

ins_left({
	"filetype",
	icon_only = true,
	cond = conditions.buffer_not_empty,
	padding = { left = 0, right = 1 },
})

ins_left({
	"filename",
	conditions = conditions.buffer_not_empty,
	padding = { left = 0, right = 0 },

	symbols = {
		modified = "", -- Text to show when the file is modified.
		readonly = "", -- Text to show when the file is non-modifiable or readonly.
		unnamed = "[No Name]", -- Text to show for unnamed buffers.
		newfile = "[New]", -- Text to show for new created file before first writting
	},
})

ins_left({
	function()
		if require("core.utils").wasModified() then
			return ""
		else
			return " "
		end
	end,
	color = { fg = colors.green },
	padding = { left = 1, right = 1 },
})

ins_right({
	"location",
	color = modecolor,
	cond = conditions.buffer_not_empty,
	icon = "",
	padding = { left = 0, right = 1 },
})

ins_right({
	progress,
	color = modecolor,
	padding = { left = 0, right = 0 },
})

----------- inactive sections

-- Inserts a component in lualine_c at left section
local function inactive_ins_left(component)
	table.insert(config.inactive_sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function inactive_ins_right(component)
	table.insert(config.inactive_sections.lualine_x, component)
end

inactive_ins_left({
	function()
		return "▇"
	end,
	padding = { left = 0, right = 1 },
})

-- inactive_ins_left({
-- 	function()
-- 		return ""
-- 	end,
-- 	cond = conditions.buffer_not_empty,
-- 	padding = { left = 1, right = 1 },
-- })

inactive_ins_left({
	function()
		return "%="
	end,
})

inactive_ins_left({
	"filetype",
	cond = conditions.buffer_not_empty,
	icon_only = true,
	padding = { left = 0, right = 1 },
	colored = false,
})

inactive_ins_left({
	"filename",
	conditions = conditions.buffer_not_empty,
	padding = { left = 0, right = 1 },
	symbols = {
		modified = "", -- Text to show when the file is modified.
		readonly = "", -- Text to show when the file is non-modifiable or readonly.
		unnamed = "[No Name]", -- Text to show for unnamed buffers.
		newfile = "[New]", -- Text to show for new created file before first writting
	},
})

inactive_ins_right({
	function()
		return "▇"
	end,
	padding = { left = 1 },
})

-- -- tabline
-- -- Inserts a component in lualine_c at left section
-- local function tab_ins_left(component)
-- 	table.insert(config.tabline.lualine_c, component)
-- end
--
-- -- Inserts a component in lualine_x ot right section
-- local function tab_ins_right(component)
-- 	table.insert(config.tabline.lualine_x, component)
-- end
--
-- local status_tabline, tabline = pcall(require, "tabline")
-- if not status_tabline then
-- 	return
-- end
--
-- tabline.setup({
-- 	-- Defaults configuration options
-- 	enable = true,
-- 	options = {
-- 		-- If lualine is installed tabline will use separators configured in lualine by default.
-- 		-- These options can be used to override those settings.
-- 		section_separators = { "", "" },
-- 		component_separators = { "", "" },
-- 		max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
-- 		show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
-- 		show_devicons = true, -- this shows devicons in buffer section
-- 		show_bufnr = false, -- this appends [bufnr] to buffer section,
-- 		show_filename_only = false, -- shows base filename only instead of relative path in filename
-- 		modified_icon = "+ ", -- change the default modified icon
-- 		modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
-- 		show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
-- 	},
-- })
--
-- tab_ins_left({})
--
-- tab_ins_left({ tabline.tabline_tabs })
-- -- Now don't forget to initialize lualine

lualine.setup(config)
