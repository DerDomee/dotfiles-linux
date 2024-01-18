local ibl = require("ibl")
local hooks = require("ibl.hooks")

local indentCharacterColors = {
	"IblRainbowRed",
	"IblRainbowYellow",
	"IblRainbowBlue",
	"IblRainbowOrange",
	"IblRainbowGreen",
	"IblRainbowViolet",
	"IblRainbowCyan",
}

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "IblRainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "IblRainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "IblRainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "IblRainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "IblRainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "IblRainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "IblRainbowCyan", { fg = "#56B6C2" })
end)

ibl.setup({
	indent = {
		char ="",
		highlight = indentCharacterColors,
	},
})
