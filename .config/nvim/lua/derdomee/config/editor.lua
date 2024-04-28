-- Use and force tabs for indentation
vim.o.expandtab = false
vim.o.smartindent = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- View line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Highlight current line number
vim.wo.cursorline = true

-- Color match brackets and show current matching bracket
vim.o.showmatch = true
vim.o.matchtime = 1

-- Show invisible characters
vim.o.list = true
vim.o.listchars = "nbsp:·,tab:│ ,trail:·,extends:→,precedes:←"
