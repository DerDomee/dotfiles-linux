

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
			name = "Tokyo Dark Storm",
			colorscheme = "tokyonight",
			before = [[
				require("tokyonight").setup({
					style = "storm"
				})
			]],
			after = [[
				require("tokyonight").setup({
					style = "storm"
				})
			]],
		},
		{
			name = "Tokyo Dark Moon",
			colorscheme = "tokyonight",
			before = [[
				require("tokyonight").setup({
					style = "moon"
				})
			]],
			after = [[
				require("tokyonight").setup({
					style = "moon"
				})
			]]
		},
		{
			name = "Tokyo Dark Night",
			colorscheme = "tokyonight",
			before = [[
				require("tokyonight").setup({
					style = "night"
				})
			]],
			after = [[
				require("tokyonight").setup({
					style = "night"
				})
			]],
		},
		{
			name = "VS Code Dark+",
			colorscheme = "vscode",
			before = [[
				vim.opt.background = 'dark'
				require("vscode").setup({
					style = 'dark',
					transparent = false,
					italic_comments = true,

				})
				require("vscode").load()
			]],
			after = [[
				vim.opt.background = 'dark'
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
				require("vscode").setup({
					style = 'light',
					transparent = false,
					italic_comments = true,

				})
				require("vscode").load()
			]],
			after = [[
				vim.opt.background = 'light'
				require("vscode").setup({
					style = 'light',
					transparent = false,
					italic_comments = true,

				})
				require("vscode").load()
			]]
		},
		{
			name = "Tokyo Light Day",
			colorscheme = "tokyonight",
			before = [[
				require("tokyonight").setup({
					light_style = "day"
				})
			]],
			after = [[
				require("tokyonight").setup({
					light_style = "day"
				})
			]],
		},
	},
	themeConfigFile = '~/.config/nvim/lua/derdomee/themes/_current-theme.lua',
	livePreview = true,
})
