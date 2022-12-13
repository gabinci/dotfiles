-- Filename: onedark.lua
-- Last Change: 
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:
local status, onedark = pcall(require, "onedark")
if not status then
	return
end

-- vim.cmd([[highlight normal guibg=#292D33]])
-- vim.cmd([[highlight endOfBuffer guibg=#292D33]])
-- vim.cmd([[highlight SignColumn guibg=#292D33]])
--
-- vim.cmd([[highlight NvimTreeNormal guibg=#202328]])
-- vim.cmd([[highlight NvimTreeEndOfBuffer guibg=#202328]])
