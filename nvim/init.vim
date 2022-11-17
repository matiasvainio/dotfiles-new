"--------------------------------------------------------------------------
" General Settings
"--------------------------------------------------------------------------

set expandtab
set shiftwidth=4
set tabstop=4
set hidden
set relativenumber
set number
set termguicolors
set hlsearch
set ignorecase
set smartcase
set mouse=a
set scrolloff=8
set sidescrolloff=8
set clipboard=unnamedplus


"--------------------------------------------------------------------------
" Omni completion
"--------------------------------------------------------------------------

filetype plugin on
set omnifunc=syntaxcomplete#Complete

"--------------------------------------------------------------------------
" Key maps 
"--------------------------------------------------------------------------

let mapleader = "\<space>"

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>

map gf :edit <cfile><cr>

nmap <silent> <C-h> <C-w>h
nmap <silent> <C-j> <C-w>j
nmap <silent> <C-k> <C-w>k
nmap <silent> <C-l> <C-w>l

vnoremap < <gv
vnoremap > >gv

imap jk <esc>

nnoremap <silent> <leader>e :Explore<cr>

"-- greatest remap ever
xnoremap("<leader>p", "\"_dP")

"-- next greatest remap ever : asbjornHaland
nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nmap("<leader>Y", "\"+Y")

"--------------------------------------------------------------------------
" Plugins 
"--------------------------------------------------------------------------

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')
source ~/.config/nvim/plugins/onedark.vim
source ~/.config/nvim/plugins/coc.vim
source ~/.config/nvim/plugins/base16.vim
source ~/.config/nvim/plugins/plenary.vim
source ~/.config/nvim/plugins/nvim-telescope.vim
source ~/.config/nvim/plugins/nvim-treesitter.vim
source ~/.config/nvim/plugins/markdown-preview.vim
call plug#end()

"--------------------------------------------------------------------------
" Colorscheme
"--------------------------------------------------------------------------

colorscheme base16-ashes

"--------------------------------------------------------------------------
" Treesitter
"--------------------------------------------------------------------------
lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
EOF
