local cheatsheet = require("cheatsheet")
local actions = require("cheatsheet.telescope.actions")


cheatsheet.setup({
	telescope_mappings = {
		['<CR>'] = actions.select_or_execute,
		['<A-CR>'] = actions.select_or_fill_commandline,
	},
	bundled_cheatsheets = false,
	bundled_plugin_cheatsheets = false,
	include_only_installed_plugins = true,
})
