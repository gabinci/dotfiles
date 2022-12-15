---@diagnostic disable
local same = function(node_index)
	return f(function(import_name)
		local parts = vim.split(import_name[1][1], ".", true)
		return parts[#parts] or ""
	end, { node_index })
end

return {
	s(
		{
			trig = "pcall",
			desc = "pcall funciton",
		},
		fmta(
			[[
      local _, <> = pcall(require, "<>") 
      if not _ then
        require("core.log").log_error("<>")
        return
      end
    ]],
			{
				i(1),
				i(2),
				i(3),
			}
		)
	),
	-- s(
	-- 	{
	-- 		trig = "req",
	-- 		desc = "Lua require function",
	-- 	},
	-- 	fmta([[ <> ]], {
	-- 		c(1, {
	-- 			fmta([[ require("<>") ]], { -- c1
	-- 				i(1),
	-- 			}),
	--
	-- 			fmta([[local <> = require "<>"]], {
	-- 				same(1),
	-- 				i(1),
	-- 			}),
	--
	-- 			fmta( -- c3
	-- 				[[
	--        local <>, <> = pcall(require '<>')
	--        if not <> then
	--          return
	--        end
	--        <>
	--          ]],
	-- 				{
	-- 					i(1, "status"),
	-- 					i(2, "_"),
	-- 					rep(2),
	-- 					rep(1),
	-- 					i(0),
	-- 				}
	-- 			),
	-- 		}),
	-- 	})
	-- ),

	s(
		{
			trig = "__snippet",
			desc = "LuaSnippet",
		},
		fmta(
			[[
        s(
          {
            trig = "<>",
            desc = "<>",
          },
          fmta(<>, {
            <>,
          })
        ),
    ]],
			{
				i(1),
				i(2),
				i(3, "[[]]"),
				i(4, "i(1)"),
			}
		)
	),

	s(
		{ trig = "M", desc = "Lua Module" },
		fmta(
			[[
    local M = {}
    <>
    return M
    ]],
			{ i(1) }
		)
	),
	s(
		{
			trig = "call",
			desc = "core.utils pcall",
		},
		fmta(
			[[
    local utils = require("core.utils")
    local <> = utils.call("<>")
    if <> == nil then
      return
    end
    ]],
			{
				i(1, "module"),
				rep(1),
				rep(1),
			}
		)
	),
}
