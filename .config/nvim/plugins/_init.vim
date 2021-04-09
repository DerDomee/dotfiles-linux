" #########################################
" #                                       #
" #   .vimrc (Vim/NeoVim Configuration)   #
" #     by "derdomee_" Dominik Riedig     #
" #                                       #
" #########################################

" ########
" Plugins
" ########
call plug#begin('~/.config/nvim/plugged')
" Colorscheme
Plug 'morhetz/gruvbox'
" NERDTree + Addons for NERDTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Color matching brackets
Plug 'frazrepo/vim-rainbow'
" Status bar
Plug 'itchyny/lightline.vim'
" Show git modifications inside the file
Plug 'airblade/vim-gitgutter'
call plug#end()

runtime plugins/nerdtree.vim
