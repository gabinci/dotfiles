vim.g.mapleader = " "

local keymap = vim.keymap.set
local generic_opts_any = { noremap = true, silent = true }
local generic_opts = {
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  command_mode = generic_opts_any,
  term_mode = { silent = true },
}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
}

local main_maps = {
  normal_mode = {
    -- Window management
    ["<leader>sv"] = { "<C-w>v", desc = "Split Vertical" },
    ["<leader>sh"] = { "<C-w>s", desc = "Split Horizontal" },
    ["<leader>sx"] = { ":close<CR>", desc = "Close Split" },
    ["<C-h>"] = { "<C-w>h", desc = "Move to Left Buffer" },
    ["<C-l>"] = { "<C-w>l", desc = "Move to Right Buffer" },
    ["<C-k>"] = { "<C-w>k", desc = "Move to Top Buffer" },
    ["<C-j>"] = { "<C-w>j", desc = "Move to Bottom Buffer" },
    ["<C-Down>"] = { "<CMD>resize -2<CR>", desc = "Resize Buffer Down" },
    ["<C-Up>"] = { "<CMD>resize +2<CR>", desc = "Resize Buffer Up" },
    ["<C-Left>"] = { "<CMD>vertical resize -2<CR>", desc = "Resize Buffer Left" },
    ["<C-Right>"] = { "<CMD>vertical resize +2<CR>", desc = "Resize Buffer Right" },

    -- Buffer management
    ["<leader>xx"] = { "<CMD>bdelete<CR>", desc = "Delete Buffer" },
    ["<leader><TAB>"] = {
      [[:<c-u>exe v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'n')<cr>]],
      desc = "Switch Buffer",
    },

    -- Text editing
    ["<leader><leader>s"] = {
      "<CMD>source " .. vim.fn.stdpath("config") .. "/init.lua<CR>",
      desc = "Source init.lua",
    },
    [",p"] = { '"0p', desc = "Paste Last Yanked" },
    [",P"] = { '"0P', desc = "Paste Last YANKED" },
    ["+"] = { "<C-a>", desc = "Increment" },
    ["_"] = { "<C-x>", desc = "Decrement" },
    ["<C-a>"] = { "gg<S-v>G", desc = "Select All" },
    ["db"] = { "vb_d", desc = "Delete Backwards" },
    ["<leader>w"] = { "<CMD>up<CR>", desc = "Quick Save" },
    ["<leader>q"] = { "ZZ", desc = "Save & Quit" },
    ["<leader>dq"] = { "ZQ", desc = "Quit Without Saving" },

    ["<A-k>"] = { "<Esc>:m .-2<CR>", desc = "Move Line Up" },
    ["<A-j>"] = { "<Esc>:m .+1<CR>", desc = "Move Line Down" },
    ["<A-K>"] = { "mzyyP`zk", desc = "Copy Line Up" },
    ["<A-J>"] = { "mzyyp`zj", desc = "Copy Line Down" },
    ["<CR>"] = { "gf", desc = "Goto File" },

    ["<ESC>"] = { "<cmd>nohlsearch<CR>", desc = "Clear Search Highlight" },

    -- Diagnostics
    ["<leader>d"] = { vim.diagnostic.setloclist, desc = "Show Diagnostics" },

    -- Toggle highlights
    ["<leader>h"] = {
      [[:exe &hls && v:hlsearch ? ':nohls' : ':set hls'<CR>]],
      { silent = true, noremap = true, expr = true, desc = "Toggle Highlights" },
    },

    -- Remap ç
    ["ç"] = { ":", { noremap = true, desc = "Remap ç" } },
    ["Ç"] = { ":", { noremap = true, desc = "Remap Ç" } },
  },

  insert_mode = {
    ["jj"] = { "<ESC>", desc = "Exit Insert Mode" },
  },

  visual_mode = {
    ["ç"] = { ":", { noremap = true, desc = "Remap ç" } },
    ["Ç"] = { ":", { noremap = true, desc = "Remap Ç" } },
    ["+"] = { "<C-a>", desc = "Increment" },
    ["_"] = { "<C-x>", desc = "Decrement" },
  },

  visual_block_mode = {
    ["ç"] = { ":", { noremap = true, desc = "Remap ç" } },
    ["Ç"] = { ":", { noremap = true, desc = "Remap Ç" } },
    ["<A-k>"] = { "<CMD>move '>+1<CR>gv-gv", desc = "Move Line Up" },
    ["<A-j>"] = { "<CMD>move '<-2<CR>gv-gv", desc = "Move Line Down" },
  },

  command_mode = {
    ["ç"] = { "<CR>", noremap = true, desc = "Remap ç" },
    ["Ç"] = { "<CR>", noremap = true, desc = "Remap Ç" },
  },
}

local function load_keymaps(maps)
  for mode, keymaps in pairs(maps) do
    local nvim_mode = mode_adapters[mode] or mode
    for key, val in pairs(keymaps) do
      local opt = type(val) == "table" and val[2] or generic_opts[mode] or generic_opts_any
      local mapping = type(val) == "table" and val[1] or val
      keymap(nvim_mode, key, mapping, opt)
    end
  end
end

load_keymaps(main_maps)

local function smart_delete(key)
  local l = vim.api.nvim_win_get_cursor(0)[1] -- Get the current cursor line number
  local line = vim.api.nvim_buf_get_lines(0, l - 1, l, true)[1] -- Get the content of the current line
  return (line:match("^%s*$") and '"_' or "") .. key -- If the line is empty or contains only whitespace, use the black hole register
end

local keys = { "d", "dd", "x", "c", "s", "C", "S", "X" } -- Define a list of keys to apply the smart delete functionality

-- Set keymaps for both normal and visual modes
for _, key in pairs(keys) do
  vim.keymap.set(
    { "n", "v" },
    key,
    function() return smart_delete(key) end,
    { noremap = true, expr = true, desc = "Smart delete" }
  )
end
