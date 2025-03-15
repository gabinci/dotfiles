local M = {}

--- Logs an error message for a failed module load.
-- @param name string: The name of the module that failed to load.
-- @param err string: The error message.
M.log_error = function(name, err)
	vim.notify("Failed to load " .. name .. "'s config: " .. err, vim.log.levels.ERROR, {
		title = "Plugin Error",
		timeout = 5000, -- Keep the timeout at 5 seconds for better visibility
	})
end

--- Safely requires a list of modules and logs any errors.
-- @param mods table: A list of module names to require.
M.safe_require = function(mods)
	local error_modules = {}
	for _, mod in ipairs(mods) do
		local ok, err = pcall(require, mod)
		if not ok then
			table.insert(error_modules, { mod = mod, err = err })
		end
	end

	if #error_modules > 0 then
		vim.defer_fn(function()
			for _, mod_info in ipairs(error_modules) do
				M.log_error(mod_info.mod, mod_info.err)
			end
		end, 100) -- Delay of 100 milliseconds
	end
end

return M
