

require("themery").setup({
	themes = {
		{
			name = "Gruvbox Dark",
			colorscheme = "gruvbox",
			before = [[
				vim.opt.background = "dark"
			]]
		},
		{
			name = "VS Code Dark+",
			colorscheme = "vscode",
			before = [[
				vim.opt.background = 'dark'
			]],
			after = [[
				require("vscode").setup({
					style = 'dark',
					transparent = false,
					italic_comments = true,

				})
				require("vscode").load()
			]]
		},
		{
			name = "Gruvbox Light",
			colorscheme = "gruvbox",
			before = [[
				vim.opt.background = "light"
			]]
		},
		{
			name = "VS Code Light+",
			colorscheme = "vscode",
			before = [[
				vim.opt.background = 'light'
			]],
			after = [[
				require("vscode").setup({
					style = 'light',
					transparent = false,
					italic_comments = true,

				})
				require("vscode").load()
			]]
		},
	},
	themeConfigFile = '~/.config/nvim/lua/derdomee/themes/_current-theme.lua',
	livePreview = true,
})
