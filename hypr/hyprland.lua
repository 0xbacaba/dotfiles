require("config.apps")
require("config.binds")
require("config.default")
require("config.rules")

local monitors, err = pcall(require, "monitors")
if not monitors then
	hl.notification.create({ text = "No monitor config found: " .. err, timeout = 5000, color = "#ff4f00" })
end

local rules = require("config.workspaces")
for _, rule in ipairs(rules) do
	hl.workspace_rule(rule)
end
