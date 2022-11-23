-- Filename: alpha.lua
-- Last Change: Tue, 22 Nov 2022 - 17:10:17
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local status, alpha = pcall(require, "alpha")
if not status then
	return
end

local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
	"                                                     ",
	"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
	"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
	"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
	"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
	"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
	"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
	"                                                     ",
}

-- Set menu
dashboard.section.buttons.val = {
	dashboard.button("f", "  > Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("t", "  > Find text", ":Telescope live_grep <CR>"),
	dashboard.button("r", "  > Recent files", ":Telescope oldfiles<CR>"),
	dashboard.button("s", "  > Scripts", ":e ~/dotfiles/.local/bin/README.md | :cd %:p:h| wincmd k | pwd<CR>"),
	dashboard.button("d", "  > Dotfiles", ":e ~/dotfiles/.config/README.md | :cd %:p:h| wincmd k | pwd<CR>"),
	dashboard.button("c", "  > Configs", ":e $MYVIMRC | :cd %:p:h | wincmd k | pwd<CR>"),
	dashboard.button("q", "  > Quit NVIM", ":wqa!<CR>"),
}

-- Set footer
--   NOTE: This is currently a feature in my fork of alpha-nvim (opened PR #21, will update snippet if added to main)
--   To see test this yourself, add the function as a dependecy in packer and uncomment the footer lines
--   ```init.lua
--   return require('packer').startup(function()
--       use 'wbthomason/packer.nvim'
--       use {
--           'goolord/alpha-nvim', branch = 'feature/startify-fortune',
--           requires = {'BlakeJC94/alpha-nvim-fortune'},
--           config = function() require("config.alpha") end
--       }
--   end)
--   ```
local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

-- Send config to alpha

alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
