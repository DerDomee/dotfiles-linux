local plugins = {
	require("derdomee.plugins.telescope"),
	require("derdomee.plugins.themery-nvim"),

	require("derdomee.plugins.lualine"),
	require("derdomee.plugins.bufferline"),
	require("derdomee.plugins.nvim-toggleterm"),
	require("derdomee.plugins.neogit"),

	require("derdomee.plugins.github-copilot"),

	require("derdomee.plugins.cheatsheet-nvim"),

	require("derdomee.themes.gruvbox-nvim"),
	require("derdomee.themes.vscode"),
}

local opts = {}

require("lazy").setup(plugins, opts)

require("derdomee.themes._current-theme")
