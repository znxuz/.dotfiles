return {
	"EggbertFluffle/beepboop.nvim",
	opts = {
		audio_player = "paplay",
		volume = 50,
		sound_map = {
			{ auto_command = "VimEnter",                       sound = "open3.ogg" },
			{ auto_command = "VimLeave",                       sound = "close2.ogg" },
			{ auto_command = "InsertEnter",                    sound = "open1.ogg" },
			{ auto_command = "InsertLeave",                    sound = "open2.ogg" },
			{ auto_command = "InsertCharPre",                  sounds = { "stone1.ogg", "stone2.ogg" } },
			{ key_map = { mode = "i", key_chord = "<BS>" },    sounds = { "stone3.ogg" } },
			{ key_map = { mode = "i", key_chord = "<Enter>" }, sounds = { "stone4.ogg" } },
		},
	},
	cond = function()
    return os.execute("test -d /sys/class/power_supply/AC") == 0
	end
}
