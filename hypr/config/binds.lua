---@class bind
---@field keys table
---@field flags? table
---@field action HL.Dispatcher
local __bind = {}

local binds = {}

---Extends listA by all elements of listB
---@param listA table
---@param listB table
function binds.extend(listA, listB)
	for _, v in ipairs(listB) do
		table.insert(listA, v)
	end
end

binds:extend(require("config.binds.apps"))
binds:extend(require("config.binds.obs"))
binds:extend(require("config.binds.other"))
binds:extend(require("config.binds.wm"))
binds:extend(require("config.binds.xf86"))
binds:extend(require("config.binds.zoom"))

for _, bind in ipairs(binds) do
	hl.bind(table.concat(bind.keys, " + "), bind.action, bind.flags)
end
