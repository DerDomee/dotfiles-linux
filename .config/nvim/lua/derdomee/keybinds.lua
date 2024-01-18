vim.g.mapleader = " "

-- Toggle between relative and absolute line numbers
vim.api.nvim_set_keymap('n', '<Leader>nt', '<cmd>lua vim.wo.relativenumber = not vim.wo.relativenumber<CR>', {noremap = true, silent = true})

-- Toggle tree view
vim.api.nvim_set_keymap('n', '<Leader>b', '<cmd>NvimTreeToggle<CR>', {noremap = true, silent = true})


-- Neogit, Fugitive, DiffView, and other git related keybinds
vim.api.nvim_set_keymap('n', '<Leader>gs', '<cmd>Neogit<CR>', {noremap = true, silent = true})



local isDiffviewOpen = false

function toggleDiffview()
	if isDiffviewOpen then
		vim.cmd('DiffviewClose')
	else
		vim.cmd('DiffviewOpen')
	end
	isDiffviewOpen = not isDiffviewOpen
end

vim.api.nvim_set_keymap('n', '<Leader>gd', '<cmd>lua toggleDiffview()<CR>', {noremap = true, silent = true})
