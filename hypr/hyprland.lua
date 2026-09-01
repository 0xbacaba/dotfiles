require("config.apps")
require("config.binds")
require("config.default")
require("config.rules")

local monitors, err = pcall(require, "monitors")
if not monitors then
	hl.notification.create({ text = "No monitor config found: " .. err, timeout = 5000, color = "#ff4f00" })
end

require("config.workspaces")
