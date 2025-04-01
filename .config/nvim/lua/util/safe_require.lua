-- Function to safely require modules
local function safe_require(modules)
	-- Handle single string case
	if type(modules) == "string" then
		modules = { modules }
	end

	-- Validate input
	if type(modules) ~= "table" then
		vim.notify("safe_require expects a string or table of strings", vim.log.levels.ERROR)
		return
	end

	local results = {}
	-- Process each module
	for _, module in ipairs(modules) do
		local ok, result = pcall(require, module)
		if not ok then
			vim.notify("Failed to require module: " .. module .. "\n" .. tostring(result), vim.log.levels.WARN)
			results[module] = nil
		else
			results[module] = result
		end
	end

	return results
end

return safe_require
