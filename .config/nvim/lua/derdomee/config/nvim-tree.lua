nvim_tree = require "nvim-tree"

nvim_tree.setup({
	disable_netrw = true,
	hijack_unnamed_buffer_when_opening = true,
	hijack_cursor = true,
	sort = {
		sorter = "name",
		folders_first = true,
	},
	filters = {
		dotfiles = true,
	},
})

local function opts(desc)
	return {
		desc = "nvim-tree: " ..desc,
		buffer = bufnr,
		noremap = true,
		silent = true,
		nowait = true,
	}
end
vim.keymap.set('n', '<Leader>m', '<cmd>NvimTreeToggle<CR>', opts("Toggle NvimTree"))

