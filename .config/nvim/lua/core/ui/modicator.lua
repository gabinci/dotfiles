-- from https://github.com/mawkler/modicator.nvim

--- Gets the foreground color value of `group`.
--- @param group string
--- @return string
local get_highlight_fg = function(group)
	return vim.api.nvim_get_hl_by_name(group, true).foreground
end

local modes = {
	["n"] = get_highlight_fg("operator"),
	["i"] = get_highlight_fg("string"),
	["v"] = get_highlight_fg("special"),
	["V"] = get_highlight_fg("special"),
	[""] = get_highlight_fg("special"),
	["s"] = get_highlight_fg("Keyword"),
	["S"] = get_highlight_fg("Keyword"),
	["R"] = get_highlight_fg("Error"),
	["c"] = get_highlight_fg("Constant"),
}

local function create_autocmd()
	vim.api.nvim_create_augroup("Modicator", {})
	vim.api.nvim_create_autocmd("ModeChanged", {
		callback = function()
			local mode = vim.api.nvim_get_mode().mode
			local color = modes[mode] or modes.n
			local base_highlight = vim.api.nvim_get_hl_by_name("CursorLineNr", true)
			local opts = vim.tbl_extend("keep", { foreground = color }, base_highlight)
			vim.api.nvim_set_hl(0, "CursorLineNr", opts)
		end,
		group = "Modicator",
	})
end

create_autocmd()
