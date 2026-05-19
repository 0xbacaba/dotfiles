local logfile = io.open("/tmp/hyprlua.log", "a+")
if logfile == nil then
	hl.notification.create({
		text = "failed to open logfile",
		duration = 15,
		color = "red",
	})
end

return {
	mainMod = "SUPER",

	log = function(text)
		if logfile == nil then
			return
		end
		logfile:write(text)
		logfile:write("\n")
	end,
}
