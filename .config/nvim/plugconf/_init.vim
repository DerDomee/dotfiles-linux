" #########################################
" #                                       #
" #   .vimrc (Vim/NeoVim Configuration)   #
" #     by "derdomee_" Dominik Riedig     #
" #                                       #
" #########################################

" Disable plugins defining their own keymappings
let g:no_plugin_maps = 1

" ########
" Plugins
" ########
call plug#begin('~/.local/share/nvim/plugged-plugins')

Plug 'preservim/nerdtree'                           " Tree file viewer
Plug 'Xuyuanp/nerdtree-git-plugin'                  " Show git file icons in tree
Plug 'ryanoasis/vim-devicons'                       " Show file icons in tree

Plug 'preservim/tagbar'                             " Code outline viewer

Plug 'ntpeters/vim-better-whitespace'               " Show trailing whitespace
Plug 'frazrepo/vim-rainbow'                         " Same color on matching parantheses
Plug 'sheerun/vim-polyglot'                         " Better and more syntax highlighting
Plug 'nikvdp/ejs-syntax'                            " Syntax highlighting for ejs files
Plug 'cakebaker/scss-syntax.vim'                    " Syntax highlighting for scss and sass

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }  " fzf support
Plug 'junegunn/fzf.vim'                             " fzf integration
Plug 'nvim-treesitter/nvim-treesitter'              " Treesitter is a dependency for telescope
Plug 'nvim-lua/plenary.nvim'                        " Plenary is a dependency for telescope
Plug 'nvim-telescope/telescope.nvim'                " Wonderful fuzzy finder

Plug 'neoclide/coc.nvim', {'branch': 'release'}     " Autocompletion
Plug 'raimondi/delimitmate'                         " Autocomplete closing brackets

Plug 'eslint/eslint'                                " ESLint linter for Javascript

Plug 'ap/vim-css-color'                             " Preview colors in code

Plug 'jez/vim-superman'                             " Read syntax highlighted man pages inside vim

Plug 'airblade/vim-gitgutter'                       " Show git line modifications
Plug 'tpope/vim-fugitive'                           " Git wrapper in vim

Plug 'andweeb/presence.nvim'                        " Discord rich presence

Plug 'morhetz/gruvbox'                              " Colortheme

Plug 'vim-airline/vim-airline-themes'               " Airline color themes
Plug 'lambdalisue/battery.vim'                      " Show battery level in status bar
Plug 'vim-airline/vim-airline'                      " Airline itself

call plug#end()


" Coc Plugin definition

let g:coc_global_extensions = ["coc-json", "coc-jest", "coc-prettier", "coc-tsserver", "coc-tailwindcss"]


runtime plugconf/nerdtree.vim
runtime plugconf/airline.vim
runtime plugconf/coc.vim
