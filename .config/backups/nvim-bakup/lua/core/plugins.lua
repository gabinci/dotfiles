-- Filename: plugins.lua
-- Last Change: Mon, 12 Dec 2022 - 09:24:41
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:
--
--
-- ██████╗ ██╗     ██╗   ██╗ ██████╗ ██╗███╗   ██╗███████╗
-- ██╔══██╗██║     ██║   ██║██╔════╝ ██║████╗  ██║██╔════╝
-- ██████╔╝██║     ██║   ██║██║  ███╗██║██╔██╗ ██║███████╗
-- ██╔═══╝ ██║     ██║   ██║██║   ██║██║██║╚██╗██║╚════██║
-- ██║     ███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║███████║
-- ╚═╝     ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end
-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	--
	-- ██▄ ▄▀▄ ▄▀▀ ██▀
	-- █▄█ █▀█ ▄██ █▄▄

	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("nvim-tree/nvim-web-devicons")

	-- █▀ █ █   ██▀   ██▀ ▀▄▀ █▀▄ █   ▄▀▄ █▀▄ ██▀ █▀▄ ▄▀▀
	-- █▀ █ █▄▄ █▄▄   █▄▄ █ █ █▀  █▄▄ ▀▄▀ █▀▄ █▄▄ █▀▄ ▄██

	-- nvim tree
	use("nvim-tree/nvim-tree.lua")

	-- telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-project.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- ▄▀  █ ▀█▀
	-- ▀▄█ █  █

	-- git signs
	use("lewis6991/gitsigns.nvim")

	-- git
	-- use("dinhhuy258/git.nvim")

	-- ▄▀▀ █▄ █ █ █▀▄ █▀▄ ██▀ ▀█▀ ▄▀▀   ▄▀▄ █▀▄ █▄ █   ▄▀▀ ▄▀▄ █▄ ▄█ █▀▄ █   ██▀ ▀█▀ █ ▄▀▄ █▄ █
	-- ▄██ █ ▀█ █ █▀  █▀  █▄▄  █  ▄██   █▀█ █▄▀ █ ▀█   ▀▄▄ ▀▄▀ █ ▀ █ █▀  █▄▄ █▄▄  █  █ ▀▄▀ █ ▀█

	-- autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("f3fora/cmp-spell")
	use("dcampos/cmp-emmet-vim")

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")
	use("mattn/emmet-vim")

	-- manage & install lsp servers, linters & formatters
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- configuring lsp servers
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use("glepnir/lspsaga.nvim")
	use("jose-elias-alvarez/typescript.nvim")
	use("onsails/lspkind.nvim")
	use("folke/trouble.nvim")

	-- formatting & linting
	use("Jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")

	-- debugger
	-- use("mfussenegger/nvim-dap")
	-- use("rcarriga/nvim-dap-ui")
	-- use("theHamsta/nvim-dap-virtual-text")
	-- use("nvim-telescope/telescope-dap.nvim")
	-- use("mxsdev/nvim-dap-vscode-js")
	-- use({
	-- 	"microsoft/vscode-js-debug",
	-- 	opt = true,
	-- 	run = "npm install --legacy-peer-deps && npm run compile",
	-- })

	-- treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- live server
	use("aurum77/live-server.nvim")

	-- █ █ ▀█▀ █ █   ▄▀▀
	-- ▀▄█  █  █ █▄▄ ▄██

	-- nvim comment
	use("numToStr/Comment.nvim")

	-- auto closing
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	-- nvim surround
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	})

	-- impatient nvim
	use("lewis6991/impatient.nvim")

	-- indent line
	-- use("lukas-reineke/indent-blankline.nvim")
	use("yaocccc/nvim-hlchunk")
	-- md preview
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- wilder
	use("gelguy/wilder.nvim")

	-- █ █ █ ▄▀▀ █ █ ▄▀▄ █
	-- ▀▄▀ █ ▄██ ▀▄█ █▀█ █▄▄

	-- statusline
	use("nvim-lualine/lualine.nvim")

	-- bufferline
	use("akinsho/bufferline.nvim")

	-- ccc
	use({
		"uga-rosa/ccc.nvim",
		config = function()
			require("nvim-surround").setup({})
		end,
	})

	-- dashboard
	use("goolord/alpha-nvim")

	-- THEMES
	-- use("folke/tokyonight.nvim")
	-- use("ray-x/aurora")
	-- use("navarasu/onedark.nvim")
	use("catppuccin/nvim")

	-- dressing
	use("stevearc/dressing.nvim")

	-- colorbuddy
	-- use("tjdevries/colorbuddy.nvim")
	-- use("Th3Whit3Wolf/onebuddy")
	-- use("tjdevries/gruvbuddy.nvim")

	-- transparent bg
	-- use("xiyaowong/nvim-transparent")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
