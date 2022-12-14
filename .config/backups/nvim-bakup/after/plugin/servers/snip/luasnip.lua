-- Filename: luasnip.lua
-- Last Change: Wed, 23 Nov 2022 - 09:06:15
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local status, ls = pcall(require, "luasnip")
if not status then
	return
end

-- local types = require("luasnip.util.types")

ls.config.set_config({
	enable_autosnippets = true,
	history = true, -- This tells LuaSnip to remember to keep around the last snippet. You can jump back into it even if you move outside of the selection
	updateevents = "TextChanged,TextChangedI", -- This one is cool cause if you have dynamic snippets, it updates as you type!
	ext_opts = {
		-- [types.choiceNode] = {
		-- 	active = {
		-- 		virt_text = { { " « ", "NonTest" } },
		-- 	},
		-- },
	},
	store_selection_keys = "<S-q>",
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
