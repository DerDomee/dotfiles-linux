return {
	'sudormrfbin/cheatsheet.nvim',

	dependencies = {
		{ 'nvim-telescope/telescope.nvim' },
		{ 'nvim-lua/popup.nvim' },
		{ 'nvim-lua/plenary.nvim' },
	},

	config = function()
		require("derdomee.config.cheatsheet-nvim")
	end,
}
