-- Filename: alpha.lua
-- Last Change: Thu, 17 Nov 2022 20:51:40
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local status, alpha = pcall(require, "alpha")
if not status then
	return
end

-- local dashboard = require("alpha.themes.dashboard")
-- dashboard.section.header.val = {
-- 	[[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
-- 	[[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
-- 	[[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
-- 	[[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
-- 	[[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
-- 	[[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
-- }
-- dashboard.section.buttons.val = {
-- 	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
-- 	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
-- 	dashboard.button("p", "  Find project", ":Telescope project <CR>"),
-- 	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
-- 	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
-- 	dashboard.button("c", "  Configuration", ":cd ~/.config/nvim/<CR> :e init.lua <CR>"),
-- 	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
-- }
--
-- local function footer()
-- 	-- NOTE: requires the fortune-mod package to work
-- 	-- local handle = io.popen("fortune")
-- 	-- local fortune = handle:read("*a") -- handle:close()
-- 	-- return fortune
-- 	return " github.com/gabinci"
-- end
--
-- dashboard.section.footer.val = footer()
--
-- dashboard.section.footer.opts.hl = "Type"
-- dashboard.section.header.opts.hl = "Include"
-- dashboard.section.buttons.opts.hl = "Keyword"
--
-- dashboard.opts.opts.noautocmd = true
-- -- vim.cmd([[autocmd User AlphaReady echo 'ready']])
--

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
	dashboard.button("p", "  > Find project", ":Telescope project <CR>"),
	dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
	dashboard.button("t", "  > Find text", ":Telescope live_grep <CR>"),
	dashboard.button("d", "  > Dotfiles", ":e ~/dotfiles/.config/README.md | :cd %:p:h| wincmd k | pwd<CR>"),
	dashboard.button("c", "  > Configs", ":e $MYVIMRC | :cd %:p:h | wincmd k | pwd<CR>"),
	dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
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
