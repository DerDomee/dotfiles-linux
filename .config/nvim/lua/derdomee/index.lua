vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local plugins = {

	require("derdomee.plugins.indent-blankline-nvim"),

	require("derdomee.plugins.telescope"),
	require("derdomee.plugins.themery-nvim"),

	require("derdomee.plugins.lualine"),
	require("derdomee.plugins.bufferline"),
	require("derdomee.plugins.nvim-tree"),
	require("derdomee.plugins.nvim-toggleterm"),
	require("derdomee.plugins.neogit"),
	require("derdomee.plugins.gitsigns-nvim"),

	require("derdomee.plugins.github-copilot"),

	require("derdomee.plugins.cheatsheet-nvim"),

	require("derdomee.themes.gruvbox-nvim"),
	require("derdomee.themes.tokyonight-nvim"),
	require("derdomee.themes.vscode"),
}

local opts = {}

require("lazy").setup(plugins, opts)

require("derdomee.themes._current-theme")

require("derdomee.config.editor")

require("derdomee.keybinds")
