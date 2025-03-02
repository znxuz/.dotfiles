return {
	"EggbertFluffle/beepboop.nvim",
	opts = {
		max_sounds = 10,
		audio_player = "paplay",
		volume = 50,
		sound_map = {
			{ auto_command = "VimEnter",                       sound = "open3.ogg" },
			{ auto_command = "VimLeave",                       sound = "close2.ogg" },
			{ auto_command = "InsertEnter",                    sound = "open2.ogg" },
			{ auto_command = "InsertLeave",                    sound = "open1.ogg" },
			-- { auto_command = "CmdlineEnter",                   sound = "open2.ogg" },
			-- { auto_command = "CmdlineLeave",                   sound = "open1.ogg" },
			{ auto_command = "InsertCharPre",                  sounds = { "stone1.ogg", "stone2.ogg", "coral1.ogg", "coral2.ogg", "coral3.ogg", "coral4.ogg" } },
			{ key_map = { mode = "i", key_chord = "<BS>" },    sounds = { "stone3.ogg" } },
			{ key_map = { mode = "i", key_chord = "<Enter>" }, sounds = { "stone4.ogg" } },
		},
	},
	cond = function()
		return os.execute("test -d /sys/class/power_supply/AC") == 0
	end
}
