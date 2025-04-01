-- inspired by https://github.com/mawkler/modicator.nvim

-- Cache for storing highlight foreground colors to avoid repeated API calls
local highlight_cache = {}

--- Gets the foreground color value of `group`.
--- @param group string The name of the highlight group
--- @return integer The foreground color value of the highlight group
local function get_highlight_fg(group)
  if not highlight_cache[group] then
    highlight_cache[group] = vim.api.nvim_get_hl(0, { name = group, link = false }).fg
  end
  return highlight_cache[group]
end

-- Mapping of Vim modes to their corresponding highlight group foreground colors
local modes = {
  ["n"] = get_highlight_fg("operator"), -- Normal mode
  ["i"] = get_highlight_fg("string"), -- Insert mode
  ["v"] = get_highlight_fg("special"), -- Visual mode
  ["V"] = get_highlight_fg("special"), -- Visual line mode
  [""] = get_highlight_fg("special"), -- Visual block mode
  ["s"] = get_highlight_fg("Keyword"), -- Select mode
  ["S"] = get_highlight_fg("Keyword"), -- Select line mode
  ["R"] = get_highlight_fg("Error"), -- Replace mode
  ["c"] = get_highlight_fg("Constant"), -- Command mode
}

local last_mode = nil -- Variable to store the last mode to prevent redundant updates

--- Updates the cursor line highlight color based on the current mode
local function set_cursor_line_highlight()
  local mode = vim.api.nvim_get_mode().mode
  if mode == last_mode then
    return
  end
  last_mode = mode

  local color = modes[mode] or modes["n"]
  local base_highlight = vim.api.nvim_get_hl(0, { name = "CursorLineNr", link = false })
  local opts = vim.tbl_extend("keep", { fg = color }, base_highlight)
  vim.api.nvim_set_hl(0, "CursorLineNr", opts)
end

--- Debounces a function by the given timeout to prevent excessive calls
--- @param fn function The function to debounce
--- @param timeout integer The debounce timeout in milliseconds
--- @return function The debounced function
local function debounce(fn, timeout)
  local timer = nil
  return function(...)
    local args = { ... }
    if timer then
      vim.fn.timer_stop(timer)
    end
    timer = vim.fn.timer_start(timeout, function()
      fn(unpack(args))
    end)
  end
end

--- Creates autocommands to update the cursor line highlight on mode change and Vim enter
local function create_autocmd()
  local group_id = vim.api.nvim_create_augroup("Modicator", { clear = true })

  vim.api.nvim_create_autocmd("ModeChanged", {
    callback = debounce(set_cursor_line_highlight, 100),
    group = group_id,
  })

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = set_cursor_line_highlight,
    group = group_id,
  })
end

create_autocmd()
