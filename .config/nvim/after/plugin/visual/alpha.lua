-- Filename: alpha.lua
-- Last Change: Mon, 21 Nov 2022 10:11:17
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
	dashboard.button("t", "  > Find text", ":Telescope live_grep <CR>"),
	dashboard.button("r", "  > Recent files", ":Telescope oldfiles<CR>"),
	dashboard.button("s", "  > Scripts", ":e ~/dotfiles/.local/bin/README.md | :cd %:p:h| wincmd k | pwd<CR>"),
	dashboard.button("d", "  > Dotfiles", ":e ~/dotfiles/.config/README.md | :cd %:p:h| wincmd k | pwd<CR>"),
	dashboard.button("c", "  > Configs", ":e $MYVIMRC | :cd %:p:h | wincmd k | pwd<CR>"),
	dashboard.button("q", "  > Quit NVIM", ":wqa!<CR>"),
}

local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

-- Send config to alpha

alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
