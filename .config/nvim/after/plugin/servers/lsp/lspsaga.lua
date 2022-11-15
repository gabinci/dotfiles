-- Filename: lspsaga.lua
-- Last Change: 
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local status, saga = pcall(require, "lspsaga")
if not status then
	return
end

saga.init_lsp_saga({
	move_in_saga = { prev = "<C-k", next = "<C-j" },
	finder_action_keys = {
		open = "<CR>",
	},
	definition_action_keys = {
		edit = "<CR>",
	},
})
