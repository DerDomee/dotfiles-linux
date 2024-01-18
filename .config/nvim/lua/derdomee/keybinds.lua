vim.g.mapleader = " "

-- Toggle between relative and absolute line numbers
vim.api.nvim_set_keymap('n', '<Leader>nt', '<cmd>lua vim.wo.relativenumber = not vim.wo.relativenumber<CR>', {noremap = true, silent = true})

-- Toggle tree view
vim.api.nvim_set_keymap('n', '<Leader>b', '<cmd>NvimTreeToggle<CR>', {noremap = true, silent = true})
