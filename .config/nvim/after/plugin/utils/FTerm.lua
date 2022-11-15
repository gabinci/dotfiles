-- Filename: FTerm.lua
-- Last Change: Wed, 09 Nov 2022 17:08:43
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local status, FTerm = pcall(require, "FTerm")
if not status then
	return
end

FTerm.setup({
	---Filetype of the terminal buffer
	---@type string
	ft = "FTerm",

	---Command to run inside the terminal
	---NOTE: if given string[], it will skip the shell and directly executes the command
	---@type fun():(string|string[])|string|string[]
	cmd = os.getenv("SHELL"),

	---Neovim's native window border. See `:h nvim_open_win` for more configuration options.
	border = "single",

	---Close the terminal as soon as shell/command exits.
	---Disabling this will mimic the native terminal behaviour.
	---@type boolean
	auto_close = true,

	---Highlight group for the terminal. See `:h winhl`
	---@type string
	hl = "Normal",

	---Transparency of the floating window. See `:h winblend`
	---@type integer
	blend = 0,

	---Object containing the terminal window dimensions.
	---The value for each field should be between `0` and `1`
	---@type table<string,number>
	dimensions = {
		height = 0.8, -- Height of the terminal window
		width = 0.8, -- Width of the terminal window
		x = 0.5, -- X axis of the terminal window
		y = 0.5, -- Y axis of the terminal window
	},

	---Callback invoked when the terminal exits.
	---See `:h jobstart-options`
	---@type fun()|nil
	on_exit = nil,

	---Callback invoked when the terminal emits stdout data.
	---See `:h jobstart-options`
	---@type fun()|nil
	on_stdout = nil,

	---Callback invoked when the terminal emits stderr data.
	---See `:h jobstart-options`
	---@type fun()|nil
	on_stderr = nil,
})

-- Example keybindings

local lazygit = FTerm:new({
	ft = "fterm_lazygit",
	cmd = "lazygit",
	dimensions = {
		height = 0.9,
		width = 0.9,
	},
})

-- Use this to toggle lazygit in a floating terminal
vim.keymap.set("n", "<A-g>", function()
	lazygit:open()
end)

vim.keymap.set("t", "<A-g>", function()
	lazygit:close()
end)

local ranger = FTerm:new({
	ft = "FTerm_ranger",
	cmd = "ranger",
	dimensions = {
		height = 0.9,
		width = 0.9,
	},
})

vim.keymap.set("n", "<A-r>", function()
	ranger:open()
end)

vim.keymap.set("t", "<A-r>", function()
	ranger:close()
end)
