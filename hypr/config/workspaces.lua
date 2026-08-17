-- workspaces are ordered by distance to the builtin monitor. If the builtin monitor was not detected, the workspaces are ordered from left to right.

local builtin = hl.get_monitor("eDP-1")
local monitors = hl.get_monitors()

---return the center point of the given monitor
---@param mon HL.Monitor
local function center(mon)
	return {
		x = mon.x + mon.width / 2,
		y = mon.y + mon.height / 2,
	}
end

---return the eucledian distance between the two monitors
---@param a HL.Monitor
---@param b HL.Monitor
local function dist(a, b)
	local a_center = center(a)
	local b_center = center(b)
	local dx = math.abs(a_center.x - b_center.x)
	local dy = math.abs(a_center.y - b_center.y)
	return math.sqrt(dx ^ 2 + dy ^ 2)
end

if builtin then
	table.sort(monitors, function(a, b)
		-- monitors are ordered by distance to builtin
		return dist(builtin, a) < dist(builtin, b)
	end)
else
	table.sort(monitors, function(a, b)
		-- monitors are ordered from left to right
		return a.x < b.x
	end)
end

---@class WorkspaceRule
---@field workspace string
---@field monitor string

---@type WorkspaceRule[]
local rules = {}
for i, monitor in ipairs(monitors) do
	table.insert(rules, {
		workspace = tostring(i),
		monitor = "desc:" .. monitor.description,
	})
end

---Find the workspace rule of the given monitor
---@param monitor HL.Monitor
local function find_rule(monitor)
	for _, rule in ipairs(rules) do
		if rule.monitor == "desc:" .. monitor.description then
			return rule
		end
	end
end

return {
	rules = rules,
	find_rule = find_rule,
}
