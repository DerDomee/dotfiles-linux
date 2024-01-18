require("copilot").setup({
	panel = {
		enabled = true,
		auto_refresh = false,
	},
	suggestion = {
		enabled = true,
		auto_trigger = true,
		debounce = 75,
		keymap = {
			accept_line = "<M-CR>",
			accept_word = false,
			accept = false,
			next = "<M-l>",
			prev = "<M-h>",
			dismiss = "<M-<Esc>>",
		}
	}
})
