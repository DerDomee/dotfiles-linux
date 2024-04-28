return {
	"neogitorg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
  },
  config = function ()
		require("derdomee.config.neogit")
	end,
}
