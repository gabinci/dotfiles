-- Filename: teste.lua
-- Last Change: Sun, 13 Nov 2022 17:40:49
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local M = {}
local bufnr = vim.api.nvim_get_current_buf()

M.isModifiable = function()
	if vim.api.nvim_buf_get_option(bufnr, "modifiable") then
		return vim.cmd([[!echo "this file is modifiable"]])
	else
		return vim.cmd([[!echo "this file is not modifiable"]])
	end
end
M.wasModified = function()
	if vim.api.nvim_buf_get_option(bufnr, "modified") then
		return vim.cmd([[!echo "this file was modified"]])
	else
		return vim.cmd([[!echo "this file was not modified"]])
	end
end

M.changeHeader = function()
	if not M.wasModified() and not M.isModifiable() then
		return vim.cmd([[!echo "this file wasn't modified or isn't modifiable"]])
		-- return
	end

	if vim.fn.line("$") >= 7 then
		os.setlocale("en_US.UTF-8")
		local time = os.date("%a, %d %b %Y %H:%M:%S")
		local l = 1
		while l <= 7 do
			vim.fn.setline(l, vim.fn.substitute(vim.fn.getline(l), "\\c\\vlast (change|update): \\zs.*", time, "g"))
			l = l + 1
		end
	end
end

M.changeHeader()

return M
