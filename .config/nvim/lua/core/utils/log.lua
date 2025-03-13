local M = {}

---@param name string
M.log_error = function(name)
	vim.notify("Failed to load " .. name .. "'s config", vim.log.levels.ERROR, {
		title = "Plugin Error",
		timeout = 2000,
	})
end

return M
