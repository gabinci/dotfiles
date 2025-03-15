local M = {}

M.isModifiable = function()
	return vim.api.nvim_get_option_value("modifiable", { buf = 0 })
end

M.wasModified = function()
	return vim.api.nvim_get_option_value("modified", { buf = 0 })
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

-- ---@param module string
-- M.call = function(module)
-- 	local status, _ = pcall(require, module)
-- 	if not status then
-- 		log.log_error("" .. module)
-- 		return "error"
-- 	end
-- 	return module
-- end

return M
