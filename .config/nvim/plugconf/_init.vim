" #########################################
" #                                       #
" #   .vimrc (Vim/NeoVim Configuration)   #
" #     by "derdomee_" Dominik Riedig     #
" #                                       #
" #########################################

" ########
" Plugins
" ########
call plug#begin('~/.local/share/nvim/plugged-plugins')

Plug 'preservim/nerdtree'                       " Tree file viewer
Plug 'Xuyuanp/nerdtree-git-plugin'              " Show git file icons in tree
Plug 'ryanoasis/vim-devicons'                   " Show file icons in tree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  " Color file names by type

Plug 'preservim/tagbar'                         " Code outline viewer

Plug 'ntpeters/vim-better-whitespace'           " Show trailing whitespace
Plug 'frazrepo/vim-rainbow'                     " Same color on matching parantheses
Plug 'sheerun/vim-polyglot'                     " Better and more syntax highlighting

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion
Plug 'raimondi/delimitmate'                     " Autocomplete closing brackets

Plug 'eslint/eslint'                            " ESLint linter for Javascript

Plug 'ap/vim-css-color'                         " Preview colors in code

Plug 'jez/vim-superman'                         " Read syntax highlighted man pages inside vim

Plug 'airblade/vim-gitgutter'                   " Show git line modifications
Plug 'tpope/vim-fugitive'                       " Git wrapper in vim

Plug 'morhetz/gruvbox'                          " Colortheme

Plug 'vim-airline/vim-airline-themes'           " Airline color themes
Plug 'lambdalisue/battery.vim'                  " Show battery level in status bar
Plug 'vim-airline/vim-airline'                  " Airline itself

call plug#end()

runtime plugconf/nerdtree.vim
runtime plugconf/airline.vim
runtime plugconf/coc.vim
