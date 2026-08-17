local shared = require("config.shared")

---@param operation "+"|"-"|"*"|"/"|"0"
---@return HL.Dispatcher
local function zoom(operation)
	local change = 0.2
	local script = "~/.config/hypr/scripts/zoom.sh"

	if operation ~= "0" then
		return hl.dsp.exec_cmd(("%s %s%f"):format(script, operation, change))
	else
		return hl.dsp.exec_cmd(("%s 0"):format(script))
	end
end

return {
	{
		-- mainMod + '+'
		keys = { shared.mainMod, "code:35" },
		flags = { repeating = true },
		action = zoom("+"),
	},
	{
		-- mainMod + '-'
		keys = { shared.mainMod, "code:61" },
		flags = { repeating = true },
		action = zoom("-"),
	},
	{
		keys = { shared.mainMod, "0" },
		action = zoom("0"),
	},
}
