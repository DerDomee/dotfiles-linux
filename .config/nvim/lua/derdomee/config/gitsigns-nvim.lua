local gitsigns = require("gitsigns")

gitsigns.setup({
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text_pos = 'right_align',
		delay = 50,
	},
	current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>'
})
