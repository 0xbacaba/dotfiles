local logfile = io.open("/tmp/hyprlua.log", "a+")
if logfile == nil then
	hl.notification.create({
		text = "failed to open logfile",
		timeout = 15,
		color = "red",
	})
end

---@enum Layout
local Layout = {
	dwindle = {
		name = "dwindle",
		resize = hl.dsp.window.resize(),
		custom_action = hl.dsp.layout("togglesplit"),
	},
	scrolling = {
		name = "scrolling",
		resize = hl.dsp.no_op(),
		custom_action = hl.dsp.layout("colresize +conf"),
	},
}

return {
	mainMod = "SUPER",

	log = function(text)
		if logfile == nil then
			return
		end
		logfile:write(text)
		logfile:write("\n")
	end,

	layout = Layout.scrolling,
}
