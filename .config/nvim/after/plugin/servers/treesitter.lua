#!/usr/bin/env lua
-- Filename: treesitter.lua
-- Last Change: Sat, 05 Nov 2022 - 18:58
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	ensure_installed = {
		"tsx",
		"toml",
		"php",
		"json",
		"yaml",
		"html",
		"lua",
		"javascript",
		"typescript",
		"markdown",
		"svelte",
		"graphql",
		"bash",
		"vim",
		"dockerfile",
	}, -- one of "all" or a list of languages

	auto_install = true,
	ignore_install = { "" }, -- List of parsers to ignore installing

	highlight = {
		enable = true, -- false will disable the whole extension
		-- disable = { "css", "html", "markdown" }, -- list of language that will be disabled
	},

	atotag = {
		enable = true,
	},

	autopairs = {
		enable = true,
	},

	indent = { enable = true, disable = { "python", "css" } },
	-- markid = { enable = true },
})

vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
