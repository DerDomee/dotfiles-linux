-- Themery block
-- This block will be replaced by Themery.
vim.opt.background = 'dark'


vim.cmd("colorscheme vscode")

require("vscode").setup({
style = 'dark',
transparent = false,
italic_comments = true,

})
require("vscode").load()

vim.g.theme_id = 2
-- end themery block
