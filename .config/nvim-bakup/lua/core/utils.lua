-- current file path: /home/gabinci/dotfiles/.config/nvim/lua/core/utils.lua
-- last change: Fri, 25 Nov 2022 - 18:33:03
-- Author: gabinci

local M = {}

M.isModifiable = function()
	return vim.api.nvim_buf_get_option(0, "modifiable")
end
M.wasModified = function()
	return vim.api.nvim_buf_get_option(0, "modified")
end

M.changeHeader = function()
	if not M.wasModified() and not M.isModifiable() then
		return vim.cmd([[!echo "this file wasn't modified or isn't modifiable"]])
		-- return
	end

	if vim.fn.line("$") >= 7 then
		os.setlocale("en_US.UTF-8")
		local time = os.date("%a, %d %b %Y - %H:%M:%S")
		local l = 1
		while l <= 7 do
			vim.fn.setline(l, vim.fn.substitute(vim.fn.getline(l), "\\c\\vlast (change|update): \\zs.*", time, "g"))
			l = l + 1
		end
	end
end

M.is_executable = function()
	local file = vim.fn.expand("%:p")
	local type = vim.fn.getftype(file)
	if type == "file" then
		local perm = vim.fn.getfperm(file)
		if string.match(perm, "x", 3) then
			return true
		else
			return false
		end
	end
end

return M
